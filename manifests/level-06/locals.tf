locals {
  service = "ecp"

  resource_prefix = var.branch_hash == "null" ? "${var.environment_short_name}-${var.location_short_name}-${var.project}" : "${var.environment_short_name}-${var.branch_hash}-${var.location_short_name}-${var.project}"

  resource_prefix_sa = var.branch_hash == "null" ? "${var.environment_short_name}${var.location_short_name}${var.project}" : "${var.environment_short_name}${var.branch_hash}${var.location_short_name}${var.project}"

  service_name_rg = "${local.resource_prefix}-${local.service}-rg"

  # module_tags = { # Module specific tags
  #   project     = var.project 
  #   content     = local.content
  #   service     = local.service
  #   environment = var.environment
  # }

  # tags = merge(local.module_tags, var.default_tags) # Merging local module tags and default tags by the pipeline.
}
