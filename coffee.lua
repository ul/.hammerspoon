-- This module helps to avoid mandatory screen lock in the trusted environment
-- which is detected as "my external monitor is connected and is on".

local screenUUID = "C13F5D79-658E-43E8-AC39-E9195A9BFAC4"

local coffee = nil

local function takeCoffee()
    if not coffee then
        coffee = hs.task.new("/usr/bin/caffeinate", nil, {"-usd"})
        coffee:start()
    end
end

local function takeMelatonin()
    if coffee then
        coffee:terminate()
        coffee = nil
    end
end

local autoCoffee =
    hs.screen.watcher.new(
    function()
        if hs.screen.find(screenUUID) then
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
