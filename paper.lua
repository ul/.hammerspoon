require("hyper_meh")

hs.window.animationDuration = 0

PaperWM = hs.loadSpoon("PaperWM")
PaperWM.window_gap = 0
PaperWM.window_ratios = {1 / 4, 1 / 3, 1 / 2, 2 / 3, 3 / 4}
PaperWM.swipe_fingers = 3
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
        toggle_floating = {hyper, "t"},
        -- move between screens
        move_window_to_next_screen = {hyper, "v"}
    }
)
PaperWM:start()

WarpMouse = hs.loadSpoon("WarpMouse")
-- WarpMouse.margin = 8  -- optionally set how far past a screen edge the mouse should warp, default is 2 pixels
WarpMouse:start()
