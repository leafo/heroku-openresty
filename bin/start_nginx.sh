#!/bin/sh
DEFAULT_CONF=nginx.conf
DEFAULT_ROOT="$(pwd)"

CONF="${1:-$DEFAULT_CONF}"
ROOT="${2:-$DEFAULT_ROOT}"

OUT_CONF="$CONF.compiled"
# tail -f -n 0 logs/error.log &

(
	cd "$ROOT"
	cat "$CONF" | compile_nginx_config.lua > "$OUT_CONF"
	mkdir -p logs
	touch logs/error.log
	touch logs/access.log
	nginx -p "$(pwd)" -c "$OUT_CONF"
)

