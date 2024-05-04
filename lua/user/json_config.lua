local function read_json(path)
    local file = io.open(path, "r")
    if not file then return nil end
    local content = file:read "*a"
    file:close()
    local err, retval = pcall(vim.json.decode, content)
    if err == false then
        error("error in json file: " .. path)
        return nil
    end
    return retval
end

local M = {}
local build = read_json(".nvim/build.json")
M.build = {}

if build then
    if build.build then
        M.build.build = build.build
    end

    if build.generate then
        M.build.generate = build.generate
    end
end


local run = read_json(".nvim/run.json")
M.run = {}

if run then
    if run.debug then
        M.run.debug = run.debug
    end
end

return M
