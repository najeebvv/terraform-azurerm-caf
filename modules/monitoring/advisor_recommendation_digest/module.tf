
resource "azurecaf_name" "ard" {
  name          = var.settings.name
  resource_type = "azurerm_monitor_activity_log_alert"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}


resource "azapi_resource" "ard" {
  type = "Microsoft.Advisor/configurations@2020-01-01"
  name = azurecaf_name.ard.result
  parent_id = format("/subscriptions/%s", var.client_config.subscription_id)
  body = jsonencode({
    properties = {
      digests = [
        {
          actionGroupResourceId = coalesce(
            try(var.remote_objects["monitor_action_groups"][var.settings.action_group.lz_key][var.settings.action_group.key].id, null),
            try(var.remote_objects["monitor_action_groups"][var.client_config.landingzone_key][var.settings.action_group.key].id, null),
            try(var.settings.action_group.id, null)
          )
          categories = try(var.settings.categories, null)
          frequency = try(var.settings.frequency, null)
          language = try(var.settings.frequency, null)
          name = azurecaf_name.ard.result
          state = try(var.settings.state, null)
        }
      ]
      exclude = try(var.settings.exclude, false)
      lowCpuThreshold = try(var.settings.low_cpu_threshold, null)
    }
  })
}
