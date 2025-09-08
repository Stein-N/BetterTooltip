-- ================================ --
-- ==     Contains all Logic     == --
-- ==     related to Tooltips    == --
-- ================================ --

BetterTooltip = {}

-- Loads the given SavedVariables Key
local function GetOptionValue(variable)
    local setting = BetterTooltipOptions[variable]
    return BetterTooltipDB[setting["key"]]
end

local function GetPrefix(variable)
    local langCode = GetLocale()
    local setting = BetterTooltipOptions[variable]
    local langObj = setting[langCode] or setting["enEN"]

    return langObj["prefix"]
end

-- Returns the SavedVariable for the given variable
function BetterTooltip:IsEnabled(variable)
    return GetOptionValue(variable)
end

-- Returns the anchorPosition from SavedVariables
function BetterTooltip:GetAnchorPosition()
    return GetOptionValue("anchorPosition")
end

-- Tooltip cant be outside the Screen
function BetterTooltip:SetDefaultBehaviour(tooltip)
    if not tooltip or tooltip:IsForbidden() then return end
    if tooltip.SetClampedToScreen then
        tooltip:SetClampedToScreen(true)
    end
end

-- Disables all Tooltips, also sets a Script that disables the Tooltip when the OnShow Event is triggered
function BetterTooltip:HideTooltips()
    if BetterTooltip:IsEnabled("hideTooltips") then
        GameTooltip:Hide()
        GameTooltip:SetScript("OnShow", GameTooltip.Hide)
    end
end

-- Reenables all Tooltips and removes the Script for the OnShow Event
function BetterTooltip:ShowTooltip()
    GameTooltip:Show()
    GameTooltip:SetScript("OnShow", nil)
end

-- Deactivate the Tooltip Healthbar
function BetterTooltip:HideHealthBar()
    if BetterTooltip:IsEnabled("hideTooltipHealthbar") then
        GameTooltipStatusBarTexture:SetTexture("")
    else
        GameTooltipStatusBarTexture:SetTexture(137014)
    end
end

-- Adds the Unit Id to the Tooltip
function BetterTooltip:AddUnitId(tooltip)
    if not tooltip or BetterTooltipUtils:IsPlayerHovered(tooltip)
    then return end

    local _, unit = tooltip:GetUnit()

    local guid = UnitGUID(unit)
    if guid == nil or guid == "" then return end

    local parts = BetterTooltipUtils:SplitString(guid, "%-")
    if parts == nil or parts == {} then return end

    local prefix = GetPrefix("showUnitId") or "Unit-ID"
    BetterTooltipUtils:AddTooltipIdText(tooltip, "|cffffd100" .. prefix .. ": |r" .. parts[6])
end

-- Generic function to add the Id to the Tooltip
function BetterTooltip:AddId(tooltip, data, prefixKey, defaultPrefix)
    if not data.id then return end

    local prefix = GetPrefix(prefixKey) or defaultPrefix
    BetterTooltipUtils:AddTooltipIdText(tooltip, "|cffffd100" .. prefix .. ": |r" .. data.id)
end

function BetterTooltip:AddMythicScore(tooltip, data)
    if BetterTooltipUtils:IsPlayerHovered(tooltip) then
        local summary = C_PlayerInfo.GetPlayerMythicPlusRatingSummary("mouseover")

        local prefix = GetPrefix("showMythicPlusScore")
        if summary then
            BetterTooltipUtils:AddTooltipIdText(tooltip, "|cffffd100" .. prefix .. ": |r" .. summary.currentSeasonScore)
        end
    end
end