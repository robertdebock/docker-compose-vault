#!/bin/bash

# Set VAULT_ADDR if not set.
if [ ! -n ${VAULT_ADDR} ] ; then
  export VAULT_ADDR="http://127.0.0.1:8200"
fi

# Unset VAULT_TOKEN if set.
if [ -n ${VAULT_TOKEN} ] ; then
  unset VAULT_TOKEN
fi

# A function to test if the result was succesful.
pass() {
  $@ > /dev/null 2>&1
  if [ $? != 0 ] ; then
    echo -e "\u2620 should-fail: $@"
  else
    echo -e "\xE2\x9C\x94 should-pass: $@"
  fi
}

# A function to test if the result was unsuccesful.
fail() {
  $@ > /dev/null 2>&1
  if [ $? != 0 ] ; then
    echo -e "\xE2\x9C\x94 should-fail: $@"
  else
    echo -e "\u2620 should-pass: $@"
  fi
}

for user in am-uat-reader am-uat-editor am-uat-admin ; do
  # user should be able to login
  pass vault login -method=userpass username=${user} password=changeme

  # user should be able too lookup it's own token
  pass vault token lookup

  # user should be able to list
  pass vault secrets list -namespace amuat
done

for user in am-uat-reader ; do
  # user should be able to login
  pass vault login -method=userpass username=${user} password=changeme

  # user be able to read this secret.
  pass vault kv get -namespace=amuat -mount="one" "my_secret"

  # user should not be able to write a secret
  fail vault kv put -namespace=amuat -mount="one" my_secret username=some_username_2 password=some_password_2
done

for user in am-uat-editor ; do
  # user should be able to login
  pass vault login -method=userpass username=${user} password=changeme

  # user be able to read this secret.
  pass vault kv get -namespace=amuat -mount="one" "my_secret"

  # user should be able to write a secret
  pass vault kv put -namespace=amuat -mount="one" my_secret username=some_username_2 password=some_password_2
done

for user in am-uat-admin ; do
  # user should be able to login
  pass vault login -method=userpass username=${user} password=changeme
done
