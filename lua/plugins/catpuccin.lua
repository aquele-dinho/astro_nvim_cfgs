return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      -- Usamos o Frappe como base para o Neovim entender que é 'dark mode'
      flavour = "frappe",
      transparent_background = true, -- Mantém o seu fundo escuro

      -- Aqui injetamos as cores vibrantes do Latte no tema escuro
      color_overrides = {
        frappe = {
          rosewater = "#dc8a78",
          flamingo = "#dd7878",
          pink = "#ea76cb",
          mauve = "#8839ef", -- O roxo vibrante do Latte
          red = "#d20f39", -- O vermelho vivo do Latte
          maroon = "#e64553",
          peach = "#fe640b",
          yellow = "#df8e1d",
          green = "#40a02b", -- O verde saturado do Latte
          teal = "#179287",
          sky = "#04a5e5",
          sapphire = "#209fb5",
          blue = "#1e66f5", -- O azul 'royal' do Latte
          lavender = "#7287fd",
          text = "#ffffff", -- Texto branco puro para máximo contraste
        },
      },

      custom_highlights = function(colors)
        return {
          -- Agora o CursorLine com o roxo vibrante em 10% sobre o fundo escuro
          CursorLine = { bg = "#29213d" },
          CursorLineNr = { fg = colors.mauve, style = { "bold" } },

          -- Aumenta o contraste de palavras-chave (if, else, return)
          Statement = { fg = colors.mauve, style = { "bold" } },

          -- Adicione isso dentro do return do seu custom_highlights
          NeoTreeDirectoryIcon = { fg = colors.blue },
          NeoTreeDirectoryName = { fg = colors.blue },
          NeoTreeRootName = { fg = colors.mauve, style = { "bold" } },
          -- Também dentro do custom_highlights
          Comment = { fg = "#949cbb", style = { "italic" } },
        }
      end,
    },
  },
}
