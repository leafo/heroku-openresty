# OpenResty for Heroku

This is a Lua rock containing binaries for running OpenResty on Heroku. It's
designed to be used in conjunction with the [Lua
buildpack](https://github.com/leafo/heroku-buildpack-lua).

This is an alternative to the [OpenResty
buildpack](https://github.com/jtarchie/heroku-buildpack-openresty). The
advantage of this is that you get Lua and LuaRocks with the Lua buildpack.
Ideally there is Lua buildpack with LuaRocks and the http servers can be
distributed as rocks.

## What it does

In addition to a pre compiled openresty, some scripts to start nginx are
included. nginx doesn't support passing in port through argument or reading
from environment variable so we preprocess the config file.

Anything matching `${{NAME}}` is replaced with the environment variable `NAME`
inside of your nginx configuration config. (note: doesn't apply to included
files)

The `start_nginx.sh` script will read in `nginx.conf`, compile it to
`nginx.conf.compiled` then start nginx. It takes two optional arguments, an
alternative path for the config as the first and and an alternative root
directory to run the server from. The config must be specified relative to the
root.

The `daemon off`; directive must be added to the config for the entire thing to
work.

## How to use

Create a new app with the [Lua buildpack](https://github.com/leafo/heroku-buildpack-lua).

```bash
$ heroku create --buildpack http://github.com/leafo/heroku-buildpack-lua.git
```

Add to your rockspec dependencies:

```lua
dependencies = {
  "http://github.com/downloads/leafo/heroku-openresty/heroku-openresty-dev-1.src.rock"
}
```

Create a basic `nginx.conf`, this is the one from the OpenResty guide (with the
addition of `daemon off` and `${{PORT}}`):

```
worker_processes  1;
error_log logs/error.log;
daemon off;
events {
    worker_connections 1024;
}
http {
    server {
        listen ${{PORT}};
        location / {
            default_type text/html;
            content_by_lua '
                ngx.say("<p>hello, world</p>")
            ';
        }
    }
}
```

Create a `Procfile`:

```
web: start_nginx.sh
```

Commit everything and push to deploy. Run `heroku scale web=1` if nginx doesn't
start automatically.

## Version

* OpenResty 1.2.4.7 Development Release `--with-luajit`