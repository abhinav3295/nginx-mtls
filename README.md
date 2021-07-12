# Description
This project demos :
1. Generating Certificates
    1. Creating root and intermediate CA
    1. Generating Leaf CSR and signing them
1. Setting up nginx
    1. to terminate SSL
    1. requesting client certificates
    1. passing client certificate dn to an upstream

# Pre Requisite
* You will need `docker` installed on your system to get started

# Setup

## starting server
* execute `docker compose up`

## making request

```
curl -vvvv \
    --cacert gateway/output/cert/caCert.pem \
    --cert gateway/output/cert/user_fullchain.pem \
    --key gateway/output/cert/user.key \
    "https://localhost:8443"
```

Wiremock backend is deployed at `/upstream`, it can be reached at:
```
curl -vvvv \
    --cacert gateway/output/cert/caCert.pem \
    --cert gateway/output/cert/user_fullchain.pem \
    --key gateway/output/cert/user.key \
    "https://localhost:8443/upstream/some/thing"
```