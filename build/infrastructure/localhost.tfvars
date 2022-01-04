
/*
Make sure to select values that ensures globally unique names of resources.
This is required for e.g. SQL Server and more. Failure to do so does not always result
in intuitive errors. As an example a time out on creating SQL Server has been observed.

Also be cautious about length of strings as some resources have a very limited
max name length.
*/

domain_name_short                       = "vnettest"
environment_short                       = "x"
environment_instance                    = "1"
resource_group_name                     = "rg-khs"
subscription_id                         = "51f48dbe-8726-4fee-9886-3889b03fd8d4"
sharedresources_keyvault_name           = "kv-main-sharedres-u-002"
sharedresources_resource_group_name     = "rg-DataHub-SharedResouces-U-002"
notification_email                      = "xkhs@energinet.dk"
project_name                            = "vnet-test-project"