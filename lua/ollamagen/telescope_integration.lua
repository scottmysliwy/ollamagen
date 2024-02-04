local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local conf = require('telescope.config').values
local action_state = require('telescope.actions.state')
local actions = require('telescope.actions')

local M = {}

function M.setup(opts)
    -- Optional setup function for configuring integration
end

function M.display_results(results)
    pickers.new({}, {
        prompt_title = "CodeLlama Results",
        finder = finders.new_table({
            results = results,
            entry_maker = function(entry)
                return {
                    value = entry,
                    display = entry.text,
                    ordinal = entry.text,
                }
            end,
        }),
        sorter = conf.generic_sorter({}),
        attach_mappings = function(prompt_bufnr, map)
            actions.select_default:replace(function()
                local selection = action_state.get_selected_entry()
                actions.close(prompt_bufnr)
                -- Handle selection, e.g., insert text
                print(vim.inspect(selection))
            end)
            return true
        end,
    }):find()
end

return M

