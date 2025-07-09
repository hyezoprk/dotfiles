local colors = {
  black = "#0f1419",
  smokeWhite = "#e6e1cf",
  neutral = "NONE",
  gray = "#3e4b59",
  lavender = "#beb0e2",
  salary = "#A6E3A1",
  skyblue = "#6db0e1",
  scarlet = "#cb7072",
  pink = "#ddc1bf",
  coral = "#d49ca3",
  cream = "#dfcfa6",
  orange = "fab387",
}
local hoonyboom = {
  normal = {
    a = { fg = colors.black, bg = colors.skyblue, gui = "bold" },
    b = { fg = colors.black, bg = colors.cream },
    c = { fg = colors.gray, bg = colors.neutral },
    y = { fg = colors.black, bg = colors.coral },
    z = { fg = colors.black, bg = colors.pink },
  },
  insert = {
    a = { fg = colors.black, bg = colors.salary, gui = "bold" },
    b = { fg = colors.smokeWhite, bg = colors.neutral },
  },
  visual = {
    a = { fg = colors.black, bg = colors.lavender, gui = "bold" },
    b = { fg = colors.smokeWhite, bg = colors.neutral },
  },
  replace = {
    a = { fg = colors.black, bg = colors.scarlet, gui = "bold" },
    b = { fg = colors.smokeWhite, bg = colors.neutral },
  },
  inactive = {
    a = { fg = colors.smokeWhite, bg = colors.neutral, gui = "bold" },
    b = { fg = colors.smokeWhite, bg = colors.neutral },
    c = { fg = colors.smokeWhite, bg = colors.neutral },
  },
}

local function foldername()
  local path = vim.fn.expand("%:p:~")
  local sep = package.config:sub(1, 1)
  local segments = vim.split(path, sep)
  if #segments == 0 then
    return path
  elseif #segments == 1 then
    return segments[#segments]
  else
    return segments[#segments - 1]
  end
end

return {
  "nvim-lualine/lualine.nvim",
  dependencies = "nvim-tree/nvim-web-devicons",
  config = function()
    require("lualine").setup({
      options = {
        theme = hoonyboom,
        component_separators = "",
        section_separators = { left = " ", right = " " },
      },
      disabled_filetypes = { "packer", "NvimTree" },
      sections = {
        lualine_a = {
          {
            "mode",
            separator = { left = "", right = "" },
            icon = "",
            fmt = function(str)
              local mode = vim.fn.mode()
              if mode == 't' then
                return "TERMINAL"
              end
              return str
            end
          },
        },
        lualine_b = {
          {
            "branch",
            icon = "",
          },
          {
            "location",
            separator = { right = "" },
          },
        },
        lualine_c = {
          "%=",
          {
            "diff",
            symbols = { added = " ", modified = " ", removed = " " },
            colored = true,
            diff_color = {
              added = { fg = colors.skyblue },
              modified = { fg = colors.cream },
              removed = { fg = colors.coral },
            },
          },
        },
        lualine_x = {
          "diagnostics",
          "selectioncount",
          "searchcount",
        },
        lualine_y = {
          {
            "filetype",
            icon_only = true,
            padding = { left = 1, right = 0 },
            separator = { left = "" },
          },
          "filename",
        },
        lualine_z = {
          {
            foldername,
            icon = "🗂️",
            separator = { left = "", right = "" },
          },
        },
      },
      inactive_sections = {
        lualine_a = { "filename" },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = { "location" },
      },
      extensions = { "toggleterm", "trouble", "quickfix" },
    })
  end,
}
