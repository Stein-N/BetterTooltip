BTEvents = {}
local handler = {}

function handler.ADDON_LOADED(name)
    if name == BTData.addonName then
        BTMenu.BuildSettings()

        hooksecurefunc("GameTooltip_SetDefaultAnchor", BTModifications.SetTooltipAnchor)

        hooksecurefunc(GameTooltip, "Show", function(self)
            BTModifications.SetTooltipScale(self)
            BTModifications.HideTooltipInCombat(self)
            BTModifications.ApplyTooltipHealthbar()
        end)
    end
end

function BTEvents.OnEvent(event, ...)
    local func = handler[event]
    if func then return func(...) end
end