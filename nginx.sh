#!/usr/bin/env bash
source ./var.sh
export NGINX_CONFIG=${OUTPUT_DIR}/ssl-demo.conf
export BUNDLE=${CERT_DIR}/website_bundle.pem

cat ${WEBSERV_CERT} > ${BUNDLE}
cat ${ISSUER_CERT} >> ${BUNDLE}
cat ${CA_CERT} >> ${BUNDLE}


rm -f /etc/nginx/conf.d/default.conf
cat >${NGINX_CONFIG} <<EOL
server {
    listen       443 ssl;
    server_name  localhost;
    ssl_certificate     ${BUNDLE};
    ssl_certificate_key ${WEBSERV_PRIVATE_KEY};
    ssl_protocols       TLSv1 TLSv1.1 TLSv1.2;
    ssl_ciphers         HIGH:!aNULL:!MD5;

    #ssl_verify_client       on;
    #ssl_trusted_certificate ${ISSUER_CERT};

    location / {
        root   /usr/share/nginx/html;
        index  index.html index.htm;
    }

    error_page   500 502 503 504  /50x.html;
    location = /50x.html {
        root   /usr/share/nginx/html;
    }
}
EOL
cp ${NGINX_CONFIG} /etc/nginx/conf.d/