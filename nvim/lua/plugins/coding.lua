return {
  -- Use new config for <tab>
  { "axieax/urlview.nvim" },

  {
    "L3MON4D3/LuaSnip",
    keys = function()
      return {}
    end,
  },
  -- then: setup supertab in cmp
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-emoji",
    },
    -- @param opts cmp.ConfigSchema
    -- opts = function(_, opts)
    -- local has_words_before = function()
    --   unpack = unpack or table.unpack
    --   local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    --   return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    -- end
    --
    -- local luasnip = require("luasnip")
    -- local cmp = require("cmp")

    -- opts.mapping = vim.tbl_extend("force", opts.mapping, {
    --   ["<Tab>"] = cmp.mapping(function(fallback)
    --     if cmp.visible() then
    --       cmp.select_next_item()
    --       -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
    --       -- this way you will only jump inside the snippet region
    --     elseif luasnip.expand_or_jumpable() then
    --       luasnip.expand_or_jump()
    --     elseif has_words_before() then
    --       cmp.complete()
    --     else
    --       fallback()
    --     end
    --   end, { "i", "s" }),
    --   ["<S-Tab>"] = cmp.mapping(function(fallback)
    --     if cmp.visible() then
    --       cmp.select_prev_item()
    --     elseif luasnip.jumpable(-1) then
    --       luasnip.jump(-1)
    --     else
    --       fallback()
    --     end
    --   end, { "i", "s" }),
    -- })
    -- end,
  },

  {
    "junegunn/vim-easy-align",
  },

  -- {
  --   "folke/neodev.nvim",
  --   opts = {
  --     library = { plugins = { "nvim-dap-ui" }, types = true },
  --   },
  -- },
  {
    "stevearc/aerial.nvim",
    keys = {
      { "<leader>uo", "<cmd>AerialToggle<cr>", desc = "Aerial (Symbols)" },
    },
    cmd = "Toggle Aerial",
  },
  {
    "b0o/incline.nvim",
    dependencies = { -- optional packages
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      local devicons = require("nvim-web-devicons")
      require("incline").setup({
        render = function(props)
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
          if filename == "" then
            filename = "[No Name]"
          end
          local ft_icon, ft_color = devicons.get_icon_color(filename)

          local function get_git_diff()
            local icons = { removed = "", changed = "", added = "" }
            local signs = vim.b[props.buf].gitsigns_status_dict
            local labels = {}
            if signs == nil then
              return labels
            end
            for name, icon in pairs(icons) do
              if tonumber(signs[name]) and signs[name] > 0 then
                table.insert(labels, { icon .. signs[name] .. " ", group = "Diff" .. name })
              end
            end
            if #labels > 0 then
              table.insert(labels, { "┊ " })
            end
            return labels
          end

          local function get_diagnostic_label()
            local icons = { error = "", warn = "", info = "", hint = "" }
            local label = {}

            for severity, icon in pairs(icons) do
              local n = #vim.diagnostic.get(props.buf, { severity = vim.diagnostic.severity[string.upper(severity)] })
              if n > 0 then
                table.insert(label, { icon .. n .. " ", group = "DiagnosticSign" .. severity })
              end
            end
            if #label > 0 then
              table.insert(label, { "┊ " })
            end
            return label
          end

          return {
            { get_diagnostic_label() },
            { get_git_diff() },
            { (ft_icon or "") .. " ", guifg = ft_color, guibg = "none" },
            { filename .. " ", gui = vim.bo[props.buf].modified and "bold,italic" or "bold" },
            { "┊  " .. vim.api.nvim_win_get_number(props.win), group = "DevIconWindows" },
          }
        end,
      })
    end,
    -- Optional: Lazy load Incline
    event = "VeryLazy",
  },
  {
    "smjonas/inc-rename.nvim",
    config = function()
      require("inc_rename").setup()
    end,
    keys = {
      {
        "<leader>cr",
        function()
          return "<cmd>IncRename " .. vim.fn.expand("<cword>")
        end,
        { expr = true },
      },
    },
  },
}
