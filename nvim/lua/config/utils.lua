-- local ok, json = pcall(require, "lua-cjson")
-- if not ok then
--   print("Consider install lua-cjson: luarocks install lua-cjson")
--   return
-- end

local formatters = { json = "jq", sql = "sleek" }

local M = {}

function M.get_selected_content()
  local mode = vim.fn.mode()
  if mode == "v" or mode == "V" or mode == "s" then
    -- NOTE: Exit visual mode and then select the content again, to make the '< '> markers to be correct
    -- TODO: '< '> 表示前一次选中的收尾位置，通过下面的trick先退出v模式再选中内容，来达成想要的效果。有时间再调研下the right way
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>gv", false, true, true), "nx", false)
  end

  local vstart = vim.fn.getpos("'<")
  local vend = vim.fn.getpos("'>")

  local content = vim.fn.getline(vstart[2], vend[2])

  local start_col = vstart[3]
  local end_col = vend[3]

  if end_col == vim.v.maxcol then
    -- 参考https://neovim.io/doc/user/vvars.html#v%3Amaxcol
    end_col = #content[#content]
  end

  if #content == 1 then
    content[1] = content[1]:sub(start_col, end_col)
  end

  if #content > 1 then
    content[1] = content[1]:sub(start_col, end_col)
    content[#content] = content[#content]:sub(start_col, end_col)
  end

  return table.concat(content)
end

function M.replace_selected_content(content)
  local start_line = vim.fn.line("'<")
  local end_line = vim.fn.line("'>")
  local start_col = vim.fn.col("'<")
  local end_col = vim.fn.col("'>")

  -- vim.api.nvim_buf_set_text(0, start_line - 1, start_col - 1, end_line, end_col, {})
  vim.print(content)

  vim.api.nvim_buf_set_text(0, start_line - 1, start_col - 1, end_line - 1, end_col - 1, content)
end

function M.smart_prettier()
  vim.ui.input({ prompt = "FileType: " }, function(ft)
    if ft == nil then
      return
    end
    local formatter = formatters[ft]
    if formatter ~= nil then
      local mode = vim.fn.mode()

      if mode == "n" then
        vim.cmd("%!" .. formatter)
      end

      if mode == "v" or mode == "V" or mode == "^v" then
        vim.cmd("'<,'>!" .. formatter)
      end

      vim.cmd("set ft=" .. ft)
    else
      vim.print("No formatter for " .. ft)
    end
  end)
end

function M.windo()
  vim.ui.input({ prompt = "Cmd: " }, function(cmd)
    if cmd ~= nil then
      vim.cmd("windo " .. cmd)
    end
  end)
end

function M.ensure_installed(...)
  local programs = { ... }
  local os_type = vim.loop.os_uname().sysname

  for _, program in ipairs(programs) do
    if 0 == vim.fn.executable(program) then
      if os_type == "Linux" then
        -- Archlinux is my choice
        os.execute("sudo pacman -S " .. program)
      elseif os_type == "Darwin" then
        local cmd = "brew install " .. program
        os.execute(cmd)
      else
        print("Unsupported OS, please install " .. program .. " manually")
      end
    end
  end
end

function M.show_lsp_capabilities()
  local bufnr = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients({ bufnr = bufnr })

  for _, client in ipairs(clients) do
    vim.print(client.name .. " capabilities: ")
    vim.print(client.capabilities)
    vim.print("server capabilities: ")
    vim.print(client.server_capabilities)
  end
end

return M
