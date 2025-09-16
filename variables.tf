variable "resource_group_name" {
  description = "Name of the existing Azure Resource Group"
  type        = string
  default     = "rg-ai-feature"
}

variable "location" {
  description = "Azure region where resources will be created"
  type        = string
  default     = "West Europe"
}

variable "project_name" {
  description = "Name of the project (used for resource naming)"
  type        = string
  default     = "helloterra"
}

variable "container_app_environment_name" {
  description = "Name of the existing Container App Environment"
  type        = string
  default     = ""
}

variable "container_app_name" {
  description = "Name of the Container App"
  type        = string
  default     = ""
}

variable "log_analytics_workspace_name" {
  description = "Name of the Log Analytics Workspace"
  type        = string
  default     = ""
}

variable "key_vault_name" {
  description = "Name of the existing Key Vault"
  type        = string
  default     = ""
}

variable "key_vault_resource_group_name" {
  description = "Resource group name for the Key Vault"
  type        = string
  default     = ""
}

variable "container_image" {
  description = "Container image to deploy"
  type        = string
  default     = "mcr.microsoft.com/azuredocs/containerapps-helloworld:latest"
}

variable "target_port" {
  description = "Port that the container exposes"
  type        = number
  default     = 80
}

variable "min_replicas" {
  description = "Minimum number of container replicas"
  type        = number
  default     = 0
}

variable "max_replicas" {
  description = "Maximum number of container replicas"
  type        = number
  default     = 10
}

variable "cpu_requests" {
  description = "CPU requests for the container"
  type        = string
  default     = "0.25"
}

variable "memory_requests" {
  description = "Memory requests for the container"
  type        = string
  default     = "0.5Gi"
}

variable "container_registry_host" {
  description = "Conatainer registry host name"
  type        = string
  default     = ""
}

variable "container_registry_username" {
  description = "Conatainer registry user name"
  type        = string
  default     = ""
}

variable "container_registry_pasword_secret_name" {
  description = "Conatainer registry Password Secret Name"
  type        = string
  default     = "container-registry-password"
}



variable "container_env_variables" {
  description = "Environment variables for the container"
  type        = map(string)
  default = {
    ENVIRONMENT = "production"
    APP_NAME    = "helloterra"
  }
}

variable "container_env_secrets" {
  description = "Environment Secrets"
  type        = map(string)
  default = {}
}

variable "container_secrets" {
  description = "Secrets for the container"
  type        = map(string)
  default = {}
}

variable "enable_ingress" {
  description = "Enable or disable ingress for the Container App"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default = {
    Environment = "Development"
    Project     = "HelloTerra"
    ManagedBy   = "Terraform"
  }
}
