---@meta
---@class telescope
local telescope = {}

---@class telescope.setup_opts
---@field defaults table? Default configuration options
---@field pickers table? Configuration for specific pickers
---@field extensions table? Configuration for extensions

---@class telescope.builtin
---@field find_files fun(opts?: table): nil Find files in the current working directory
---@field live_grep fun(opts?: table): nil Search for a string in your current working directory
---@field buffers fun(opts?: table): nil Lists open buffers
---@field oldfiles fun(opts?: table): nil Lists previously open files
---@field help_tags fun(opts?: table): nil Lists available help tags
---@field keymaps fun(opts?: table): nil Lists normal mode keymappings
---@field grep_string fun(opts?: table): nil Search for the string under your cursor in your current working directory
---@field diagnostics fun(opts?: table): nil Lists diagnostics for all open buffers or a specific buffer
---@field git_files fun(opts?: table): nil Lists git files in your current working directory
---@field git_commits fun(opts?: table): nil Lists git commits with diff preview
---@field git_bcommits fun(opts?: table): nil Lists git commits for current buffer with diff preview
---@field git_branches fun(opts?: table): nil Lists all git branches with log preview
---@field git_status fun(opts?: table): nil Lists current changes per file with diff preview
---@field lsp_references fun(opts?: table): nil Lists LSP references for word under cursor
---@field lsp_document_symbols fun(opts?: table): nil Lists LSP document symbols in current buffer
---@field lsp_workspace_symbols fun(opts?: table): nil Lists LSP workspace symbols
---@field lsp_dynamic_workspace_symbols fun(opts?: table): nil Dynamically lists LSP workspace symbols
---@field lsp_implementations fun(opts?: table): nil Lists LSP implementations for word under cursor
---@field lsp_definitions fun(opts?: table): nil Lists LSP definitions for word under cursor
---@field lsp_type_definitions fun(opts?: table): nil Lists LSP type definitions for word under cursor
---@field builtin fun(opts?: table): nil Lists all builtin pickers
---@field resume fun(opts?: table): nil Resume the previous picker
---@field commands fun(opts?: table): nil Lists available commands
---@field command_history fun(opts?: table): nil Lists command history
---@field search_history fun(opts?: table): nil Lists search history
---@field vim_options fun(opts?: table): nil Lists vim options
---@field autocommands fun(opts?: table): nil Lists autocommands
---@field spell_suggest fun(opts?: table): nil Lists spelling suggestions for the current word
---@field current_buffer_fuzzy_find fun(opts?: table): nil Live fuzzy search inside the current buffer
---@field current_buffer_tags fun(opts?: table): nil Lists tags in current buffer
---@field tags fun(opts?: table): nil Lists tags in current directory
---@field colorscheme fun(opts?: table): nil Lists available colorschemes
---@field highlights fun(opts?: table): nil Lists available highlights
---@field man_pages fun(opts?: table): nil Lists man pages
---@field marks fun(opts?: table): nil Lists marks
---@field registers fun(opts?: table): nil Lists registers
---@field jumplist fun(opts?: table): nil Lists jumplist entries
---@field loclist fun(opts?: table): nil Lists items from the current window's location list
---@field quickfix fun(opts?: table): nil Lists items from the quickfix list
---@field quickfixhistory fun(opts?: table): nil Lists quickfix history
---@field treesitter fun(opts?: table): nil Lists function names, variables, from treesitter

---@type telescope.builtin
local builtin = {}

return telescope
