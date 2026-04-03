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
    local guid = UnitGUID(unit)
    if guid ~= nil then
        local _, realm = UnitFullName(unit)
        local slug = self:GetRealmSlug(realm or GetNormalizedRealmName())

        return self:GetLanguage(slug)
    end
end

function RegionUtils:GetLanguageFromResultID(resultID)
    local result = C_LFGList.GetSearchResultInfo(resultID)
    if result ~= nil then
        local _, realm = strsplit("-", result.leaderName)
        local slug = self:GetRealmSlug(realm or GetNormalizedRealmName())

        return self:GetLanguage(slug)
    end
end

