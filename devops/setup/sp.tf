# KV-SP
resource "azuread_application" "service_connection" {
  display_name = local.azad_service_connection_sp_name
}

resource "azuread_service_principal" "service_connection" {
  application_id = azuread_application.service_connection.application_id
}

resource "azuread_service_principal_password" "service_connection" {
  service_principal_id = azuread_service_principal.service_connection.id
}

# pipeline SP
resource "azuread_application" "resource_creation" {
  display_name = local.azad_resource_creation_sp_name
}

resource "azuread_service_principal" "resource_creation" {
  application_id = azuread_application.resource_creation.application_id
}

resource "azuread_service_principal_password" "resource_creation" {
  service_principal_id = azuread_service_principal.resource_creation.id
}

resource "azurerm_role_assignment" "resource_creation" {
  scope = data.azurerm_subscription.current.id
  role_definition_name = "Contributor"
  principal_id = azuread_service_principal.resource_creation.object_id
}

