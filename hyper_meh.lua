-- `hyper` is for system-wide actions, `meh` is for focusing apps. Both have
-- dedicated keys assigned to them on keyboard so I don't have to do finger
-- gymnastics.

hyper = {"alt", "shift", "ctrl", "cmd"}
meh = {"alt", "shift", "ctrl"}

function bindActions(keyToAction)
    for key, action in pairs(keyToAction) do
        hs.hotkey.bind(hyper, key, action)
    end
end

-- Bind meh-{key} to focus specific application.
-- appName must be as in Dock tooltip, not as a title in Menu Bar.
-- Double press within 500ms will center the window using PaperWM.
function bindApp(key, appName)
    local lastPressTime = 0
    local doubleClickThreshold = 0.5 -- 500ms
    
    hs.hotkey.bind(
        meh,
        key,
        function()
            local currentTime = hs.timer.secondsSinceEpoch()
            local timeDiff = currentTime - lastPressTime
            
            if timeDiff <= doubleClickThreshold then
                -- Double press detected - center window
                if PaperWM and PaperWM.windows and PaperWM.windows.centerWindow then
                    PaperWM.windows.centerWindow()
                else
                    hs.alert.show("PaperWM center_window not available")
                end
            else
                -- Single press - focus app
                hs.application.launchOrFocus(appName)
            end
            
            lastPressTime = currentTime
        end
    )
end

function bindApps(keyToAppName)
    for key, appName in pairs(keyToAppName) do
        bindApp(key, appName)
    end
end
