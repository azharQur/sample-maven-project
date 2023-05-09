module "tf-functions" {
  source = "../../common-functions/tf-functions.sentinel"
}

mock "tfplan/v2" {
  module {
    source = "../../test-data/mock-tfplan-v2.sentinel"
  }
}

test {
  rules = {
    main = true
  }
}
