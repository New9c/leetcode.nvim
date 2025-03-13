local path = require("plenary.path")
local log = require("leetcode.logger")

local config = require("leetcode.config")
---@type Path
local file = config.storage.cache:joinpath(("settings%s"):format(config.is_cn and "_cn" or ""))

local Settings = {}
local contents = file:read()

function Settings.set(str)
    file:write(str, "w")
end

if not contents then
    Settings.set("All")
end

function Settings.nxt()
    if contents == "All" then
        Settings.set("Easy")
    elseif contents == "Easy" then
        Settings.set("Medium")
    elseif contents == "Medium" then
        Settings.set("Hard")
    elseif contents == "Hard" then
        Settings.set("All")
    end
end

return Settings
