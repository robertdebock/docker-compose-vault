resource "vault_mount" "customer_1" {
  path        = "customer_1"
  type        = "kv-v2"
  options     = {
    version = "2"
  }
  description = "Secrets for Customer 1"
}

resource "vault_mount" "customer_2" {
  path        = "customer_2"
  type        = "kv-v2"
  options     = {
    version = "2"
  }
  description = "Secrets for Customer 2"
}


resource "vault_generic_secret" "some_secret_1" {
  path = "${vault_mount.customer_1.path}/some_secret"
  data_json = file("${path.module}/secrets/some_secret_1.json")
}

resource "vault_generic_secret" "some_secret_2" {
  path = "${vault_mount.customer_2.path}/some_secret"
  data_json = file("${path.module}/secrets/some_secret_2.json")
}
