local function execute(command, user_env)
    local f
    if user_env then
        f = io.popen("/bin/sh" .. [[ -l -i -c "]] .. command .. [["]], "r")
    else
        f = io.popen(command, "r")
    end
    local s = f:read("*a")
    local status, exit_type, rc = f:close()
    return s, status, exit_type, rc
end

function turnTheKey()
    local c = "~/.local/bin/read-key"
    local f = io.popen("/bin/sh" .. [[ -l -i -c "]] .. c .. [["]], "r")
    local s = f:read("*a"):gsub('%s*$', '')
    hs.eventtap.keyStrokes(s)
    f:close()
end
