# Define policies, each has a name and paths. Each item of paths has a path and capabilities.
variable "policies" {
  type = list(object({
    name  = string
    paths = list(object({
      path         = string
      capabilities = list(string)
    }))
  }))
  default = [
    {
      name = "am-uat-reader"
      paths = [
        {
          path         = "amuat/*"
          capabilities = ["list", "read"]
        },
        {
          path         = "amuat/data/*"
          capabilities = ["read", "list"]
        }
      ]
    },
    {
      name = "am-uat-editor"
      paths = [
        {
          path         = "amuat/*"
          capabilities = ["list", "read", "update"]
        },
        {
          path         = "amuat/data/*"
          capabilities = ["read", "create", "update", "delete", "list"]
        }
      ]
    },
    {
      name = "am-uat-admin"
      paths = [
        {
          path = "amuat/sys/health"
          capabilities = ["read", "sudo"]
        },
        {
          path = "amuat/sys/policies/acl"
          capabilities = ["list"]
        },
        {
          path = "amuat/sys/policies/acl/*"
          capabilities = ["create", "read", "update", "delete", "list", "sudo"]
        },
        {
          path = "amuat/auth/*"
          capabilities = ["create", "read", "update", "delete", "list", "sudo"]
        },
        {
          path = "amuat/sys/auth/*"
          capabilities = ["create", "update", "delete", "sudo"]
        },
        {
          path = "amuat/sys/auth"
          capabilities = ["read"]
        },
        {
          path = "amuat/secret/*"
          capabilities = ["create", "read", "update", "delete", "list", "sudo"]
        },
        {
          path = "amuat/sys/mounts/*"
          capabilities = ["create", "read", "update", "delete", "list", "sudo"]
        },
        {
          path = "amuat/sys/mounts"
          capabilities = ["read"]
        }
      ]
    },
    {
      name = "am-prod-reader"
      paths = [
        {
          path         = "amprod/sys/*"
          capabilities = ["list", "read"]
        },
        {
          path         = "amprod/*"
          capabilities = ["list"]
        },
        {
          path         = "amprod/data/*"
          capabilities = ["read", "create", "update", "delete", "list"]
        }
      ]
    },
    {
      name = "am-prod-editor"
      paths = [
        {
          path         = "amprod/sys/*"
          capabilities = ["list", "read"]
        },
        {
          path         = "amprod/*"
          capabilities = ["list"]
        },
        {
          path         = "amprod/data/*"
          capabilities = ["read", "create", "update", "delete", "list"]
        }
      ]
    },
    {
      name = "am-prod-admin"
      paths = [
        {
          path = "amprod/sys/health"
          capabilities = ["read", "sudo"]
        },
        {
          path = "amprod/sys/policies/acl"
          capabilities = ["list"]
        },
        {
          path = "amprod/sys/policies/acl/*"
          capabilities = ["create", "read", "update", "delete", "list", "sudo"]
        },
        {
          path = "amprod/auth/*"
          capabilities = ["create", "read", "update", "delete", "list", "sudo"]
        },
        {
          path = "amprod/sys/auth/*"
          capabilities = ["create", "update", "delete", "sudo"]
        },
        {
          path = "amprod/sys/auth"
          capabilities = ["read"]
        },
        {
          path = "amprod/secret/*"
          capabilities = ["create", "read", "update", "delete", "list", "sudo"]
        },
        {
          path = "amprod/sys/mounts/*"
          capabilities = ["create", "read", "update", "delete", "list", "sudo"]
        },
        {
          path = "amprod/sys/mounts"
          capabilities = ["read"]
        }
      ]
    }
  ]
}

# Create the policies.
resource "vault_policy" "default" {
  count  = length(var.policies)
  name   = var.policies[count.index].name
  policy = templatefile("${path.module}/templates/policy.tftpl", {
    paths = var.policies[count.index].paths
  })
}
