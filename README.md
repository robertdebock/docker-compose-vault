# Vault

A container with HashiCorp Vault.

## Setup

Start the container.

```bash
docker-compose up -d
```

Initialize HashiCorp Vault.

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
