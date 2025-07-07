require("hyper_meh")
require("coffee")
require("clipboard_actions")
-- N.B. clipboard_sequences sets up own bindings
-- require("clipboard_sequences")
require("misc")

bindActions(
    {
        g = goURL,
        j = goJ,
        k = toggleCoffee,
    }
)

-- normalizeDeleteWord()

killZoomOnMonitorOff():start()
hideChromeUSBPopup()

require("keystats")

hs.alert.show("Hammerspoon is ready")
