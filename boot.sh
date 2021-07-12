#!/usr/bin/env bash

cd scripts
./ca.sh
./nginx.sh
nginx -g "daemon off;"