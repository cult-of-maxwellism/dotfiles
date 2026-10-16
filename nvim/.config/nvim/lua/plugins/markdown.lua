-- Ensure standard fenced languages are highlighted by Vim's syntax engine
vim.g.markdown_fenced_languages = {
  "c",
  "cpp",
  "python",
  "lua",
  "bash=sh",
  "sh",
  "json",
  "yaml",
  "toml",
  "html",
  "css",
  "javascript",
  "typescript",
}

-- Function to follow markdown links [text](path.md#heading) with Enter
local function follow_markdown_link()
  local line = vim.api.nvim_get_current_line()
  local col = vim.api.nvim_win_get_cursor(0)[2] + 1
  local pattern = "%[([^%]]-)%]%(([^%)]-)%)"
  local s, e, text, target
  local init = 1
  while true do
    s, e, text, target = string.find(line, pattern, init)
    if not s then
      break
    end
    if col >= s and col <= e then
      local path, anchor = target:match("([^#]*)#?(.*)")
      if path == "" then
        path = vim.api.nvim_buf_get_name(0)
      else
        if not path:match("^/") and not path:match("^~") then
          local dir = vim.fn.expand("%:p:h")
          path = dir .. "/" .. path
        end
      end
      local expanded_path = vim.fn.expand(path)
      if vim.fn.filereadable(expanded_path) == 1 then
        vim.cmd.edit(vim.fn.fnameescape(expanded_path))
        if anchor and anchor ~= "" then
          local clean_anchor = anchor:gsub("%-", " ")
          vim.fn.search(clean_anchor, "w")
        end
        return
      end
    end
    init = e + 1
  end
  -- Fallback to default Enter behavior
  local key = vim.api.nvim_replace_termcodes("<CR>", true, false, true)
  vim.api.nvim_feedkeys(key, "n", false)
end

-- Buffer options for reading and editing Markdown comfortably
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.opt_local.conceallevel = 2
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    vim.opt_local.breakindent = true

    -- Jump to next / previous heading
    vim.keymap.set("n", "]h", function()
      vim.fn.search("^#\\+ ", "W")
    end, { buffer = true, desc = "Next markdown heading" })

    vim.keymap.set("n", "[h", function()
      vim.fn.search("^#\\+ ", "bW")
    end, { buffer = true, desc = "Previous markdown heading" })

    -- Follow markdown link under cursor with Enter
    vim.keymap.set("n", "<CR>", follow_markdown_link, {
      buffer = true,
      desc = "Follow markdown link under cursor",
    })
  end,
})

return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    ft = { "markdown" },
    opts = {
      heading = {
        sign = false,
        icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
      },
      code = {
        sign = false,
        style = "full",
        width = "block",
        right_pad = 1,
        language_icon = true,
      },
      checkbox = {
        enabled = true,
        unchecked = { icon = "󰄱 " },
        checked = { icon = "󰄵 " },
      },
      bullet = {
        icons = { "•", "◦", "◆", "◇" },
      },
      callout = {
        note = { raw = "[!NOTE]", rendered = "󰋽 Note", highlight = "RenderMarkdownInfo" },
        tip = { raw = "[!TIP]", rendered = "󰌵 Tip", highlight = "RenderMarkdownSuccess" },
        important = { raw = "[!IMPORTANT]", rendered = "󰅙 Important", highlight = "RenderMarkdownHint" },
        warning = { raw = "[!WARNING]", rendered = " Warning", highlight = "RenderMarkdownWarn" },
        caution = { raw = "[!CAUTION]", rendered = "󰳦 Caution", highlight = "RenderMarkdownError" },
      },
    },
    config = function(_, opts)
      require("render-markdown").setup(opts)

      -- Toggle rendered view vs raw markdown
      vim.keymap.set("n", "<leader>mr", "<cmd>RenderMarkdown toggle<cr>", { desc = "Toggle Markdown Render" })
    end,
  },
}
