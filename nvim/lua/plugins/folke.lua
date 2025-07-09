return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    config = function()
      local wk = require("which-key")

      wk.setup()
      wk.add({
        -- Groups
        { "<leader>f", group = "Find" },
        { "<leader>g", group = "Git" },
        { "<leader>s", group = "Search" },
        { "<leader>t", group = "Todo" },

        { "<leader>d", "<CMD>Alpha<CR>",                desc = "Dashboard" },
        { "<leader>l", "<CMD>Lazy<CR>",                 desc = "LazyVim" },
        { "<leader>c", "<CMD>e ~/.config/nvim/lua<CR>", desc = "Config" },
        { "<leader>q", "<CMD>wqa!<CR>",                 desc = "Save & Quit" },
        {
          "<leader>w",
          function()
            Snacks.bufdelete()
          end,
          desc = "Close",
        },
        {
          "<leader>W",
          function()
            Snacks.bufdelete.other()
          end,
          desc = "Close except current",
        },
        {
          "<leader>z",
          function()
            Snacks.zen()
          end,
          desc = "Zen mode",
        },
        {
          "<leader>gg",
          function()
            Snacks.lazygit()
          end,
          desc = "LazyGit",
        },
        {
          "<leader>.",
          function()
            Snacks.scratch()
          end,
          desc = "Scratch anything",
        },
        { "<leader>sf", "<CMD>BufferLineSortByDirectory<CR>", desc = "Sorting buffers by directory" },

        -- Snacks
        -- Top Pickers & Explorer
        {
          "<leader><space>",
          function()
            Snacks.picker.smart()
          end,
          desc = "Smart Find Files",
        },
        {
          "<leader>s:",
          function()
            Snacks.picker.command_history()
          end,
          desc = "Command History",
        },
        {
          "<leader>e",
          function()
            Snacks.explorer()
          end,
          desc = "Explorer",
        },
        -- { "<leader>,", function() Snacks.picker.buffers() end, desc = "Buffers" },
        -- { "<leader>/", function() Snacks.picker.grep() end, desc = "Grep" },
        -- { "<leader>n", function() Snacks.picker.notifications() end, desc = "Notification History" },

        -- find
        {
          "<leader>fb",
          function()
            Snacks.picker.buffers()
          end,
          desc = "Buffers",
        },
        {
          "<leader>ff",
          function()
            Snacks.picker.files()
          end,
          desc = "Find Files",
        },
        {
          "<leader>fg",
          function()
            Snacks.picker.grep()
          end,
          desc = "Grep",
        },
        {
          "<leader>fp",
          function()
            Snacks.picker.projects()
          end,
          desc = "Projects",
        },
        {
          "<leader>fr",
          function()
            Snacks.picker.recent()
          end,
          desc = "Recent",
        },
        {
          "<leader>fm",
          function()
            Snacks.picker.marks()
          end,
          desc = "Marks",
        },
        {
          '<leader>f"',
          function()
            Snacks.picker.registers()
          end,
          desc = "Registers",
        },
        {
          "<leader>fd",
          function()
            Snacks.picker.diagnostics()
          end,
          desc = "Diagnostics",
        },
        {
          "<leader>fD",
          function()
            Snacks.picker.diagnostics_buffer()
          end,
          desc = "Buffer Diagnostics",
        },
        {
          "<leader>fs",
          function()
            Snacks.picker.lsp_symbols()
          end,
          desc = "LSP Symbols",
        },
        {
          "<leader>fS",
          function()
            Snacks.picker.lsp_workspace_symbols()
          end,
          desc = "LSP Workspace Symbols",
        },
        -- { "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },

        -- git
        {
          "<leader>gb",
          function()
            Snacks.picker.git_branches()
          end,
          desc = "Git Branches",
        },
        {
          "<leader>gl",
          function()
            Snacks.picker.git_log()
          end,
          desc = "Git Log",
        },
        {
          "<leader>gL",
          function()
            Snacks.picker.git_log_line()
          end,
          desc = "Git Log Line",
        },
        {
          "<leader>gs",
          function()
            Snacks.picker.git_status()
          end,
          desc = "Git Status",
        },
        {
          "<leader>gS",
          function()
            Snacks.picker.git_stash()
          end,
          desc = "Git Stash",
        },
        {
          "<leader>gd",
          function()
            Snacks.picker.git_diff()
          end,
          desc = "Git Diff (Hunks)",
        },
        {
          "<leader>gf",
          function()
            Snacks.picker.git_log_file()
          end,
          desc = "Git Log File",
        },

        -- Grep
        {
          "<leader>sb",
          function()
            Snacks.picker.lines()
          end,
          desc = "Buffer Lines",
        },
        {
          "<leader>sB",
          function()
            Snacks.picker.grep_buffers()
          end,
          desc = "Grep Open Buffers",
        },
        {
          "<leader>sg",
          function()
            Snacks.picker.grep()
          end,
          desc = "Grep",
        },
        {
          "<leader>sw",
          function()
            Snacks.picker.grep_word()
          end,
          desc = "Visual selection or word",
          mode = { "n", "x" },
        },

        -- search
        {
          "<leader>s/",
          function()
            Snacks.picker.search_history()
          end,
          desc = "Search History",
        },
        {
          "<leader>sa",
          function()
            Snacks.picker.autocmds()
          end,
          desc = "Autocmds",
        },
        {
          "<leader>sc",
          function()
            Snacks.picker.command_history()
          end,
          desc = "Command History",
        },
        {
          "<leader>sC",
          function()
            Snacks.picker.commands()
          end,
          desc = "Commands",
        },
        {
          "<leader>sh",
          function()
            Snacks.picker.help()
          end,
          desc = "Help Pages",
        },
        {
          "<leader>sH",
          function()
            Snacks.picker.highlights()
          end,
          desc = "Highlights",
        },
        {
          "<leader>si",
          function()
            Snacks.picker.icons()
          end,
          desc = "Icons",
        },
        {
          "<leader>sj",
          function()
            Snacks.picker.jumps()
          end,
          desc = "Jumps",
        },
        {
          "<leader>sk",
          function()
            Snacks.picker.keymaps()
          end,
          desc = "Keymaps",
        },
        {
          "<leader>sl",
          function()
            Snacks.picker.loclist()
          end,
          desc = "Location List",
        },
        {
          "<leader>sM",
          function()
            Snacks.picker.man()
          end,
          desc = "Man Pages",
        },
        {
          "<leader>sp",
          function()
            Snacks.picker.lazy()
          end,
          desc = "Search for Plugin Spec",
        },
        {
          "<leader>sq",
          function()
            Snacks.picker.qflist()
          end,
          desc = "Quickfix List",
        },
        {
          "<leader>sR",
          function()
            Snacks.picker.resume()
          end,
          desc = "Resume",
        },
        {
          "<leader>su",
          function()
            Snacks.picker.undo()
          end,
          desc = "Undo History",
        },
        -- { "<leader>uC", function() Snacks.picker.colorschemes() end, desc = "Colorschemes" },

        -- Todo
        {
          "<leader>tf",
          function()
            Snacks.picker.todo_comments()
          end,
          desc = "Find Todo",
        },
        {
          "<leader>tF",
          function()
            Snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" } })
          end,
          desc = "Find Todo/Fix/Fixme",
        },
        {
          "<leader>td", "<CMD>Dooing<CR>", desc = "Dooing List",
        },

        -- LSP
        {
          "gd",
          function()
            Snacks.picker.lsp_definitions()
          end,
          desc = "Goto Definition",
        },
        {
          "gD",
          function()
            Snacks.picker.lsp_declarations()
          end,
          desc = "Goto Declaration",
        },
        {
          "gh",
          function()
            Snacks.picker.lsp_references()
          end,
          nowait = true,
          desc = "References",
        },
        {
          "gi",
          function()
            Snacks.picker.lsp_implementations()
          end,
          desc = "Goto Implementation",
        },
        {
          "gt",
          function()
            Snacks.picker.lsp_type_definitions()
          end,
          desc = "Goto Type Definition",
        },
      })
    end,
  },

  {
    "folke/snacks.nvim",
    ---@type snacks.Config
    lazy = false,
    opts = {
      image = {},
      picker = {
        exclude = {
          "node_modules",
          ".DS_Store"
        },
        sources = {
          explorer = {
            hidden = true,
            git_untracked = false,
            auto_close = true,
            layout = {
              preset = "default",
              layout = {
                position = "float",
                max_width = 70,
                height = 0.8,
              },
            },
          },
        },
      },
      explorer = {
        replace_netrw = true,
      },
      scope = {},
      indent = {},
      scratch = {},
      animate = {},
      scroll = {},
      statuscolumn = {},
      words = {},
      zen = {},
      terminal = {},
      lazygit = {},
    },
  },

  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    config = function()
      require("noice").setup({
        lsp = {
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
        },
      })
      require("notify").setup({
        max_width = 30,
        render = "wrapped-compact"
      })
    end
  },

  {
    "folke/todo-comments.nvim",
    event = "BufRead",
    dependencies = "nvim-lua/plenary.nvim",
    opts = {},
  },
}
