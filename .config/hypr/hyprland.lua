local fn = require("utils.functions")
local home   = os.getenv("HOME")
local hypr   = home .. "/.config/hypr"
package.path = package.path .. ";" .. home .. "/.config/caelestia/?.lua"

-- Maybe set current colours to defaults
fn.maybe_copy(hypr .. "/scheme/default.lua", hypr .. "/scheme/current.lua")

-- User variables
fn.maybe_create(home .. "/.config/caelestia/hypr-vars.lua", "return {}\n")
local overrides = require("hypr-vars")
if type(overrides) == "table" then
    local vars = require("variables")
    for k, v in pairs(overrides) do
        vars[k] = v
    end
end

-- Configs
require("hyprland.monitors")
require("hyprland.env")
require("hyprland.general")
require("hyprland.input")
require("hyprland.animations")
require("hyprland.decorations")
require("hyprland.group")
require("hyprland.execs")
require("hyprland.rules")
require("hyprland.keybindings")

-- User configs
fn.maybe_create(home .. "/.config/caelestia/hypr-user.lua")
require("hypr-user")