#!/bin/sh

unset VAULT_TOKEN

pass() {
  $@ > /dev/null 2>&1
  if [ $? != 0 ] ; then
    echo "FAIL"
  else
    echo "PASS"
  fi
}

fail() {
  ! $@ > /dev/null 2>&1
  if [ $? != 0 ] ; then
    echo "FAIL"
  else
    echo "PASS"
  fi
}

# Test if user-1 can login.
pass vault login -method=userpass username=user-1 password=changeme

# Test if user-1 can list secrets.
pass vault secrets list

# Test if user-1 can read roberts AWS secrets.
pass vault kv get robert/aws

# Test if user-1 can't read adfinis AWS secrets.
fail vault kv get adfinis/aws

# Test if user-2 can login.
pass vault login -method=userpass username=user-2 password=changeme

# Test if user-2 can list secrets.
pass vault secrets list

# Test if user-2 can read adfinis AWS secrets.
pass vault kv get adfinis/aws

# Test if user-2 can't read robert AWS secrets.
fail vault kv get robert/aws

# Test if user-3 can login.
pass vault login -method=userpass username=user-3 password=changeme
