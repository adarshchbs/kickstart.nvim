-- Theme configuration
return {{
    'olimorris/onedarkpro.nvim',
    priority = 1000, -- Ensure it loads first
    config = function()
        -- Function to toggle between light and dark themes
        _G.ToggleTheme = function()
            if vim.o.background == 'dark' then
                vim.o.background = 'light'
                require('onedarkpro').setup({
                    colors = {
                        red = '#E65E62',
                        gray = '#8e8e9e'
                    }
                })
                vim.cmd([[colorscheme onelight]])
            else
                vim.o.background = 'dark'
                vim.cmd([[colorscheme onedark]])
            end
        end

        -- Create command to toggle theme
        vim.api.nvim_create_user_command('ToggleTheme', ToggleTheme, {})

        -- Set up keybinding to toggle theme
        vim.keymap.set('n', '<leader>tt', ToggleTheme, {
            noremap = true,
            silent = true,
            desc = 'Toggle theme between light and dark'
        })

        -- Set default theme based on time of day
        local time = os.date('*t')
        if time.hour > 6 and time.hour <= 19 then
            vim.o.background = 'light'
            vim.cmd([[colorscheme onelight]])
        else
            vim.o.background = 'dark'
            vim.cmd([[colorscheme onedark]])
        end
    end
}, {
    'folke/tokyonight.nvim',
    priority = 1000,
    lazy = true,
    opts = {}
}, {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = {'nvim-lua/plenary.nvim'},
    opts = {
        signs = false
    }
}}
