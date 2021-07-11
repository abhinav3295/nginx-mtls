export OUTPUT_DIR='/opt/output'
export CERT_DIR=${OUTPUT_DIR}/'cert'
export CA_PRIVATE_KEY=${CERT_DIR}/ca.key
export CA_CERT=${CERT_DIR}/caCert.pem

export ISSUER_PRIVATE_KEY=${CERT_DIR}/issuer.key
export ISSUER_CSR=${CERT_DIR}/issuer.csr
export ISSUER_CERT=${CERT_DIR}/issuer.pem

export USER_PRIVATE_KEY=${CERT_DIR}/user.key
export USER_CSR=${CERT_DIR}/user.csr
export USER_CERT=${CERT_DIR}/user.pem

export WEBSERV_PRIVATE_KEY=${CERT_DIR}/webserv.key
export WEBSERV_CSR=${CERT_DIR}/webserv.csr
export WEBSERV_CERT=${CERT_DIR}/webserv.pem
