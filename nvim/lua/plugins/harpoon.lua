return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
  opts = {
    menu = {
      width = vim.api.nvim_win_get_width(0) - 4,
    },
    settings = {
      save_on_toggle = true,
      key = function()
        local cwd = vim.loop.cwd()
        local root = vim.fn.system("git rev-parse --show-toplevel")
        if vim.v.shell_error == 0 and root ~= nil then
          return string.gsub(root, "\n", "")
        end
        return cwd
      end,
    },
    -- NOTE: 问题：harpoon按照project维度来记录文件列表，而project区分的方式是通过cwd来确定的，harpoon通过如下配置函数来确定project范围。
    -- 而project.nvim插件会将vim的cwd设置成项目根目录，判断方式参考 ../plugins/project.lua 中的 patterns 配置项，所以当project中的pattern配置包含 pom.xml， package.json等模式时，
    -- 可能会造成相同git仓库下的多个maven module中的文件存放在不同的harpoon list下，给文件遍历带来困扰。解决方式有两个：
    -- 1. 修改project插件的pattern配置，仅根据vcs的根目录来决定项目根目录【当前采用该方式】
    -- 2. 修改harpoon的配置，代码如下 [参考：https://github.com/ThePrimeagen/harpoon/issues/473]。注意：如果如下变更不正确，则再看下 settings.key这个配置，当前这两个配置都是 vim.loop.cwd()
    --
    default = {
      get_root_dir = function()
        local cwd = vim.loop.cwd()
        local root = vim.fn.system("git rev-parse --show-toplevel")
        if vim.v.shell_error == 0 and root ~= nil then
          return string.gsub(root, "\n", "")
        end
        return cwd
      end,
    },
  },
  config = function(_, opts)
    local harpoon = require("harpoon")
    harpoon:setup({})

    -- basic telescope configuration
    local conf = require("telescope.config").values
    local function telescope_harpoon(harpoon_files)
      local file_paths = {}
      for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
      end

      require("telescope.pickers")
        .new({}, {
          prompt_title = "Harpoon",
          finder = require("telescope.finders").new_table({
            results = file_paths,
          }),
          previewer = conf.file_previewer({}),
          sorter = conf.generic_sorter({}),
        })
        :find()
    end

    vim.keymap.set("n", "<leader>hh", function()
      telescope_harpoon(harpoon:list())
    end, { desc = "Open harpoon window" })
  end,
  keys = function()
    local keys = {
      {
        "<leader>ha",
        function()
          require("harpoon"):list():add()
        end,
        desc = "Harpoon File",
      },
      {
        "[h",
        function()
          require("harpoon"):list():prev()
        end,
        desc = "Prev Harpoon File",
      },
      {
        "]h",
        function()
          require("harpoon"):list():next()
        end,
        desc = "Next Harpoon File",
      },
      {
        "<leader>H",
        function()
          local harpoon = require("harpoon")
          harpoon.ui:toggle_quick_menu(harpoon:list())
        end,
        desc = "Harpoon Quick Menu",
      },
    }

    for i = 1, 5 do
      table.insert(keys, {
        "<leader>" .. i,
        function()
          require("harpoon"):list():select(i)
        end,
        desc = "Harpoon to File " .. i,
      })
    end
    return keys
  end,
}
