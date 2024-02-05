local M = {}

M.load_mapping = function(plugin, opts)

  opts = opts or {}
  local mappings = require("core.mappings")[plugin]

  for mode, mode_maps in pairs(mappings) do
    for keybind, map_info in pairs(mode_maps) do
      opts.desc = map_info[2]

      vim.keymap.set(mode, keybind, map_info[1], opts)
    end
  end

end

return M
