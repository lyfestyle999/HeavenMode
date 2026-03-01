#!/bin/bash
TOKEN_VALUE="${HEAVEN_TOKEN}"
CURRENT_IP=$(curl -s ifconfig.me || echo "0.0.0.0")
TARGET="heaven_mode"

S_URL="https://nineioxlmxijmiqddvqw.supabase.co/rest/v1/rpc/get_protected_script"
S_KEY="sb_publishable_nT9SJJgb6j918DC6ePvGJw_ihFhoO0U"

echo "💤Подключаемся к HEAVEN...💤"

RESPONSE=$(curl -s -X POST "$S_URL" \
    -H "apikey: $S_KEY" \
    -H "Authorization: Bearer $S_KEY" \
    -H "Content-Type: application/json" \
    -d "{\"p_token\": \"$TOKEN_VALUE\", \"p_ip\": \"$CURRENT_IP\", \"p_script_name\": \"$TARGET\"}")

if [[ -z "$RESPONSE" || "$RESPONSE" == *"error"* ]]; then
    echo "❌Неверный токен❌"
    sleep infinity
    exit 1
fi

echo "$RESPONSE" | python3 -c "import sys, json; print(json.load(sys.stdin))" | bash
