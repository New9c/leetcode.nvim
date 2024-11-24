local Lines = require("leetcode-ui.lines")
local config = require("leetcode.config")

---@class lc.ui.menu.Header : lc.ui.Lines
local MenuHeader = Lines:extend("LeetMenuHeader")

local ascii = {
    [[ /󰈸󰈸                          /󰈸󰈸     /󰈸󰈸󰈸󰈸󰈸󰈸                /󰈸󰈸         ]],
    [[| 󰈸󰈸                         | 󰈸󰈸    /󰈸󰈸__  󰈸󰈸              | 󰈸󰈸         ]],
    [[| 󰈸󰈸       /󰈸󰈸󰈸󰈸󰈸󰈸  /󰈸󰈸󰈸󰈸󰈸󰈸 /󰈸󰈸󰈸󰈸󰈸󰈸 | 󰈸󰈸  \__/ /󰈸󰈸󰈸󰈸󰈸󰈸  /󰈸󰈸󰈸󰈸󰈸󰈸󰈸 /󰈸󰈸󰈸󰈸󰈸󰈸 ]],
    [[| 󰈸󰈸      /󰈸󰈸__  󰈸󰈸/󰈸󰈸__  󰈸|_  󰈸󰈸_/ | 󰈸󰈸      /󰈸󰈸__  󰈸󰈸/󰈸󰈸__  󰈸󰈸/󰈸󰈸__  󰈸󰈸]],
    [[| 󰈸󰈸     | 󰈸󰈸󰈸󰈸󰈸󰈸󰈸| 󰈸󰈸󰈸󰈸󰈸󰈸󰈸󰈸 | 󰈸󰈸   | 󰈸󰈸     | 󰈸󰈸  \ 󰈸| 󰈸󰈸  | 󰈸| 󰈸󰈸󰈸󰈸󰈸󰈸󰈸󰈸]],
    [[| 󰈸󰈸     | 󰈸󰈸_____| 󰈸󰈸_____/ | 󰈸󰈸 /󰈸| 󰈸󰈸    󰈸| 󰈸󰈸  | 󰈸| 󰈸󰈸  | 󰈸| 󰈸󰈸_____/]],
    [[| 󰈸󰈸󰈸󰈸󰈸󰈸󰈸|  󰈸󰈸󰈸󰈸󰈸󰈸|  󰈸󰈸󰈸󰈸󰈸󰈸󰈸 |  󰈸󰈸󰈸󰈸|  󰈸󰈸󰈸󰈸󰈸󰈸|  󰈸󰈸󰈸󰈸󰈸󰈸|  󰈸󰈸󰈸󰈸󰈸󰈸|  󰈸󰈸󰈸󰈸󰈸󰈸󰈸]],
    [[|________/\_______/\_______/  \___/  \______/ \______/ \_______/\_______/]],
}

function MenuHeader:init()
    local stats = config.stats
    local daily = stats.daily
    MenuHeader.super.init(self, {}, {
        hl = daily.today_completed and "leetcode_hard" or "Keyword",
    })

    for _, line in ipairs(ascii) do
        self:append(line, "leetcode_hard"):endl()
    end
end

---@type fun(): lc.ui.menu.Header
local LeetMenuHeader = MenuHeader

return LeetMenuHeader()
