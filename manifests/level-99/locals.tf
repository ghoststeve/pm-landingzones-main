locals {
  service = "ssv"
  content = "tf"

  # service_name_rg = "${var.environment_short_name}${var.branch_hash}-${var.location_short_name}-${var.project}-${local.service}-${local.content}-rg"

  service_name_rg          = var.branch_hash == "null" ? local.mainline_service_name_rg : local.hash_service_name_rg
  mainline_service_name_rg = "${var.environment_short_name}-${var.location_short_name}-${var.project}-${local.service}-${local.content}-rg"
  hash_service_name_rg     = "${var.environment_short_name}-${var.branch_hash}-${var.location_short_name}-${var.project}-${local.service}-${local.content}-rg"

  # service_name          = var.branch_hash == null ? local.mainline_service_name_rg : local.hash_service_name_rg 
  # mainline_service_name = "${var.environment_short_name}${var.location_short_name}${var.project}${local.service}-${local.content}"
  # hash_service_name     = "${var.environment_short_name}${var.branch_hash}${var.location_short_name}${var.project}${local.service}${local.content}"

  # module_tags = { # Module specific tags
  #   project     = var.project 
  #   content     = local.content
  #   service     = local.service
  #   environment = var.environment
  # }

  # tags = merge(local.module_tags, var.default_tags) # Merging local module tags and default tags by the pipeline.
}
