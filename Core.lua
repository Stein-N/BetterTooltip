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
            function(t, d)
                if not UnitAffectingCombat("player") then
                    BTModifications.AddTooltipId(t, d.id, string.lower(key))
                end
            end
    )
end

TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Unit,
        function(t, _)
            BTModifications.ApplyTooltipColor(t)

            if not UnitAffectingCombat("player") and not (InCombatLockdown() or IsInInstance()) then
                BTModifications.AddUnitId(t, "unit")
                BTModifications.AddPlayerMythicScore(t, "score")
                BTModifications.AddPlayerMount(t, "mount")
                BTModifications.AddPlayerTarget(t, "target")

                BTModifications.AddPlayerGuildRank(t, "rank")
            end
        end)

hooksecurefunc("QuestMapLogTitleButton_OnEnter", function(b)
    BTModifications.AddTooltipId(GameTooltip, b.questID, "quest")
end)