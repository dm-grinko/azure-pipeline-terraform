output "key-vault" {
  value = azurerm_key_vault.setup.name
}

output "kv-sp" {
  value     = azuread_service_principal.service_connection.id
  sensitive = true
}

output "kv-sp-password" {
  value     = azuread_service_principal_password.service_connection.value
  sensitive = true
}

output "pipeline-sp" {
  value     = azuread_service_principal.resource_creation.id
  sensitive = true
}

output "pipeline-sp-name-password" {
  value     = azuread_service_principal_password.resource_creation.value
  sensitive = true
}


