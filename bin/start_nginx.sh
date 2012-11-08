#!/bin/sh
DEFAULT_CONF=nginx.conf
DEFAULT_ROOT="$(pwd)"

CONF="${1:-$DEFAULT_CONF}"
ROOT="${2:-$DEFAULT_ROOT}"

OUT_CONF="$CONF.compiled"

(
	cd "$ROOT"
	cat "$CONF" | compile_nginx_config.lua > "$OUT_CONF"
	mkdir -p logs
	touch logs/error.log
	touch logs/access.log
	tail -f -n 0 logs/*.log &
	nginx -p "$(pwd)" -c "$OUT_CONF"
)

