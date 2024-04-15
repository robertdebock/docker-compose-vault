# Create a secrets engine "one" in each namespace.
resource "vault_mount" "one" {
  count       = length(var.namespaces)
  path        = "one"
  type        = "kv-v2"
  namespace   = vault_namespace.default[count.index].path
  options     = {
    version = "2"
  }
  description = "KV Secrets engine 1."
}

# Create a secrets "my_secret" in secrets engine "one" in each namespace.
resource "vault_generic_secret" "one" {
  count     = length(var.namespaces)
  namespace = var.namespaces[count.index]
  path      = "${vault_mount.one[count.index].path}/my_secret"
  data_json = file("${path.module}/secrets/my_secret.json")
}

# Create a secrets engine "two" in each namespace.
resource "vault_mount" "two" {
  count       = length(var.namespaces)
  path        = "two"
  type        = "kv-v2"
  namespace   = vault_namespace.default[count.index].path
  options     = {
    version = "2"
  }
  description = "KV Secrets engine 2."
}

# Create a secrets "my_secret" in secrets engine "two" in each namespace.
resource "vault_generic_secret" "two" {
  count     = length(var.namespaces)
  namespace = vault_namespace.default[count.index].path
  path      = "${vault_mount.two[count.index].path}/my_secret"
  data_json = file("${path.module}/secrets/my_secret.json")
}
