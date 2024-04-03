variable "namespaces" {
  type    = list(string)
  default = ["amuat", "amprod", "hsref", "hsint", "hsprod", "azint", "azprod", "shared"]
}

resource "vault_namespace" "default" {
  count = length(var.namespaces)
  path = var.namespaces[count.index]
}
