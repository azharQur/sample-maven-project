locals {
  tfe_org = "Badal"
}


terraform {
  required_providers {
    tfe = {
      version = "~> 0.44.0"
    }
  }
  backend "gcs" {
    bucket = "STATE_BUCKET_NAME"
    prefix = "terraform/projects/state"
  }
}

provider "tfe" {
  hostname = "tfe.badal.io" # Optional, defaults to Terraform Cloud `app.terraform.io`
  token    = var.tfe_badal_api_token
  version  = "~> 0.44.0"
}

resource "tfe_workspace" "sentinel-test" {
  name         = "sentinel-poc-test"
  organization = local.tfe_org
  tag_names    = ["test", "app"]


}

data "tfe_slug" "sentinel-policy" {
  // point to the local directory where the policies are located.
  source_path = "./"
}

resource "tfe_policy_set" "test" {
  name          = "poc-set"
  description   = "Testing sentinel with TFE"
  organization  = local.tfe_org
  workspace_ids = [tfe_workspace.sentinel-test.id]

  // reference the tfe_slug data source.
  slug = data.tfe_slug.sentinel-policy

  depends_on = [tfe_workspace.sentinel-test]
}

