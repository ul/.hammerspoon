-- This module helps to avoid mandatory screen lock in the trusted environment
-- which is detected as "my external monitor is connected and is on".

--
local screenUUIDs = {"C13F5D79-658E-43E8-AC39-E9195A9BFAC4", "7ABAF228-FFBD-4B98-B7D4-F6DB06CC9556", "F28E8228-B03D-4E0C-81D7-3323543C4429"}

local function isScreenConnected(uuid)
    return hs.screen.find(uuid) ~= nil
end

local coffee = hs.timer.new(60, hs.caffeinate.declareUserActivity)

local function takeCoffee()
    coffee:start()
    hs.caffeinate.set("displayIdle", true)
    hs.caffeinate.set("systemIdle", true)
    hs.caffeinate.set("system", true)
end

local function takeMelatonin()
    coffee:stop()
    hs.caffeinate.set("displayIdle", false)
    hs.caffeinate.set("systemIdle", false)
    hs.caffeinate.set("system", false)
end

local autoCoffee =
    hs.screen.watcher.new(
    function()
        local anyScreenConnected = false

        for _, uuid in ipairs(screenUUIDs) do
            if isScreenConnected(uuid) then
                anyScreenConnected = true
                break
            end
        end

        if anyScreenConnected then
            takeCoffee()
        else
            takeMelatonin()
        end
    end
)

local isAutoCoffee = false

function toggleCoffee()
    if isAutoCoffee then
        autoCoffee:stop()
        takeMelatonin()
        isAutoCoffee = false
        hs.alert.show("  🔒  ")
    else
        autoCoffee:start()
        takeCoffee()
        isAutoCoffee = true
        hs.alert.show("  ☕️  ")
    end
end
