#!/usr/bin/env bash

./ca.sh
./nginx.sh
nginx -g "daemon off;"