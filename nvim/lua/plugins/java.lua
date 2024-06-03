-- This is the same as in lspconfig.server_configurations.jdtls, but avoids
-- needing to require that when this module loads.
local java_filetypes = { "java" }

return {
  -- Ensure java debugger and test packages are installed.
  {
    "mfussenegger/nvim-dap",
    optional = true,
    dependencies = {
      {
        "williamboman/mason.nvim",
        opts = function(_, opts)
          opts.ensure_installed = opts.ensure_installed or {}
          vim.list_extend(opts.ensure_installed, { "java-test", "java-debug-adapter" })
        end,
      },
    },
  },

  -- Configure nvim-lspconfig to install the server automatically via mason, but
  -- defer actually starting it to our configuration of nvim-jtdls below.
  {
    "neovim/nvim-lspconfig",
    -- FIXME: 不知道为啥jdtls表示不支持textDocument/definition, textDocument/rename, textDocument/codeAction几个方法，但实际上对应方法又是OK的
    -- 这里重新配置几个快捷键，删掉每个配置中的 has=<method> 的配置，以便绕过注册时的检测逻辑。
    -- 详细原因可见 ../../README.md 中的第一个问题
    -- 如果后续OK了的话，可以删除keys的配置
    --
    -- Updated at 2024-05-27 21:00: 发生上述问题并非jtdls的问题，而是更新项目代码后无法正确构建，导致jtdls无法正常启动，可以通过 LspLog 查看日志，或通过 LspInfo 找到lsp的日志文件查看对应内容
    --
    -- keys = function(_, keys)
    --   -- local keys = require("lazyvim.plugins.lsp.keymaps").get()
    --   keys[#keys + 1] = {
    --     "gd",
    --     function()
    --       -- DO NOT RESUSE WINDOW
    --       require("telescope.builtin").lsp_definitions({ reuse_win = true })
    --     end,
    --     desc = "Goto Definition[resue_win=true]",
    --   }
    --   keys[#keys + 1] = { "<leader>ca", vim.lsp.buf.code_action, desc = "Code Action", mode = { "n", "v" } }
    --   keys[#keys + 1] = {
    --     "<leader>cA",
    --     function()
    --       vim.lsp.buf.code_action({
    --         context = {
    --           only = {
    --             "source",
    --           },
    --           diagnostics = {},
    --         },
    --       })
    --     end,
    --     desc = "Source Action",
    --   }
    --
    --   if LazyVim.has("inc-rename.nvim") then
    --     keys[#keys + 1] = {
    --       "<leader>cr",
    --       function()
    --         local inc_rename = require("inc_rename")
    --         return ":" .. inc_rename.config.cmd_name .. " " .. vim.fn.expand("<cword>")
    --       end,
    --       expr = true,
    --       desc = "Rename",
    --     }
    --   else
    --     keys[#keys + 1] = { "<leader>cr", vim.lsp.buf.rename, desc = "Rename" }
    --   end
    -- end,
    opts = {
      -- make sure mason installs the server
      servers = {
        jdtls = {},
      },
      setup = {
        jdtls = function()
          return true -- avoid duplicate servers
        end,
      },
    },
  },
  -- {
  --   "rcasia/neotest-java",
  --   config = function()
  --     local function ensure_test_env()
  --       local output = io.popen("bash --version"):read("*a")
  --       local version = output:match("(%d+.%d+)")
  --
  --       if version then
  --         local major, minor = version:match("(%d+)%.(%d+)")
  --         if not (tonumber(major) > 4 or (tonumber(major) == 4 and tonumber(minor) > 0)) then
  --           print(
  --             "Bash version is not greater than 4.0, neotest-java may not work correctly. Please upgrade your bash!!!"
  --           )
  --         end
  --       else
  --         print(
  --           "Failed to determine Bash version. If its actull version is not greater than 4.0, neotest-java may not work correctly. Please check it!!!"
  --         )
  --       end
  --     end
  --
  --     ensure_test_env()
  --   end,
  -- },
  --
  -- {
  --   "nvim-neotest/neotest",
  --   optional = true,
  --   dependencies = {
  --     "rcasia/neotest-java",
  --   },
  --   opts = {
  --     log_level = vim.log.levels.WARN,
  --     adapters = {
  --       ["neotest-java"] = {},
  --     },
  --   },
  -- },
  {
    -- jdtls配置问题可参考：https://neovimcraft.com/plugin/mfussenegger/nvim-jdtls/, 日常使用Tips：
    -- 1. 修改了依赖或者依赖的jar有更新，通过命令:JdtUpdateConfig使其生效
    "mfussenegger/nvim-jdtls",
    dependencies = { "folke/which-key.nvim", "mfussenegger/nvim-dap" },
    ft = java_filetypes,

    opts = function()
      return {
        dap = { hotcodereplace = "auto", config_overrides = {} },
        dap_main = {},
        test = true,
      }
    end,
    config = function()
      local mason = require("mason-registry")
      local function buildBundles()
        local opts = LazyVim.opts("nvim-jdtls") or {}
        local bundles = {} ---@type string[]
        if opts.dap and LazyVim.has("nvim-dap") and mason.is_installed("java-debug-adapter") then
          local java_dbg_pkg = mason.get_package("java-debug-adapter")
          local java_dbg_path = java_dbg_pkg:get_install_path()
          local jar_patterns = {
            java_dbg_path .. "/extension/server/com.microsoft.java.debug.plugin-*.jar",
          }
          -- java-test also depends on java-debug-adapter.
          if opts.test and mason.is_installed("java-test") then
            local java_test_pkg = mason.get_package("java-test")
            local java_test_path = java_test_pkg:get_install_path()
            vim.list_extend(jar_patterns, {
              java_test_path .. "/extension/server/*.jar",
            })
          end
          for _, jar_pattern in ipairs(jar_patterns) do
            for _, bundle in ipairs(vim.split(vim.fn.glob(jar_pattern), "\n")) do
              table.insert(bundles, bundle)
            end
          end
        end

        return bundles
      end

      local function attach_jdtls()
        -- This function is copied from: https://github.com/gmr458/nvim/blob/main/ftplugin/java.lua
        local jdtls_path = mason.get_package("jdtls"):get_install_path()

        local equinox_launcher_path = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")

        local system = "linux"
        if vim.fn.has("win32") then
          system = "win"
        elseif vim.fn.has("mac") then
          system = "mac"
        end
        local config_path = vim.fn.glob(jdtls_path .. "/config_" .. system)

        local lombok_path = jdtls_path .. "/lombok.jar"

        local jdtls = require("jdtls")

        local extendedClientCapabilities = jdtls.extendedClientCapabilities
        extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

        local config = {
          cmd = {
            -- vim.fn.expand("~/.sdkman/candidates/java/21.0.2-tem/bin/java"), -- or '/path/to/java17_or_newer/bin/java'
            "/Library/Java/JavaVirtualMachines/jdk-17.jdk/Contents/Home/bin/java",

            "-Declipse.application=org.eclipse.jdt.ls.core.id1",
            "-Dosgi.bundles.defaultStartLevel=4",
            "-Declipse.product=org.eclipse.jdt.ls.core.product",
            "-Dlog.protocol=true",
            "-Dlog.level=ALL",
            "-Xmx4g",
            "--add-modules=ALL-SYSTEM",
            "--add-opens",
            "java.base/java.util=ALL-UNNAMED",
            "--add-opens",
            "java.base/java.lang=ALL-UNNAMED",

            "-javaagent:" .. lombok_path,

            "-jar",
            equinox_launcher_path,

            "-configuration",
            config_path,

            "-data",
            vim.fn.stdpath("cache") .. "/jdtls/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":t"),
          },

          root_dir = require("jdtls.setup").find_root({
            "mvnw",
            "gradlew",
          }),

          -- on_attach = require("gmr.configs.lsp").on_attach,
          capabilities = require("cmp_nvim_lsp").default_capabilities(),

          -- Here you can configure eclipse.jdt.ls specific settings
          -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
          -- for a list of options
          settings = {
            java = {
              format = {
                settings = {
                  url = "file://" .. vim.fn.stdpath("config") .. "/lsp/java/self-java-style.xml",
                  -- profile = "GoogleStyle",
                },
              },
              server = { launchMode = "Hybrid" },
              eclipse = {
                downloadSources = true,
              },
              maven = {
                downloadSources = true,
              },
              configuration = {
                runtimes = {
                  {
                    name = "JavaSE-1.8",
                    path = "/Library/Java/JavaVirtualMachines/jdk1.8.0_202.jdk/Contents/Home",
                  },
                  {
                    name = "JavaSE-17",
                    path = "/Library/Java/JavaVirtualMachines/jdk-17.jdk/Contents/Home/",
                  },
                  -- {
                  --   name = "JavaSE-22",
                  --   path = "/Library/Java/JavaVirtualMachines/jdk-22.jdk/Contents/Home/",
                  -- },
                },
              },
              references = {
                includeDecompiledSources = true,
              },
              implementationsCodeLens = {
                enabled = false,
              },
              referenceCodeLens = {
                enabled = false,
              },
              inlayHints = {
                parameterNames = {
                  enabled = "none",
                },
              },
              signatureHelp = {
                enabled = true,
                description = {
                  enabled = true,
                },
              },
              sources = {
                organizeImports = {
                  starThreshold = 9999,
                  staticStarThreshold = 9999,
                },
              },
            },
            redhat = { telemetry = { enabled = false } },
          },

          -- Language server `initializationOptions`
          -- You need to extend the `bundles` with paths to jar files
          -- if you want to use additional eclipse.jdt.ls plugins.
          --
          -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
          --
          -- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
          init_options = {
            bundles = buildBundles(),
            extendedClientCapabilities = extendedClientCapabilities,
          },
        }

        -- This starts a new client & server,
        -- or attaches to an existing client & server depending on the `root_dir`.
        jdtls.start_or_attach(config)
      end

      local mason_registry = require("mason-registry")
      vim.api.nvim_create_autocmd("FileType", {
        pattern = java_filetypes,
        callback = attach_jdtls,
      })

      -- Setup keymap and dap after the lsp is fully attached.
      -- https://github.com/mfussenegger/nvim-jdtls#nvim-dap-configuration
      -- https://neovim.io/doc/user/lsp.html#LspAttach
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client and client.name == "jdtls" then
            local wk = require("which-key")
            wk.register({
              ["<leader>cx"] = { name = "+extract" },
              ["<leader>cxv"] = { require("jdtls").extract_variable_all, "Extract Variable" },
              ["<leader>cxc"] = { require("jdtls").extract_constant, "Extract Constant" },
              ["<leader>ls"] = { require("jdtls").super_implementation, "Goto Super" },
              ["<leader>lt"] = { require("jdtls.tests").goto_subjects, "Goto Subjects" },
              ["<leader>co"] = { require("jdtls").organize_imports, "Organize Imports" },
            }, { mode = "n", buffer = args.buf })
            wk.register({
              ["<leader>c"] = { name = "+code" },
              ["<leader>cx"] = { name = "+extract" },
              ["<leader>cxm"] = {
                [[<ESC><CMD>lua require('jdtls').extract_method(true)<CR>]],
                "Extract Method",
              },
              ["<leader>cxv"] = {
                [[<ESC><CMD>lua require('jdtls').extract_variable_all(true)<CR>]],
                "Extract Variable",
              },
              ["<leader>cxc"] = {
                [[<ESC><CMD>lua require('jdtls').extract_constant(true)<CR>]],
                "Extract Constant",
              },
            }, { mode = "v", buffer = args.buf })

            if LazyVim.has("nvim-dap") and mason_registry.is_installed("java-debug-adapter") then
              -- custom init for Java debugger
              require("jdtls").setup_dap({ hotcodereplace = "auto", config_overrides = {} })
              require("jdtls.dap").setup_dap_main_class_configs({})

              -- Java Test require Java debugger to work
              if mason_registry.is_installed("java-test") then
                -- custom keymaps for Java test runner (not yet compatible with neotest)
                wk.register({
                  ["<leader>t"] = { name = "+test" },
                  ["<leader>tt"] = { require("jdtls.dap").test_class, "Run All Test" },
                  ["<leader>tr"] = { require("jdtls.dap").test_nearest_method, "Run Nearest Test" },
                  ["<leader>tT"] = { require("jdtls.dap").pick_test, "Run Test" },
                }, { mode = "n", buffer = args.buf })
              end
            end
          end
        end,
      })
    end,
  },
}
