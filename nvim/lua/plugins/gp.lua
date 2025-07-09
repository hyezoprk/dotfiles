return {
  "robitx/gp.nvim",
  config = function()
    local conf = {
      providers = {
        anthropic = {
          disable = false,
          endpoint = "https://api.anthropic.com/v1/messages",
          secret = os.getenv("ANTHROPIC_API_KEY"),
        },
      },

      agents = {
        {
          provider = "anthropic",
          name = "ChatClaude-3-7-Sonnet",
          chat = true,
          command = false,
          model = { model = "claude-3-7-sonnet-latest", temperature = 0.8, top_p = 1 },
          system_prompt = require("gp.defaults").chat_system_prompt,
        },
        {
          provider = "anthropic",
          name = "ChatClaude-3-5-Haiku",
          chat = true,
          command = false,
          model = { model = "claude-3-5-haiku-latest", temperature = 0.8, top_p = 1 },
          system_prompt = require("gp.defaults").chat_system_prompt,
        },
        -- ... (필요한 agent만 남기고 나머지는 disable = true 추가)
      }
    }

    require("gp").setup(conf)
    -- Setup shortcuts here (see Usage > Shortcuts in the Documentation/Readme)
  end,
}
