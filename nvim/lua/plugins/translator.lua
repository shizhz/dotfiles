return {
  {
    "voldikss/vim-translator",
    init = function()
      vim.g.translator_default_engines = { "google", "bing" }
      -- vim.g.translator_proxy_url = "socks5://127.0.0.1:1080"
      vim.g.translator_window_type = "popup"
    end,
    keys = {
      {
        "<leader>t",
        "<cmd>TranslateW<CR>",
        mode = { "n", "v" },
        desc = "Tanslate and display in a window",
      },
    },
  },
}
