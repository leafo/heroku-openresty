
test:
	luarocks make --tree=dump

package::
	BASE=$$(basename $$(ls *.rockspec) .rockspec); git archive --prefix $$BASE/ -o $$BASE.tar.gz master

