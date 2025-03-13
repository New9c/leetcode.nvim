local cmd = require("leetcode.command")

local Title = require("leetcode-ui.lines.title")
local Button = require("leetcode-ui.lines.button.menu")
local BackButton = require("leetcode-ui.lines.button.menu.back")
local Buttons = require("leetcode-ui.group.buttons.menu")
local Page = require("leetcode-ui.group.page")

local footer = require("leetcode-ui.lines.footer")
local header = require("leetcode-ui.lines.menu-header")

local page = Page()

local config = require("leetcode.config")
---@type Path
local file = config.storage.cache:joinpath(("cookie%s"):format(config.is_cn and "_cn" or ""))

page:insert(header)

page:insert(Title({ "Menu" }, "Problems"))

local contents = file:read()
if not contents or type(contents) ~= "string" then
    contents = "NONE"
end

local list = Button("List", {
    icon = "",
    sc = "p",
    on_press = cmd.problems,
})

local random = Button("Random", {
    icon = "",
    sc = "r",
    on_press = cmd.random_question,
})

local daily = Button("Daily", {
    icon = "󰃭",
    sc = "d",
    on_press = cmd.qot,
})

local status = Button("Settings", {
    icon = "",
    sc = "s",
    on_press = cmd.problems,
    expandable = true,
    expand_icon = contents,
})

local back = BackButton("menu")

page:insert(Buttons({
    list,
    random,
    daily,
    status,
    back,
}))

page:insert(footer)

return page
