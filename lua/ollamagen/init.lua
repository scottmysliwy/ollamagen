local codellama = require('ollamagen.codellama')
local telescope_integration = require('ollamagen.telescope_integration')

local M = {}

function M.setup(opts)
    codellama.setup(opts.codellama or {})
    telescope_integration.setup(opts.telescope_integration or {})

     -- Define a new Neovim command 'AskModel'
    vim.api.nvim_create_user_command('AskModel', function(input)
        local question = input.args
        if question == "" then
            print("Please provide a question.")
            return
        end
        codellama.ask_question(question, function(response)
            -- Assuming 'response' contains a list of answers or similar
            telescope_integration.display_results(response)
        end)
    end, {
        nargs = "*",  -- Allows for any number of arguments to be passed
        desc = "Ask a question to the model",  -- Description for :help
    })
end

return M

