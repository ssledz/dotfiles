local awful = require("awful")
local naughty = require("naughty")
require("awful.autofocus")

-- Simple function to load additional LUA files from rc/.
function loadrc(name, mod)
  local success
  local result

  -- Which file? In rc/ or in lib/?
  local path = awful.util.getdir("config") .. "/" ..  (mod and "lib" or "rc") ..
  "/" .. name .. ".lua"

  -- If the module is already loaded, don't load it again
  if mod and package.loaded[mod] then return package.loaded[mod] end

  -- Execute the RC/module file
  success, result = pcall(function() return dofile(path) end)
  if not success then
    naughty.notify({ title = "Error while loading an RC file", text = "When loading `" .. name ..
    "`, got the following error:\n" .. result, preset = naughty.config.presets.critical })
    return print("E: error loading RC file '" .. name .. "': " .. result)
  end

  -- Is it a module?
  if mod then
    return package.loaded[mod]
  end

  return result
end

-- errors and debug stuff
loadrc("errors")

-- Create cache directory
os.execute("test -d " .. awful.util.getdir("cache") ..  " || mkdir -p " .. awful.util.getdir("cache"))

-- Global configuration
modkey = "Mod4"
config = {}
config.terminal = "urxvtc" or "xterm"
config.editor     = os.getenv("EDITOR") or "vi"
config.editor_cmd = config.terminal .. " -e " .. config.editor
config.browser = "google-chrome"
config.browser2 = "firefox"
config.gui_editor = "gvim"
config.screen_lock="xscreensaver-command -lock"
config.console_jabber_client = config.terminal .. " -e mcabber"
config.console_music_player = config.terminal .. " -e cmus"
config.mail = config.terminal .. " -e mutt "
config.hostname = awful.util.pread('uname -n'):gsub('\n', '')
config.awesome=awesome

config.layouts =
{
  awful.layout.suit.floating,
  awful.layout.suit.tile,
  awful.layout.suit.tile.left,
  awful.layout.suit.tile.bottom,
  awful.layout.suit.tile.top,
  awful.layout.suit.fair,
  awful.layout.suit.fair.horizontal,
  awful.layout.suit.spiral,
  awful.layout.suit.spiral.dwindle,
  awful.layout.suit.max,
  awful.layout.suit.max.fullscreen,
  awful.layout.suit.magnifier
}


-- Remaining modules
--loadrc("xrun")-- xrun function
loadrc("appearance")-- theme and appearance settings
--loadrc("debug")-- debugging primitive `dbg()`

loadrc("tags")-- tags handling
--loadrc("start")-- programs to run on start
loadrc("bindings")-- keybindings
--loadrc("wallpaper")-- wallpaper settings
--loadrc("widgets")-- widgets configuration
--loadrc("xlock")-- lock screen
--loadrc("signals")-- window manager behaviour
--loadrc("rules")-- window rules
--loadrc("quake")-- quake console
--loadrc("xrandr")-- xrandr menu

root.keys(config.keys.global)
root.buttons(config.mouse.global)
