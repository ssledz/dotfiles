local awful = require("awful")

-- Define a tag table which hold all screen tags.
local tags = {}
tags = {
  names  = { "1-main", "2-www", "3-term", "4-dev", "5-steam", 6, 7, 8, 9 },
  layout = { config.layouts[2], config.layouts[1], config.layouts[2], config.layouts[1], config.layouts[1],
  config.layouts[2], config.layouts[2], config.layouts[2], config.layouts[2]
}}
for s = 1, screen.count() do
  -- Each screen has its own tag table.
  tags[s] = awful.tag(tags.names, s, tags.layout)
end

