require("hyper_meh")
require("coffee")
require("clipboard_actions")
-- N.B. clipboard_sequences sets up own bindings
require("clipboard_sequences")
require("misc")
require("key")

bindApps(
    {
        a = "Activity Monitor",
        b = "RustDesk",
        c = "Google Chrome",
        d = "Dash",
        e = "Emacs",
        i = "IntelliJ IDEA",
        l = "Slack",
        n = "Notes",
        s = "Google Chrome",
        v = "Visual Studio Code",
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

hs.hotkey.bind(hyper, "q", nil, turnTheKey)

normalizeDeleteWord()

killZoomOnMonitorOff():start()
hideChromeUSBPopup()

hs.alert.show("Hammerspoon is ready")
