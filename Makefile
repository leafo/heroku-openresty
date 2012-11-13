
test_install::
	-rm -rf dump
	luarocks make $$(ls *.rockspec) --tree=dump
