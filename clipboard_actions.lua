-- Open go/j/{selected issue key}
function goJ()
    hs.eventtap.keyStroke({"cmd"}, "c")
    local issueKey = hs.pasteboard.readString()
    issueKey = string.match(issueKey, "[A-Z]+-%d+")
    if issueKey then
        local url = string.format("http://go.atlassian.com/j/%s", issueKey)
        hs.urlevent.openURL(url)
    end
end

-- Open selected url (useful for non-linkified go links)
function goURL()
    hs.eventtap.keyStroke({"cmd"}, "c")
    local url = hs.pasteboard.readString()
    local hasProtocol = string.match(url, "://")
    if not hasProtocol then
        url = "http://" .. url
    end
    hs.urlevent.openURL(url)
end
