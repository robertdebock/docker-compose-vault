# Create an audit device.
resource "vault_audit" "file" {
  type = "file"
  options = {
    file_path = "/vault/logs/audit.log"
  }
}
