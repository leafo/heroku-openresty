#!/bin/sh
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PORT=8080 PATH="$ROOT/../bin:/usr/local/openresty/nginx/sbin:$PATH" POSTGRES_URL="postgres://theuser:thepassword@127.0.0.1/cats" start_nginx.sh "$ROOT/nginx.conf" "$ROOT"
