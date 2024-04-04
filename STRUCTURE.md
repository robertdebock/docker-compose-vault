```yaml
authentication_engines:
  userpass:
    users:
      - user: x
        password:
    policies:
      - d
      - e
  ldap:
    users:
      - user: a

policies:
  - name: d
    paths:
      - path: x
        capabilities:
          - read
          - write
  - name: 3
    paths:
      - path: y
        capabilities:
          - read
          - write
groups:
  - name: z
    policies:
      - d
      - e

entities:
  - name: y
    alias:
      - x (userpass)
      - a (ldap)
    groups:
      - name: z
```
