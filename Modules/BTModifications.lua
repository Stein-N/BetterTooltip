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
            BTUtils.AddPrefixedText(tooltip, prefix, data.id)
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
                BTUtils.AddPrefixedText(tooltip, prefix, parts[6])
            end
        end
    end
end