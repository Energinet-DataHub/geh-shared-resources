# Copyright 2020 Energinet DataHub A/S
#
# Licensed under the Apache License, Version 2.0 (the "License2");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
resource "azurerm_portal_dashboard" "datahub_cpu_memory_dashboard" {
  name                  = "CPU-utilization-and-Memory-consumption-by-resource"
  resource_group_name   = azurerm_resource_group.this.name
  location              = azurerm_resource_group.this.location
  dashboard_properties  = templatefile("dashboard-templates/cpu_memory_by_resource.tpl",
    {
        dashboard_name = "${var.project_name} Resources: CPU Utilization and Memory Consumption"
        subscription_id = data.azurerm_subscription.this.subscription_id,
        shared_resources_resource_group_name = azurerm_resource_group.this.name,
        shared_plan_name = module.plan_services.name,
        charges_resource_group_name = "rg-${var.project_name}-Charges-${upper(var.environment_short)}-${var.environment_instance}",
        charges_function_name = "func-functionhost-charges-${lower(var.environment_short)}-${var.environment_instance}",
        aggregations_resource_group_name = "rg-${var.project_name}-Aggregations-${upper(var.environment_short)}-${var.environment_instance}",
        aggregations_coordinator_function_name = "func-coordinator-aggre-${lower(var.environment_short)}-${var.environment_instance}",
        aggregations_integration_event_function_name = "func-integration-event-listener-aggre-${lower(var.environment_short)}-${var.environment_instance}",
        market_participant_resource_group_name = "rg-${var.project_name}-MarketParticipant-${upper(var.environment_short)}-${var.environment_instance}",
        market_participant_organization_function_name = "func-organization-markpart-${lower(var.environment_short)}-${var.environment_instance}",
        market_roles_resource_group_name = "rg-${var.project_name}-MarketRoles-${upper(var.environment_short)}-${var.environment_instance}",
        market_roles_api_function_name = "func-api-markrol-${lower(var.environment_short)}-${var.environment_instance}",
        market_roles_ingestion_function_name = "func-ingestion-markrol-${lower(var.environment_short)}-${var.environment_instance}",
        market_roles_internalcommanddispatcher_function_name = "func-internalcommanddispatcher-markrol-${lower(var.environment_short)}-${var.environment_instance}",
        market_roles_localmessagehub_function_name = "func-localmessagehub-markrol-${lower(var.environment_short)}-${var.environment_instance}",
        market_roles_outbox_function_name = "func-outbox-markrol-${lower(var.environment_short)}-${var.environment_instance}",
        market_roles_processing_function_name = "func-processing-markrol-${lower(var.environment_short)}-${var.environment_instance}",
        message_archive_resource_group_name = "rg-${var.project_name}-MessageArchive-${upper(var.environment_short)}-${var.environment_instance}",
        message_archive_entrypoint_function_name = "func-entrypoint-msgarch-${lower(var.environment_short)}-${var.environment_instance}",
        metering_point_resource_group_name = "rg-${var.project_name}-MeteringPoint-${upper(var.environment_short)}-${var.environment_instance}",
        metering_point_ingestion_function_name = "func-ingestion-mpt-${lower(var.environment_short)}-${var.environment_instance}",
        metering_point_localmessagehub_function_name = "func-localmessagehub-mpt-${lower(var.environment_short)}-${var.environment_instance}",
        metering_point_outbox_function_name = "func-outbox-mpt-${lower(var.environment_short)}-${var.environment_instance}",
        metering_point_processing_function_name = "func-processing-mpt-${lower(var.environment_short)}-${var.environment_instance}",
        post_office_resource_group_name = "rg-${var.project_name}-PostOffice-${upper(var.environment_short)}-${var.environment_instance}",
        post_office_marketoperator_function_name = "func-marketoperator-pstoff-${lower(var.environment_short)}-${var.environment_instance}",
        post_office_operations_function_name = "func-operations-pstoff-${lower(var.environment_short)}-${var.environment_instance}",
        post_office_subdomain_function_name = "func-subdomain-pstoff-${lower(var.environment_short)}-${var.environment_instance}",
        time_series_resource_group_name = "rg-${var.project_name}-TimeSeries-${upper(var.environment_short)}-${var.environment_instance}",
        time_series_bundle_ingestor_function_name = "func-time-series-bundle-ingestor-timeseries-${lower(var.environment_short)}-${var.environment_instance}",
        charges_webapi_name = "app-webapi-charges-${lower(var.environment_short)}-${var.environment_instance}",
        frontend_resource_group_name = "rg-${var.project_name}-Frontend-${upper(var.environment_short)}-${var.environment_instance}",
        frontend_bff_webapi_name = "app-bff-fe-${lower(var.environment_short)}-${var.environment_instance}",
        market_participant_webapi_name = "app-webapi-markpart-${lower(var.environment_short)}-${var.environment_instance}",
        message_archive_webapi_name = "app-webapi-msgarch-${lower(var.environment_short)}-${var.environment_instance}",
        metering_point_webapi_name = "app-webapi-mpt-${lower(var.environment_short)}-${var.environment_instance}"
    })
  
  tags                         = azurerm_resource_group.this.tags
}