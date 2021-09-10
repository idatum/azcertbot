#!/usr/bin/env sh

# Variables used per certbot documentation for Pre and Post Validation Hooks:
# CERTBOT_DOMAIN: The domain being authenticated
# CERTBOT_VALIDATION: The validation string
#

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

# Create the record set for the zone.
az network dns record-set txt create --resource-group lab --zone-name $zone --name $txtname --ttl 15
if [ $? -ne 0 ]
then
    exit 2
fi
az network dns record-set txt add-record --resource-group lab --zone-name $zone --record-set-name $txtname --value ${CERTBOT_VALIDATION}
if [ $? -ne 0 ]
then
    exit 2
fi

# Give time for DNS to propagate.
sleep 60