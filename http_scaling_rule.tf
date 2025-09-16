# HTTP Scaling Rule for Container App
# This resource updates the existing container app with HTTP scaling configuration
resource "azapi_update_resource" "container_app_http_scaling" {
  type        = "Microsoft.App/containerApps@2023-05-01"
  resource_id = azurerm_container_app.main.id

  body = jsonencode({
    properties = {
      template = {
        scale = {
          minReplicas = var.min_replicas
          maxReplicas = var.max_replicas
          rules = [
            {
              name = "http-scaling-rule"
              http = {
                metadata = {
                  concurrentRequests = tostring(var.http_scaler_concurrent_requests)
                }
              }
            }
          ]
        }
      }
    }
  })

  depends_on = [azurerm_container_app.main]
}
