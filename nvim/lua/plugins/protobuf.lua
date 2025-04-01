local configs = require("lspconfig.configs")
local util = require("lspconfig.util")

local function get_protoc_version()
  local handle = io.popen("protoc --version")
  local result = handle:read("*a")
  handle:close()
  local version = result:match("libprotoc (%d+%.%d+%.%d+)")
  return version or "29.3" -- Default to 29.3 if version cannot be determined
end

configs.protobuf_language_server = {
  default_config = {

    -- Install language server manually: https://github.com/shizhz/protobuf-language-server
    -- Clone this repo and install it manually(go build main.go && mv main ~/go/bin/protobuf-language-server)
    -- cmd = { "/Users/shizhz/go/bin/protobuf-language-server" },
    cmd = { "/Users/shizhz/Projects/protobuf-language-server/main" },
    filetypes = { "proto" },
    root_dir = util.root_pattern(".git"),
    single_file_support = true,
    settings = {
      ["additional-proto-dirs"] = {
        -- 三方proto依赖
        "/usr/local/Cellar/protobuf/"
          .. get_protoc_version()
          .. "/include/",
      },
    },
  },
}

-- protobuf_language_server本身不支持跳转到三方库的protobuf位置，已经通过clone repo修复了，保留这个protols，如果后期能力更强了可以考虑使用这个protols
configs.protols = {
  default_config = {

    -- Install language server manually: https://github.com/coder3101/protols
    -- cargo install protols
    cmd = { "/Users/shizhz/.cargo/bin/protols" },
    filetypes = { "proto" },
    root_dir = util.root_pattern(".git"),
    single_file_support = true,
  },
}

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "proto" } },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        protobuf_language_server = {},

        -- https://github.com/LazyVim/LazyVim/discussions/3997
        -- 去掉proto，否则clangd也会被绑到proto文件上
        clangd = {
          filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "hpp" },
        },
      },
    },
  },
}
