local Page = require("leetcode-ui.group.page")
local Buttons = require("leetcode-ui.group.buttons.menu")
local ExitButton = require("leetcode-ui.lines.button.menu.exit")
local Title = require("leetcode-ui.lines.title")

local page = Page()

page:insert(Title({}, "Loading..."))

local exit = ExitButton()

page:insert(Buttons({
    exit,
}))

return page
