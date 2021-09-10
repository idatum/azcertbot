#!/usr/bin/env sh

# Variables used per certbot documentation for Pre and Post Validation Hooks:
# CERTBOT_DOMAIN: The domain being authenticated

domain_split=`echo ${CERTBOT_DOMAIN} | awk -f ./split_domain.awk`
subname=`echo $domain_split | cut -d ' ' -f 1`
zone=`echo $domain_split | cut -d ' ' -f 2`
if [ "${subname}" = "${zone}" ]
then
    # No subname
    txtname="_acme-challenge"
else
    txtname="_acme-challenge.$subname"
fi
echo $txtname $zone

# Delete the record set.
az network dns record-set txt delete --yes --resource-group lab --zone-name $zone --name $txtname

# Any custom post actions
if [ -f ./custom_post_action.sh ]
then
    env sh custom_post_action.sh
fi