terraform {
  required_providers {
    azurecaf = {
      source = "aztfmod/azurecaf"
    }
    azapi = {
      source = "Azure/azapi"
    }
  }
}
locals {
  module_tag = {
    "module" = basename(abspath(path.module))
  }
}
