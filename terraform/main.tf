locals {
  tags = {
    Department    = "Marketing"
    Environment   = "Prod"
    "Cost-Center" = "CST-PRM85"
    Project       = "EcoEnergy"
  }
}

resource "azurerm_resource_group" "rg" {
  name     = "rsGrp-salesDp-east-prod-tf"
  location = "eastus"
  tags     = local.tags
}

resource "azurerm_proximity_placement_group" "ppg" {
  name                = "proxGrpAvSet-salesDp-east-prod-tf"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  tags                = local.tags
}

resource "azurerm_availability_set" "avset" {
  name                         = "avSet-salesDp-east-prod-tf"
  location                     = azurerm_resource_group.rg.location
  resource_group_name          = azurerm_resource_group.rg.name
  platform_fault_domain_count  = 3
  platform_update_domain_count = 8
  managed                      = true
  proximity_placement_group_id = azurerm_proximity_placement_group.ppg.id
  tags                         = local.tags
}