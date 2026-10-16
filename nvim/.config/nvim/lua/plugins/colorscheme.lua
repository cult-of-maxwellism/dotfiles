local book_themes = {
  "melange",
  "zenwritten",
  "zenbones",
  "forestbones",
  "rosebones",
  "flexoki",
  "gruvbox",
  "everforest",
  "rose-pine",
}

local function cycle_theme()
  local current = vim.g.colors_name or ""
  local next_theme = book_themes[1]
  for i, theme in ipairs(book_themes) do
    if theme == current then
      next_theme = book_themes[(i % #book_themes) + 1]
      break
    end
  end
  vim.cmd.colorscheme(next_theme)
  vim.notify("Book Theme: " .. next_theme, vim.log.levels.INFO, { title = "Colorscheme" })
end

local function toggle_background()
  local new_bg = vim.o.background == "dark" and "light" or "dark"
  vim.o.background = new_bg
  vim.notify("Background: " .. new_bg .. " (" .. (vim.g.colors_name or "") .. ")", vim.log.levels.INFO, { title = "Appearance" })
end

return {
  -- Melange: warm, cozy, book-like palette (earthy hues & paper feel)
  {
    "savq/melange-nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("melange")

      -- Keymaps to cycle book themes and toggle paper mode (light/dark)
      vim.keymap.set("n", "<leader>tt", cycle_theme, { desc = "Cycle Book Themes" })
      vim.keymap.set("n", "<leader>tb", toggle_background, { desc = "Toggle Light/Dark Paper Mode" })
    end,
  },

  -- Zenbones suite: designed specifically around typography and ink on paper
  -- Includes: zenwritten (pure prose/reading), zenbones, forestbones, rosebones
  {
    "mcchrish/zenbones.nvim",
    dependencies = { "rktjmp/lush.nvim" },
    lazy = false,
    priority = 1000,
  },

  -- Flexoki: an inky color scheme for prose and code (by Steph Ango)
  {
    "kepano/flexoki-neovim",
    name = "flexoki",
    lazy = false,
    priority = 1000,
  },

  -- Gruvbox: warm retro paper, sepia, and warm amber tones
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      contrast = "soft",
    },
  },

  -- Everforest: soft natural forest and parchment tones
  {
    "neanias/everforest-nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("everforest").setup({
        background = "soft",
      })
    end,
  },

  -- Rose Pine: includes rose-pine-dawn (warm paperback novel look)
  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = false,
    priority = 1000,
  },
}
