#!/usr/bin/env bash

docker run --rm -it -v ${PWD}:/opt -w /opt -p 8443:443 --name nginx nginx:1.20 bash boot.sh