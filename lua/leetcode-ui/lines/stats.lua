local Lines = require("leetcode-ui.lines")
local t = require("leetcode.translator")
local log = require("leetcode.logger")
local cmd = require("leetcode.command")
local config = require("leetcode.config")

---@class lc.ui.menu.Stats : lc.ui.Lines
local Stats = Lines:extend("LeetMenuTitle")

function Stats:contents()
    self:clear()

    local stats = config.stats
    local daily, ranking, progress = stats.daily, stats.ranking, stats.progress

    local hl = daily.today_completed and "leetcode_hard" or "leetcode_alt"
    self:append("󰈸 ", hl)
    self:append(daily.streak and tostring(daily.streak) or "-")

    self:append((" %s  "):format(config.icons.bar))
    self:append("Global Ranking: ", "leetcode_menu")
    self:append(ranking and tostring(ranking) or "-")

    local icon = (" %s "):format(config.icons.square)
    local function create_progress(key)
        self:append(icon, "leetcode_" .. key)
        local count = progress[key] and tostring(progress[key].count) or "-"
        self:append(count)
    end

    create_progress("easy")
    create_progress("medium")
    create_progress("hard")

    return Stats.super.contents(self)
end

---@type fun(): lc.ui.menu.Stats
local LeetMenuStats = Stats

return LeetMenuStats()
