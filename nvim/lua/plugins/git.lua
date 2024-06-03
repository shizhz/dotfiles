return {
  {
    "lewis6991/gitsigns.nvim",
    event = "User FilePost",
    opts = function()
      local icons = require("config.icons")

      local options = {
        signs = {
          add = {
            hl = "GitSignsAdd",
            text = icons.ui.BoldLineLeft,
            numhl = "GitSignsAddNr",
            linehl = "GitSignsAddLn",
          },
          change = {
            hl = "GitSignsChange",
            text = icons.ui.BoldLineLeft,
            numhl = "GitSignsChangeNr",
            linehl = "GitSignsChangeLn",
          },
          delete = {
            hl = "GitSignsDelete",
            text = icons.ui.Triangle,
            numhl = "GitSignsDeleteNr",
            linehl = "GitSignsDeleteLn",
          },
          topdelete = {
            hl = "GitSignsDelete",
            text = icons.ui.Triangle,
            numhl = "GitSignsDeleteNr",
            linehl = "GitSignsDeleteLn",
          },
          changedelete = {
            hl = "GitSignsChange",
            text = icons.ui.BoldLineLeft,
            numhl = "GitSignsChangeNr",
            linehl = "GitSignsChangeLn",
          },
        },
        signcolumn = true,
        numhl = false,
        linehl = false,
        word_diff = false,
        watch_gitdir = {
          interval = 1000,
          follow_files = true,
        },
        attach_to_untracked = true,
        current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
          delay = 1000,
          ignore_whitespace = false,
        },
        current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
        sign_priority = 6,
        status_formatter = nil, -- Use default
        update_debounce = 200,
        max_file_length = 40000,
        preview_config = {
          -- Options passed to nvim_open_win
          border = "rounded",
          style = "minimal",
          relative = "cursor",
          row = 0,
          col = 1,
        },
        yadm = { enable = false },

        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns

          local function opts(desc)
            return { buffer = bufnr, desc = desc }
          end

          local map = vim.keymap.set

          -- Navigation
          map("n", "]c", function()
            if vim.wo.diff then
              vim.cmd.normal({ "]h", bang = true })
            else
              gs.next_hunk()
            end
          end)

          map("n", "[c", function()
            if vim.wo.diff then
              vim.cmd.normal({ "[h", bang = true })
            else
              gs.prev_hunk()
            end
          end)

          map("n", "<leader>hr", gs.reset_hunk, opts("Reset Hunk"))
          map("n", "<leader>hs", gs.stage_hunk, opts("Stage Hunk"))
          map("n", "<leader>hu", gs.undo_stage_hunk, opts("Undo Stage Hunk"))
          map("n", "<leader>hS", gs.stage_buffer, opts("Stage Buffer"))
          map("n", "<leader>hR", gs.reset_buffer, opts("Reset Buffer"))
          map("n", "<leader>hv", gs.preview_hunk, opts("Preview Hunk"))
          map("n", "<leader>hn", gs.next_hunk, opts("Next Hunk"))
          map("n", "<leader>hp", gs.prev_hunk, opts("Prev Hunk"))
          map("n", "<leader>hb", function()
            gs.blame_line({ full = true })
          end, opts("Blame Line"))
          map("n", "<leader>hB", gs.toggle_current_line_blame, opts("Toggle blame"))
          map("n", "<leader>hd", gs.diffthis, opts("Diffthis"))
          map("n", "<leader>hD", function()
            gs.diffthis("~")
          end, opts("Diff Head"))
          map("n", "<leader>td", gs.toggle_deleted, opts("Toggle Deleted"))

          map("v", "<leader>hs", function()
            gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
          end, opts("Stage selected hunks"))
          map("v", "<leader>hr", function()
            gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
          end, opts("Reset selected hunks"))

          map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", opts("GitSigns Select Hunk"))
        end,
      }

      return options
    end,
    config = function(_, opts)
      require("gitsigns").setup(opts)
    end,
  },

  { "tpope/vim-fugitive" },
}
