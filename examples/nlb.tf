# module "nlb" {
#   source = "../network_load_balancer"

#   load_balancer = {
#     name = "nlb-dspmdemo-lab-eastus"
#     sku  = "Standard"
#     public_ip_name = module.nlb_pip.public_ip_name
#     public_ip_address_id = module.nlb_pip.public_ip
#     lb_backend_address_pool_name = "nlb-pool1" 
#     lb_probe_name = "nlb-proble"
#     port = 80
#     protocol = "Tcp"
#     lb_rule_name = "nlb-rule-1"
#     disable_outbound_snat = true
#     outbound_rule_name = "nlb-outbound-rule" 
#     backend_address_pool_association = {
#         pool1 = {
#             ip_configuration_name = module.private_windows_vm_1_nic.ip_configuration_name #"private-vm-1-nic-ip-config"
#             network_interface_id  = module.private_windows_vm_1_nic.network_interface_id
#         },
#         pool2 = {
#             ip_configuration_name = module.private_windows_vm_2_nic.ip_configuration_name#"private-vm-1-nic-ip-config"
#             network_interface_id  = module.private_windows_vm_2_nic.network_interface_id
#         }
#     }
    
#   }

#   location = module.rg.location
#   resource_group_name = module.rg.resource_group_name
#   tags = local.tags

#   depends_on = [ module.private_windows_vm_1,module.private_windows_vm_2 ]
# }