local M = {}

M.debug = function(t)
    if (t) then
        print(vim.inspect(t))
    else
        print(vim.inspect(M.test))
    end
end

vim.g.debug = M.debug

M.test = {}
M.trace = function(value)
    if (M.test) then
        table.insert(M.test, value)
    end
end


return M