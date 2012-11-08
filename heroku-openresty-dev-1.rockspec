
package = "heroku-openresty"
version = "dev-1"

source = {
	url = "file:///srv/git/heroku-openresty.git/"
}

description = {
	summary = "openresty binaries for running on heroku",
	license = "MIT"
}

dependencies = {
	"lua >= 5.1"
}

build = {
	type = "makefile"
}
