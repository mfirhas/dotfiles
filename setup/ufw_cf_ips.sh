#!/bin/bash

# Make sure to deny any incoming first.
ufw default deny incoming 

# Allow cloudflare IPv4 ranges
for ip in $(curl -s https://www.cloudflare.com/ips-v4); do
    ufw allow from "$ip"
done

# Allow cloudflare IPv6 ranges
for ip in $(curl -s https://www.cloudflare.com/ips-v6); do
    ufw allow from "$ip"
done

echo "Cloudflare IPs added to ufw"
