terraform {
  required_providers {
    vault = {
      source = "hashicorp/vault"
      version = "4.1.0"
    }
  }
}

provider "vault" {
  # Configuration options
}
