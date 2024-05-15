module "hub_resource_group" {
  source = "git::ssh://git@github.com/BritishAirways-Ent/bcup-glb-tf-libraries//modules/azurerm-resource_group?ref=0.20.0"

  name     = local.service_name_rg
  location = var.location
  tags     = local.tags
}

# to be assigned to connectivity subscription
#  
# module "hub_network_resources" {
#   source = "git::ssh://git@github.com/BritishAirways-Ent/bcup-glb-tf-libraries//modules/azurerm-networking?ref=0.20.0"

#   depends_on = [module.hub_resource_group]

#   resource_group_name = local.service_name_rg
#   location            = var.location

#   virtual_network = {
#     name          = local.hub_vnet_name
#     address_space = ["10.0.0.0/16"]
#     tags          = local.tags
#   }

#   subnets = [
#     {
#       name             = "subnet-01a"
#       address_prefixes = ["10.0.0.0/24"]
#       nsg = {
#         name           = "${local.resource_prefix}-hub-01-nsg-01a"
#         security_rules = []
#         tags           = local.tags
#       }
#     }
#   ]

#   firewall = {
#     name = "${local.resource_prefix}-hub-01-fwl-01"
#     subnet = {
#       address_prefixes = ["10.0.1.0/26"]
#     }
#     public_ip = {
#       name     = "${local.resource_prefix}-hub-01-fwl-01-pip"
#       sku_tier = "Regional"
#       tags     = local.tags
#     }
#     sku_name = "AZFW_VNet"
#     sku_tier = "Standard"
#     policy = {
#       name                     = "${local.resource_prefix}-hub-01-fwl-01-pol"
#       threat_intelligence_mode = "Off"
#     }
#     rule_collection_groups = [
#       {
#         name     = "hub_firewall_application_rule_collection"
#         priority = 100

#         application_rule_collections = [
#           {
#             name     = "application_rule_collection"
#             action   = "Allow"
#             priority = 100
#             rules = [
#               {
#                 name = "application_rule"
#                 source_addresses = [
#                   "10.0.0.0/16",
#                 ]
#                 protocols = [
#                   {
#                     port = "443"
#                     type = "Https"
#                   }
#                 ]
#                 destination_fqdns = ["*.microsoft.com"]
#               }
#             ]
#           }
#         ]
#       }
#     ]
#   }
# }
