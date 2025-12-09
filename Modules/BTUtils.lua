BTUtils = {}

function BTUtils.IsPlayerHovered(tooltip)
    if not (tooltip and tooltip.GetUnit) then return end
    local _, unit = tooltip:GetUnit()
    return unit and UnitIsPlayer(unit)
end

function BTUtils.AddTooltipText(tooltip, text)
    if not tooltip or tooltip:IsForbidden() then return end
    if text ~= nil and text ~= "" then
        tooltip:AddLine(text, 1, 1, 1)
        tooltip:Show()
    end
end

function BTUtils.AddPrefixedText(tooltip, prefix, text)
    if not tooltip or tooltip:IsForbidden() then return end
    if text ~= nil and text ~= "" and prefix ~= nil and prefix ~= "" then
        tooltip:AddDoubleLine("|cffffd100" .. prefix .. ":", "|cffffffff" .. text)
        tooltip:Show()
    end
end

function BTUtils.SplitString(input, sep)
    local result = {}
    sep = sep or "%s"

    for part in string.gmatch(input, "([^" .. sep .. "]+)") do
        table.insert(result, part)
    end

    return result
end

function BTUtils.IsAuraMount(aura)
    if aura.spellId then
        local mountId = C_MountJournal.GetMountFromSpell(aura.spellId)
        if mountId then return true end
    end

    return false
end