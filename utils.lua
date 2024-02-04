local M = {}

function M.trim_table(tbl)
    local function is_whitespace(str)
        return str:match("^%s*$") ~= nil
    end

    while #tbl > 0 and (tbl[1] == "" or is_whitespace(tbl[1])) do
        table.remove(tbl, 1)
    end

    while #tbl > 0 and (tbl[#tbl] == "" or is_whitespace(tbl[#tbl])) do
        table.remove(tbl, #tbl)
    end

    return tbl
end

function M.async_http_request(url, body, callback)
    local cmd = "curl --silent --no-buffer -X POST " .. url .. " -d " .. vim.fn.shellescape(body)
    vim.fn.jobstart(cmd, {
        on_stdout = function(_, data)
            callback(table.concat(data, ""))
        end,
        stdout_buffered = true,
    })
end

return M

