#!/usr/bin/env sh

# Variables used per certbot documentation for Pre and Post Validation Hooks:
# CERTBOT_DOMAIN: The domain being authenticated
# CERTBOT_VALIDATION: The validation string
#

domain_split=`echo ${CERTBOT_DOMAIN} | awk -f ./split_domain.awk`
subname=`echo $domain_split | cut -d ' ' -f 1`
zone=`echo $domain_split | cut -d ' ' -f 2` 
echo _acme-challenge.$subname $zone

# Create the record set for the zone.
az network dns record-set txt create --resource-group lab --zone-name $zone --name _acme-challenge.$subname --ttl 15
az network dns record-set txt add-record --resource-group lab --zone-name $zone --record-set-name _acme-challenge.$subname --value ${CERTBOT_VALIDATION}

# Give time for DNS to propagate.
sleep 60