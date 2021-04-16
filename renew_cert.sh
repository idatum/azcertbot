#!/usr/bin/env sh

# Usage: sh renew_certbot.sh www.example.com [--dry-run]

domain=$1
if [ -d $domain ]
then
    echo "Full domain name required (e.g. www.example.com)"
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

certbot certonly \
            $dryrun \
            -d $domain \
            --non-interactive --manual-public-ip-logging-ok --agree-tos --manual \
            --preferred-challenges=dns \
            --manual-auth-hook ./certbot_dns_auth.sh \
            --manual-cleanup-hook ./certbot_dns_cleanup.sh