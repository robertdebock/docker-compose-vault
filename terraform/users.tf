# Mount the "userpass" authentication engine.
resource "vault_auth_backend" "default" {
  type = "userpass"
}

# Create the defined users.
resource "vault_generic_endpoint" "default" {
  count                = length(var.users)
  path                 = "auth/${vault_auth_backend.default.path}/users/${var.users[count.index].name}"
  ignore_absent_fields = true
  data_json = templatefile("${path.module}/templates/user.tftpl", {
    policies = var.users[count.index].policies,
    password = var.users[count.index].password
  })
}
