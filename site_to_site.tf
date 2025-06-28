resource "azurerm_virtual_network_gateway" "vpn-gateway" {
  name                = "vpn-gateway"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  type     = "Vpn"
  vpn_type = "RouteBased"

  ip_configuration {
    name                          = "vnetGatewayConfig"
    public_ip_address_id          = azurerm_public_ip.vpn-gw-ip.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.subnet1.id
  }

  sku {
    name = "VpnGw1"
  }
}

resource "azurerm_public_ip" "vpn-gw-ip" {
  name                = "vpn-gateway-pip"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  allocation_method   = "Dynamic"
}

resource "azurerm_local_network_gateway" "onprem" {
  name                = "onprem-gateway"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  gateway_address     = "203.0.113.1"
  address_space       = ["192.168.0.0/16"]
}

resource "azurerm_virtual_network_gateway_connection" "site-to-site" {
  name                        = "s2s-connection"
  location                    = azurerm_resource_group.main.location
  resource_group_name         = azurerm_resource_group.main.name
  type                        = "IPsec"
  virtual_network_gateway_id  = azurerm_virtual_network_gateway.vpn-gateway.id
  local_network_gateway_id    = azurerm_local_network_gateway.onprem.id
  shared_key                  = "SuperSecretSharedKey"
}
