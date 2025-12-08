BTEvents = {}
local handler = {}

function handler.ADDON_LOADED(name)
    if name == BTData.addonName then
        BTMenu.BuildSettings()

        BTModifications.SetTooltipAnchor()
    end
end

function BTEvents.OnEvent(event, ...)
    local func = handler[event]
    if func then return func(...) end
end