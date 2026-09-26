# AWS / TEAM configuration
#
# Copy to config/aws.local.sh (gitignored) and fill in real values:
#   cp config/aws.example.sh config/aws.local.sh
#
# Sourced by bash/zsh aliases and bin/team-request.

# ---------- AWS SSO profiles (used by exp-aws-profile) ----------
AWS_PROFILE_DEV="MyOrg-DevAccount_AdministratorAccess"
AWS_PROFILE_PROD="MyOrg-ProductionAccount_AdministratorAccess"
AWS_PROFILE_MASTER_PROD="MyOrg-MasterProduction_PowerUserAccess"
AWS_PROFILE_OPERATIONS="MyOrg-OperationsAccount_AdministratorAccess"

# ---------- AWS TEAM elevated access (team-request / team-activate) ----------
# TEAM portal request page
TEAM_URL="https://main.xxxxxxxx.amplifyapp.com/requests/request"
# Target account ID and permission set name
TEAM_ACCOUNT_ID="123456789012"
TEAM_PERMSET="PowerUserAccess"
# Ticket number attached to requests
TEAM_TICKET="123"

# AppSync GraphQL endpoint (leave empty to auto-discover from the TEAM portal)
TEAM_APPSYNC_URL=""
# Account name as it appears in TEAM (e.g. "MyOrg-Production")
TEAM_ACCOUNT_NAME=""
# Permission Set ARN from IAM Identity Center (NOT the IAM role ARN)
# Format: arn:aws:sso:::permissionSet/ssoins-xxxxx/ps-xxxxx
TEAM_ROLE_ID=""
# Username as shown in the TEAM portal (e.g. idc_user@company.com)
TEAM_USERNAME=""
# SSO profile to activate after approval
TEAM_SSO_PROFILE=""
