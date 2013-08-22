
package = "heroku-openresty"
version = "1.2.8.6-1"

source = {
	url = "git://github.com/leafo/heroku-openresty.git",
	branch = "v1.2.8.6"
}

description = {
	summary = "OpenResty binaries for running on Heroku with the Lua buildpack",
	license = "MIT"
}

dependencies = {
	"lua >= 5.1"
}

build = {
	type = "command",
	install_command = [[
		LIB_DIR=`cd $(PREFIX)/../../../../; pwd`
		cp luajit/lib/libluajit-5.1.so.2.0.2 "$LIB_DIR"
		(
			cd "$LIB_DIR"
			ln -s libluajit-5.1.so.2.0.2 libluajit-5.1.so.2
			ln -s libluajit-5.1.so.2.0.2 libluajit-5.1.so
		)
	]],
	install = {
		bin = {
			"nginx/sbin/nginx",

			"bin/compile_nginx_config.lua",
			"bin/start_nginx.sh"
		},
		lib = {
			["rds.parser"] = "lualib/rds/parser.so",
			["redis.parser"] = "lualib/redis/parser.so",
			["cjson"] = "lualib/cjson.so",
		},
		lua = {
			["resty.aes"] = "lualib/resty/aes.lua",
			["resty.dns.resolver"] = "lualib/resty/dns/resolver.lua",
			["resty.md5"] = "lualib/resty/md5.lua",
			["resty.memcached"] = "lualib/resty/memcached.lua",
			["resty.mysql"] = "lualib/resty/mysql.lua",
			["resty.random"] = "lualib/resty/random.lua",
			["resty.redis"] = "lualib/resty/redis.lua",
			["resty.sha"] = "lualib/resty/sha.lua",
			["resty.sha1"] = "lualib/resty/sha1.lua",
			["resty.sha224"] = "lualib/resty/sha224.lua",
			["resty.sha256"] = "lualib/resty/sha256.lua",
			["resty.sha384"] = "lualib/resty/sha384.lua",
			["resty.sha512"] = "lualib/resty/sha512.lua",
			["resty.string"] = "lualib/resty/string.lua",
			["resty.upload"] = "lualib/resty/upload.lua",
		},
	}
}
