return {
  { "williamboman/mason.nvim", build = ":MasonUpdate", config = true },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "clangd", "pyright" }, -- C/C++, Python
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      -- C/C++
      vim.lsp.enable("clangd")
      -- Python
      vim.lsp.enable("pyright")
      -- useful keybinds (no completion involved)
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "LSP: goto def" })
      vim.keymap.set("n", "K",  vim.lsp.buf.hover,      { desc = "LSP: hover" })
      vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
      vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Prev diagnostic" })
    end,
  },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("trouble").setup({})
      vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>",
        { desc = "Diagnostics (Trouble)" })
      vim.keymap.set("n", "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        { desc = "Buffer Diagnostics (Trouble)" })
    end,
  },
}

