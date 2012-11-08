#!/bin/sh
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PORT=8080 PATH=$ROOT/../bin:/usr/local/openresty/nginx/sbin:$PATH start_nginx.sh $ROOT/nginx.conf
