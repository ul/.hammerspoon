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
    local screenUUID = "C13F5D79-658E-43E8-AC39-E9195A9BFAC4"
    return hs.screen.watcher.new(
        function()
            if not hs.screen.find(screenUUID) then
                hs.application("zoom.us"):kill()
            end
        end
    )
end

function hideChromeUSBPopup()
    return hs.window.filter.new(
        function(w)
            return (w:application() ~= nil) and (w:application():title() == "Google Chrome") and
                (w:frame().area == 32400)
        end
    ):subscribe(
        hs.window.filter.windowCreated,
        function(w)
            -- w:close() doesn't work on that popup, thus just moving it out of the way
            -- also have to inject delay as Chrome positions the window after creation
            hs.timer.doAfter(
                1,
                function()
                    w:setTopLeft({hs.screen.mainScreen():frame().w, 0})
                end
            )
        end
    )
end

function openRecentTerminal()
    hs.execute("switch-to-terminal", true)
end
