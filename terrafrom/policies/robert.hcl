path "sys/*" {
  capabilities = ["list", "read"]
}

path "robert/*" {
    capabilities = ["list"]
}

path "robert/data/*" {
  capabilities = ["read", "create", "update", "delete", "list"]
}
