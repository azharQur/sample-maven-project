module "tf-functions" {
  source = "./common-functions/tf-functions.sentinel"
}


policy "restrict-gcp-machine-type" {
  source            = "./restrict-gcp-machine-type.sentinel"
  enforcement_level = "hard-mandatory"
}

