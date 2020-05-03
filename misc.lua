-- Chromium-based abominations do not appreciate old good ctrl+w,
-- this is a workaround to teach them.
function normalizeDeleteWord()
    local function deleteWord()
        local title = hs.window.focusedWindow():application():title()
        if title == "Google Chrome" or title == "Slack" then
            hs.eventtap.keyStroke({"alt"}, "delete", 0)
        else
            ctrlW:disable()
            hs.eventtap.keyStroke({"ctrl"}, "w", 0)
            ctrlW:enable()
        end
    end

    local ctrlW = hs.hotkey.bind({"ctrl"}, "w", deleteWord, nil, nil)
end

function centerMouseInWindow()
    local frame = hs.window.focusedWindow():frame()
    hs.mouse.setAbsolutePosition(frame.center)
end
