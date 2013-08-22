# How to build

Create a new heroku app.

Start a bash session:

```bash
$ heroku run bash --app my_app
```

Download `build-openresty.sh` to the current directory:

```bash
$ curl -O https://raw.github.com/leafo/heroku-openresty/master/support/build-openresty.sh
```

Run the script:

```
$ sh build-openresty.sh
```

Copy the result `build.tar.gz` to your computer (somehow).
