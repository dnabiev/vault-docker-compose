curl \
    --header "X-Vault-Token: s.cinJf5fizJPva3xSZbxq2Hu6" \
    http://127.0.0.1:8200/v1/secret/data/redis | jq -r

curl \
    --header "X-Vault-Token: s.cinJf5fizJPva3xSZbxq2Hu6" \
    http://127.0.0.1:8200/v1/secret/data/postgres | jq -r