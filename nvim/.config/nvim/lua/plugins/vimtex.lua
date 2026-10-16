return {
  {
    "lervag/vimtex",
    ft = { "tex" },
    config = function()
      vim.g.vimtex_view_method = "zathura"
      vim.g.vimtex_compiler_method = "latexmk"
      -- common latexmk option if you want continuous compilation:
      -- vim.g.vimtex_compiler_latexmk = { continuous = 1 }
    end,
  }
}

