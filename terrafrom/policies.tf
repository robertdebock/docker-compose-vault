resource "vault_policy" "admin" {
  name = "admin"
  policy = file("${path.module}/policies/admin.hcl")
}

resource "vault_policy" "adfinis" {
  name = "adfinis"
  policy = file("${path.module}/policies/adfinis.hcl")
}

resource "vault_policy" "robert" {
  name = "robert"
  policy = file("${path.module}/policies/robert.hcl")
}
