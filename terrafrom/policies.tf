resource "vault_policy" "admin" {
  name = "admin"
  policy = file("${path.module}/policies/admin.hcl")
}

resource "vault_policy" "users" {
  name = "users"
  policy = file("${path.module}/policies/users.hcl")
}
