-- This module helps to avoid mandatory screen lock in the trusted environment
-- which is detected as "my external monitor is connected and is on".

local screenUUID = "3192FE8A-349C-45C9-A311-099F7EBC9308"

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
        hs.alert.show("No more coffee today")
    else
        autoCoffee:start()
        takeCoffee()
        isAutoCoffee = true
        hs.alert.show("Coffee!")
    end
end
