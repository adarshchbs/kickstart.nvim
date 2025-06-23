-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`
-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', {
        clear = true
    }),
    callback = function()
        vim.highlight.on_yank()
    end
})

-- Autosave configuration
-- Create an autocommand group for autosave
local autosave_group = vim.api.nvim_create_augroup('autosave', {
    clear = true
})

-- Autosave when changing buffers
vim.api.nvim_create_autocmd({'BufLeave', 'FocusLost'}, {
    group = autosave_group,
    callback = function()
        if vim.bo.modified and not vim.bo.readonly and vim.fn.expand '%' ~= '' then
            vim.cmd 'silent! write'
        end
    end,
    desc = 'Autosave when changing buffer or losing focus'
})

-- Autosave after 60 seconds of inactivity
vim.api.nvim_create_autocmd({'CursorHold', 'CursorHoldI'}, {
    group = autosave_group,
    callback = function()
        if vim.bo.modified and not vim.bo.readonly and vim.fn.expand '%' ~= '' then
            vim.cmd 'silent! write'
        end
    end,
    desc = 'Autosave after 60 seconds of inactivity'
})

return {}
