# cd /vault-compose/scripts

# 1. Vaul init, store key and root token in file vault.init
vault operator init -key-shares=1 -key-threshold=1 > vault.init

# 2. Unseal and login vault
export VAULT_ADDR=http://127.0.0.1:8200

# Use key in step 1
vault operator unseal

# Use root token in step 1
vault login

# 3. create secret
vault secrets enable -path=secret/ kv-v2
vault kv put secret/redis password=redis
vault kv put secret/postgres login=user, password=1234

# 4. create approle
vault auth enable approle
vault policy write my-policy my-policy.hcl
vault write auth/approle/role/my_apps policies="my-policy"

# 5. get roleID and secretID in files from Vault for agent config:
# role_id_file_path = "/vault/config/my_apps_roleID"
# secret_id_file_path = "/vault/config/my_apps_secretID"
vault read -format=json auth/approle/role/my_apps/role-id | jq  -r '.data.role_id' > my_apps_roleID
vault write -f -format=json auth/approle/role/my_apps/secret-id | jq -r '.data.secret_id' > my_apps_secretID

# 6. get token for example in get-secrets.sh
vault write auth/approle/login role_id="a2a1253f-ae99-aef4-5360-7220c500d985" \
  secret_id="606151b4-bebc-7e88-4a40-d19db7afc0b2"

# 7. in code we take token from file /vault/config/approleToken which mount as path /home/dnabiev/vault-docker/agent in docker-compose.yml
