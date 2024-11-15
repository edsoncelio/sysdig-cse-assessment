module "agentless-scanning" {
  source                   = "sysdiglabs/secure/aws//modules/agentless-scanning"
  version                  = "~>1.0"
  regions                  = ["us-east-1","us-west-2"]
  sysdig_secure_account_id = module.onboarding.sysdig_secure_account_id
}

resource "sysdig_secure_cloud_auth_account_feature" "agentless_scanning" {
  account_id = module.onboarding.sysdig_secure_account_id
  type       = "FEATURE_SECURE_AGENTLESS_SCANNING"
  enabled    = true
  components = [module.agentless-scanning.scanning_role_component_id, module.agentless-scanning.crypto_key_component_id]
  depends_on = [module.agentless-scanning]
}