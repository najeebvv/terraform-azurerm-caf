# Do not use this resource at the same time as the cidrs property of the azurerm_ip_group
locals {
  cidrs = try(var.settings.cidrs, try(var.settings.subnet_keys, []) == [] ? var.vnet.address_space : flatten([
    for key, subnet in var.vnet.subnets : subnet.cidr
    if contains(var.settings.subnet_keys, key)
  ]))
}
output "cidrs" {
  value = local.cidrs
}
resource "azurerm_ip_group_cidr" "ip_group_cidr" {

  ip_group_id         = var.ip_group_id
  cidrs               = local.cidrs
}
