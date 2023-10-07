local log = require("leetcode.logger")
local config = require("leetcode.config")

---@class lc.Commands
local cmd = {}

function cmd.cache_update() require("leetcode.cache").update() end

function cmd.problems()
    local async = require("plenary.async")
    local problems = require("leetcode.cache.problems")

    async.run(function()
        local res = problems.get()
        return res
    end, function(res) require("leetcode.ui.pickers.question").pick(res) end)
end

---@param cb? function
function cmd.cookie_prompt(cb)
    local cookie = require("leetcode.cache.cookie")

    local popup_options = {
        relative = "editor",
        position = {
            row = "50%",
            col = "50%",
        },
        size = 100,
        border = {
            style = "rounded",
            text = {
                top = " Enter cookie ",
                top_align = "left",
            },
        },
        win_options = {
            winhighlight = "Normal:Normal",
        },
    }

    local Input = require("nui.input")
    local input = Input(popup_options, {
        prompt = " 󰆘 ",
        on_submit = function(value)
            if cookie.update(value) then
                cmd.menu_layout("menu")
                log.info("Sign-in successful")
                if cb then cb() end
            end
        end,
    })

    input:map("n", { "<Esc>", "q" }, function() input:unmount() end)
    input:mount()
end

---Signout
function cmd.delete_cookie()
    log.warn("You're now signed out")
    local cookie = require("leetcode.cache.cookie")
    pcall(cookie.delete)

    cmd.menu_layout("signin")
end

---Merge configurations into default configurations and set it as user configurations.
---
---@return lc.UserAuth | nil
function cmd.authenticate() require("leetcode.api.auth").user() end

---Merge configurations into default configurations and set it as user configurations.
---
--@param theme lc-db.Theme
function cmd.qot() require("leetcode.ui").open_qot() end

function cmd.random_question()
    local problems = require("leetcode.cache.problems")
    local question = require("leetcode.api.question")

    local q = question.random()
    if q then
        local item = problems.get_by_title_slug(q.title_slug) or {}
        require("leetcode.ui.question"):init(item)
    end
end

function cmd.console()
    local q = QUESTIONS[CURR_QUESTION]

    if q then
        q.console:toggle()
    else
        log.error("No current question found")
    end
end

function cmd.start()
    -- if vim.fn.argc() ~= 1 then return end
    --
    -- local invoke, arg = config.user.arg, vim.fn.argv()[1]
    -- if arg ~= invoke then return end
    --
    -- local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    -- if #lines > 1 or (#lines == 1 and lines[1]:len() > 0) then return true end

    require("leetcode.api").setup()
    require("leetcode.api.auth").user()
    -- require("leetcode.cache").setup()
    require("leetcode-menu"):init()
end

function cmd.menu() vim.api.nvim_set_current_tabpage(config.user.menu_tabpage) end

---@param layout layouts
function cmd.menu_layout(layout) _LC_MENU:set_layout(layout) end

function cmd.questions() vim.api.nvim_set_current_tabpage(config.user.questions_tabpage) end

function cmd.list_questions()
    local utils = require("leetcode.utils")
    local questions = utils.get_current_questions()

    if not vim.tbl_isempty(questions) then
        local ui = require("leetcode.ui")
        local curr_tabp = vim.api.nvim_get_current_tabpage()

        ui.pick_one(questions, "Select a Question", function(item)
            ---@type question_response
            local question = item.question.q
            local text = question.frontend_id .. ". " .. question.title

            return (curr_tabp == item.tabpage and "(C) " or "    ") .. text
        end, function(res) pcall(vim.cmd.tabnext, res.tabpage) end)
    else
        log.warn("No questions openned")
    end
end

function cmd.prompt_lang()
    local ui = require("leetcode.ui")

    ui.pick_one(
        {
            { lang = "C++", slug = "cpp" },
            { lang = "Java", slug = "java" },
            { lang = "Python", slug = "python" },
            { lang = "Python3", slug = "python3" },
            { lang = "C", slug = "c" },
            { lang = "C#", slug = "csharp" },
            { lang = "JavaScript", slug = "javascript" },
            { lang = "TypeScript", slug = "typescript" },
            { lang = "PHP", slug = "php" },
            { lang = "Swift", slug = "swift" },
            { lang = "Kotlin", slug = "kotlin" },
            { lang = "Dart", slug = "dart" },
            { lang = "Go", slug = "golang" },
            { lang = "Ruby", slug = "ruby" },
            { lang = "Scala", slug = "scala" },
            { lang = "Rust", slug = "rust" },
            { lang = "Racket", slug = "racket" },
            { lang = "Erlang", slug = "erlang" },
            { lang = "Elixir", slug = "elixir" },
        },
        "Pick a Langauge",
        function(t) return t.lang end,
        function(t)
            config.lang = t.slug
            log.info("Langauge set to " .. t.lang)
        end
    )
end

return cmd
