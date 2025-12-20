return {
  "nvimtools/none-ls.nvim",
  opts = function(_, opts)
    local nls = require "null-ls"
    -- Ensure opts.sources is initialized
    opts.sources = opts.sources or {}

    -- Function to dynamically find the project root and append the config path
    local get_config_path = function()
      -- This utility function finds the project root based on markers like .git/ or pom.xml
      local root =
        require("null-ls.utils").root_pattern(".git", "pom.xml", "build.gradle")(vim.api.nvim_buf_get_name(0))
      if root then return "-c", root .. "/checkstyle.xml" end
      -- Fallback to default google checks if no project config is found
      return "-c", "/google_checks.xml"
    end

    -- Add the checkstyle diagnostic source with dynamic extra_args
    table.insert(
      opts.sources,
      nls.builtins.diagnostics.checkstyle.with {
        extra_args = { get_config_path },
      }
    )

    -- Optional: Add a formatter as well if desired
    -- table.insert(opts.sources, nls.builtins.formatting.google_java_format)

    return opts
  end,
}
