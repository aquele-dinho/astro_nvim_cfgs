return {
  "folke/which-key.nvim",
  event = "VimEnter", -- Carrega o plugin na inicialização do Neovim
  config = function()
    require("which-key").setup {
      -- Opções de configuração (deixe vazio para usar os padrões)
    }
  end,
}
