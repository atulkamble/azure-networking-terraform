resource "azurerm_virtual_network_gateway" "p2s-vpn-gateway" {
  name                = "p2s-vpn-gateway"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  type     = "Vpn"
  vpn_type = "RouteBased"

  ip_configuration {
    name                          = "gatewayConfig"
    public_ip_address_id          = azurerm_public_ip.vpn-gw-ip.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.subnet1.id
  }

  vpn_client_configuration {
    address_space = ["172.16.201.0/24"]
  }

  sku {
    name = "VpnGw1"
  }
}
