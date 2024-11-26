---@class lc.Stats
local Stats = {}

Stats.daily = {} ---@type { streak?: number, today_completed?: boolean }
Stats.ranking = 0 ---@type number
Stats.progress = {} ---@type table<string, lc.Stats.QuestionCount>

function Stats.update_streak()
    local stats_api = require("leetcode.api.statistics")
    local log = require("leetcode.logger")

    stats_api.streak(function(res, err)
        if err then
            return log.err(err)
        end

        Stats.daily.streak = res.streakCount
        Stats.daily.today_completed = res.todayCompleted

        _Lc_state.menu:draw()
    end)
end

function Stats.update_ranking()
    local stats_api = require("leetcode.api.statistics")
    local log = require("leetcode.logger")

    stats_api.solved(function(res, err)
        if err then
            return log.err(err)
        end
        Stats.ranking = res.ranking

        _Lc_state.menu:draw()
    end)
end

function Stats.update_sessions()
    local stats_api = require("leetcode.api.statistics")
    local log = require("leetcode.logger")

    Stats.progress = {}

    -- stats_api.sessions(function(_, err)
    --     if err then
    --         return log.err(err)
    --     end
    --
    --     _Lc_state.menu:draw()
    -- end)

    stats_api.session_progress(function(res, err)
        if err then
            return log.err(err)
        end

        Stats.progress = {}

        local progress = res
        for _, p in ipairs(progress) do
            Stats.progress[p.difficulty:lower()] = p
        end

        _Lc_state.menu:draw()
    end)
end

function Stats.update()
    Stats.update_streak()
    Stats.update_ranking()
    Stats.update_sessions()

    _Lc_state.menu:draw()
end

return Stats
