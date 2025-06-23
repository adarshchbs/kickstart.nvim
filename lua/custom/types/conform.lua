---@meta
---@class conform
local conform = {}

---@class conform.setupOpts
---@field notify_on_error boolean? Whether to notify on format errors
---@field format_on_save boolean|fun(bufnr: integer):table|boolean? Format on save options
---@field format_after_save boolean|fun(bufnr: integer):table|boolean? Format after save options
---@field formatters_by_ft table<string, string[]|{string[]|string, stop_after_first: boolean?}> Formatters to use for each filetype
---@field formatters table<string, conform.FormatterConfig>? Custom formatter configurations
---@field log_level number? Log level (0-5)
---@field debug boolean? Enable debug logging

---@class conform.FormatterConfig
---@field command string|fun(self: conform.Formatter, ctx: conform.FormatterContext): string|string[]|nil The command to run
---@field args string[]|fun(self: conform.Formatter, ctx: conform.FormatterContext): string[]|nil The arguments to pass to the command
---@field cwd string|fun(self: conform.Formatter, ctx: conform.FormatterContext): string|nil The working directory for the command
---@field stdin boolean? Whether to pass the buffer contents to stdin
---@field require_cwd boolean? Whether to require the working directory to exist
---@field condition fun(self: conform.Formatter, ctx: conform.FormatterContext): boolean|nil A function that returns whether to use this formatter
---@field exit_codes integer[]? The exit codes that indicate success
---@field env table<string, string>|fun(self: conform.Formatter, ctx: conform.FormatterContext): table<string, string>|nil Environment variables for the command
---@field prepend_args fun(self: conform.Formatter, ctx: conform.FormatterContext): string[]|nil A function that returns arguments to prepend
---@field append_args fun(self: conform.Formatter, ctx: conform.FormatterContext): string[]|nil A function that returns arguments to append
---@field inherit boolean? Whether to inherit the parent process environment

---@class conform.Range
---@field start integer[] Start position (1-indexed) [row, col]
---@field end integer[] End position (1-indexed) [row, col]

---@class conform.FormatterContext
---@field buf integer The buffer to format
---@field filename string The name of the file
---@field dirname string The directory of the file
---@field range? conform.Range The range to format (1-indexed)
---@class conform.Formatter
---@field name string The name of the formatter
---@field command string The command to run
---@field args string[] The arguments to pass to the command
---@field cwd string The working directory for the command
---@field stdin boolean Whether to pass the buffer contents to stdin
---@field require_cwd boolean Whether to require the working directory to exist
---@field condition fun(self: conform.Formatter, ctx: conform.FormatterContext): boolean A function that returns whether to use this formatter
---@field exit_codes integer[] The exit codes that indicate success
---@field env table<string, string> Environment variables for the command
---@field prepend_args fun(self: conform.Formatter, ctx: conform.FormatterContext): string[] A function that returns arguments to prepend
---@field append_args fun(self: conform.Formatter, ctx: conform.FormatterContext): string[] A function that returns arguments to append
---@field inherit boolean Whether to inherit the parent process environment

return conform
