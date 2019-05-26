# ===== Service Principals =====
resource "azuread_application" "MSMApp_DBAccess" {
  name                       = "MusicSampleManager Application: Database Access"
  homepage                   = "https://example.com"
  available_to_other_tenants = false
}

# resource "azurerm_azuread_service_principal" "MsmDbAppSPADSP" {
#   application_id = "${azurerm_azuread_application.MsmDbAppSPADApp.application_id}"
# }

