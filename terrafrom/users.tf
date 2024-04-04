# Mount the "userpass" authentication engine.
resource "vault_auth_backend" "default" {
  type = "userpass"
}

# Define users, with a policy and password.
variable "users" {
  type = list(object({
    name     = string
    policies = list(string)
    password = string
  }))
  default = [
    {
      name     = "am-uat-reader"
      policies = ["default", "am-uat-reader"]
      password = "changeme"
    },
    {
      name     = "am-uat-editor"
      policies = ["default", "am-uat-editor"]
      password = "changeme"
    },
    {
      name     = "am-uat-admin"
      policies = ["default", "am-uat-admin"]
      password = "changeme"
    },
    {
      name     = "am-prod-reader"
      policies = ["default", "am-prod-reader"]
      password = "changeme"
    },
    {
      name     = "am-prod-editor"
      policies = ["default", "am-prod-editor"]
      password = "changeme"
    },
    {
      name     = "am-prod-admin"
      policies = ["default", "am-prod-admin"]
      password = "changeme"
    }
  ]
}

# Create the defined users.
resource "vault_generic_endpoint" "default" {
  count                = length(var.users)
  path                 = "auth/${vault_auth_backend.default.path}/users/${var.users[count.index].name}"
  ignore_absent_fields = true
  data_json            = templatefile("${path.module}/templates/user.tftpl", {
    policies = var.users[count.index].policies,
    password = var.users[count.index].password
  })
}
