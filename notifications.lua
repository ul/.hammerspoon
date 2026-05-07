-- ~/.hammerspoon/notifications.lua
local M = {}

local NC_BUNDLE = "com.apple.notificationcenterui"
local BANNER_SUBROLE = "AXNotificationCenterBanner"

local function attr(el, n)
  local ok, v = pcall(function() return el:attributeValue(n) end)
  if ok then return v end
end

-- DFS that returns *all* notification-banner elements in document order
-- (top-most banner first, since the AX tree mirrors visual stacking).
local function findBanners()
  local apps = hs.application.applicationsForBundleID(NC_BUNDLE)
  local app  = apps and apps[1]
  if not app then return {} end
  local root = hs.axuielement.applicationElement(app)
  if not root then return {} end

  local banners = {}
  local function dfs(el, depth)
    if not el or depth > 16 then return end
    if attr(el, "AXSubrole") == BANNER_SUBROLE then
      banners[#banners+1] = el
      -- Don't descend into a banner; its children are static text only.
      return
    end
    for _, k in ipairs(attr(el, "AXChildren") or {}) do dfs(k, depth+1) end
  end

  for _, w in ipairs(attr(root, "AXWindows") or {}) do dfs(w, 0) end
  return banners
end

-- Perform a named action on the topmost banner. `action` is one of
-- "AXPress" (default), "Show Details", "Show", "Close", or any other
-- name the app declared (varies per notification).
local function actOnTopBanner(action)
  local banners = findBanners()
  local b = banners[1]
  if not b then hs.alert.show("No notification on screen"); return false end
  local ok, err = b:performAction(action or "AXPress")
  if not ok then
    hs.alert.show(string.format("%s failed: %s", action, tostring(err)))
    return false
  end
  return true
end

function M.activate()      return actOnTopBanner("AXPress")       end
function M.showDetails()   return actOnTopBanner("Show Details")  end
function M.show()          return actOnTopBanner("Show")          end
function M.close()         return actOnTopBanner("Close")         end

-- Inspect the actions available on the top banner right now.
-- Useful for one-off "what can I do?" probing, since custom apps add
-- their own action names (e.g. "Reply", "Snooze", "Mark as Read").
function M.debugActions()
  local b = findBanners()[1]
  if not b then print("no banner"); return end
  print("Banner identifier:", attr(b, "AXIdentifier"))
  print("Banner description:", attr(b, "AXDescription"))
  local ok, names = pcall(function() return b:actionNames() end)
  if ok and names then
    for _, n in ipairs(names) do print("  action:", n) end
  end
end

-- Bind a hotkey set. Pick whatever fits your scheme.
-- hs.hotkey.bind({"ctrl", "alt", "cmd"}, "N", M.activate)     -- default action
-- hs.hotkey.bind({"ctrl", "alt", "cmd"}, ".", M.close)        -- dismiss
-- hs.hotkey.bind({"ctrl", "alt", "cmd"}, "/", M.showDetails)  -- expand

return M
