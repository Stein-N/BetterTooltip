TooltipUtils = {}

--- Checks if the given Tooltip is valid
---@param tooltip GameTooltip
local function ValidTooltip(tooltip)
    return tooltip and not tooltip:IsForbidden()
end

---Checks if the given string exists and isn't empty
---@param string string
local function ValidText(string)
    return string ~= nil and string:match("%S")
end

---Checks if the hovered Object is a player unit
---@param tooltip GameTooltip
function TooltipUtils.IsPlayerHovered(tooltip)
    if not (tooltip or tooltip.GetUnit) then
        return false
    end

    local _, unit = tooltip:GetUnit()
    return unit and UnitIsPlayer(unit)
end

---Adds a single line at the end of the given tooltip
---@param tooltip GameTooltip
---@param text string
function TooltipUtils.AddTooltipLine(tooltip, text)
    if ValidTooltip(tooltip) and ValidText(text) then
        tooltip:AddLine(text, 1, 1, 1)
        tooltip:Show()
    end
end

---Adds a line with left and right text to the end of the given tooltip
---@param tooltip GameTooltip
---@param prefix string
---@param text string
function TooltipUtils.AddPrefixedLine(tooltip, prefix, text)
    if ValidTooltip(tooltip) and ValidText(prefix) and ValidText(text) then
        tooltip:AddDoubleLine("|cffffd100" .. prefix .. ":", "|cffffffff" .. text)
        tooltip:Show()
    end
end