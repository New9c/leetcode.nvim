local Lines = require("leetcode-ui.lines")
local t = require("leetcode.translator")

---@class lc.ui.Header : lc.ui.Lines
local Header = Lines:extend("LeetHeader")

local function testcases_passed(item)
    local correct = item.total_correct ~= vim.NIL and item.total_correct or "0"
    local total = item.total_testcases ~= vim.NIL and item.total_testcases or "0"

    return ("%d/%d %s"):format(correct, total, t("testcases passed"))
end

local ToFunnyTitle = {
    [" Accepted"] = "",
    [" Wrong Answer"] = " WRONG 🙅",
    [" Time Limit Exceeded"] = " TOO SLOW 🐌",
    [" Runtime Error"] = " Code Can't Run 💥",
    [" Compile Error"] = " Code Can't Compile 💥",
}
---@param item lc.interpreter_response
function Header:init(item) --
    Header.super.init(self)
    local funnyTitle = ToFunnyTitle[item._.title] or item._.title
    self:append(funnyTitle, item._.hl)
    if item._.submission then
        if item._.success then
            self:append(" ANOTHER ONE BITES THE DUST 🗡️", item._.hl)
        else
            self:append(" | ")
            self:append(testcases_passed(item), "leetcode_alt")
        end
    else
        if item._.success then
            self:append(" OKIE 👌", item._.hl)
        end
        if item.status_runtime then
            self:append(" | ")
            self:append(("%s: %s"):format(t("Runtime"), item.status_runtime), "leetcode_alt")
        end
    end
end

---@type fun(item: lc.runtime): lc.ui.Header
local LeetHeader = Header

return LeetHeader
