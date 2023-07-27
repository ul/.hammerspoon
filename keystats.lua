local logPath = "/Users/rprakapchuk/keyStats.txt"
local keyStats = {}

keyStatsTimer =
    hs.timer.doEvery(
    60,
    function()
        local keyStatsString = ""
        for key, value in pairs(keyStats) do
            keyStatsString = keyStatsString .. key .. ": " .. value .. "\n"
        end
        keyStats = {}
        local keyStatsFile = io.open(logPath, "a")
        keyStatsFile:write(keyStatsString)
        keyStatsFile:close()
    end
):start()

local lastKey = nil

function getEventKey(event)
    local key = hs.keycodes.map[event:getKeyCode()]
    local mods = event:getFlags()
    for k, v in pairs(mods) do
        if v then
            key = k .. "+" .. key
        end
    end
    return key
end

keyStatsWatcher =
    hs.eventtap.new(
    {hs.eventtap.event.types.keyDown},
    function(event)
        local key = getEventKey(event)
        if key == "delete" then
            key = "-" .. lastKey
        end
        if keyStats[key] == nil then
            keyStats[key] = 1
        else
            keyStats[key] = keyStats[key] + 1
        end
        lastKey = getEventKey(event)
    end
):start()
