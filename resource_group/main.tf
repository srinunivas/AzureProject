resource "azurerm_resource_group" "example" {
  name     = "${var.org_name}-${var.project_name}-${var.env}-${var.region}-${var.resource_group_name}"
  location = var.location
}