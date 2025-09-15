-- Rainbow delimiters configuration
return {
    'HiPhish/rainbow-delimiters.nvim',
    lazy = false, -- Load immediately
    priority = 1000, -- Load early
    dependencies = {'nvim-treesitter/nvim-treesitter'},
    config = function()
        -- Simple configuration using vim.g method from documentation
        ---@type rainbow_delimiters.config
        vim.g.rainbow_delimiters = {
            strategy = {
                [''] = 'rainbow-delimiters.strategy.local',
                lua = 'rainbow-delimiters.strategy.local',
                vim = 'rainbow-delimiters.strategy.local'
            },
            query = {
                [''] = 'rainbow-delimiters',
                lua = 'rainbow-blocks'
            },
            priority = {
                [''] = 110,
                lua = 300 -- Higher priority for better visibility
            },
            -- Enable cursor-based highlighting for better block visibility
            condition = function(bufnr)
                local line_count = vim.api.nvim_buf_line_count(bufnr)
                return line_count < 5000 -- Disable for very large files
            end,
            highlight = {'RainbowDelimiterRed', 'RainbowDelimiterYellow', 'RainbowDelimiterBlue',
                         'RainbowDelimiterOrange', 'RainbowDelimiterGreen', 'RainbowDelimiterViolet',
                         'RainbowDelimiterCyan'}
        }

        -- Custom colors for better visibility with onedarkpro
        vim.api.nvim_create_autocmd('ColorScheme', {
            callback = function()
                -- Highlight only the delimiter characters with bright colors
                local is_dark = vim.o.background == 'dark'

                if is_dark then
                    -- Bright colors for dark theme - only highlight delimiters
                    vim.api.nvim_set_hl(0, 'RainbowDelimiterRed', {
                        fg = '#ff6b6b',
                        bold = true,
                        underline = true
                    })
                    vim.api.nvim_set_hl(0, 'RainbowDelimiterYellow', {
                        fg = '#ffd93d',
                        bold = true,
                        underline = true
                    })
                    vim.api.nvim_set_hl(0, 'RainbowDelimiterBlue', {
                        fg = '#74c0fc',
                        bold = true,
                        underline = true
                    })
                    vim.api.nvim_set_hl(0, 'RainbowDelimiterOrange', {
                        fg = '#ffb84d',
                        bold = true,
                        underline = true
                    })
                    vim.api.nvim_set_hl(0, 'RainbowDelimiterGreen', {
                        fg = '#51cf66',
                        bold = true,
                        underline = true
                    })
                    vim.api.nvim_set_hl(0, 'RainbowDelimiterViolet', {
                        fg = '#d084ff',
                        bold = true,
                        underline = true
                    })
                    vim.api.nvim_set_hl(0, 'RainbowDelimiterCyan', {
                        fg = '#3bc9db',
                        bold = true,
                        underline = true
                    })
                else
                    -- Darker colors for light theme - only highlight delimiters
                    vim.api.nvim_set_hl(0, 'RainbowDelimiterRed', {
                        fg = '#ff004c',
                        bold = true,
                        underline = true
                    })
                    vim.api.nvim_set_hl(0, 'RainbowDelimiterYellow', {
                        fg = '#3dce04',
                        bold = true,
                        underline = true
                    })
                    vim.api.nvim_set_hl(0, 'RainbowDelimiterBlue', {
                        fg = '#0091ff',
                        bold = true,
                        underline = true
                    })
                    vim.api.nvim_set_hl(0, 'RainbowDelimiterOrange', {
                        fg = '#db5b20',
                        bold = true,
                        underline = true
                    })
                    vim.api.nvim_set_hl(0, 'RainbowDelimiterGreen', {
                        fg = '#00b894',
                        bold = true,
                        underline = true
                    })
                    vim.api.nvim_set_hl(0, 'RainbowDelimiterViolet', {
                        fg = '#af21d2',
                        bold = true,
                        underline = true
                    })
                    vim.api.nvim_set_hl(0, 'RainbowDelimiterCyan', {
                        fg = '#00cec9',
                        bold = true,
                        underline = true
                    })
                end
            end
        })

        -- Set colors immediately - only highlight delimiter characters
        vim.defer_fn(function()
            local is_dark = vim.o.background == 'dark'

            if is_dark then
                -- Bright colors for dark theme - only highlight delimiters
                vim.api.nvim_set_hl(0, 'RainbowDelimiterRed', {
                    fg = '#ff6b6b',
                    bold = true,
                    underline = true
                })
                vim.api.nvim_set_hl(0, 'RainbowDelimiterYellow', {
                    fg = '#ffd93d',
                    bold = true,
                    underline = true
                })
                vim.api.nvim_set_hl(0, 'RainbowDelimiterBlue', {
                    fg = '#74c0fc',
                    bold = true,
                    underline = true
                })
                vim.api.nvim_set_hl(0, 'RainbowDelimiterOrange', {
                    fg = '#ffb84d',
                    bold = true,
                    underline = true
                })
                vim.api.nvim_set_hl(0, 'RainbowDelimiterGreen', {
                    fg = '#51cf66',
                    bold = true,
                    underline = true
                })
                vim.api.nvim_set_hl(0, 'RainbowDelimiterViolet', {
                    fg = '#d084ff',
                    bold = true,
                    underline = true
                })
                vim.api.nvim_set_hl(0, 'RainbowDelimiterCyan', {
                    fg = '#3bc9db',
                    bold = true,
                    underline = true
                })
            else
                -- Darker colors for light theme - only highlight delimiters
                vim.api.nvim_set_hl(0, 'RainbowDelimiterRed', {
                    fg = '#d63031',
                    bold = true,
                    underline = true
                })
                vim.api.nvim_set_hl(0, 'RainbowDelimiterYellow', {
                    fg = '#f39c12',
                    bold = true,
                    underline = true
                })
                vim.api.nvim_set_hl(0, 'RainbowDelimiterBlue', {
                    fg = '#0984e3',
                    bold = true,
                    underline = true
                })
                vim.api.nvim_set_hl(0, 'RainbowDelimiterOrange', {
                    fg = '#e17055',
                    bold = true,
                    underline = true
                })
                vim.api.nvim_set_hl(0, 'RainbowDelimiterGreen', {
                    fg = '#00b894',
                    bold = true,
                    underline = true
                })
                vim.api.nvim_set_hl(0, 'RainbowDelimiterViolet', {
                    fg = '#a29bfe',
                    bold = true,
                    underline = true
                })
                vim.api.nvim_set_hl(0, 'RainbowDelimiterCyan', {
                    fg = '#00cec9',
                    bold = true,
                    underline = true
                })
            end
        end, 100)
    end
}
