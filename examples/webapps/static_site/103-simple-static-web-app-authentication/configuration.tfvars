global_settings = {
  default_region = "region1"
  regions = {
    region1 = "westeurope"
  }
}

resource_groups = {
  rg1 = {
    name   = "staticsite"
    region = "region1"
  }
}

static_sites = {
  s1 = {
    name               = "staticsite"
    resource_group_key = "rg1"
    region             = "region1"

    sku_tier = "Standard"
    sku_size = "Standard"

    settings = {
      authentication = {
        lz_key        = "some_l3_lz"        # L3 landingzone with KeyVault that contains the azuread credentials
        key           = "myVault"           # KeyVault
        secret_prefix = "sp"                # Prefix that was used to write the credentials into the KeyVault
        id            = "AAD_CLIENT_ID"     # Name of the environment variable of the app to write the client id to
        secret        = "AAD_CLIENT_SECRET" # Name of the environment variable of the app to write the client secret to
      }
    }
  }
}
