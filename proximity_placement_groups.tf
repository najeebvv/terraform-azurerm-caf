

module "proximity_placement_groups" {
  source   = "./modules/compute/proximity_placement_group"
  for_each = local.compute.proximity_placement_groups

  global_settings = local.global_settings
  client_config   = local.client_config
  name            = each.value.name
  tags            = try(each.value.tags, null)

  base_tags           = local.global_settings.inherit_tags
  resource_group      = local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)]
  resource_group_name = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : null
  location            = try(local.global_settings.regions[each.value.region], null)
}


output "proximity_placement_groups" {
  value = module.proximity_placement_groups

}
