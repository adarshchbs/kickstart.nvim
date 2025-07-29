-- Markdown configuration
local M = {}

-- Local settings for Markdown
local function setup_markdown_settings()
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    vim.opt_local.list = false
    vim.opt_local.spell = true
    vim.opt_local.showbreak = "NONE"

    -- Turn conceal on and off in a buffer:
    vim.keymap.set("n", "<leader>cc", function()
        vim.opt_local.conceallevel = vim.opt_local.conceallevel == 0 and 2 or 0
    end, {
        buffer = true,
        silent = true,
        desc = "Toggle conceallevel"
    })

    -- No compiler set - removed unsupported markdown_combo

    -- You can add your own markdown-specific keymaps here if needed
end

-- Pandoc command to compile documents quickly and easily
function M.setup_pandoc_command()
    vim.api.nvim_create_user_command("Pandoc", function(args)
        vim.cmd("!pandoc -i " .. vim.fn.fnameescape(vim.fn.expand("%")) .. " -o " ..
                    vim.fn.fnameescape(vim.fn.expand("%:r")) .. "." .. args.args)
    end, {
        nargs = 1
    })
end

-- Function to set up the rich text export command
function M.setup_rich_text_export_command()
    vim.api.nvim_create_user_command("RichTextCopy", function(opts)
        -- Get the selected lines
        local start_line = opts.line1
        local end_line = opts.line2

        -- Create a temporary file
        local tmp_file = vim.fn.tempname()

        -- Write the selected lines to the temporary file
        local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
        vim.fn.writefile(lines, tmp_file)

        -- Use pandoc to convert the temporary file to HTML and copy to clipboard
        local os_name = vim.loop.os_uname().sysname

        -- Pre-process the markdown to ensure headers are properly formatted
        -- Add a newline before any heading that doesn't have one
        local preprocessed_file = vim.fn.tempname()
        vim.fn.system("awk '{if($0 ~ /^##/ && prev !~ /^$/) print \"\"; print; prev=$0}' " ..
                          vim.fn.shellescape(tmp_file) .. " > " .. vim.fn.shellescape(preprocessed_file))

        if os_name == "Darwin" then
            -- macOS - with UTF-8 encoding explicitly set
            vim.fn.system('cat ' .. vim.fn.shellescape(preprocessed_file) ..
                              ' | pandoc -f markdown -t html --ascii --email-obfuscation=none --metadata=lang:en ' ..
                              '| textutil -stdin -format html -convert rtf -stdout | pbcopy')
        elseif os_name == "Linux" then
            -- Linux (requires xclip)
            vim.fn.system('cat ' .. vim.fn.shellescape(preprocessed_file) ..
                              ' | pandoc -f markdown -t html --ascii --email-obfuscation=none --metadata=lang:en ' ..
                              '| xclip -t text/html -selection clipboard')
        elseif os_name:find("Windows") then
            -- Windows
            vim.fn.system('type ' .. vim.fn.shellescape(preprocessed_file) ..
                              ' | pandoc -f markdown -t html --ascii --email-obfuscation=none --metadata=lang:en ' ..
                              '| clip')
        end

        -- Clean up the preprocessed file
        vim.fn.delete(preprocessed_file)

        -- Clean up
        vim.fn.delete(tmp_file)
        print("Rich text copied to clipboard")
    end, {
        range = true,
        desc = "Copy selection as rich text to clipboard"
    })
end

-- Set buffer-specific mappings for markdown files
function M.set_buf_maps()
    -- Add keyboard shortcut to export selected text to rich text
    vim.keymap.set("v", "<leader>mr", ":'<,'>RichTextCopy<CR>", {
        buffer = true,
        silent = true,
        desc = "Export selection to rich text"
    })
end

-- Setup function to be called on initialization
function M.setup()
    -- Create an autocommand to apply markdown settings when opening markdown files
    vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function()
            setup_markdown_settings()
            M.set_buf_maps()
        end,
        desc = "Setup markdown configuration"
    })

    -- Setup the Pandoc command and rich text export command
    M.setup_pandoc_command()
    M.setup_rich_text_export_command()
end

return M
