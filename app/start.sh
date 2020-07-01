set e
  
# shift
# cmd="$@"

# run Vault agent
>&2 echo "Vault agent run"

/vault/vault agent -config=/vault/config/agent.conf > /var/log/vault/vault.log 2>&1 &

>&2 echo "Nginx run"
# exec $cmd
nginx -g 'daemon off;'