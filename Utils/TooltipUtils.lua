local _, addon = ...
TooltipUtils = {}

--- Checks if the given Tooltip is valid
---@param tooltip GameTooltip
local function ValidTooltip(tooltip)
    return tooltip and not tooltip:IsForbidden()
end

---Checks if the given string exists and isn't empty
---@param string string
local function ValidText(string)
    string = tostring(string)
    return string ~= nil and string:match("%w+")
end

---Checks if the hovered Object is a player unit
---@param tooltip GameTooltip
function TooltipUtils.IsPlayerHovered(tooltip)
    if tooltip ~= nil and tooltip.GetUnit ~= nil then
        local _, unit = tooltip:GetUnit()

        if unit ~= nil then
            local guid = UnitGUID(unit)
            local type = strsplit("-", guid)

            return type:lower() == "player"
        end
    end

    return false
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
function TooltipUtils.AddPrefixedLine(tooltip, prefix, text, textColor)
    if ValidTooltip(tooltip) and ValidText(prefix) and ValidText(text) then
        tooltip:AddDoubleLine("|cffffd100" .. prefix .. ":", (textColor or "|cffffffff") .. text)
        tooltip:Show()
    end
end