# Define the namespaces.
variable "namespaces" {
  type = list(string)
}

# Define users, with a policy and password.
variable "users" {
  type = list(object({
    name     = string
    policies = list(string)
    password = string
  }))
}

# Define policies, each has a name and paths. Each item of paths has a path and capabilities.
variable "policies" {
  type = list(object({
    name = string
    paths = list(object({
      path         = string
      capabilities = list(string)
    }))
  }))
}
