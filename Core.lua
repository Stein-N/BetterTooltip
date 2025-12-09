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

local tooltipMods = { "Spell", "Mount", "UnitAura", "Item", "Toy", "Currency", "Quest", "Macro" }
for _, key in ipairs(tooltipMods) do
    TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType[key],
            function(t, d) BTModifications.AddTooltipId(t, d, string.lower(key)) end)
end

TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Unit,
        function(t, _)
            BTModifications.AddUnitId(t, "unit")
            BTModifications.AddPlayerMount(t, "mount")
            BTModifications.AddPlayerMythicScore(t, "score")
            BTModifications.AddPlayerTarget(t, "target")

            BTModifications.PlayerNameToClassColor(t)
            BTModifications.AddPlayerGuildRank(t, "rank")
        end)