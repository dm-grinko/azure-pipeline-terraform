variable "prefix" {
  type        = string
  description = "Naming prefix for resources"
  default     = "app"
}

variable "az_location" {
  type    = string
  default = "eastus"
}

variable "az_container_name" {
  type        = string
  description = "Name of container on storage account for Terraform state"
  default     = "terraform-state"
}

variable "az_state_key" {
  type        = string
  description = "Name of key in storage account for Terraform state"
  default     = "terraform.tfstate"
}

resource "random_integer" "suffix" {
  min = 10000
  max = 99999
}

locals {
  az_resource_group_name  = "${var.prefix}${random_integer.suffix.result}"
  az_storage_account_name = "${lower(var.prefix)}${random_integer.suffix.result}"
  az_key_vault_name = "${var.prefix}${random_integer.suffix.result}"

  pipeline_variables = {
    tf-state-resource-group = var.az_location
    tf-state-storage-account = azurerm_storage_account.sa.name
    tf-state-container = var.az_container_name
    tf-state-key = var.az_state_key
    ARM-ACCESS-KEY = data.azurerm_storage_account_sas.state.sas
    ARM-CLIENT-ID = azuread_application.resource_creation.application_id
    ARM-CLIENT-SECRET = azuread_service_principal_password.resource_creation.value
    ARM-SUBSCRIPTION-ID = data.azurerm_client_config.current.subscription_id
    ARM-TENANT-ID = data.azurerm_client_config.current.tenant_id
    # storageaccount = azurerm_storage_account.sa.name
    # container-name = var.az_container_name
    # key = var.az_state_key
    # sas-token = data.azurerm_storage_account_sas.state.sas
    # az-client-id = azuread_application.resource_creation.application_id
    # az-client-secret = azuread_service_principal_password.resource_creation.value
    # az-subscription = data.azurerm_client_config.current.subscription_id
    # az-tenant = data.azurerm_client_config.current.tenant_id
  }

  azad_service_connection_sp_name = "${var.prefix}-service-connection-${random_integer.suffix.result}"
  azad_resource_creation_sp_name = "${var.prefix}-resource-creation-${random_integer.suffix.result}"
}
