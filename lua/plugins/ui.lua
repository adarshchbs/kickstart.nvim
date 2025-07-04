-- UI related plugins
return { -- Better UI for notifications
{
    'rcarriga/nvim-notify',
    opts = {
        timeout = 3000,
        max_height = function()
            return math.floor(vim.o.lines * 0.75)
        end,
        max_width = function()
            return math.floor(vim.o.columns * 0.75)
        end,
        on_open = function(win)
            vim.api.nvim_win_set_config(win, {
                zindex = 100
            })
        end
    },
    init = function()
        -- when noice is not enabled, install notify on VeryLazy
        local Util = require('util')
        if not Util.has('noice.nvim') then
            Util.on_very_lazy(function()
                vim.notify = require('notify')
            end)
        end
    end
}, -- Better vim.ui
{
    'stevearc/dressing.nvim',
    lazy = true,
    init = function()
        ---@diagnostic disable-next-line: duplicate-set-field
        vim.ui.select = function(...)
            require('lazy').load({
                plugins = {'dressing.nvim'}
            })
            return vim.ui.select(...)
        end
        ---@diagnostic disable-next-line: duplicate-set-field
        vim.ui.input = function(...)
            require('lazy').load({
                plugins = {'dressing.nvim'}
            })
            return vim.ui.input(...)
        end
    end
}, -- Bufferline for managing buffers
{
    'akinsho/bufferline.nvim',
    event = 'VeryLazy',
    keys = {{
        '<leader>bp',
        '<Cmd>BufferLineTogglePin<CR>',
        desc = 'Toggle pin'
    }, {
        '<leader>bP',
        '<Cmd>BufferLineGroupClose ungrouped<CR>',
        desc = 'Delete non-pinned buffers'
    }, {
        '<leader>bo',
        '<Cmd>BufferLineCloseOthers<CR>',
        desc = 'Delete other buffers'
    }, {
        '<leader>br',
        '<Cmd>BufferLineCloseRight<CR>',
        desc = 'Delete buffers to the right'
    }, {
        '<leader>bl',
        '<Cmd>BufferLineCloseLeft<CR>',
        desc = 'Delete buffers to the left'
    }, {
        '<S-h>',
        '<cmd>BufferLineCyclePrev<cr>',
        desc = 'Prev buffer'
    }, {
        '<S-l>',
        '<cmd>BufferLineCycleNext<cr>',
        desc = 'Next buffer'
    }, {
        '[b',
        '<cmd>BufferLineCyclePrev<cr>',
        desc = 'Prev buffer'
    }, {
        ']b',
        '<cmd>BufferLineCycleNext<cr>',
        desc = 'Next buffer'
    }},
    opts = {
        options = {
            -- stylua: ignore
            close_command = function(n)
                require('mini.bufremove').delete(n, false)
            end,
            -- stylua: ignore
            right_mouse_command = function(n)
                require('mini.bufremove').delete(n, false)
            end,
            diagnostics = 'nvim_lsp',
            always_show_bufferline = false,
            diagnostics_indicator = function(_, _, diag)
                local icons = {
                    Error = ' ',
                    Warn = ' ',
                    Hint = ' ',
                    Info = ' '
                }
                local ret = (diag.error and icons.Error .. diag.error .. ' ' or '') ..
                                (diag.warning and icons.Warn .. diag.warning or '')
                return vim.trim(ret)
            end,
            offsets = {{
                filetype = 'neo-tree',
                text = 'Neo-tree',
                highlight = 'Directory',
                text_align = 'left'
            }}
        }
    }
}, -- Statusline
{
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    opts = function()
        local icons = {
            diagnostics = {
                Error = ' ',
                Warn = ' ',
                Hint = ' ',
                Info = ' '
            },
            git = {
                added = '+',
                modified = '~',
                removed = '-'
            }
        }

        local function fg(name)
            return function()
                local hl = vim.api.nvim_get_hl(0, {
                    name = name
                })
                return hl and hl.fg and {
                    fg = string.format('#%06x', hl.fg)
                }
            end
        end

        return {
            options = {
                theme = 'auto',
                globalstatus = true,
                disabled_filetypes = {
                    statusline = {'dashboard', 'alpha'}
                }
            },
            sections = {
                lualine_a = {'mode'},
                lualine_b = {'branch', {
                    'diff',
                    symbols = {
                        added = icons.git.added,
                        modified = icons.git.modified,
                        removed = icons.git.removed
                    }
                }},
                lualine_c = {{
                    'diagnostics',
                    symbols = {
                        error = icons.diagnostics.Error,
                        warn = icons.diagnostics.Warn,
                        info = icons.diagnostics.Info,
                        hint = icons.diagnostics.Hint
                    }
                }, {
                    'filetype',
                    icon_only = true,
                    separator = '',
                    padding = {
                        left = 1,
                        right = 0
                    }
                }, {
                    'filename',
                    path = 1,
                    symbols = {
                        modified = '  ',
                        readonly = '',
                        unnamed = ''
                    }
                }},
                lualine_x = { -- stylua: ignore
                {
                    function()
                        return require('noice').api.status.command.get()
                    end,
                    cond = function()
                        return package.loaded['noice'] and require('noice').api.status.command.has()
                    end,
                    color = fg('Statement')
                }, -- stylua: ignore
                {
                    function()
                        return require('noice').api.status.mode.get()
                    end,
                    cond = function()
                        return package.loaded['noice'] and require('noice').api.status.mode.has()
                    end,
                    color = fg('Constant')
                }, -- stylua: ignore
                {
                    function()
                        return '  ' .. require('dap').status()
                    end,
                    cond = function()
                        return package.loaded['dap'] and require('dap').status() ~= ''
                    end,
                    color = fg('Debug')
                }, {
                    require('lazy.status').updates,
                    cond = require('lazy.status').has_updates,
                    color = fg('Special')
                }, {
                    'diff',
                    symbols = {
                        added = icons.git.added,
                        modified = icons.git.modified,
                        removed = icons.git.removed
                    }
                }},
                lualine_y = {{
                    'progress',
                    separator = ' ',
                    padding = {
                        left = 1,
                        right = 0
                    }
                }, {
                    'location',
                    padding = {
                        left = 0,
                        right = 1
                    }
                }},
                lualine_z = {function()
                    return ' ' .. os.date('%R')
                end}
            },
            extensions = {'neo-tree', 'lazy'}
        }
    end
}, -- Indent guides for Neovim
{
    'lukas-reineke/indent-blankline.nvim',
    event = {'BufReadPost', 'BufNewFile'},
    opts = {
        indent = {
            char = '│',
            tab_char = '│'
        },
        scope = {
            enabled = false
        },
        exclude = {
            filetypes = {'help', 'alpha', 'dashboard', 'neo-tree', 'Trouble', 'lazy', 'mason'}
        }
    },
    main = 'ibl'
}, -- Active indent guide and indent text objects
{
    'echasnovski/mini.indentscope',
    version = false, -- wait till new 0.7.0 release to put it back on semver
    event = {'BufReadPre', 'BufNewFile'},
    opts = {
        -- symbol = "▏",
        symbol = '│',
        options = {
            try_as_border = true
        }
    },
    init = function()
        vim.api.nvim_create_autocmd('FileType', {
            pattern = {'help', 'alpha', 'dashboard', 'neo-tree', 'Trouble', 'lazy', 'mason', 'notify'},
            callback = function()
                vim.b.miniindentscope_disable = true
            end
        })
    end
}, -- Noice UI
{
    'folke/noice.nvim',
    event = 'VeryLazy',
    opts = {
        lsp = {
            override = {
                ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
                ['vim.lsp.util.stylize_markdown'] = true,
                ['cmp.entry.get_documentation'] = true
            }
        },
        routes = {{
            filter = {
                event = 'msg_show',
                any = {{
                    find = '%d+L, %d+B'
                }, {
                    find = '; after #%d+'
                }, {
                    find = '; before #%d+'
                }}
            },
            view = 'mini'
        }},
        presets = {
            bottom_search = true,
            command_palette = true,
            long_message_to_split = true,
            inc_rename = true
        }
    },
    -- stylua: ignore
    keys = {{
        '<S-Enter>',
        function()
            require('noice').redirect(vim.fn.getcmdline())
        end,
        mode = 'c',
        desc = 'Redirect Cmdline'
    }, {
        '<leader>snl',
        function()
            require('noice').cmd('last')
        end,
        desc = 'Noice Last Message'
    }, {
        '<leader>snh',
        function()
            require('noice').cmd('history')
        end,
        desc = 'Noice History'
    }, {
        '<leader>sna',
        function()
            require('noice').cmd('all')
        end,
        desc = 'Noice All'
    }, {
        '<leader>snd',
        function()
            require('noice').cmd('dismiss')
        end,
        desc = 'Dismiss All'
    }, {
        '<c-f>',
        function()
            if not require('noice.lsp').scroll(4) then
                return '<c-f>'
            end
        end,
        silent = true,
        expr = true,
        desc = 'Scroll forward',
        mode = {'i', 'n', 's'}
    }, {
        '<c-b>',
        function()
            if not require('noice.lsp').scroll(-4) then
                return '<c-b>'
            end
        end,
        silent = true,
        expr = true,
        desc = 'Scroll backward',
        mode = {'i', 'n', 's'}
    }}
}, -- Dashboard
{
    'goolord/alpha-nvim',
    event = 'VimEnter',
    opts = function()
        local dashboard = require('alpha.themes.dashboard')
        local logo = [[
      ██╗      █████╗ ███████╗██╗   ██╗██╗   ██╗██╗███╗   ███╗          Z
      ██║     ██╔══██╗╚══███╔╝╚██╗ ██╔╝██║   ██║██║████╗ ████║      Z    
      ██║     ███████║  ███╔╝  ╚████╔╝ ██║   ██║██║██╔████╔██║   z       
      ██║     ██╔══██║ ███╔╝    ╚██╔╝  ╚██╗ ██╔╝██║██║╚██╔╝██║ z         
      ███████╗██║  ██║███████╗   ██║    ╚████╔╝ ██║██║ ╚═╝ ██║
      ╚══════╝╚═╝  ╚═╝╚══════╝   ╚═╝     ╚═══╝  ╚═╝╚═╝     ╚═╝
      ]]

        dashboard.section.header.val = vim.split(logo, '\n')
        dashboard.section.buttons.val = {dashboard.button('f', ' ' .. ' Find file', ':Telescope find_files <CR>'),
                                         dashboard.button('n', ' ' .. ' New file', ':ene <BAR> startinsert <CR>'),
                                         dashboard.button('r', ' ' .. ' Recent files', ':Telescope oldfiles <CR>'),
                                         dashboard.button('g', ' ' .. ' Find text', ':Telescope live_grep <CR>'),
                                         dashboard.button('c', ' ' .. ' Config', ':e $MYVIMRC <CR>'),
                                         dashboard.button('s', ' ' .. ' Restore Session',
            [[:lua require("persistence").load() <cr>]]), dashboard.button('l', '󰒲 ' .. ' Lazy', ':Lazy<CR>'),
                                         dashboard.button('q', ' ' .. ' Quit', ':qa<CR>')}
        for _, button in ipairs(dashboard.section.buttons.val) do
            button.opts.hl = 'AlphaButtons'
            button.opts.hl_shortcut = 'AlphaShortcut'
        end
        dashboard.section.header.opts.hl = 'AlphaHeader'
        dashboard.section.buttons.opts.hl = 'AlphaButtons'
        dashboard.section.footer.opts.hl = 'AlphaFooter'
        dashboard.opts.layout[1].val = 8
        return dashboard
    end,
    config = function(_, dashboard)
        -- close Lazy and re-open when the dashboard is ready
        if vim.o.filetype == 'lazy' then
            vim.cmd.close()
            vim.api.nvim_create_autocmd('User', {
                pattern = 'AlphaReady',
                callback = function()
                    require('lazy').show()
                end
            })
        end

        require('alpha').setup(dashboard.opts)

        vim.api.nvim_create_autocmd('User', {
            pattern = 'LazyVimStarted',
            callback = function()
                local stats = require('lazy').stats()
                local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
                dashboard.section.footer.val = '⚡ Neovim loaded ' .. stats.count .. ' plugins in ' .. ms .. 'ms'
                pcall(vim.cmd.AlphaRedraw)
            end
        })
    end
}}
