
test_install::
	-rm -rf dump
	luarocks make heroku-openresty-dev-1.rockspec --tree=dump
