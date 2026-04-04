local _, addon = ...
RegionUtils = {}

function RegionUtils:Init()
    local region = GetCurrentRegionName()
    if region ~= nil then
        addon.Region = BetterTooltipRegions[region] or {}
    end
end

function RegionUtils:GetRealmSlug(realm)
    return realm:gsub("[%s']", ""):lower();
end

function RegionUtils:GetLanguage(realmSlug)
    if realmSlug ~= nil or realmSlug ~= "" then
        local langCode = addon.Region[realmSlug].locale

        return addon.Locale.languages[langCode]
    end
end

function RegionUtils:GetLanguageFromUnit(unit)
    if unit ~= nil then
        local _, realm = UnitFullName(unit)
        local slug = self:GetRealmSlug(realm or GetNormalizedRealmName())

        return self:GetLanguage(slug)
    end
end

function RegionUtils:GetLanguageFromResultID(resultID)
    local result = C_LFGList.GetSearchResultInfo(resultID)
    if result ~= nil and result.leaderName ~= nil then
        local _, realm = strsplit("-", result.leaderName)
        local slug = self:GetRealmSlug(realm or GetNormalizedRealmName())

        return self:GetLanguage(slug)
    end
end

function RegionUtils:GetLangFlagFromApplicant(appID, memberIndex)
    local fullName = C_LFGList.GetApplicantMemberInfo(appID, memberIndex)
    if fullName ~= nil then
        local _, realm = strsplit("-", fullName)
        local slug = self:GetRealmSlug(realm or GetNormalizedRealmName())
        local locale = addon.Region[slug].locale

        return "|TInterface\\AddOns\\BetterTooltip\\Media\\" .. locale .. "_flag:10:18|t "
    end
end

