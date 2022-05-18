#!/bin/bash

# Bash strict mode, stop on any error
set -e
new_token="test12345"
jq -n --arg token "$new_token" '{"token":$token}'

# eval "$(jq -r '@sh "DATABRICKS_WORKSPACE_RESOURCE_ID=\(.DATABRICKS_WORKSPACE_RESOURCE_ID) ARM_CLIENT_ID=\(.ARM_CLIENT_ID) ARM_CLIENT_SECRET=\(.ARM_CLIENT_SECRET) ARM_TENANT_ID=\(.ARM_TENANT_ID) DATABRICKS_ENDPOINT=\(.DATABRICKS_ENDPOINT)"')"

# # Login
# az login --service-principal -u "$ARM_CLIENT_ID" -p "$ARM_CLIENT_SECRET" -t "$ARM_TENANT_ID"

# # Get a token for the global Databricks application.
# # The resource name is fixed and never changes.
# token_response=$(az account get-access-token --resource 2ff814a6-3304-4ab8-85cb-cd0e6f879c1d)
# token=$(jq .accessToken -r <<< "$token_response")

# # Get a token for the Azure management API
# token_response=$(az account get-access-token --resource https://management.core.windows.net/)
# azToken=$(jq .accessToken -r <<< "$token_response")

# # Generate a PAT token. Note the quota limit of 600 tokens.
# api_response=$(curl -sf $DATABRICKS_ENDPOINT/api/2.0/token/create \
#   -H "Authorization: Bearer $token" \
#   -H "X-Databricks-Azure-SP-Management-Token:$azToken" \
#   -H "X-Databricks-Azure-Workspace-Resource-Id:$DATABRICKS_WORKSPACE_RESOURCE_ID" \
#   -d '{ "comment": "Terraform-generated token" }')
# pat_token=$(jq .token_value -r <<< "$api_response")
