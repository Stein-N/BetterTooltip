local _, addon = ...
DungeonTooltipModule = {}
DTM = DungeonTooltipModule

function DungeonTooltipModule:AddContribution(tooltip)
    if not C_ScenarioInfo.GetUnitCriteriaProgressValues then return end

    local numerical, _, percentage = C_ScenarioInfo.GetUnitCriteriaProgressValues("mouseover")

    local lang = addon.Locale.contributes
    local displayNumerical = BTSettings.displayMythicPlusInfoActive.forcesProgressNumerical
    local displayPercentage = BTSettings.displayMythicPlusInfoActive.forcesProgressPercentage

    local text
    if displayNumerical and displayPercentage and numerical ~= nil and percentage ~= nil then
        text = string.format("%d (%s%s", numerical or "0", percentage or "1", "%)")
    end

    if not displayNumerical and displayPercentage and percentage ~= nil then
        text = string.format("%s%s", percentage or "1", "%")
    end

    if displayNumerical and not displayPercentage and numerical ~= nil then
        text = string.format("%d", numerical or "0")
    end

    if lang ~= nil and text ~= nil then
        TooltipUtils.AddPrefixedLine(tooltip, lang.label, text)
    end
end

function DungeonTooltipModule:Init()
    TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Unit, function(tooltip, _)
        if BTUtils.IsPlayerHovered() then return end
        if not C_ChallengeMode.IsChallengeModeActive() then return end

        DungeonTooltipModule:AddContribution(tooltip)
    end)
end

addon.AddModule(DungeonTooltipModule)