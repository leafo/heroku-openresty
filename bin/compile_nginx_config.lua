#!/usr/bin/env lua

local filters = {
  pg = function (url)
    local user, password, host, db = url:match "^postgres://(.*):(.*)@(.*)/(.*)$"
    return ("%s dbname=%s user=%s password=%s"):format(host, db, user, password)
  end
}

function fill_env(s)
  return (s:gsub('(${%b{}})', function(w)
    local name = w:sub(4, -3)

    local filter, env = name:match("^(%S*)%s*(.*)$")
    if filter and filters[filter] then
      env = os.getenv(env)
      if not env then
        return w
      end

      return filters[filter](env)
    else
      return os.getenv(name) or w
    end
  end))
end

io.write(fill_env(io.stdin:read"*a"))

