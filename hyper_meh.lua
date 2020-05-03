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
function bindApp(key, appName)
    hs.hotkey.bind(
        meh,
        key,
        function()
            hs.application.launchOrFocus(appName)
        end
    )
end

function bindApps(keyToAppName)
    for key, appName in pairs(keyToAppName) do
        bindApp(key, appName)
    end
end
