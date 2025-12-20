-- Customize Mason

---@type LazySpec
return {
  -- use mason-tool-installer for automatically installing Mason packages
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    -- overrides `require("mason-tool-installer").setup(...)`
    opts = {
      -- Make sure to use the names found in `:Mason`
      ensure_installed = {
        -- install language servers
        "lua-language-server",
        "jdtls", -- Java Language Server
        "gopls", -- Go Language Server

        -- install formatters
        "stylua",
        "google-java-format", -- Java formatter
        "gofumpt", -- Go formatter (stricter than gofmt)
        "goimports", -- Go imports organizer

        -- install linters
        "checkstyle", -- Java linter
        "golangci-lint", -- Go linter (comprehensive)
        "staticcheck", -- Go static analyzer

        -- install debuggers
        "debugpy",
        "java-debug-adapter", -- Java debugger
        "java-test", -- Java test runner
        "delve", -- Go debugger

        -- install any other package
        "tree-sitter-cli",
      },
    },
  },
}
