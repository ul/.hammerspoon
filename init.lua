require("hyper_meh")
require("clipboard_actions")
-- N.B. clipboard_sequences sets up own bindings
-- require("clipboard_sequences")
require("misc")

bindApps(
    {
        a = "Anytype",
        c = "Visual Studio Code",
        -- e = "/Users/rprakapchuk/Applications/Home Manager Apps/Emacs.app",
        e = "Emacs",
        i = "IntelliJ IDEA Ultimate",
        l = "Slack",
        n = "Notes",
        s = "Google Chrome",
        t = "Ghostty",
        v = "Visual Studio Code",
        z = "zoom.us"
    }
)

bindActions(
    {
        c = hs.spotify.playpause,
        e = emacsEverywhereSafe,
        g = goURL,
        j = goJ,
        r = hs.reload,
        v = hs.spotify.displayCurrentTrack,
        x = hs.spotify.next,
        y = centerMouseInWindow,
        z = hs.spotify.previous
    }
)

-- normalizeDeleteWord()

killZoomOnMonitorOff():start()
hideChromeUSBPopup()

require("keystats")

hs.alert.show("Hammerspoon is ready")
