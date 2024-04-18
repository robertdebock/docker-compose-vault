namespaces = ["amuat", "amprod", "hsref", "hsint", "hsprod", "azint", "azprod", "shared"]

users = [
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
    name     = "am-uat-remover"
    policies = ["default", "am-uat-remover"]
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
    name     = "am-prod-remover"
    policies = ["default", "am-prod-remover"]
    password = "changeme"
  },
  {
    name     = "am-prod-admin"
    policies = ["default", "am-prod-admin"]
    password = "changeme"
  }
]

policies = [
  {
    name = "am-uat-reader"
    paths = [
      {
        path         = "amuat/*"
        capabilities = ["read", "list"]
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
        capabilities = ["read", "list", "update"]
      },
      {
        path         = "amuat/data/*"
        capabilities = ["read", "list", "create", "update", "delete", ]
      }
    ]
  },
  {
    name = "am-uat-remover"
    paths = [
      {
        path         = "amuat/*"
        capabilities = ["read", "list", "delete"]
      },
      {
        path         = "amuat/data/*"
        capabilities = ["read", "list", "delete"]
      }
    ]
  },
  {
    name = "am-uat-admin"
    paths = [
      {
        path         = "amuat/sys/health"
        capabilities = ["read", "sudo"]
      },
      {
        path         = "amuat/sys/policies/acl"
        capabilities = ["list"]
      },
      {
        path         = "amuat/sys/policies/acl/*"
        capabilities = ["read", "list", "create", "update", "delete", "sudo"]
      },
      {
        path         = "amuat/auth/*"
        capabilities = ["read", "list", "create", "update", "delete", "sudo"]
      },
      {
        path         = "amuat/sys/auth/*"
        capabilities = ["create", "update", "delete", "sudo"]
      },
      {
        path         = "amuat/sys/auth"
        capabilities = ["read"]
      },
      {
        path         = "amuat/secret/*"
        capabilities = ["read", "list", "create", "update", "delete", "sudo"]
      },
      {
        path         = "amuat/sys/mounts/*"
        capabilities = ["read", "list", "create", "update", "delete", "sudo"]
      },
      {
        path         = "amuat/sys/mounts"
        capabilities = ["read"]
      }
    ]
  },
  {
    name = "am-prod-reader"
    paths = [
      # Is the below required?
      {
        path         = "amprod/sys/*"
        capabilities = ["read", "list"]
      },
      {
        path         = "amprod/*"
        capabilities = ["read", "list"]
      },
      {
        path         = "amprod/data/*"
        capabilities = ["read", "list"]
      }
    ]
  },
  {
    name = "am-prod-editor"
    paths = [
      {
        path         = "amprod/sys/*"
        capabilities = ["read", "list"]
      },
      {
        path         = "amprod/*"
        capabilities = ["read", "list"]
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
        path         = "amprod/sys/health"
        capabilities = ["read", "sudo"]
      },
      {
        path         = "amprod/sys/policies/acl"
        capabilities = ["list"]
      },
      {
        path         = "amprod/sys/policies/acl/*"
        capabilities = ["read", "list", "create", "update", "delete", "sudo"]
      },
      {
        path         = "amprod/auth/*"
        capabilities = ["read", "list", "create", "update", "delete", "sudo"]
      },
      {
        path         = "amprod/sys/auth/*"
        capabilities = ["create", "update", "delete", "sudo"]
      },
      {
        path         = "amprod/sys/auth"
        capabilities = ["read"]
      },
      {
        path         = "amprod/secret/*"
        capabilities = ["read", "list", "create", "update", "delete", "sudo"]
      },
      {
        path         = "amprod/sys/mounts/*"
        capabilities = ["read", "list", "create", "update", "delete", "sudo"]
      },
      {
        path         = "amprod/sys/mounts"
        capabilities = ["read"]
      }
    ]
  }
]
