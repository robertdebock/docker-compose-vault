resource "vault_auth_backend" "default" {
  disable_remount = false
  local           = false
  path            = "userpass"
  tune            = []
  type            = "userpass"
}
