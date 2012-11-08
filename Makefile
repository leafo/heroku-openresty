
test_install:: package
	luarocks install $$(ls *.src.rock) --tree=dump

rock:: package
	-rm *.rock
	BASE=$$(basename $$(ls *.rockspec) .rockspec); zip $$BASE.src.rock $$(ls *.rockspec) $$(ls *.tar.gz)

package::
	BASE=$$(basename $$(ls *.rockspec) .rockspec); git archive --prefix $$BASE/ -o $$BASE.tar.gz master

