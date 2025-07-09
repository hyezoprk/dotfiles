return {
  { "williamboman/mason.nvim", opts = {} },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "lua_ls",
        "ts_ls",
        "mdx_analyzer",
        "rust_analyzer",
        "tailwindcss",
        "svelte",
        "astro",
        "yamlls",
        "jsonls",
        "somesass_ls",
        "html",
        "graphql",
        "eslint",
        "cssls",
        "emmet_ls",
        "prismals",
      },
    }
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = "saghen/blink.cmp",
    opts = {
      servers = {
        sourcekit = {},
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = {
                globals = { "vim" },
              },
            },
          },
        },
        ts_ls = {
          filetypes = {
            "javascript",
            "typescript",
            "javascriptreact",
            "typescriptreact",
          },
        },
        eslint = {
          settings = {
            packageManager = "pnpm",
            format = true,
            autoFixOnSave = true,
            codeAction = {
              disableRuleComment = {
                enable = true,
                location = "separateLine",
              },
              showDocumentation = {
                enable = true,
              },
            },
            validate = "on",
            quiet = false,
            run = "onSave",
            workingDirectory = {
              mode = "auto",
            },
          },
        },
        yamlls = {
          settings = {
            yaml = {
              schemas = {
                ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
                ["https://json.schemastore.org/kubernetes.json"] = "/*.k8s.yaml",
              },
              validate = true,
              format = { enable = true },
              completion = true,
              hover = true,
              schemaStore = {
                enable = true,
                url = "https://www.schemastore.org/api/json/catalog.json",
              },
              -- keyOrdering = false, -- 필요시 활성화
            },
          },
        },
        html = {},
        emmet_ls = {},
        tailwindcss = {},
        astro = {},
        svelte = {},
        cssls = {},
        jsonls = {},
        graphql = {},
        dockerls = {},
        mdx_analyzer = {},
        prismals = {},
      },
    },

    config = function(_, opts)
      local blinkCmpCapabilties = require("blink.cmp").get_lsp_capabilities()

      for server, myConfig in pairs(opts.servers) do
        local config = vim.tbl_deep_extend("force", {
          capabilities = blinkCmpCapabilties,
        }, myConfig)

        vim.lsp.config(server, config)
        vim.lsp.enable(server)
      end
    end,
  },
}
