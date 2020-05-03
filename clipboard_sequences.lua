-- Integration with Alfred Clipboard History that enables FIFO and LIFO style
-- copy-pasting of sequences of items.
--
-- Requires a simple workflow in Alfred that receives clipboard history item
-- index from external trigger and immediately pastes that item.
--
-- Relies on cmd+c being used to copy as opposed to the context menu etc.
--
-- Binds cmd+option+v to pasting items as if the history was a stack.
-- Copying a new item with cmd+c resets the stack pointer.
--
-- Binds ctrl+option+c to copying item and marking it as a start of a queue.
-- Consecutive items copied as usual with cmd+c.
-- Binds ctrl+option+v to paste the next item from the queue, starting from the
-- one copied with ctrl+option+c.

local alfredWorkflowBundleId = "com.atlassian.rprakapchuk.clipboard"
local alfredWorkflowTriggerId = "paste"

local clipboardStackIndex = 0
local clipboardQueueIndex = 0

local function pasteFromAlfred(index)
    hs.applescript(
        'tell application id "com.runningwithcrayons.Alfred" to run trigger "' ..
            alfredWorkflowTriggerId ..
                '" in workflow "' .. alfredWorkflowBundleId .. '" with argument "' .. tostring(index) .. '"'
    )
end

local function popClipboardStack()
    pasteFromAlfred(clipboardStackIndex)
    clipboardStackIndex = clipboardStackIndex + 1
end

local function resetClipboardStack()
    clipboardStackIndex = 0
end

local function popClipboardQueue()
    pasteFromAlfred(clipboardQueueIndex)
    if clipboardQueueIndex > 0 then
        clipboardQueueIndex = clipboardQueueIndex - 1
    end
end

local function pushClipboardQueue()
    clipboardQueueIndex = clipboardQueueIndex + 1
end

local cmdC

local function rawCmdC()
    cmdC:disable()
    hs.eventtap.keyStroke({"cmd"}, "c", 0)
    cmdC:enable()
end

local function handleCmdC()
    rawCmdC()
    resetClipboardStack()
    pushClipboardQueue()
end

local function activateClipboardQueue()
    rawCmdC()
    clipboardQueueIndex = 0
end

cmdC = hs.hotkey.bind({"cmd"}, "c", handleCmdC, nil, nil)
hs.hotkey.bind({"alt", "ctrl"}, "c", nil, activateClipboardQueue, nil) -- have to be on release, otherwise messes with emitted cmd+c
hs.hotkey.bind({"alt", "ctrl"}, "v", popClipboardQueue, nil, nil)
hs.hotkey.bind({"alt", "cmd"}, "v", popClipboardStack, nil, nil)
