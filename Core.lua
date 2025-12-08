BTSettings = {}

local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")

f:SetScript("OnEvent", function(self, event, ...)
    BTEvents.OnEvent(event, ...)
end)

hooksecurefunc("GameTooltip_SetDefaultAnchor", BTModifications.SetTooltipAnchor)

hooksecurefunc(GameTooltip, "Show", function(self)
    BTModifications.SetTooltipScale(self)
    BTModifications.HideTooltipInCombat(self)
    BTModifications.ApplyTooltipHealthbar()
end)