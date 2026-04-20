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
    if ValidTooltip(tooltip) then
        tooltip:AddDoubleLine("|cffffd100" .. prefix .. ":", (textColor or "|cffffffff") .. text)
        tooltip:Show()
    end
end

---@param tooltip GameTooltip
---@param iLvl string
function TooltipUtils.UpdateItemLevelLine(tooltip, iLvl)
    if ValidTooltip(tooltip) and ValidText(iLvl) then
        local lang = addon.Locale.itemLevel
        local pattern = lang.label .. ":"

        for i = tooltip:NumLines(), 1, -1 do
            local tipName = tooltip:GetName()
            local leftText = _G[tipName .."TextLeft" .. i]:GetText()
            if type(leftText) == "string" and leftText:find(pattern) then
                local iLvlText = _G[tipName .. "TextRight" .. i]
                iLvlText:SetText("|cffffffff" .. iLvl)

                return
            end
        end
    end
end