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

local function GetIdPrefix(variable)
    local langCode = GetLocale()
    local setting = BetterTooltipOptions[variable]
    local langObj = setting[langCode] or setting["enEN"]

    return langObj["prefix"]
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
    return GetOptionValue("showUnitId")
end

-- Returns the showSpellIds from SavedVariables
function BetterTooltip:IsShowSpellIdEnabled()
    return GetOptionValue("showSpellId")
end

-- Returns the showMountIds from SavedVariables
function BetterTooltip:IsShowMountIdEnabled()
    return GetOptionValue("showMountId")
end

-- Returns the showAuraId from SavedVariables
function BetterTooltip:IsShowAuraIdEnabled()
    return GetOptionValue("showAuraId")
end

-- Returns the showItemId from SavedVariables
function BetterTooltip:IsShowItemtIdEnabled()
    return GetOptionValue("showItemId")
end

-- Returns the showToytId from SavedVariables
function BetterTooltip:IsShowToyIdEnabled()
    return GetOptionValue("showToyId")
end

-- Returns the showCurrencyId from SavedVariables
function BetterTooltip:IsShowCurrencyIdEnabled()
    return GetOptionValue("showCurrencyId")
end

-- Returns the showQuestId from SavedVariables
function BetterTooltip:IsShowQuestIdEnabled()
    return GetOptionValue("showQuestId")
end

-- Returns the showBattlePetId from SavedVariables
function BetterTooltip:IsShowBattlePetIdEnabled()
    return GetOptionValue("showBattlePetId")
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

    local prefix = GetIdPrefix("showUnitId") or "Unit-ID"
    BetterTooltipUtils:AddTooltipIdText(tooltip, "|cffffd100" .. prefix .. ": |r" .. parts[6])
end

-- Adds the Spell Id to the Tooltip
function BetterTooltip:AddSpellId(tooltip)
    local _, spellId = tooltip:GetSpell()
    if not spellId then return end

    local prefix = GetIdPrefix("showSpellId") or "Spell-ID"
    BetterTooltipUtils:AddTooltipIdText(tooltip, "|cffffd100" .. prefix .. ": |r" .. spellId)
end

-- Adds the Mount Id to the Tooltip
function BetterTooltip:AddMountId(tooltip, data)
    if not data.id then return end
    local mountId = data.id

    local prefix = GetIdPrefix("showMountId") or "Mount-ID"
    BetterTooltipUtils:AddTooltipIdText(tooltip, "|cffffd100" .. prefix .. ": |r" .. mountId)
end

-- Adds the Aura Id to the Tooltip
function BetterTooltip:AddAuraId(tooltip, data)
    if not data.id then return end
    local auraId = data.id

    local prefix = GetIdPrefix("showAuraId") or "Aura-ID"
    BetterTooltipUtils:AddTooltipIdText(tooltip, "|cffffd100" .. prefix .. ": |r" .. auraId)
end