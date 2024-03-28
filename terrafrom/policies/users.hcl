path "sys/*" {
  capabilities = ["list", "read"]
}

path "customer_1/*" {
    capabilities = ["list"]
}

path "customer_1/data/*" {
  capabilities = ["read", "create", "update", "delete", "list"]
}
