provider "azurerm" {
  features {}
  subscription_id = "e85d2a4f-b968-4dbf-8631-bdc6fd9fe118"
}

resource "azurerm_resource_group" "rg" {
  name     = "aks-autoscale-rg"
  location = "East US"
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "autoscale-aks"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "autoscale"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_DS2_v2"
  }

  identity {
    type = "SystemAssigned"
  }
}
