#!/bin/bash

if [[ "$1" != "--skip-login" ]]; then
    az login
fi

SUBSCRIPTION_ID=$(az account show --query id -o tsv)

SP_INFO=$(az ad sp create-for-rbac --name "servicePrincipal1" --role contributor --scope /subscriptions/$SUBSCRIPTION_ID)

APP_ID=$(echo $SP_INFO | cut -d '"' -f 4)
PASSWORD=$(echo $SP_INFO | cut -d '"' -f 12)
TENANT=$(echo $SP_INFO | cut -d '"' -f 16)

OUTPUT_FILE=".env"

echo "SUBSCRIPTION_ID: $SUBSCRIPTION_ID" > $OUTPUT_FILE
echo "APP_ID: $APP_ID" >> $OUTPUT_FILE
echo "PASSWORD: $PASSWORD" >> $OUTPUT_FILE
echo "TENANT: $TENANT" >> $OUTPUT_FILE