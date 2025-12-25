require("hyper_meh")
require("coffee")
require("clipboard_actions")
-- N.B. clipboard_sequences sets up own bindings
-- require("clipboard_sequences")
require("misc")

require("hs.ipc")

bindApps(
    {
        a = "AnyType",
        b = "Logseq",
        c = "Google Chrome",
        d = "Discord",
        e = "/Users/ul/Applications/Home Manager Apps/Emacs.app",
        -- e = "/Users/ul/.nix-profile/Applications/Emacs.app",
        -- e = "Emacs",
        f = "Figma",
        h = "/Users/ul/ergral-3d/target/hotreload",
        k = "Anki",
        l = "Telegram",
        n = "Notes",
        p = "SuperCollider",
        s = "Safari",
        -- u = "Unity",
        v = "Visual Studio Code"
    }
)

bindActions(
    {
        c = hs.spotify.playpause,
        g = goURL,
        k = toggleCoffee,
        r = hs.reload,
        v = hs.spotify.displayCurrentTrack,
        x = hs.spotify.next,
        y = centerMouseInWindow,
        z = hs.spotify.previous
    }
)

hs.hotkey.bind(
    meh,
    "t",
    function()
        hs.execute("switch-to-terminal", true)
    end
)

-- normalizeDeleteWord()

require("keystats")

hs.alert.show("Hammerspoon is ready")
