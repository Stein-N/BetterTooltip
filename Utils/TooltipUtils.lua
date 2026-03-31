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
function TooltipUtils.AddPrefixedLine(tooltip, prefix, text, textColor)
    if ValidTooltip(tooltip) and ValidText(prefix) and ValidText(text) then
        tooltip:AddDoubleLine("|cffffd100" .. prefix .. ":", (textColor or "|cffffffff") .. text)
        tooltip:Show()
    end
end

---Get the Region and Category of an player
---@param tooltip GameTooltip
function TooltipUtils.GetPlayerRegion(tooltip)
    if ValidTooltip(tooltip) and tooltip.GetUnit and TooltipUtils.IsPlayerHovered(tooltip) then
        local _, unit = tooltip:GetUnit()

        if unit ~= nil then
            local _, realm = UnitFullName(unit)
            local regionName = GetCurrentRegionName()

            if not realm ~= nil then
                realm = GetNormalizedRealmName()
            end

            realm = realm:gsub("[%s']", ""):lower()

            local regionData = addon.Regions[regionName]

            if regionData ~= nil and regionData[realm] ~= nil then
                local realmData = regionData[realm]
                local regionLang = addon.GetLocale("serverRegion")
                local realmLang = addon.GetLocale("categories")

                return regionLang[regionName], realmLang[realmData.category]
            end
        end

        return "Unknown Region", { category = "N/A", locale = "N/A" }
    end
end