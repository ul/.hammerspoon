-- Chromium-based abominations do not appreciate old good ctrl+w,
-- this is a workaround to teach them.
function normalizeDeleteWord()
    local ctrlW
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

    ctrlW = hs.hotkey.bind({"ctrl"}, "w", deleteWord, nil, nil)
end

function centerMouseInWindow()
    local frame = hs.window.focusedWindow():frame()
    hs.mouse.setAbsolutePosition(frame.center)
end

function killZoomOnMonitorOff()
    local screenUUID = "3192FE8A-349C-45C9-A311-099F7EBC9308"
    return hs.screen.watcher.new(
        function()
            if not hs.screen.find(screenUUID) then
                hs.application("zoom.us"):kill()
            end
        end
    )
end
