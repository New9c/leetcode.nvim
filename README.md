<div align="center">

# leetcode.nvim

🔥 Solve [LeetCode] problems within [Neovim][neovim] 🔥

</div>

https://github.com/kawre/leetcode.nvim/assets/69250723/4647761c-609c-4b85-9396-535ae6baf3ba

[leetcode.nvim]: https://github.com/kawre/leetcode.nvim
[LeetCode]: https://leetcode.com
[neovim]: https://github.com/neovim/neovim

## ✨ Features

- 😍 Description formatting

- 📈 [LeetCode] statistics withing [Neovim][neovim] (Soon)

- 🔀 Support for daily and random questions

- 💾 Caching

## 📬 Requirements

- [Neovim][neovim] >= 0.8

- [nvim-treesitter][nvim-treesitter]

- [telescope.nvim][telescope.nvim]

- [nui.nvim][nui.nvim]

[nvim-treesitter]: https://github.com/nvim-treesitter/nvim-treesitter
[telescope.nvim]: https://github.com/nvim-telescope/telescope.nvim
[nui.nvim]: https://github.com/MunifTanjim/nui.nvim
[nvim-notify]: https://github.com/rcarriga/nvim-notify

## 📦 Installation

- [packer.nvim][packer.nvim]

```lua
use {
  "kawre/leetcode.nvim",
  run = ":TSUpdate html",
  requires = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-telescope/telescope.nvim",
    "MunifTanjim/nui.nvim",

     - optional dependencies
    "rcarriga/nvim-notify",
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require('leetcode').setup({
      -- configuration goes here
    })
  end,
}
```


- [lazy.nvim][lazy.nvim]

```lua
{
  "kawre/leetcode.nvim",
  build = ":TSUpdate html",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-telescope/telescope.nvim",
    "MunifTanjim/nui.nvim",
     - optional dependencies
    "rcarriga/nvim-notify",
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    -- configuration goes here
  },
}
```

[lazy.nvim]: https://github.com/folke/lazy.nvim
[packer.nvim]: https://github.com/wbthomason/packer.nvim

## 🛠️ Configuration

To see full configuration types see [template.lua](./lua/leetcode/config/template.lua)

### arg

Argument for [Neovim][neovim] 


```lua
---@type string
arg = "leetcode.nvim"
```

<small>See [usage](#🚀-usage) for more info</small>

### lang

Language to start your session with

```lua
---@type lc.lang
lang = "cpp"

---@type lc.sql_lang
sql = "mysql"
```

### domain

[LeetCode] domain.

```lua
---@type lc.domain
domain = "com" -- For now "com" is only supported
```

### directory

Where to store [leetcode.nvim][leetcode.nvim] data

```lua
---@type string
directory = vim.fn.stdpath("data") .. "/leetcode/"
```

### logging

Whether to log [leetcode.nvim][leetcode.nvim] status notifications

```lua
---@type boolean
logging = true
```

### console

Console appearance

```lua
console = {
    size = {
        width = "75%", ---@type string | integer
        height = "75%", ---@type string | integer
    },
    dir = "row", ---@type "col" | "row"

    result = {
        max_stdout_length = 200, ---@type integer
    },
}
```

### description

Question description appearance

```lua
description = {
    width = "40%", ---@type string | integer
}
```


### ⚙️ default configuration

<details>
  <summary>Click to see</summary>

```lua
{
    ---@type string
    arg = "leetcode.nvim",

    ---@type lc.lang
    lang = "cpp",

    ---@type lc.sql_lang
    sql = "mysql",

    ---@type lc.domain
    domain = "com",

    ---@type string
    directory = vim.fn.stdpath("data") .. "/leetcode/",

    ---@type boolean
    logging = true,

    console = {
        size = {
            width = "75%", ---@type string | integer
            height = "75%", ---@type string | integer
        },
        dir = "row", ---@type "col" | "row"

        result = {
            max_stdout_length = 200, ---@type integer
        },
    },

    description = {
        width = "40%", ---@type string | integer
    },
}
```

</details>

## 🚀 Usage

This plugin is meant to be used within a <b>fresh</b> [Neovim][neovim] instance.
Meaning that to lauch [leetcode.nvim][leetcode.nvim] you <b>have</b> to pass [`arg`](#arg) as the <i>first and <b>only</b></i> [Neovim][neovim] argument

```
nvim leetcode.nvim
```

### Sign In

It is <b>required</b> to be <b>signed-in</b> to use [leetcode.nvim][leetcode.nvim]

https://github.com/kawre/leetcode.nvim/assets/69250723/13594f1d-fff6-444b-b128-29c8cf83e97f

## 🍴 Recipes

- Full lazy loading with [lazy.nvim]

```lua
{
    ...
    cond = function()
        local user_arg = "leetcode.nvim"

        if vim.fn.argc() ~= 1 then return false end
        if user_arg ~= vim.fn.argv()[1] then return false end
        local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
        if #lines > 1 or (#lines == 1 and lines[1]:len() > 0) then return false end

        return true
    end
    ...
}
```

## 📋 Commands

| command   | triggers    |
|--------------- | --------------- |
| LcMenu | opens menu dashboard |
| LcConsole | opens console for currently opened question |
| LcQuestionList | opens a picker with all currently opened questions |
| LcLanguage | opens a prompt to select a new language for the current session |

## ✅ Todo

- [ ] CN version
- [ ] SQL support
- [ ] Statistics menu page