local os_dir = vim.fn.expand("~/Documents/CSCI-3753_OS")

-- Prefer newest cheat.md, fallback to os_exam_cheatsheet.md
local function get_cheatsheet_path()
  if vim.fn.filereadable(os_dir .. "/cheat.md") == 1 then
    return os_dir .. "/cheat.md"
  end
  return os_dir .. "/os_exam_cheatsheet.md"
end

local notes_file = os_dir .. "/notes.md"
local quicksearch_file = os_dir .. "/quicksearch.md"

return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = function()
          return vim.fn.executable("make") == 1
        end,
      },
    },
    cmd = "Telescope",
    keys = {
      -- ─── RAPID OS EXAM SHORTCUTS (~/Documents/CSCI-3753_OS) ───
      {
        "<leader>so",
        function()
          require("telescope.builtin").live_grep({
            cwd = os_dir,
            prompt_title = "󰑮 Search All OS Notes & Cheatsheet",
          })
        end,
        desc = "Search OS Notes (live grep)",
      },
      {
        "<leader>oc",
        function()
          vim.cmd.edit(get_cheatsheet_path())
        end,
        desc = "Open Cheatsheet (cheat.md)",
      },
      {
        "<leader>ov",
        function()
          vim.cmd("vsplit " .. vim.fn.fnameescape(get_cheatsheet_path()))
        end,
        desc = "Open Cheatsheet in Vertical Split",
      },
      {
        "<leader>on",
        function()
          vim.cmd.edit(notes_file)
        end,
        desc = "Open OS Notes (notes.md)",
      },
      {
        "<leader>oq",
        function()
          vim.cmd.edit(quicksearch_file)
        end,
        desc = "Open QuickSearch Guide",
      },
      {
        "<leader>sh",
        function()
          require("telescope.builtin").current_buffer_fuzzy_find({
            default_text = "^#+ ",
            prompt_title = "󰉖 Sections / Headings in Document",
          })
        end,
        desc = "Search Headings / Section Outline",
      },
      {
        "<leader>st",
        function()
          require("telescope.builtin").live_grep({
            cwd = os_dir,
            default_text = "\\[!\\]",
            prompt_title = " OS Exam Traps [!]",
          })
        end,
        desc = "Search Exam Traps [!]",
      },
      {
        "<leader>sw",
        function()
          require("telescope.builtin").grep_string({
            cwd = os_dir,
            prompt_title = " Search Word under Cursor",
          })
        end,
        desc = "Search Word under cursor in OS Notes",
      },
      {
        "<leader>fo",
        function()
          require("telescope.builtin").find_files({
            cwd = os_dir,
            prompt_title = "󰈙 OS Exam Files",
          })
        end,
        desc = "Find OS Files",
      },

      -- ─── GENERAL WORKSPACE SEARCHING & BUFFERS ───
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Switch Buffers" },
      { "<leader><space>", "<cmd>Telescope buffers<cr>", desc = "Switch Buffers" },
      { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent Files" },
      { "<leader>/", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Search Current Buffer" },

      -- ─── THEMES (LIVE PREVIEW) ───
      {
        "<leader>th",
        function()
          require("telescope.builtin").colorscheme({
            enable_preview = true,
            ignore_builtins = true,
          })
        end,
        desc = "Search & Switch Colorscheme",
      },
    },
    config = function()
      local telescope = require("telescope")
      telescope.setup({
        defaults = {
          prompt_prefix = "  ",
          selection_caret = "󰄾 ",
          entry_prefix = "   ",
          path_display = { "truncate" },
          sorting_strategy = "ascending",
          layout_config = {
            horizontal = {
              prompt_position = "top",
              preview_width = 0.55,
            },
          },
        },
        pickers = {
          colorscheme = {
            enable_preview = true,
          },
        },
      })

      pcall(telescope.load_extension, "fzf")
    end,
  },
}
