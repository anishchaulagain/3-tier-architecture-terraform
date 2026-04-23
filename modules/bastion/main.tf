# Bastion / jump host for break-glass access.
# Prefer SSM Session Manager over SSH: run a hardened instance in a public
# subnet with the SSM agent and no inbound SSH, and use IAM + Session Manager
# for access. Keep this module minimal — it exists as an escape hatch.
