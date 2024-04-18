# Create the definded namespaces.
resource "vault_namespace" "default" {
  count = length(var.namespaces)
  path  = var.namespaces[count.index]
}
