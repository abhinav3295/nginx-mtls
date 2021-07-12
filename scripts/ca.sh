#!/usr/bin/env bash

source ./var.sh

rm -rf ${OUTPUT_DIR}
mkdir -p ${CERT_DIR}

# CA SAN extention Config
export SAN_CONFIG=${OUTPUT_DIR}/ca_san.ext
export SAN_CONFIG_LEAF=${OUTPUT_DIR}/ca_san_leaf.ext
export CA_DN="/C=SG/ST=Singapore/L=Singapore/O=SSL Demo/OU=Root/CN=Test Root"
export ISSUER_DN="/C=SG/ST=Singapore/L=Singapore/O=SSL Demo/OU=Issuer/CN=Test Issuer"
export USER_DN="/C=SG/ST=Singapore/L=Singapore/O=SSL Demo/OU=User/CN=Test User"
export WEBSERV_DN="/C=SG/ST=Singapore/L=Singapore/O=SSL Demo/OU=Webiste Server/CN=localhost"

cat >${SAN_CONFIG} <<EOL
authorityKeyIdentifier=keyid,issuer
basicConstraints=critical, CA:TRUE
keyUsage =critical, digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment, keyCertSign
extendedKeyUsage = serverAuth, clientAuth
EOL

cat >${SAN_CONFIG_LEAF} <<EOL
authorityKeyIdentifier=keyid,issuer
basicConstraints=critical, CA:FALSE
keyUsage =critical, digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
extendedKeyUsage = serverAuth, clientAuth
EOL

## CA Certs
# Generate Root Certs
openssl req -x509 -sha256 -nodes -days 365 -newkey rsa:2048 -keyout ${CA_PRIVATE_KEY} -out ${CA_CERT} -subj "${CA_DN}"

# Generate Issuer Cert
openssl req -new -newkey rsa:2048 -nodes -out ${ISSUER_CSR} -keyout ${ISSUER_PRIVATE_KEY} -subj "${ISSUER_DN}"

# Sign CSR
openssl x509 -req -sha256 -CAcreateserial -days 825 -in ${ISSUER_CSR} -CA ${CA_CERT} -CAkey ${CA_PRIVATE_KEY} -extfile ${SAN_CONFIG} -out ${ISSUER_CERT} 

## User Certs
# Generate User Cert
openssl req -new -newkey rsa:2048 -nodes -out ${USER_CSR} -keyout ${USER_PRIVATE_KEY} -subj "${USER_DN}"

# Sign CSR
openssl x509 -req -sha256 -CAcreateserial -days 825 -in ${USER_CSR} -CA ${ISSUER_CERT} -CAkey ${ISSUER_PRIVATE_KEY} -extfile ${SAN_CONFIG_LEAF} -out ${USER_CERT} 
cat ${USER_CERT} ${ISSUER_CERT} ${CA_CERT} > ${USER_FULL_CHAIN_CERT}

## Website Server Certs
# Generate WEBSERV Cert
openssl req -new -newkey rsa:2048 -nodes -out ${WEBSERV_CSR} -keyout ${WEBSERV_PRIVATE_KEY} -subj "${WEBSERV_DN}"

# Sign CSR
openssl x509 -req -sha256 -CAcreateserial -days 825 -in ${WEBSERV_CSR} -CA ${ISSUER_CERT} -CAkey ${ISSUER_PRIVATE_KEY} -extfile ${SAN_CONFIG_LEAF} -out ${WEBSERV_CERT} 
cat ${WEBSERV_CERT} ${ISSUER_CERT} ${CA_CERT} > ${WEBSERV_FULLCHAIN_CERT}