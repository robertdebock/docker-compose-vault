resource "vault_auth_backend" "default" {
  type = "userpass"
}

resource "vault_generic_endpoint" "default" {
  path                 = "auth/${vault_auth_backend.default.path}/users/default"
  ignore_absent_fields = true
  data_json            = file("${path.module}/users/default.json")
}

resource "vault_generic_endpoint" "user" {
  path                 = "auth/${vault_auth_backend.default.path}/users/user"
  ignore_absent_fields = true
  data_json            = file("${path.module}/users/user.json")
}

resource "vault_generic_endpoint" "admin" {
  path                 = "auth/${vault_auth_backend.default.path}/users/admin"
  ignore_absent_fields = true
  data_json            = file("${path.module}/users/admin.json")
}
