local codellama = require('ollamagen.codellama')
local telescope_integration = require('ollamagen.telescope_integration')

local M = {}

function M.setup(opts)
    codellama.setup(opts.codellama or {})
    telescope_integration.setup(opts.telescope_integration or {})
end

return M

