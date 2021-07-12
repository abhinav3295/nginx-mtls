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
curl -k -vvvv \
    --cacert output/cert/caCert.pem \
    --cert output/cert/user.pem \
    --key output/cert/user.key \
    "https://localhost:8443"
```
