{
  "properties": {
    "lenses": {
      "0": {
        "order": 0,
        "parts": {
          "0": {
            "position": {
              "x": 0,
              "y": 0,
              "colSpan": 6,
              "rowSpan": 4
            },
            "metadata": {
              "inputs": [
                {
                  "name": "options",
                  "isOptional": true
                },
                {
                  "name": "sharedTimeRange",
                  "isOptional": true
                }
              ],
              "type": "Extension/HubsExtension/PartType/MonitorChartPart",
              "settings": {
                "content": {
                  "options": {
                    "chart": {
                      "metrics": [
                        {
                          "resourceMetadata": {
                            "id": "/subscriptions/${subscription_id}/resourceGroups/${shared_resources_resource_group_name}/providers/Microsoft.Web/serverFarms/${shared_plan_name}"
                          },
                          "name": "CpuPercentage",
                          "aggregationType": 4,
                          "namespace": "microsoft.web/serverfarms",
                          "metricVisualization": {
                            "displayName": "CPU Percentage",
                            "resourceDisplayName": "${shared_plan_name}"
                          }
                        },
                        {
                          "resourceMetadata": {
                            "id": "/subscriptions/${subscription_id}/resourceGroups/${shared_resources_resource_group_name}/providers/Microsoft.Web/serverFarms/${shared_plan_name}"
                          },
                          "name": "MemoryPercentage",
                          "aggregationType": 4,
                          "namespace": "microsoft.web/serverfarms",
                          "metricVisualization": {
                            "displayName": "Memory Percentage",
                            "resourceDisplayName": "${shared_plan_name}"
                          }
                        }
                      ],
                      "title": "Avg CPU Percentage and Avg Memory Percentage for ${shared_plan_name}",
                      "titleKind": 1,
                      "visualization": {
                        "chartType": 2,
                        "legendVisualization": {
                          "isVisible": true,
                          "position": 2,
                          "hideSubtitle": false
                        },
                        "axisVisualization": {
                          "x": {
                            "isVisible": true,
                            "axisType": 2
                          },
                          "y": {
                            "isVisible": true,
                            "axisType": 1
                          }
                        },
                        "disablePinning": true
                      }
                    }
                  }
                }
              }
            }
          },
          "1": {
            "position": {
              "x": 6,
              "y": 0,
              "colSpan": 6,
              "rowSpan": 4
            },
            "metadata": {
              "inputs": [
                {
                  "name": "options",
                  "isOptional": true
                },
                {
                  "name": "sharedTimeRange",
                  "isOptional": true
                }
              ],
              "type": "Extension/HubsExtension/PartType/MonitorChartPart",
              "settings": {
                "content": {
                  "options": {
                    "chart": {
                      "metrics": [
                        {
                          "resourceMetadata": {
                            "id": "/subscriptions/${subscription_id}/resourceGroups/${charges_resource_group_name}/providers/Microsoft.Web/sites/func-functionhost-charges-u-001"
                          },
                          "name": "FunctionExecutionUnits",
                          "aggregationType": 4,
                          "namespace": "microsoft.web/sites",
                          "metricVisualization": {
                            "displayName": "Function Execution Units",
                            "resourceDisplayName": "func-functionhost-charges-u-001"
                          }
                        },
                        {
                          "resourceMetadata": {
                            "id": "/subscriptions/${subscription_id}/resourceGroups/rg-DataHub-Aggregations-U-001/providers/Microsoft.Web/sites/func-coordinator-aggre-u-001"
                          },
                          "name": "FunctionExecutionUnits",
                          "aggregationType": 4,
                          "namespace": "microsoft.web/sites",
                          "metricVisualization": {
                            "displayName": "Function Execution Units",
                            "resourceDisplayName": "func-coordinator-aggre-u-001"
                          }
                        },
                        {
                          "resourceMetadata": {
                            "id": "/subscriptions/${subscription_id}/resourceGroups/rg-DataHub-Aggregations-U-001/providers/Microsoft.Web/sites/func-integration-event-listener-aggre-u-001"
                          },
                          "name": "FunctionExecutionUnits",
                          "aggregationType": 4,
                          "namespace": "microsoft.web/sites",
                          "metricVisualization": {
                            "displayName": "Function Execution Units",
                            "resourceDisplayName": "func-integration-event-listener-aggre-u-001"
                          }
                        },
                        {
                          "resourceMetadata": {
                            "id": "/subscriptions/${subscription_id}/resourceGroups/rg-DataHub-MarketParticipant-U-001/providers/Microsoft.Web/sites/func-organization-markpart-u-001"
                          },
                          "name": "FunctionExecutionUnits",
                          "aggregationType": 4,
                          "namespace": "microsoft.web/sites",
                          "metricVisualization": {
                            "displayName": "Function Execution Units",
                            "resourceDisplayName": "func-organization-markpart-u-001"
                          }
                        },
                        {
                          "resourceMetadata": {
                            "id": "/subscriptions/${subscription_id}/resourceGroups/rg-DataHub-MarketRoles-U-001/providers/Microsoft.Web/sites/func-api-markrol-u-001"
                          },
                          "name": "FunctionExecutionUnits",
                          "aggregationType": 4,
                          "namespace": "microsoft.web/sites",
                          "metricVisualization": {
                            "displayName": "Function Execution Units",
                            "resourceDisplayName": "func-api-markrol-u-001"
                          }
                        },
                        {
                          "resourceMetadata": {
                            "id": "/subscriptions/${subscription_id}/resourceGroups/rg-DataHub-MarketRoles-U-001/providers/Microsoft.Web/sites/func-ingestion-markrol-u-001"
                          },
                          "name": "FunctionExecutionUnits",
                          "aggregationType": 4,
                          "namespace": "microsoft.web/sites",
                          "metricVisualization": {
                            "displayName": "Function Execution Units",
                            "resourceDisplayName": "func-ingestion-markrol-u-001"
                          }
                        },
                        {
                          "resourceMetadata": {
                            "id": "/subscriptions/${subscription_id}/resourceGroups/rg-DataHub-MarketRoles-U-001/providers/Microsoft.Web/sites/func-internalcommanddispatcher-markrol-u-001"
                          },
                          "name": "FunctionExecutionUnits",
                          "aggregationType": 4,
                          "namespace": "microsoft.web/sites",
                          "metricVisualization": {
                            "displayName": "Function Execution Units",
                            "resourceDisplayName": "func-internalcommanddispatcher-markrol-u-001"
                          }
                        },
                        {
                          "resourceMetadata": {
                            "id": "/subscriptions/${subscription_id}/resourceGroups/rg-DataHub-MarketRoles-U-001/providers/Microsoft.Web/sites/func-localmessagehub-markrol-u-001"
                          },
                          "name": "FunctionExecutionUnits",
                          "aggregationType": 4,
                          "namespace": "microsoft.web/sites",
                          "metricVisualization": {
                            "displayName": "Function Execution Units",
                            "resourceDisplayName": "func-localmessagehub-markrol-u-001"
                          }
                        },
                        {
                          "resourceMetadata": {
                            "id": "/subscriptions/${subscription_id}/resourceGroups/rg-DataHub-MarketRoles-U-001/providers/Microsoft.Web/sites/func-outbox-markrol-u-001"
                          },
                          "name": "FunctionExecutionUnits",
                          "aggregationType": 4,
                          "namespace": "microsoft.web/sites",
                          "metricVisualization": {
                            "displayName": "Function Execution Units",
                            "resourceDisplayName": "func-outbox-markrol-u-001"
                          }
                        },
                        {
                          "resourceMetadata": {
                            "id": "/subscriptions/${subscription_id}/resourceGroups/rg-DataHub-MarketRoles-U-001/providers/Microsoft.Web/sites/func-processing-markrol-u-001"
                          },
                          "name": "FunctionExecutionUnits",
                          "aggregationType": 4,
                          "namespace": "microsoft.web/sites",
                          "metricVisualization": {
                            "displayName": "Function Execution Units",
                            "resourceDisplayName": "func-processing-markrol-u-001"
                          }
                        },
                        {
                          "resourceMetadata": {
                            "id": "/subscriptions/${subscription_id}/resourceGroups/rg-DataHub-MessageArchive-U-001/providers/Microsoft.Web/sites/func-entrypoint-msgarch-u-001"
                          },
                          "name": "FunctionExecutionUnits",
                          "aggregationType": 4,
                          "namespace": "microsoft.web/sites",
                          "metricVisualization": {
                            "displayName": "Function Execution Units",
                            "resourceDisplayName": "func-entrypoint-msgarch-u-001"
                          }
                        },
                        {
                          "resourceMetadata": {
                            "id": "/subscriptions/${subscription_id}/resourceGroups/rg-DataHub-MeteringPoint-U-001/providers/Microsoft.Web/sites/func-ingestion-mpt-u-001"
                          },
                          "name": "FunctionExecutionUnits",
                          "aggregationType": 4,
                          "namespace": "microsoft.web/sites",
                          "metricVisualization": {
                            "displayName": "Function Execution Units",
                            "resourceDisplayName": "func-ingestion-mpt-u-001"
                          }
                        },
                        {
                          "resourceMetadata": {
                            "id": "/subscriptions/${subscription_id}/resourceGroups/rg-DataHub-MeteringPoint-U-001/providers/Microsoft.Web/sites/func-localmessagehub-mpt-u-001"
                          },
                          "name": "FunctionExecutionUnits",
                          "aggregationType": 4,
                          "namespace": "microsoft.web/sites",
                          "metricVisualization": {
                            "displayName": "Function Execution Units",
                            "resourceDisplayName": "func-localmessagehub-mpt-u-001"
                          }
                        },
                        {
                          "resourceMetadata": {
                            "id": "/subscriptions/${subscription_id}/resourceGroups/rg-DataHub-MeteringPoint-U-001/providers/Microsoft.Web/sites/func-outbox-mpt-u-001"
                          },
                          "name": "FunctionExecutionUnits",
                          "aggregationType": 4,
                          "namespace": "microsoft.web/sites",
                          "metricVisualization": {
                            "displayName": "Function Execution Units",
                            "resourceDisplayName": "func-outbox-mpt-u-001"
                          }
                        },
                        {
                          "resourceMetadata": {
                            "id": "/subscriptions/${subscription_id}/resourceGroups/rg-DataHub-MeteringPoint-U-001/providers/Microsoft.Web/sites/func-processing-mpt-u-001"
                          },
                          "name": "FunctionExecutionUnits",
                          "aggregationType": 4,
                          "namespace": "microsoft.web/sites",
                          "metricVisualization": {
                            "displayName": "Function Execution Units",
                            "resourceDisplayName": "func-processing-mpt-u-001"
                          }
                        },
                        {
                          "resourceMetadata": {
                            "id": "/subscriptions/${subscription_id}/resourceGroups/rg-DataHub-PostOffice-U-001/providers/Microsoft.Web/sites/func-marketoperator-pstoff-u-001"
                          },
                          "name": "FunctionExecutionUnits",
                          "aggregationType": 4,
                          "namespace": "microsoft.web/sites",
                          "metricVisualization": {
                            "displayName": "Function Execution Units",
                            "resourceDisplayName": "func-marketoperator-pstoff-u-001"
                          }
                        },
                        {
                          "resourceMetadata": {
                            "id": "/subscriptions/${subscription_id}/resourceGroups/rg-DataHub-PostOffice-U-001/providers/Microsoft.Web/sites/func-operations-pstoff-u-001"
                          },
                          "name": "FunctionExecutionUnits",
                          "aggregationType": 4,
                          "namespace": "microsoft.web/sites",
                          "metricVisualization": {
                            "displayName": "Function Execution Units",
                            "resourceDisplayName": "func-operations-pstoff-u-001"
                          }
                        },
                        {
                          "resourceMetadata": {
                            "id": "/subscriptions/${subscription_id}/resourceGroups/rg-DataHub-PostOffice-U-001/providers/Microsoft.Web/sites/func-subdomain-pstoff-u-001"
                          },
                          "name": "FunctionExecutionUnits",
                          "aggregationType": 4,
                          "namespace": "microsoft.web/sites",
                          "metricVisualization": {
                            "displayName": "Function Execution Units",
                            "resourceDisplayName": "func-subdomain-pstoff-u-001"
                          }
                        },
                        {
                          "resourceMetadata": {
                            "id": "/subscriptions/${subscription_id}/resourceGroups/rg-DataHub-TimeSeries-U-001/providers/Microsoft.Web/sites/func-time-series-bundle-ingestor-timeseries-u-001"
                          },
                          "name": "FunctionExecutionUnits",
                          "aggregationType": 4,
                          "namespace": "microsoft.web/sites",
                          "metricVisualization": {
                            "displayName": "Function Execution Units",
                            "resourceDisplayName": "func-time-series-bundle-ingestor-timeseries-u-001"
                          }
                        }
                      ],
                      "title": "Avg Function Execution Units for func-functionhost-charges-u-001, func-coordinator-aggre-u-001, and 17 other resources",
                      "titleKind": 1,
                      "visualization": {
                        "chartType": 2,
                        "legendVisualization": {
                          "isVisible": true,
                          "position": 2,
                          "hideSubtitle": false
                        },
                        "axisVisualization": {
                          "x": {
                            "isVisible": true,
                            "axisType": 2
                          },
                          "y": {
                            "isVisible": true,
                            "axisType": 1
                          }
                        },
                        "disablePinning": true
                      }
                    }
                  }
                }
              }
            }
          },
          "2": {
            "position": {
              "x": 12,
              "y": 0,
              "colSpan": 6,
              "rowSpan": 4
            },
            "metadata": {
              "inputs": [
                {
                  "name": "options",
                  "isOptional": true
                },
                {
                  "name": "sharedTimeRange",
                  "isOptional": true
                }
              ],
              "type": "Extension/HubsExtension/PartType/MonitorChartPart",
              "settings": {
                "content": {
                  "options": {
                    "chart": {
                      "metrics": [
                        {
                          "resourceMetadata": {
                            "id": "/subscriptions/${subscription_id}/resourceGroups/${charges_resource_group_name}/providers/Microsoft.Web/sites/app-webapi-charges-u-001"
                          },
                          "name": "CpuTime",
                          "aggregationType": 1,
                          "namespace": "microsoft.web/sites",
                          "metricVisualization": {
                            "displayName": "CPU Time",
                            "resourceDisplayName": "app-webapi-charges-u-001"
                          }
                        },
                        {
                          "resourceMetadata": {
                            "id": "/subscriptions/${subscription_id}/resourceGroups/rg-DataHub-Frontend-U-001/providers/Microsoft.Web/sites/app-bff-fe-u-001"
                          },
                          "name": "CpuTime",
                          "aggregationType": 1,
                          "namespace": "microsoft.web/sites",
                          "metricVisualization": {
                            "displayName": "CPU Time",
                            "resourceDisplayName": "app-bff-fe-u-001"
                          }
                        },
                        {
                          "resourceMetadata": {
                            "id": "/subscriptions/${subscription_id}/resourceGroups/rg-DataHub-MarketParticipant-U-001/providers/Microsoft.Web/sites/app-webapi-markpart-u-001"
                          },
                          "name": "CpuTime",
                          "aggregationType": 1,
                          "namespace": "microsoft.web/sites",
                          "metricVisualization": {
                            "displayName": "CPU Time",
                            "resourceDisplayName": "app-webapi-markpart-u-001"
                          }
                        },
                        {
                          "resourceMetadata": {
                            "id": "/subscriptions/${subscription_id}/resourceGroups/rg-DataHub-MessageArchive-U-001/providers/Microsoft.Web/sites/app-webapi-msgarch-u-001"
                          },
                          "name": "CpuTime",
                          "aggregationType": 1,
                          "namespace": "microsoft.web/sites",
                          "metricVisualization": {
                            "displayName": "CPU Time",
                            "resourceDisplayName": "app-webapi-msgarch-u-001"
                          }
                        },
                        {
                          "resourceMetadata": {
                            "id": "/subscriptions/${subscription_id}/resourceGroups/rg-DataHub-MeteringPoint-U-001/providers/Microsoft.Web/sites/app-webapi-mpt-u-001"
                          },
                          "name": "CpuTime",
                          "aggregationType": 1,
                          "namespace": "microsoft.web/sites",
                          "metricVisualization": {
                            "displayName": "CPU Time",
                            "resourceDisplayName": "app-webapi-mpt-u-001"
                          }
                        },
                        {
                          "resourceMetadata": {
                            "id": "/subscriptions/${subscription_id}/resourceGroups/rg-DataHub-MessageArchive-U-001/providers/Microsoft.Web/sites/app-webapi-msgarch-u-001"
                          },
                          "name": "CpuTime",
                          "aggregationType": 1,
                          "namespace": "microsoft.web/sites",
                          "metricVisualization": {
                            "displayName": "CPU Time",
                            "resourceDisplayName": "app-webapi-msgarch-u-001"
                          }
                        }
                      ],
                      "title": "Sum CPU Time for app-webapi-charges-u-001, app-bff-fe-u-001, and 3 other resources",
                      "titleKind": 1,
                      "visualization": {
                        "chartType": 2,
                        "legendVisualization": {
                          "isVisible": true,
                          "position": 2,
                          "hideSubtitle": false
                        },
                        "axisVisualization": {
                          "x": {
                            "isVisible": true,
                            "axisType": 2
                          },
                          "y": {
                            "isVisible": true,
                            "axisType": 1
                          }
                        },
                        "disablePinning": true
                      }
                    }
                  }
                }
              }
            }
          },
          "3": {
            "position": {
              "x": 6,
              "y": 4,
              "colSpan": 6,
              "rowSpan": 4
            },
            "metadata": {
              "inputs": [
                {
                  "name": "options",
                  "isOptional": true
                },
                {
                  "name": "sharedTimeRange",
                  "isOptional": true
                }
              ],
              "type": "Extension/HubsExtension/PartType/MonitorChartPart",
              "settings": {
                "content": {
                  "options": {
                    "chart": {
                      "metrics": [
                        {
                          "resourceMetadata": {
                            "id": "/subscriptions/${subscription_id}/resourceGroups/rg-DataHub-Aggregations-U-001/providers/Microsoft.Web/sites/func-coordinator-aggre-u-001"
                          },
                          "name": "AverageMemoryWorkingSet",
                          "aggregationType": 4,
                          "namespace": "microsoft.web/sites",
                          "metricVisualization": {
                            "displayName": "Average memory working set",
                            "resourceDisplayName": "func-coordinator-aggre-u-001"
                          }
                        },
                        {
                          "resourceMetadata": {
                            "id": "/subscriptions/${subscription_id}/resourceGroups/rg-DataHub-Aggregations-U-001/providers/Microsoft.Web/sites/func-integration-event-listener-aggre-u-001"
                          },
                          "name": "AverageMemoryWorkingSet",
                          "aggregationType": 4,
                          "namespace": "microsoft.web/sites",
                          "metricVisualization": {
                            "displayName": "Average memory working set",
                            "resourceDisplayName": "func-integration-event-listener-aggre-u-001"
                          }
                        },
                        {
                          "resourceMetadata": {
                            "id": "/subscriptions/${subscription_id}/resourceGroups/${charges_resource_group_name}/providers/Microsoft.Web/sites/func-functionhost-charges-u-001"
                          },
                          "name": "AverageMemoryWorkingSet",
                          "aggregationType": 4,
                          "namespace": "microsoft.web/sites",
                          "metricVisualization": {
                            "displayName": "Average memory working set",
                            "resourceDisplayName": "func-functionhost-charges-u-001"
                          }
                        },
                        {
                          "resourceMetadata": {
                            "id": "/subscriptions/${subscription_id}/resourceGroups/rg-DataHub-MarketParticipant-U-001/providers/Microsoft.Web/sites/func-organization-markpart-u-001"
                          },
                          "name": "AverageMemoryWorkingSet",
                          "aggregationType": 4,
                          "namespace": "microsoft.web/sites",
                          "metricVisualization": {
                            "displayName": "Average memory working set",
                            "resourceDisplayName": "func-organization-markpart-u-001"
                          }
                        },
                        {
                          "resourceMetadata": {
                            "id": "/subscriptions/${subscription_id}/resourceGroups/rg-DataHub-MarketRoles-U-001/providers/Microsoft.Web/sites/func-api-markrol-u-001"
                          },
                          "name": "AverageMemoryWorkingSet",
                          "aggregationType": 4,
                          "namespace": "microsoft.web/sites",
                          "metricVisualization": {
                            "displayName": "Average memory working set",
                            "resourceDisplayName": "func-api-markrol-u-001"
                          }
                        },
                        {
                          "resourceMetadata": {
                            "id": "/subscriptions/${subscription_id}/resourceGroups/rg-DataHub-MarketRoles-U-001/providers/Microsoft.Web/sites/func-ingestion-markrol-u-001"
                          },
                          "name": "AverageMemoryWorkingSet",
                          "aggregationType": 4,
                          "namespace": "microsoft.web/sites",
                          "metricVisualization": {
                            "displayName": "Average memory working set",
                            "resourceDisplayName": "func-ingestion-markrol-u-001"
                          }
                        },
                        {
                          "resourceMetadata": {
                            "id": "/subscriptions/${subscription_id}/resourceGroups/rg-DataHub-MarketRoles-U-001/providers/Microsoft.Web/sites/func-internalcommanddispatcher-markrol-u-001"
                          },
                          "name": "AverageMemoryWorkingSet",
                          "aggregationType": 4,
                          "namespace": "microsoft.web/sites",
                          "metricVisualization": {
                            "displayName": "Average memory working set",
                            "resourceDisplayName": "func-internalcommanddispatcher-markrol-u-001"
                          }
                        },
                        {
                          "resourceMetadata": {
                            "id": "/subscriptions/${subscription_id}/resourceGroups/rg-DataHub-MarketRoles-U-001/providers/Microsoft.Web/sites/func-internalcommanddispatcher-markrol-u-001"
                          },
                          "name": "AverageMemoryWorkingSet",
                          "aggregationType": 4,
                          "namespace": "microsoft.web/sites",
                          "metricVisualization": {
                            "displayName": "Average memory working set",
                            "resourceDisplayName": "func-internalcommanddispatcher-markrol-u-001"
                          }
                        },
                        {
                          "resourceMetadata": {
                            "id": "/subscriptions/${subscription_id}/resourceGroups/rg-DataHub-MarketRoles-U-001/providers/Microsoft.Web/sites/func-outbox-markrol-u-001"
                          },
                          "name": "AverageMemoryWorkingSet",
                          "aggregationType": 4,
                          "namespace": "microsoft.web/sites",
                          "metricVisualization": {
                            "displayName": "Average memory working set",
                            "resourceDisplayName": "func-outbox-markrol-u-001"
                          }
                        },
                        {
                          "resourceMetadata": {
                            "id": "/subscriptions/${subscription_id}/resourceGroups/rg-DataHub-MarketRoles-U-001/providers/Microsoft.Web/sites/func-processing-markrol-u-001"
                          },
                          "name": "AverageMemoryWorkingSet",
                          "aggregationType": 4,
                          "namespace": "microsoft.web/sites",
                          "metricVisualization": {
                            "displayName": "Average memory working set",
                            "resourceDisplayName": "func-processing-markrol-u-001"
                          }
                        },
                        {
                          "resourceMetadata": {
                            "id": "/subscriptions/${subscription_id}/resourceGroups/rg-DataHub-MessageArchive-U-001/providers/Microsoft.Web/sites/func-entrypoint-msgarch-u-001"
                          },
                          "name": "AverageMemoryWorkingSet",
                          "aggregationType": 4,
                          "namespace": "microsoft.web/sites",
                          "metricVisualization": {
                            "displayName": "Average memory working set",
                            "resourceDisplayName": "func-entrypoint-msgarch-u-001"
                          }
                        },
                        {
                          "resourceMetadata": {
                            "id": "/subscriptions/${subscription_id}/resourceGroups/rg-DataHub-MeteringPoint-U-001/providers/Microsoft.Web/sites/func-ingestion-mpt-u-001"
                          },
                          "name": "AverageMemoryWorkingSet",
                          "aggregationType": 4,
                          "namespace": "microsoft.web/sites",
                          "metricVisualization": {
                            "displayName": "Average memory working set",
                            "resourceDisplayName": "func-ingestion-mpt-u-001"
                          }
                        },
                        {
                          "resourceMetadata": {
                            "id": "/subscriptions/${subscription_id}/resourceGroups/rg-DataHub-MeteringPoint-U-001/providers/Microsoft.Web/sites/func-localmessagehub-mpt-u-001"
                          },
                          "name": "AverageMemoryWorkingSet",
                          "aggregationType": 4,
                          "namespace": "microsoft.web/sites",
                          "metricVisualization": {
                            "displayName": "Average memory working set",
                            "resourceDisplayName": "func-localmessagehub-mpt-u-001"
                          }
                        },
                        {
                          "resourceMetadata": {
                            "id": "/subscriptions/${subscription_id}/resourceGroups/rg-DataHub-MeteringPoint-U-001/providers/Microsoft.Web/sites/func-outbox-mpt-u-001"
                          },
                          "name": "AverageMemoryWorkingSet",
                          "aggregationType": 4,
                          "namespace": "microsoft.web/sites",
                          "metricVisualization": {
                            "displayName": "Average memory working set",
                            "resourceDisplayName": "func-outbox-mpt-u-001"
                          }
                        },
                        {
                          "resourceMetadata": {
                            "id": "/subscriptions/${subscription_id}/resourceGroups/rg-DataHub-MeteringPoint-U-001/providers/Microsoft.Web/sites/func-processing-mpt-u-001"
                          },
                          "name": "AverageMemoryWorkingSet",
                          "aggregationType": 4,
                          "namespace": "microsoft.web/sites",
                          "metricVisualization": {
                            "displayName": "Average memory working set",
                            "resourceDisplayName": "func-processing-mpt-u-001"
                          }
                        },
                        {
                          "resourceMetadata": {
                            "id": "/subscriptions/${subscription_id}/resourceGroups/rg-DataHub-PostOffice-U-001/providers/Microsoft.Web/sites/func-marketoperator-pstoff-u-001"
                          },
                          "name": "AverageMemoryWorkingSet",
                          "aggregationType": 4,
                          "namespace": "microsoft.web/sites",
                          "metricVisualization": {
                            "displayName": "Average memory working set",
                            "resourceDisplayName": "func-marketoperator-pstoff-u-001"
                          }
                        },
                        {
                          "resourceMetadata": {
                            "id": "/subscriptions/${subscription_id}/resourceGroups/rg-DataHub-PostOffice-U-001/providers/Microsoft.Web/sites/func-operations-pstoff-u-001"
                          },
                          "name": "AverageMemoryWorkingSet",
                          "aggregationType": 4,
                          "namespace": "microsoft.web/sites",
                          "metricVisualization": {
                            "displayName": "Average memory working set",
                            "resourceDisplayName": "func-operations-pstoff-u-001"
                          }
                        },
                        {
                          "resourceMetadata": {
                            "id": "/subscriptions/${subscription_id}/resourceGroups/rg-DataHub-PostOffice-U-001/providers/Microsoft.Web/sites/func-subdomain-pstoff-u-001"
                          },
                          "name": "AverageMemoryWorkingSet",
                          "aggregationType": 4,
                          "namespace": "microsoft.web/sites",
                          "metricVisualization": {
                            "displayName": "Average memory working set",
                            "resourceDisplayName": "func-subdomain-pstoff-u-001"
                          }
                        },
                        {
                          "resourceMetadata": {
                            "id": "/subscriptions/${subscription_id}/resourceGroups/rg-DataHub-TimeSeries-U-001/providers/Microsoft.Web/sites/func-time-series-bundle-ingestor-timeseries-u-001"
                          },
                          "name": "AverageMemoryWorkingSet",
                          "aggregationType": 4,
                          "namespace": "microsoft.web/sites",
                          "metricVisualization": {
                            "displayName": "Average memory working set",
                            "resourceDisplayName": "func-time-series-bundle-ingestor-timeseries-u-001"
                          }
                        }
                      ],
                      "title": "Avg Average memory working set for func-coordinator-aggre-u-001, func-integration-event-listener-aggre-u-001, and 16 other resources",
                      "titleKind": 1,
                      "visualization": {
                        "chartType": 2,
                        "legendVisualization": {
                          "isVisible": true,
                          "position": 2,
                          "hideSubtitle": false
                        },
                        "axisVisualization": {
                          "x": {
                            "isVisible": true,
                            "axisType": 2
                          },
                          "y": {
                            "isVisible": true,
                            "axisType": 1
                          }
                        },
                        "disablePinning": true
                      }
                    }
                  }
                }
              }
            }
          },
          "4": {
            "position": {
              "x": 12,
              "y": 4,
              "colSpan": 6,
              "rowSpan": 4
            },
            "metadata": {
              "inputs": [
                {
                  "name": "options",
                  "isOptional": true
                },
                {
                  "name": "sharedTimeRange",
                  "isOptional": true
                }
              ],
              "type": "Extension/HubsExtension/PartType/MonitorChartPart",
              "settings": {
                "content": {
                  "options": {
                    "chart": {
                      "metrics": [
                        {
                          "resourceMetadata": {
                            "id": "/subscriptions/${subscription_id}/resourceGroups/${charges_resource_group_name}/providers/Microsoft.Web/sites/app-webapi-charges-u-001"
                          },
                          "name": "AverageMemoryWorkingSet",
                          "aggregationType": 4,
                          "namespace": "microsoft.web/sites",
                          "metricVisualization": {
                            "displayName": "Average memory working set",
                            "resourceDisplayName": "app-webapi-charges-u-001"
                          }
                        },
                        {
                          "resourceMetadata": {
                            "id": "/subscriptions/${subscription_id}/resourceGroups/rg-DataHub-Frontend-U-001/providers/Microsoft.Web/sites/app-bff-fe-u-001"
                          },
                          "name": "AverageMemoryWorkingSet",
                          "aggregationType": 4,
                          "namespace": "microsoft.web/sites",
                          "metricVisualization": {
                            "displayName": "Average memory working set",
                            "resourceDisplayName": "app-bff-fe-u-001"
                          }
                        },
                        {
                          "resourceMetadata": {
                            "id": "/subscriptions/${subscription_id}/resourceGroups/rg-DataHub-MarketParticipant-U-001/providers/Microsoft.Web/sites/app-webapi-markpart-u-001"
                          },
                          "name": "AverageMemoryWorkingSet",
                          "aggregationType": 4,
                          "namespace": "microsoft.web/sites",
                          "metricVisualization": {
                            "displayName": "Average memory working set",
                            "resourceDisplayName": "app-webapi-markpart-u-001"
                          }
                        },
                        {
                          "resourceMetadata": {
                            "id": "/subscriptions/${subscription_id}/resourceGroups/rg-DataHub-MessageArchive-U-001/providers/Microsoft.Web/sites/app-webapi-msgarch-u-001"
                          },
                          "name": "AverageMemoryWorkingSet",
                          "aggregationType": 4,
                          "namespace": "microsoft.web/sites",
                          "metricVisualization": {
                            "displayName": "Average memory working set",
                            "resourceDisplayName": "app-webapi-msgarch-u-001"
                          }
                        },
                        {
                          "resourceMetadata": {
                            "id": "/subscriptions/${subscription_id}/resourceGroups/rg-DataHub-MeteringPoint-U-001/providers/Microsoft.Web/sites/app-webapi-mpt-u-001"
                          },
                          "name": "AverageMemoryWorkingSet",
                          "aggregationType": 4,
                          "namespace": "microsoft.web/sites",
                          "metricVisualization": {
                            "displayName": "Average memory working set",
                            "resourceDisplayName": "app-webapi-mpt-u-001"
                          }
                        }
                      ],
                      "title": "Avg Average memory working set for app-webapi-charges-u-001, app-bff-fe-u-001, and 3 other resources",
                      "titleKind": 1,
                      "visualization": {
                        "chartType": 2,
                        "legendVisualization": {
                          "isVisible": true,
                          "position": 2,
                          "hideSubtitle": false
                        },
                        "axisVisualization": {
                          "x": {
                            "isVisible": true,
                            "axisType": 2
                          },
                          "y": {
                            "isVisible": true,
                            "axisType": 1
                          }
                        },
                        "disablePinning": true
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    },
    "metadata": {
      "model": {
        "timeRange": {
          "value": {
            "relative": {
              "duration": 24,
              "timeUnit": 1
            }
          },
          "type": "MsPortalFx.Composition.Configuration.ValueTypes.TimeRange"
        },
        "filterLocale": {
          "value": "en-us"
        },
        "filters": {
          "value": {
            "MsPortalFx_TimeRange": {
              "model": {
                "format": "utc",
                "granularity": "auto",
                "relative": "24h"
              },
              "displayCache": {
                "name": "UTC Time",
                "value": "Past 24 hours"
              },
              "filteredPartIds": [
                "StartboardPart-MonitorChartPart-2696c7ee-b807-4f23-8c85-d18437bdfa69",
                "StartboardPart-MonitorChartPart-2696c7ee-b807-4f23-8c85-d18437bdfcda",
                "StartboardPart-MonitorChartPart-2fb11779-26e5-4488-9cf1-fcb9c8214108",
                "StartboardPart-MonitorChartPart-20f84b6b-1aa6-4d05-b7d8-9b9f80aca2d5",
                "StartboardPart-MonitorChartPart-20f84b6b-1aa6-4d05-b7d8-9b9f80acaac2"
              ]
            }
          }
        }
      }
    }
  },
  "name": "CPU Utilization - dbj test",
  "type": "Microsoft.Portal/dashboards",
  "location": "INSERT LOCATION",
  "tags": {
    "hidden-title": "CPU Utilization - dbj test"
  },
  "apiVersion": "2015-08-01-preview"
}