local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  {
    command = "eslint_d",
    filetypes = {
      "typescript",
      "typescriptreact",
      "javascript",
      "javascriptreact",
      "vue"
    }
  },
  {
    name = "prettier",
    ---@usage arguments to pass to the formatter
    -- these cannot contain whitespace
    -- options such as `--line-width 80` become either `{"--line-width", "80"}` or `{"--line-width=80"}`
    -- args = { "--line-width", "80" },
    ---@usage only start in these filetypes, by default it will attach to all filetypes it supports
    filetypes = { "typescript", "typescriptreact", "css", "vue" },
  },
}

local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
}

local code_actions = require "lvim.lsp.null-ls.code_actions"
code_actions.setup {
}
