module "sbt_energy_supplier_change_registered" {
  source              = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//azure/service-bus-topic?ref=5.1.0"

  name                = "energy-supplier-change-registered"
  namespace_name      = module.sb_domain_relay.name
  resource_group_name = azurerm_resource_group.this.name
  subscriptions       = [
    {
      name                = "mp-energy-supplier-change-registred-sub"
      max_delivery_count  = 10
      forward_to          = module.sbq_metering_point_forwarded.name
    },
  ]
}
