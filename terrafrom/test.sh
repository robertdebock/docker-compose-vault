#!/bin/sh

unset VAULT_TOKEN

pass() {
  $@ > /dev/null 2>&1
  if [ $? != 0 ] ; then
    echo "BAAD, failed: $@"
  else
    echo "GOOD, passed: $@"
  fi
}

fail() {
  $@ > /dev/null 2>&1
  if [ $? != 0 ] ; then
    echo "GOOD, failed: $@"
  else
    echo "BAAD, passed $@"
  fi
}

# default should be able to login
pass vault login -method=userpass username=default password=changeme

# default sould not be able to list
fail vault secrets list

# default should not be able to read this secret.
fail vault kv get customer_1/some_secret

# default should not be able to read this secret.
fail vault kv get customer_2/some_secret

# user should be able to login
pass vault login -method=userpass username=user password=changeme

# user should be able to list
pass vault secrets list

# user should be able to read this seret.
pass vault kv get customer_1/some_secret

# user should be not able to read this seret
fail vault kv get customer_2/some_secret

# admin should be able to login
pass vault login -method=userpass username=admin password=changeme
