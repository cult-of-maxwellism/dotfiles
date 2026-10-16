return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      -- Neovim 0.12 compatibility fix for treesitter query directives
      local function unwrap_node(node)
        if type(node) == "table" and not node.range and node[1] then
          return node[1]
        end
        return node
      end

      local query = vim.treesitter.query
      if query and query.add_directive then
        local get_parser_from_markdown_info_string = function(s)
          local map = {
            sh = "bash",
            shell = "bash",
            console = "bash",
            zsh = "bash",
            csharp = "c_sharp",
          }
          return map[s] or s
        end

        query.add_directive("set-lang-from-info-string!", function(match, _, bufnr, pred, metadata)
          local capture_id = pred[2]
          local node = unwrap_node(match[capture_id])
          if not node then
            return
          end
          local alias = vim.treesitter.get_node_text(node, bufnr):lower()
          metadata["injection.language"] = get_parser_from_markdown_info_string(alias)
        end, { force = true, all = false })

        query.add_directive("downcase!", function(match, _, bufnr, pred, metadata)
          local id = pred[2]
          local node = unwrap_node(match[id])
          if not node then
            return
          end
          local text = vim.treesitter.get_node_text(node, bufnr, { metadata = metadata[id] }) or ""
          if not metadata[id] then
            metadata[id] = {}
          end
          metadata[id].text = string.lower(text)
        end, { force = true, all = false })
      end

      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "c",
          "cpp",
          "nasm",
          "cmake",
          "make",
          "lua",
          "vim",
          "vimdoc",
          "bash",
          "python",
          "json",
          "yaml",
          "toml",
          "regex",
          "markdown",
          "markdown_inline",
          "html",
          "css",
          "javascript",
          "typescript",
        },
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = { enable = true },
      })
    end,
  },
}
