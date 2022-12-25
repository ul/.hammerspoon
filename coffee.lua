-- This module helps to avoid mandatory screen lock in the trusted environment
-- which is detected as "my external monitor is connected and is on".

local screenId = "DE32F816-9BF2-42CB-850D-5C5451299433"

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
        if hs.screen.find(screenId) then
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
        hs.alert.show("No more coffee today")
    else
        autoCoffee:start()
        takeCoffee()
        isAutoCoffee = true
        hs.alert.show("Coffee!")
    end
end
