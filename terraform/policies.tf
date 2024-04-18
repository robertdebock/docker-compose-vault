# Create the policies.
resource "vault_policy" "default" {
  count = length(var.policies)
  name  = var.policies[count.index].name
  policy = templatefile("${path.module}/templates/policy.tftpl", {
    paths = var.policies[count.index].paths
  })
}
