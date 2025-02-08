return {
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        preset = {
          header = [[
 _______          _________ _______           _______  _  _______            _________ _______
(  ____ \|\     /|\__   __// ___   )|\     /|/ ___   )( )(  ____ \  |\     /|\__   __/(       )
| (    \/| )   ( |   ) (   \/   )  || )   ( |\/   )  ||/ | (    \/  | )   ( |   ) (   | () () |
| (_____ | (___) |   | |       /   )| (___) |    /   )   | (_____   | |   | |   | |   | || || |
(_____  )|  ___  |   | |      /   / |  ___  |   /   /    (_____  )  ( (   ) )   | |   | |(_)| |
      ) || (   ) |   | |     /   /  | (   ) |  /   /           ) |   \ \_/ /    | |   | |   | |
/\____) || )   ( |___) (___ /   (_/\| )   ( | /   (_/\   /\____) |    \   /  ___) (___| )   ( |
\_______)|/     \|\_______/(_______/|/     \|(_______/   \_______)     \_/   \_______/|/     \|

 ]],
        -- stylua: ignore
        ---@type snacks.dashboard.Item[]
        keys = {
          { icon = " ", key = "p", desc = "Find Project", action = ":Telescope projects" },
          { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
          { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
          { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
          { icon = " ", key = "s", desc = "Restore Session", section = "session" },
          { icon = " ", key = "x", desc = "Lazy Extras", action = ":LazyExtras" },
          { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
        },
      },
    },
  },
}
