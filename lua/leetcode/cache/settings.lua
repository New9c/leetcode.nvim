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

if contents == "" then
    Settings.set("All")
end

function Settings.nxt()
    if contents == "All" then
        contents = "Easy"
    elseif contents == "Easy" then
        contents = "Medium"
    elseif contents == "Medium" then
        contents = "Hard"
    elseif contents == "Hard" then
        contents = "All"
    end
    Settings.set(contents)
    log.info(contents)
end

return Settings
