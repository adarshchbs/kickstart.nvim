-- Utility functions for Neovim configuration
local M = {}

--- Check if a plugin is available/loaded
-- @param plugin (string) The plugin name to check
-- @return (boolean) True if the plugin is available, false otherwise
function M.has(plugin)
    return require("lazy.core.config").spec.plugins[plugin] ~= nil
end

--- Run a function when the VeryLazy event is triggered
-- @param fn (function) The function to run
function M.on_very_lazy(fn)
    vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        callback = function()
            fn()
        end
    })
end

--- Check if a command exists
-- @param cmd (string) The command to check
-- @return (boolean) True if the command exists, false otherwise
function M.cmd_exists(cmd)
    return vim.fn.exists(":" .. cmd) == 2
end

--- Get highlight properties for a highlight group
-- @param name (string) The highlight group name
-- @param fallback (table) Optional fallback values
-- @return (table) The highlight properties
function M.get_highlight(name, fallback)
    local hl = vim.api.nvim_get_hl(0, {
        name = name
    })
    return hl or fallback
end

return M
