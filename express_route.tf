resource "azurerm_express_route_circuit" "erc" {
  name                = "erc-lab"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  service_provider_name = "Equinix"
  peering_location      = "Silicon Valley"
  bandwidth_in_mbps     = 200

  sku {
    tier   = "Standard"
    family = "MeteredData"
  }
}
