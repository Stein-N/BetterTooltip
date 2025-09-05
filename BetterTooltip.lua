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

-- Returns the toggleAnchor from SavedVariables
function BetterTooltip:IsAnchorEnabled()
    return GetOptionValue("toggleAnchor")
end

-- Returns the anchorPosition from SavedVariables
function BetterTooltip:GetAnchorPosition()
    return GetOptionValue("anchorPosition")
end

-- Returns the showUnitIds from SavedVariables
function BetterTooltip:IsShowUnitIdEnabled()
    return GetOptionValue("showUnitIds")
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
    local enabled = GetOptionValue("hideTooltips")
    if enabled then
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
    local enabled = GetOptionValue("hideTooltipHealthbar")
    if enabled then
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

    BetterTooltipUtils:AddTooltipIdText(tooltip, "|cffffd100" .. "Unit ID: |r" .. parts[6])
end