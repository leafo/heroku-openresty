# OpenResty for Heroku

This is a Lua rock containing binaries for running OpenResty on Heroku. It's
designed to be used in conjunction with the [Lua
buildpack](https://github.com/leafo/heroku-buildpack-lua).

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

### Installing the rock

Create a new app with the [Lua buildpack](https://github.com/leafo/heroku-buildpack-lua).

```bash
$ heroku create --buildpack http://github.com/leafo/heroku-buildpack-lua.git
```

Add to your rockspec dependencies:

```lua
dependencies = {
  "https://raw.github.com/leafo/heroku-openresty/master/heroku-openresty-1.2.8.6-1.rockspec"
}
```

### Running Nginx

*These directions are for manually running Nginx, if you prefer to use a
framework then I recommend checking out: <http://leafo.net/lapis>.*

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

## Using PostgreSQL

This build includes the [Postgres nginx
module](http://labs.frickle.com/nginx_ngx_postgres/), all you need to
do is pass in your database configuration.

First add a database if you haven't added one already:

```bash
heroku addons:add heroku-postgresql:dev
```

This will set an environment variable inside of your application that looks
something like this:

```bash
HEROKU_POSTGRESQL_ROSE_URL="postgres://user:password@database.domain.com/databasename"
```

The nginx config expects a slightly different format, but no worries the config
preprocessor has a filter to convert to the correct format.

Add the database to your config like so: (notice the prefix `pg`)

```
http {
    upstream database {
      postgres_server ${{pg HEROKU_POSTGRESQL_ROSE_URL}};
    }
}
```

That's it, your application can now talk to Postgres through the `database`
upstream.

## Version

* OpenResty 1.2.8.6 Stable `--with-luajit` `--with-http_postgres_module`