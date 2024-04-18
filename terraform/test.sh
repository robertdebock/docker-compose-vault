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

for namespace in amuat ; do
  for user in am-uat-reader am-uat-editor am-uat-remover am-uat-admin ; do
    # user should be able to login
    pass vault login -method=userpass username=${user} password=changeme

    # user should be able too lookup it's own token
    pass vault token lookup

    # user should be able to list
    pass vault secrets list -namespace ${namespace}

    # user should not be able too lookup it's own token when logged out
    pass rm ~/.vault-token
    fail vault token lookup

    # user should not be able too lookup it's own token
    fail vault secrets list -namespace ${namespace}

    # user should not be able to list
    fail vault secrets list -namespace ${namespace}
  done
  for user in am-uat-reader ; do
    # user should be able to login
    pass vault login -method=userpass username=${user} password=changeme

    # user should be able to read this secret.
    pass vault kv get -namespace=${namespace} -mount="one" "my_secret"

    # user should not be able to write a secret
    fail vault kv put -namespace=${namespace} -mount="one" my_secret username=some_username_2 password=some_password_2
  done
  for user in am-uat-editor ; do
    # user should be able to login
    pass vault login -method=userpass username=${user} password=changeme

    # user should be able to read this secret.
    pass vault kv get -namespace=${namespace} -mount="one" "my_secret"

    # user should be able to write a secret
    pass vault kv put -namespace=${namespace} -mount="one" my_secret username=some_username_2 password=some_password_2

    # user should not be able to delete a secret
    fail vault kv delete -namespace=${namespace} -mount="one" my_secret
  done
  for user in am-uat-remover ; do
    # user should be able to login
    pass vault login -method=userpass username=${user} password=changeme

    # user should be able to read this secret.
    pass vault kv get -namespace=${namespace} -mount="one" "my_secret"

    # user should be able to delete a secret
    pass vault kv delete -namespace=${namespace} -mount="one" my_secret
  done
  
   # Recreate the deleted secret
   pass vault login -method=userpass username=am-uat-editor password=changeme
   pass vault kv put -namespace=${namespace} -mount="one" my_secret username=some_username_3 password=some_password_3
done

for user in am-uat-admin ; do
  # user should be able to login
  pass vault login -method=userpass username=${user} password=changeme

  # user should not be able to read this secret.
  fail vault kv get -namespace=${namespace} -mount="one" "my_secret"

  # user should not be able to write a secret
  fail vault kv put -namespace=${namespace} -mount="one" my_secret username=some_username_2 password=some_password_2
done
