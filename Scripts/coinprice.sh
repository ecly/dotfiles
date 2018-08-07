#!/bin/sh
rate=$(curl -sf https://api.coinmarketcap.com/v1/ticker/$1/ | jq ".[0].price_usd")
rate=$(echo "$rate" | xargs printf '%.2f')
echo "$rate$"
