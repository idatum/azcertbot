#!/usr/bin/env sh

# Usage: sh renew_certbot.sh www.example.com[,example.com,...] [--dry-run]

domains=$1
if [ ! $domains ]
then
    echo "One or more full domain names required."
    echo "Usage: sh renew_certbot.sh www.example.com[,example.com,...] [--dry-run]"
    exit 2
fi

dryrun=$2
if [ $dryrun ]
then
    if [ $dryrun != "--dry-run" ]
    then
        echo "--dry-run is the only valid option."
        exit 2
    fi
    echo === dry run ===
fi

domain_params=`echo $domains | awk -f ./domain_params.awk`

certbot certonly \
            $dryrun \
            $domain_params \
            --non-interactive --manual-public-ip-logging-ok --agree-tos --manual \
            --preferred-challenges=dns \
            --manual-auth-hook ./certbot_dns_auth.sh \
            --manual-cleanup-hook ./certbot_dns_cleanup.sh