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

-- Simple Split Function
function BetterTooltipUtils:SplitString(input, sep)
    local result = {}
    sep = sep or "%s" -- Use seperator or whitespace

    for part in string.gmatch(input, "([^" .. sep .. "]+)") do
        table.insert(result, part)
    end

    return result
end