# terraform provider: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/static_site

terraform {
  required_providers {
    azurecaf = {
      source = "aztfmod/azurecaf"
    }
  }

}

locals {
  module_tag = {
    "module" = basename(abspath(path.module))
  }

  tags = merge(var.base_tags, local.module_tag, var.tags)

  keyvault_name = try(
    var.remote_objects.keyvaults[try(var.settings.authentication.lz_key, var.client_config.landingzone_key)][var.settings.authentication.key].name, null
  )

  authentication_settings = try(
    {
      "${var.settings.authentication.id}"     = "@Microsoft.KeyVault(VaultName=${local.keyvault_name};SecretName=${var.settings.authentication.secret_prefix}-client-id)"
      "${var.settings.authentication.secret}" = "@Microsoft.KeyVault(VaultName=${local.keyvault_name};SecretName=${var.settings.authentication.secret_prefix}-client-secret)"
    }, {}
  )

  app_settings = merge(
    try(var.app_settings, {}),
    try(local.authentication_settings, {})
  )
}
