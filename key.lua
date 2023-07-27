function turnTheKey()
    local c = "~/.local/bin/read-key"
    local f = io.popen("/bin/sh" .. [[ -l -i -c "]] .. c .. [["]], "r")
    local s = f:read("*a"):gsub("%s*$", "")
    hs.eventtap.keyStrokes(s)
    f:close()
end
