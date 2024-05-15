locals {
  service = "hub"

  resource_prefix = var.branch_hash == "null" ? "${var.environment_short_name}-${var.location_short_name}-${var.project}" : "${var.environment_short_name}-${var.branch_hash}-${var.location_short_name}-${var.project}"

  service_name_rg = "${local.resource_prefix}-${local.service}-rg"

  hub_vnet_name = "${local.resource_prefix}-hub-01-net-01"

  module_tags = { # Module specific tags
    project     = var.project
    service     = local.service
    environment = var.environment
  }

  tags = merge(local.module_tags, var.default_tags) # Merging local module tags and default tags by the pipeline.

  paws_resource_prefix = "${var.environment_short_name}-${var.location_short_name}-paws"
  paws_hub_network = {
    resource_group_name = "${local.paws_resource_prefix}-network-rg"
    vnet_name           = "${local.paws_resource_prefix}-hub-01-net-01"
  }
}
