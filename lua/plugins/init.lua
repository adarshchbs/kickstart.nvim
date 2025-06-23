-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
    local out = vim.fn.system {'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath}
    if vim.v.shell_error ~= 0 then
        error('Error cloning lazy.nvim:\n' .. out)
    end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--
-- NOTE: Here is where you install your plugins.
require('lazy').setup({ -- Load plugins from other modules
{
    import = 'plugins.ui'
}, {
    import = 'plugins.lsp'
}, {
    import = 'plugins.completion'
}, {
    import = 'plugins.telescope'
}, {
    import = 'plugins.treesitter'
}, {
    import = 'plugins.editor'
}, {
    import = 'plugins.rest'
}, {
    import = 'plugins.theme'
}, -- Basic plugins that don't need their own file
'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
'mrjones2014/smart-splits.nvim', -- Adds git related signs to the gutter, as well as utilities for managing changes
{
    'lewis6991/gitsigns.nvim',
    opts = {
        signs = {
            add = {
                text = '+'
            },
            change = {
                text = '~'
            },
            delete = {
                text = '_'
            },
            topdelete = {
                text = '‾'
            },
            changedelete = {
                text = '~'
            }
        }
    }
}, -- Useful plugin to show you pending keybinds.
{
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    opts = {
        icons = {
            -- set icon mappings to true if you have a Nerd Font
            mappings = vim.g.have_nerd_font,
            -- If you are using a Nerd Font: set icons.keys to an empty table which will use the
            -- default which-key.nvim defined Nerd Font icons, otherwise define a string table
            keys = vim.g.have_nerd_font and {} or {
                Up = '<Up> ',
                Down = '<Down> ',
                Left = '<Left> ',
                Right = '<Right> ',
                C = '<C-…> ',
                M = '<M-…> ',
                D = '<D-…> ',
                S = '<S-…> ',
                CR = '<CR> ',
                Esc = '<Esc> ',
                ScrollWheelDown = '<ScrollWheelDown> ',
                ScrollWheelUp = '<ScrollWheelUp> ',
                NL = '<NL> ',
                BS = '<BS> ',
                Space = '<Space> ',
                Tab = '<Tab> ',
                F1 = '<F1>',
                F2 = '<F2>',
                F3 = '<F3>',
                F4 = '<F4>',
                F5 = '<F5>',
                F6 = '<F6>',
                F7 = '<F7>',
                F8 = '<F8>',
                F9 = '<F9>',
                F10 = '<F10>',
                F11 = '<F11>',
                F12 = '<F12>'
            }
        },

        -- Document existing key chains
        spec = {{
            '<leader>c',
            group = '[C]ode',
            mode = {'n', 'x'}
        }, {
            '<leader>d',
            group = '[D]ocument'
        }, {
            '<leader>r',
            group = '[R]ename'
        }, {
            '<leader>s',
            group = '[S]earch'
        }, {
            '<leader>w',
            group = '[W]orkspace'
        }, {
            '<leader>t',
            group = '[T]oggle'
        }, {
            '<leader>h',
            group = 'Git [H]unk',
            mode = {'n', 'v'}
        }}
    }
}, -- Markdown table mode
{
    'Kicamon/markdown-table-mode.nvim',
    config = function()
        require('markdown-table-mode').setup()
    end
}}, {
    rocks = {
        hererocks = true -- Force lazy.nvim to install the correct versions of lua and luarocks
    },
    ui = {
        -- If you are using a Nerd Font: set icons to an empty table which will use the
        -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
        icons = vim.g.have_nerd_font and {} or {
            cmd = '⌘',
            config = '🛠',
            event = '📅',
            ft = '📂',
            init = '⚙',
            keys = '🗝',
            plugin = '🔌',
            runtime = '💻',
            require = '🌙',
            source = '📄',
            start = '🚀',
            task = '📌',
            lazy = '💤 '
        }
    }
})

return {}
