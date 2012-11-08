#!/usr/bin/env lua

function fill_env(s)
  return (s:gsub('(${%b{}})', function(w)
    return os.getenv(w:sub(4, -3)) or w
  end))
end

io.write(fill_env(io.stdin:read"*a"))

