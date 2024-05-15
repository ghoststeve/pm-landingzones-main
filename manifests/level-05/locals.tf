locals {

  resource_prefix = var.branch_hash == "null" ? "${var.environment_short_name}-${var.location_short_name}-${var.project}" : "${var.environment_short_name}-${var.branch_hash}-${var.location_short_name}-${var.project}"

  resource_prefix_sa = var.branch_hash == "null" ? "${var.environment_short_name}${var.location_short_name}${var.project}" : "${var.environment_short_name}${var.branch_hash}${var.location_short_name}${var.project}"

  service_name_law_rg = "${local.resource_prefix}-law-rg"
  service_name_ag_rg  = "${local.resource_prefix}-ag-rg"
}
