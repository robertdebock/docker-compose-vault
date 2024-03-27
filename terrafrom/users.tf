resource "vault_generic_endpoint" "user-1" {
  path                 = "auth/${vault_auth_backend.default.path}/users/user-1"
  ignore_absent_fields = true
  data_json            = file("${path.module}/users/user-1.json")
}

resource "vault_generic_endpoint" "user-2" {
  path                 = "auth/${vault_auth_backend.default.path}/users/user-2"
  ignore_absent_fields = true
  data_json            = file("${path.module}/users/user-2.json")
}

resource "vault_generic_endpoint" "user-3" {
  path                 = "auth/${vault_auth_backend.default.path}/users/user-3"
  ignore_absent_fields = true
  data_json            = file("${path.module}/users/user-3.json")
}
