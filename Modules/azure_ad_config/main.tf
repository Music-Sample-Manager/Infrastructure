# ===== Service Principals =====
resource "azuread_application" "MSMApp_DBAccess" {
  name                       = "MusicSampleManager Application: Database Access"
  homepage                   = "https://example.com"
  available_to_other_tenants = false
}

resource "azuread_application" "MSMApp_WebsiteAppRegistration" {
  name     = "MusicSampleManager Application: Website Service Principal"
  homepage = "https://example.com"

  reply_urls = [
    "https://localhost:44354/",
    "https://localhost:44354/signin-oidc",
  ]

  available_to_other_tenants = false
}

# resource "azurerm_azuread_service_principal" "MsmDbAppSPADSP" {
#   application_id = "${azurerm_azuread_application.MsmDbAppSPADApp.application_id}"
# }

