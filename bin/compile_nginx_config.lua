#!/usr/bin/env lua

function fill_env(s)
  return (s:gsub('($%b{})', function(w)
    return os.getenv(w:sub(3, -2)) or w
  end))
end

io.write(fill_env(io.stdin:read"*a"))

