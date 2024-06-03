-- bootstrap lazy.nvim, LazyVim and your plugins
function _G.get_cache_dir()
  local cache_dir = os.getenv("NVIM_CACHE_DIR")
  if not cache_dir then
    return vim.call("stdpath", "cache")
  end
  return cache_dir
end

require("config.lazy")
