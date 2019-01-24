# ===== Service Principals =====
# TODO The Terraform SP does not have permission to perform these actions:
# resource "azurerm_azuread_application" "MsmDbAppSPADApp" {
#   name                       = "MusicSampleManager DB Application Service Principal"
#   available_to_other_tenants = false
# }
# resource "azurerm_azuread_service_principal" "MsmDbAppSPADSP" {
#   application_id = "${azurerm_azuread_application.MsmDbAppSPADApp.application_id}"
# }