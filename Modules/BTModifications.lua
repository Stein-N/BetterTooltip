BTModifications = {}
BM = BTModifications
local _lang = GetLocale()

local function GetPrefix(key)
    local prefix = BTPrefixes[_lang][key] or BTPrefixes.enUS[key]
    return prefix
end

function BM.SetTooltipAnchor(tooltip, parent)
    if not BTSettings.toggleAnchor then return end

    if tooltip and not tooltip:IsForbidden() then
        local anchor = BTSettings.anchorPosition
        if anchor then
            tooltip:SetOwner(parent or UIParent, anchor)
        end
    end
end

function BM.SetTooltipScale(tooltip)
    if BTSettings.toggleScaling then
        if tooltip and not tooltip:IsForbidden() then
            local scale = BTSettings.tooltipScale
            if scale then
                tooltip:SetScale(scale / 100)
            end
        end
    else
        tooltip:SetScale(1)
    end
end

function BM.HideTooltipInCombat(tooltip)
    if BTSettings.hideTooltip and UnitAffectingCombat("player") then
        tooltip:Hide()
    end
end

function BM.ApplyTooltipHealthbar()
    if BTSettings.hideHealthbar then
        GameTooltipStatusBarTexture:SetTexture(nil)
    else
        GameTooltipStatusBarTexture:SetTexture(137014)
    end
end

function BM.AddTooltipId(tooltip, data, key)
    if data.id then
        local prefix = GetPrefix(string.lower(key))
        if BTSettings.activeIds[key] then
            BTUtils.AddPrefixedText(tooltip, prefix .. "-ID", data.id)
        end
    end
end

function BM.AddUnitId(tooltip, key)
    if tooltip and tooltip.GetUnit then
        local _, unit = tooltip:GetUnit()
        local guid = UnitGUID(unit)

        if guid ~= nil and guid ~= "" then
            local parts = BTUtils.SplitString(guid, "%-")
            local prefix = GetPrefix(key)

            if BTSettings.activeIds[key] then
                BTUtils.AddPrefixedText(tooltip, prefix .. "-ID", parts[6])
            end
        end
    end
end

function BM.AddPlayerMount(tooltip, key)
    if BTUtils.IsPlayerHovered(tooltip) then
        for i = 1, 40 do
            local aura = C_UnitAuras.GetAuraDataByIndex("mouseover", i)
            if aura and aura.name then
                if BTUtils.IsAuraMount(aura) and BTSettings.activePlayerInfo[key] then
                    local prefix = GetPrefix(key)
                    BTUtils.AddPrefixedText(tooltip, prefix, aura.name)
                end
            end
        end
    end
end

function BM.AddPlayerMythicScore(tooltip, key)
    if BTUtils.IsPlayerHovered(tooltip) then
        local summary = C_PlayerInfo.GetPlayerMythicPlusRatingSummary("player")
        local prefix = GetPrefix(key)
        if summary and BTSettings.activePlayerInfo[key] then
            BTUtils.AddPrefixedText(tooltip, prefix, summary.currentSeasonScore or 100)
        end
    end
end

function BM.AddPlayerTarget(tooltip, key)
    if BTUtils.IsPlayerHovered(tooltip) then
        local _, unit = tooltip:GetUnit()

        if not UnitIsUnit("player", unit) then
            local target = UnitName(unit .. "target")
            local prefix = GetPrefix(key)
            if BTSettings.activePlayerInfo[key] then
                BTUtils.AddPrefixedText(tooltip, prefix, target)
            end
        end
    end
end