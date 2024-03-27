path "sys/*" {
  capabilities = ["list", "read"]
}

path "adfinis/*" {
    capabilities = ["list"]
}

path "adfinis/data/*" {
  capabilities = ["read", "create", "update", "delete", "list"]
}
