require("hyper_meh")
require("coffee")
require("clipboard_actions")
-- N.B. clipboard_sequences sets up own bindings
require("clipboard_sequences")
require("misc")

bindApps(
    {
        a = "Activity Monitor",
        b = "Logseq",
        c = "Visual Studio Code",
        d = "Dash",
        e = "Emacs",
        f = "Figma",
        l = "Slack",
        n = "Notes",
        s = "Google Chrome",
        t = "iTerm",
        z = "zoom.us"
    }
)

bindActions(
    {
        c = hs.spotify.playpause,
        g = goURL,
        j = goJ,
        k = toggleCoffee,
        r = hs.reload,
        v = hs.spotify.displayCurrentTrack,
        x = hs.spotify.next,
        y = centerMouseInWindow,
        z = hs.spotify.previous
    }
)

normalizeDeleteWord()

killZoomOnMonitorOff():start()

hs.alert.show("Hammerspoon is ready")
