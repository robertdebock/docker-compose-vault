# Vault

A container with HashiCorp Vault.

## Setup

Place a license in `vault.hclic`.

Start the container.

```bash
export VAULT_LICENSE=$(cat vault.hclic) 
docker-compose up -d
```

Initialize HashiCorp Vault. (Only required once.)

```bash
export VAULT_ADDR="http://127.0.0.1:8200"
vault operator init
```

Unseal HashiCorp Vault. This is required each time the container is started.

```bash
vault operator unseal
```

Login to HashiCorp Vault.

```bash
vault login
```
