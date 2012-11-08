#!/bin/sh
PORT=8080 PATH=$(pwd)/bin:/usr/local/openresty/nginx/sbin:$PATH start_resty.sh "test/nginx.conf"
