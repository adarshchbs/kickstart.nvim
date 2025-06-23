-- Editor plugins configuration
return { -- Detect tabstop and shiftwidth automatically
{'tpope/vim-sleuth'}, -- Smart window splits
{'mrjones2014/smart-splits.nvim'}, -- Git signs in the gutter
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
}, -- Which-key for keybinding help
{
    'folke/which-key.nvim',
    event = 'VimEnter',
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
}, -- Mini plugins collection
{
    'echasnovski/mini.nvim',
    version = '*',
    config = function()
        -- Better Around/Inside textobjects
        --
        -- Examples:
        --  - va)  - [V]isually select [A]round [)]paren
        --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
        --  - ci'  - [C]hange [I]nside [']quote
        require('mini.ai').setup({
            n_lines = 500
        })

        -- Add/delete/replace surroundings (brackets, quotes, etc.)
        --
        -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
        -- - sd'   - [S]urround [D]elete [']quotes
        -- - sr)'  - [S]urround [R]eplace [)] [']
        require('mini.surround').setup()

        -- Simple and easy statusline
        local statusline = require('mini.statusline')
        -- set use_icons to true if you have a Nerd Font
        statusline.setup({
            use_icons = vim.g.have_nerd_font
        })

        -- You can configure sections in the statusline by overriding their
        -- default behavior. For example, here we set the section for
        -- cursor location to LINE:COLUMN
        ---@diagnostic disable-next-line: duplicate-set-field
        statusline.section_location = function()
            return '%2l:%-2v'
        end

        -- Additional mini modules
        require('mini.icons').setup()
        require('mini.files').setup()
        require('mini.completion').setup()
        require('mini.tabline').setup()
    end
}, -- Markdown table mode
{
    'Kicamon/markdown-table-mode.nvim',
    config = function()
        require('markdown-table-mode').setup()
    end
}, -- Autoformat
{
    'stevearc/conform.nvim',
    event = {'BufWritePre'},
    cmd = {'ConformInfo'},
    keys = {{
        '<leader>f',
        function()
            require('conform').format({
                async = true,
                lsp_format = 'fallback'
            })
        end,
        mode = '',
        desc = '[F]ormat buffer'
    }},
    opts = {
        notify_on_error = false,
        format_on_save = function(bufnr)
            -- Disable "format_on_save lsp_fallback" for languages that don't
            -- have a well standardized coding style. You can add additional
            -- languages here or re-enable it for the disabled ones.
            local disable_filetypes = {
                c = true,
                cpp = true
            }
            local lsp_format_opt
            if disable_filetypes[vim.bo[bufnr].filetype] then
                lsp_format_opt = 'never'
            else
                lsp_format_opt = 'fallback'
            end
            return {
                timeout_ms = 500,
                lsp_format = lsp_format_opt
            }
        end,
        formatters_by_ft = {
            lua = {'stylua'},
            -- Conform can also run multiple formatters sequentially
            python = {'ruff_organize_imports', 'ruff_format'}
            --
            -- You can use 'stop_after_first' to run the first available formatter from the list
            -- javascript = { "prettierd", "prettier", stop_after_first = true },
        }
    },
    init = function()
        -- Configure ruff_format
        local conform = require('conform')
        conform.formatters.ruff_format = {
            prepend_args = {'format', '--line-length', '110'}
        }

        -- Enable inlay hints
        vim.lsp.inlay_hint.enable(true)
    end
}, -- Signature help
{
    'ray-x/lsp_signature.nvim',
    event = 'InsertEnter',
    opts = {
        bind = true,
        handler_opts = {
            border = 'rounded'
        }
    },
    config = function(_, opts)
        require('lsp_signature').setup(opts)
    end
}}
