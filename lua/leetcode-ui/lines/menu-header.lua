local Lines = require("leetcode-ui.lines")
local config = require("leetcode.config")
local log = require("leetcode.logger")

---@class lc.ui.menu.Header : lc.ui.Lines
local MenuHeader = Lines:extend("LeetMenuHeader")

local ascii = {
    [[ /$$                          /$$     /$$$$$$                /$$         ]],
    [[| $$                         | $$    /$$__  $$              | $$         ]],
    [[| $$       /$$$$$$  /$$$$$$ /$$$$$$ | $$  \__/ /$$$$$$  /$$$$$$$ /$$$$$$ ]],
    [[| $$      /$$__  $$/$$__  $|_  $$_/ | $$      /$$__  $$/$$__  $$/$$__  $$]],
    [[| $$     | $$$$$$$| $$$$$$$$ | $$   | $$     | $$  \ $| $$  | $| $$$$$$$$]],
    [[| $$     | $$_____| $$_____/ | $$ /$| $$    $| $$  | $| $$  | $| $$_____/]],
    [[| $$$$$$$|  $$$$$$|  $$$$$$$ |  $$$$|  $$$$$$|  $$$$$$|  $$$$$$|  $$$$$$$]],
    [[|________/\_______/\_______/  \___/  \______/ \______/ \_______/\_______/]],
}

function MenuHeader:contents()
    self:clear()
    if config.auth.is_signed_in then
        local stats = config.stats
        local daily = stats.daily
        local hl = daily.today_completed and "leetcode_medium" or "leetcode_menu"
        local sh_hl = daily.today_completed and "Keyword" or "leetcode_alt"
        for _, line in ipairs(ascii) do
            for thing in line:gmatch(".") do
                if thing == "/" or thing == "_" or thing == "\\" or thing == "|" then
                    self:append(thing, sh_hl)
                else
                    self:append(thing, hl)
                end
            end
            self:endl()
        end
    end
    return MenuHeader.super.contents(self)
end
function MenuHeader:init()
    MenuHeader.super.init(self, {}, {
        hl = "Keyword",
    })
end

---@type fun(): lc.ui.menu.Header
local LeetMenuHeader = MenuHeader

return LeetMenuHeader()
