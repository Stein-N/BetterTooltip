BTSettings = {}

local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")

f:SetScript("OnEvent", function(self, event, ...)
    BTEvents.OnEvent(event, ...)
end)