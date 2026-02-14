local cmd = require("leetcode.command")
local config = require("leetcode.config")

local Page = require("leetcode-ui.group.page")
local Title = require("leetcode-ui.lines.title")
local Buttons = require("leetcode-ui.group.buttons.menu")
local Group = require("leetcode-ui.group")
local Button = require("leetcode-ui.lines.button.menu")
local ExitButton = require("leetcode-ui.lines.button.menu.exit")

local header = require("leetcode-ui.lines.menu-header")

local page = Page()

page:insert(header)

page:insert(Title({}, "Sign in leetcode.com First, Then Press Auto C:"))

local auto_sign_in = Button("Auto Sign in", {
    icon = "󱛖",
    sc = "a",
    on_press = cmd.auto_signin,
})

local normal_sign_in = Button("Sign in (Manual Cookie Insert)", {
    icon = "󱛖",
    sc = "s",
    on_press = cmd.cookie_prompt,
})

local exit = ExitButton()

page:insert(Buttons({
    auto_sign_in,
    normal_sign_in,
    exit,
}))

local footer = Group({}, {
    hl = "Number",
})
footer:append("leetcode." .. config.domain)
page:insert(footer)

return page
