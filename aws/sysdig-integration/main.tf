terraform {
  required_providers {
    sysdig = {
      source  = "sysdiglabs/sysdig"
      version = "~>1.38"
    }
  }
}

provider "sysdig" {
  sysdig_secure_url       = "https://app.us4.sysdig.com"
  sysdig_secure_api_token = ""
}

provider "aws" {
  region              = "us-east-1"
  allowed_account_ids = ["361769585467"]
}

module "onboarding" {
  source  = "sysdiglabs/secure/aws//modules/onboarding"
  version = "~>1.0"
}

module "config-posture" {
  source                   = "sysdiglabs/secure/aws//modules/config-posture"
  version                  = "~>1.0"
  sysdig_secure_account_id = module.onboarding.sysdig_secure_account_id
}

resource "sysdig_secure_cloud_auth_account_feature" "config_posture" {
  account_id = module.onboarding.sysdig_secure_account_id
  type       = "FEATURE_SECURE_CONFIG_POSTURE"
  enabled    = true
  components = [module.config-posture.config_posture_component_id]
  depends_on = [module.config-posture]
}