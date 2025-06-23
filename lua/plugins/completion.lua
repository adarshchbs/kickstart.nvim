-- Completion and snippets
return { -- Autocompletion
{
    'hrsh7th/nvim-cmp',
    event = {'InsertEnter', 'CmdlineEnter'},
    dependencies = { -- Snippet Engine & its associated nvim-cmp source
    {
        'L3MON4D3/LuaSnip',
        build = (function()
            -- Build Step is needed for regex support in snippets
            -- This step is not supported in many windows environments
            -- Remove the below condition to re-enable on windows
            if vim.fn.has('win32') == 1 or vim.fn.executable('make') == 0 then
                return
            end
            return 'make install_jsregexp'
        end)(),
        dependencies = {'rafamadriz/friendly-snippets'}
    }, -- Adds other completion capabilities.
    --  nvim-cmp does not ship with all sources by default. They are split
    --  into multiple repos for maintenance purposes.
    'hrsh7th/cmp-nvim-lsp', 'hrsh7th/cmp-path', 'hrsh7th/cmp-buffer', 'hrsh7th/cmp-cmdline', 'saadparwaiz1/cmp_luasnip',
    'onsails/lspkind.nvim'},
    config = function()
        -- See `:help cmp`
        local cmp = require('cmp')
        local luasnip = require('luasnip')
        local lspkind = require('lspkind')
        luasnip.config.setup({})

        -- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
        require('luasnip.loaders.from_vscode').lazy_load()

        cmp.setup({
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end
            },
            completion = {
                completeopt = 'menu,menuone,noinsert'
            },
            mapping = cmp.mapping.preset.insert({
                -- Select the [n]ext item
                ['<C-n>'] = cmp.mapping.select_next_item(),
                -- Select the [p]revious item
                ['<C-p>'] = cmp.mapping.select_prev_item(),

                -- Accept ([y]es) the completion.
                --  This will auto-import if your LSP supports it.
                --  This will expand snippets if the LSP sent a snippet.
                ['<C-y>'] = cmp.mapping.confirm({
                    select = true
                }),

                -- Manually trigger a completion from nvim-cmp.
                --  Generally you don't need this, because nvim-cmp will display
                --  completions whenever it has completion options available.
                ['<C-Space>'] = cmp.mapping.complete({}),

                -- Think of <c-l> as moving to the right of your snippet expansion.
                --  So if you have a snippet that's like:
                --  function $name($args)
                --    $body
                --  end
                --
                -- <c-l> will move you to the right of each of the expansion locations.
                -- <c-h> is similar, except moving you backwards.
                ['<C-l>'] = cmp.mapping(function()
                    if luasnip.expand_or_locally_jumpable() then
                        luasnip.expand_or_jump()
                    end
                end, {'i', 's'}),
                ['<C-h>'] = cmp.mapping(function()
                    if luasnip.locally_jumpable(-1) then
                        luasnip.jump(-1)
                    end
                end, {'i', 's'})
            }),
            sources = {{
                name = 'nvim_lsp'
            }, {
                name = 'luasnip'
            }, {
                name = 'path'
            }, {
                name = 'buffer'
            }},
            formatting = {
                format = lspkind.cmp_format({
                    mode = 'symbol_text', -- show only symbol annotations
                    maxwidth = 50, -- prevent the popup from showing more than provided characters
                    ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead
                    -- The function below will be called before any actual modifications from lspkind
                    -- so that you can provide more controls on popup customization.
                    -- (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
                    before = function(entry, vim_item)
                        return vim_item
                    end
                })
            }
        })

        -- Set configuration for specific filetype.
        cmp.setup.filetype('gitcommit', {
            sources = cmp.config.sources({{
                name = 'git'
            }}, {{
                name = 'buffer'
            }})
        })

        -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline({'/', '?'}, {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {{
                name = 'buffer'
            }}
        })

        -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline(':', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({{
                name = 'path'
            }}, {{
                name = 'cmdline'
            }})
        })
    end
}, -- Auto pairs
{
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = function()
        require('nvim-autopairs').setup({
            check_ts = true,
            ts_config = {
                lua = {'string'}, -- it will not add a pair on that treesitter node
                javascript = {'template_string'},
                java = false -- don't check treesitter on java
            },
            disable_filetype = {'TelescopePrompt', 'vim'},
            fast_wrap = {
                map = '<M-e>',
                chars = {'{', '[', '(', '"', "'"},
                pattern = [=[[%'%"%>%]%)%}%,]]=],
                end_key = '$',
                keys = 'qwertyuiopzxcvbnmasdfghjkl',
                check_comma = true,
                highlight = 'Search',
                highlight_grey = 'Comment'
            }
        })

        -- If you want to automatically add `(` after selecting a function or method
        local cmp_autopairs = require('nvim-autopairs.completion.cmp')
        local cmp = require('cmp')
        cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
    end
}}
