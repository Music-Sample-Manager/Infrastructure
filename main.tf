terraform {
  required_version = ">= 0.12"
}

variable "subscription_id" {}
variable "client_id" {}
variable "client_certificate_path" {}
variable "tenant_id" {}
variable "client_certificate_password" {}

variable "database_server_admin_login" {
  type = string
}

variable "database_server_admin_password" {
  type = string
}

provider "azurerm" {
  # Whilst version is optional, we /strongly recommend/ using it to pin the version of the Provider being used
  version = "=1.29.0"

  subscription_id             = var.subscription_id
  client_id                   = var.client_id
  client_certificate_path     = var.client_certificate_path
  client_certificate_password = var.client_certificate_password
  tenant_id                   = var.tenant_id
}

provider "azuread" {
  alias   = "aad"
  version = "=0.3.1"

  subscription_id             = var.subscription_id
  client_id                   = var.client_id
  client_certificate_path     = var.client_certificate_path
  client_certificate_password = var.client_certificate_password
  tenant_id                   = var.tenant_id
}

module "AzureAdConfig" {
  source = "./Modules/azure_ad_config"

  providers = {
    azuread = azuread.aad
  }
}

resource "azurerm_resource_group" "MusicSampleManagerResourceGroup" {
  name     = "MusicSampleManagerRG"
  location = "East US"
}

resource "azurerm_storage_account" "WebsiteBackendSA" {
  name                     = "contributorwebsitebacken"
  resource_group_name      = azurerm_resource_group.MusicSampleManagerResourceGroup.name
  location                 = "centralus"
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "XMLSchemasContainer" {
  name                  = "schemas"
  resource_group_name   = azurerm_resource_group.MusicSampleManagerResourceGroup.name
  storage_account_name  = azurerm_storage_account.WebsiteBackendSA.name
  container_access_type = "blob"
}

resource "azurerm_sql_server" "MSMDatabaseServer" {
  name                         = "msmds"
  resource_group_name          = azurerm_resource_group.MusicSampleManagerResourceGroup.name
  location                     = azurerm_resource_group.MusicSampleManagerResourceGroup.location
  version                      = "12.0"
  administrator_login          = var.database_server_admin_login
  administrator_login_password = var.database_server_admin_password
}

resource "azurerm_sql_database" "MSMDatabase" {
  name                = "msmdb"
  resource_group_name = azurerm_resource_group.MusicSampleManagerResourceGroup.name
  location            = azurerm_resource_group.MusicSampleManagerResourceGroup.location
  server_name         = azurerm_sql_server.MSMDatabaseServer.name
}
