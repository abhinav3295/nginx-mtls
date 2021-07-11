#!/usr/bin/env bash

docker run --rm -it -v /Users/abhinav.singh/workspace/nginx-mtls:/opt -w /opt -p 8443:443 --name nginx nginx:1.20 bash boot.sh