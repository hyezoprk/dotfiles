return {
  "epwalsh/obsidian.nvim",
  version = "*",
  lazy = false,
  ft = "markdown",
  dependencies = "nvim-lua/plenary.nvim",
  opts = {
    note_frontmatter_func = function(note)
      if note.title then
        note:add_alias(note.title)
      end
      local out = { id = note.id, aliases = note.aliases, tags = note.tags, date = os.date("%Y %B %d") }
      if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
        for k, v in pairs(note.metadata) do
          out[k] = v
        end
      end
      return out
    end,

    note_id_func = function(title)
      if title ~= nil then
        local id = title:gsub(" ", "-"):gsub("[^A-Za-z0-9가-힣-]", ""):lower()
        if id == "" then
          return tostring(os.time())
        end
        return id
      else
        return tostring(os.time())
      end
    end,

    ui = {
      enable = false,
    },

    workspaces = {
      {
        name = "personal",
        path = vim.g.setup.obsidian_dirs.generalpath,
      },
    },

    templates = {
      folder = vim.g.setup.obsidian_dirs.templates,
    },

    notes_subdir = vim.g.setup.obsidian_dirs.mainnotes,
    new_notes_location = "notes_subdir",

    daily_notes = {
      folder = vim.g.setup.obsidian_dirs.dailynotes,
      alias_format = "%Y년 %m월 %d일",
      date_format = "%Y-%m-%d",
      default_tags = { "일기" },
      template = "daily.md",
    },

    completion = {
      nvim_cmp = false,
      min_chars = 2,
    },

    attachments = {
      img_folder = vim.g.setup.obsidian_dirs.attachments,
    },
  },
}
