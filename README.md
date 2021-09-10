# Use certbot and Azure CLI to renew Let's Encrypt certificate using DNS validation.

Requirements:
- Azure CLI installed and already logged in (e.g. sudo az login).
- certbot installed.
- Access to locally installed Let's Encrypt certificates.
- Access to DNS zone on Azure.

Usage:

`sh renew_cert.sh example.com,www.example.com`