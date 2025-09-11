BetterTooltipUtils = {}

-- Simple Check if a Player is currently hovered
function BetterTooltipUtils:IsPlayerHovered(tooltip)
    if not (tooltip and tooltip.GetUnit) then return false end
    local _, unit = tooltip:GetUnit()
    return unit and UnitIsPlayer(unit)
end

-- Adds the given text to the Tooltip
function BetterTooltipUtils:AddTooltipIdText(tooltip, text)
    if not tooltip or tooltip:IsForbidden() then return end
    if text == nil or text == "" then return end

    tooltip:AddLine(text, 1, 1, 1)
    tooltip:Show()
end

function BetterTooltipUtils:AddPrefixedText(tooltip, prefix, id)
    if not tooltip or tooltip:IsForbidden() then return end
    if prefix == nil or prefix == "" or id == nil or id == "" then return end

    tooltip:AddDoubleLine("|cffffd100" .. prefix .. ":", "|cffffffff" .. id)
    tooltip:Show()
end

-- Simple Split Function
function BetterTooltipUtils:SplitString(input, sep)
    local result = {}
    sep = sep or "%s" -- Use seperator or whitespace

    for part in string.gmatch(input, "([^" .. sep .. "]+)") do
        table.insert(result, part)
    end

    return result
end

-- Checks if the given Aura is a Mount
function BetterTooltipUtils:IsAuraMount(aura)
    if not aura.spellId then return false end

    for i = 1, C_MountJournal.GetNumMounts() do
        local mountId = C_MountJournal.GetMountFromSpell(aura.spellId)
        if mountId then return true end
    end

    return false
end