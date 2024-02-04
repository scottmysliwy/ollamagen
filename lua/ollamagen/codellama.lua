local utils = require('ollamagen.utils')
local M = {}

M.config = {
    model = "mistral",
    api_url = "http://localhost:11434/api",
}

function M.setup(opts)
    M.config = vim.tbl_extend("force", M.config, opts)
end

function M.generate_code(prompt, callback)
    local body = vim.fn.json_encode({model = M.config.model, prompt = prompt})
    utils.async_http_request(M.config.api_url .. "/generate", body, function(response)
        callback(vim.fn.json_decode(response))
    end)
end

function M.ask_question(question, callback)
    local body = vim.fn.json_encode({question = question})
    utils.async_http_request(M.config.api_url .. "/ask", body, function(response)
        callback(vim.fn.json_decode(response))
    end)
end

return M

