local _, addon = ...
LFGListTooltipModule = {}

function LFGListTooltipModule.AddTooltipLanguage(tooltip, resultID)
    local language = RegionUtils:GetLanguageFromResultID(resultID)
    if tooltip ~= nil and language ~= nil then
        local lang = addon.Locale.language
        TooltipUtils.AddPrefixedLine(tooltip, lang.label, language)
    end
end

function LFGListTooltipModule.AddMemberLanguage(member, appID, index)
    local language = RegionUtils:GetLangFlagFromApplicant(appID, index)

    if member.Name ~= nil then
        member.Name:SetText(language .. member.Name:GetText())
    end
end

function LFGListTooltipModule:Init()
    hooksecurefunc("LFGListUtil_SetSearchEntryTooltip", LFGListTooltipModule.AddTooltipLanguage)

    hooksecurefunc("LFGListApplicationViewer_UpdateApplicantMember", LFGListTooltipModule.AddMemberLanguage)
end

addon.AddModule(LFGListTooltipModule)