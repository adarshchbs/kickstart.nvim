-- REST client configuration (kulala.nvim)
return {{
    'mistweaverco/kulala.nvim',
    dependencies = {
        'nvim-treesitter/nvim-treesitter',
        opts = function(_, opts)
            opts.ensure_installed = opts.ensure_installed or {}
            table.insert(opts.ensure_installed, 'http')
        end
    },
    keys = {{
        "<leader>rs",
        desc = "Send request"
    }, {
        "<leader>ra",
        desc = "Send all requests"
    }, {
        "<leader>rb",
        desc = "Open scratchpad"
    }, {
        "<leader>rr",
        desc = "Replay last request"
    }},
    ft = {"http", "rest"},
    opts = {
        -- Global keymaps configuration
        global_keymaps = {
            ["Send request"] = {
                "<leader>rs",
                function()
                    require("kulala").run()
                end,
                mode = {"n", "v"},
                desc = "Send request"
            },
            ["Send all requests"] = {
                "<leader>ra",
                function()
                    require("kulala").run_all()
                end,
                mode = {"n", "v"},
                desc = "Send all requests"
            },
            ["Open scratchpad"] = {
                "<leader>rb",
                function()
                    require("kulala").open_scratchpad()
                end,
                desc = "Open scratchpad"
            },
            ["Replay the last request"] = {
                "<leader>rr",
                function()
                    require("kulala").replay()
                end,
                mode = {"n", "v"},
                desc = "Replay last request"
            }
        },
        global_keymaps_prefix = "<leader>r",
        kulala_keymaps_prefix = "",

        -- LSP configuration
        lsp = {
            keymaps = true, -- enables default Kulala's LSP keymaps
            -- enable/disable/customize HTTP formatter
            formatter = {
                sort = { -- enable/disable alphabetical sorting in request body
                    metadata = true,
                    variables = true,
                    commands = false,
                    json = false
                }
            }
        },

        -- UI configuration
        ui = {
            -- Set max response size to 10MB (default is 32KB)
            max_response_size = 10485760, -- 10MB in bytes
        }
    },
    config = function(_, opts)
        require("kulala").setup(opts)
    end
}}
