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

hs.window.animationDuration = 0

PaperWM = hs.loadSpoon("PaperWM")
PaperWM.window_gap = 0
PaperWM.window_ratios = {1 / 4, 1 / 3, 1 / 2, 2 / 3, 3 / 4}
PaperWM.swipe_fingers = 4
PaperWM.lift_window = meh
PaperWM:bindHotkeys(
    {
        -- switch to a new focused window in tiled grid
        focus_left = {meh, "left"},
        focus_right = {meh, "right"},
        focus_up = {meh, "up"},
        focus_down = {meh, "down"},
        -- move windows around in tiled grid
        swap_left = {{"ctrl", "alt"}, "left"},
        swap_right = {{"ctrl", "alt"}, "right"},
        swap_up = {{"ctrl", "alt"}, "up"},
        swap_down = {{"ctrl", "alt"}, "down"},
        -- position and resize focused window
        center_window = {meh, "c"},
        full_width = {hyper, "f"},
        cycle_width = {hyper, "s"},
        reverse_cycle_width = {hyper, "r"},
        -- increase/decrease width
        increase_width = {{"ctrl", "alt"}, "."},
        decrease_width = {{"ctrl", "alt"}, ","},
        -- move focused window into / out of a column
        slurp_in = {hyper, "i"},
        barf_out = {hyper, "o"},
        -- move the focused window into / out of the tiling layer
        toggle_floating = {hyper, "t"}
    }
)
PaperWM:start()

bindApps(
    {
        a = "Anytype",
        b = "Logseq",
        e = "/Users/ul/Applications/Home Manager Apps/Emacs.app",
        s = "Safari",
        t = "Ghostty",
    }
)

-- bindActions(
--     {
--     }
-- )

hs.alert.show("Hammerspoon is ready")
