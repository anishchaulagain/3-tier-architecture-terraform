# 3-Tier Architecture on AWS with Terraform

A production-grade Terraform scaffold for a classic three-tier application on AWS:
a public load-balanced **web tier**, a private **application tier**, and an
isolated **database tier** — composed from reusable modules and deployed per
environment (`dev`, `staging`, `prod`) with isolated remote state.

---

## Architecture

```
                        Internet
                           │
                    ┌──────▼──────┐
                    │   Route 53  │
                    └──────┬──────┘
                           │
                  ┌────────▼────────┐          Public subnets
                  │  Application    │          (multi-AZ)
                  │  Load Balancer  │
                  └────────┬────────┘
                           │
              ┌────────────▼────────────┐      Private app subnets
              │  Web Tier (ASG)         │      (multi-AZ, no public IPs,
              │  — nginx / web servers  │       egress via NAT GW)
              └────────────┬────────────┘
                           │
              ┌────────────▼────────────┐      Private app subnets
              │  App Tier (ASG)         │
              │  — application servers  │
              └────────────┬────────────┘
                           │
              ┌────────────▼────────────┐      Private DB subnets
              │  DB Tier (RDS/Aurora)   │      (multi-AZ, no egress,
              │  Multi-AZ, encrypted    │       KMS-encrypted, Secrets Mgr)
              └─────────────────────────┘

   Ingress tight: each tier's SG only accepts traffic from the tier above.
   Operator access is via SSM Session Manager (bastion module is a fallback).
```

---

## Repository layout

```
.
├── global/
│   └── backend-bootstrap/   One-time stack: S3 state bucket + DynamoDB lock table
├── modules/                 Reusable, environment-agnostic building blocks
│   ├── vpc/
│   ├── security-groups/
│   ├── alb/
│   ├── web-tier/
│   ├── app-tier/
│   ├── db-tier/
│   └── bastion/
└── environments/            Thin composition layers, one state per environment
    ├── dev/
    ├── staging/
    └── prod/
```

Each module and environment stack follows the same file convention:

| File                        | Purpose                                          |
| --------------------------- | ------------------------------------------------ |
| `versions.tf`               | Terraform + provider version pins                |
| `providers.tf`              | Provider config (environments only)              |
| `backend.tf`                | Remote state config (environments only)          |
| `variables.tf`              | Input variables                                  |
| `main.tf`                   | Resources / module calls                         |
| `outputs.tf`                | Surfaced outputs                                 |
| `terraform.tfvars.example`  | Template values (real `*.tfvars` are gitignored) |

---

## Prerequisites

- Terraform `>= 1.6.0`
- AWS provider `~> 5.0`
- AWS credentials configured (`aws configure`, SSO profile, or CI role)
- An AWS account with permission to create VPCs, EC2, RDS, S3, DynamoDB, IAM

---

## First-time setup: bootstrap remote state

The environment stacks use an S3 + DynamoDB remote backend. That backend has
to exist before any environment can `init`, so it is created by a separate
stack that keeps its own state locally.

```bash
cd global/backend-bootstrap
cp terraform.tfvars.example terraform.tfvars   # fill in project / account / region
terraform init
terraform apply
```

Outputs include `state_bucket_name` and `state_lock_table_name` — plug those
into each environment's backend config below.

---

## Deploying an environment

Example for `dev`; the same commands apply to `staging` and `prod`.

```bash
cd environments/dev
cp terraform.tfvars.example terraform.tfvars   # set region, env, project, owner

terraform init \
  -backend-config="bucket=<state_bucket_name>" \
  -backend-config="dynamodb_table=<state_lock_table_name>" \
  -backend-config="region=us-east-1"

terraform plan  -out tfplan
terraform apply tfplan
```

The `key` (`envs/<env>/terraform.tfstate`) is already set in
`backend.tf`, so each environment gets its own state object in the shared
bucket.

---

## Modules

| Module              | Responsibility                                                                |
| ------------------- | ----------------------------------------------------------------------------- |
| `vpc`               | VPC, public / private-app / private-db subnets across AZs, IGW, NAT, flow logs |
| `security-groups`   | Per-tier SGs wired by SG reference (not CIDR) for east-west traffic           |
| `alb`               | Internet-facing ALB, HTTPS listener, HTTP→HTTPS redirect, access logs         |
| `web-tier`          | Launch template + ASG behind the ALB, IMDSv2, encrypted root volume           |
| `app-tier`          | Internal LB + ASG in private subnets, SSM-managed instance role               |
| `db-tier`           | RDS/Aurora, KMS encryption, Multi-AZ, credentials from Secrets Manager        |
| `bastion`           | Break-glass access (SSM Session Manager preferred over SSH)                   |

Modules are currently scaffolded; resource bodies land in follow-up commits.

---

## Conventions

- **One state per environment.** No `terraform workspace` juggling — dev,
  staging, and prod are fully separate stacks with their own state keys.
- **No secrets in tfvars.** `*.tfvars` is gitignored; DB credentials come from
  AWS Secrets Manager, not variables.
- **Provider `default_tags`** stamps `Environment`, `Project`, `Owner`, and
  `ManagedBy` on every resource — no per-resource tag plumbing.
- **SG-to-SG references** for internal traffic instead of CIDR allow-lists —
  the rules stay correct as subnets change.
- **IMDSv2 required** on every EC2 launch template.
- **Deletion protection** on the ALB and RDS in `prod`.
- **Conventional Commits** for commit messages (`feat:`, `fix:`, `docs:`…).

---

## Destroying an environment

```bash
cd environments/<env>
terraform destroy
```

The backend-bootstrap stack should be destroyed **last**, and only after
every environment's state has been torn down or migrated, since removing the
bucket orphans the state.
