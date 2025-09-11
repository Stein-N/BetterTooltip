-- ================================ --
-- ==     Contains all Logic     == --
-- ==     related to Tooltips    == --
-- ================================ --

BetterTooltip = {}

-- ============================ --
-- ==    All Tooltiptypes    == --
-- ============================ --

local tooltipTypes = {
    GameTooltip,
    FriendsTooltip,
    AutoCompleteBox,
    PetBattlePrimaryAbilityTooltip, PetBattlePrimaryUnitTooltip, BattlePetTooltip, FloatingBattlePetTooltip, FloatingPetBattleAbilityTooltip,
    FloatingGarrisonFollowerTooltip, FloatingGarrisonFollowerAbilityTooltip, FloatingGarrisonMissionTooltip, FloatingGarrisonShipyardFollowerTooltip,
    GarrisonFollowerMissionAbilityWithoutCountersTooltip, GarrisonFollowerAbilityWithoutCountersTooltip,
    ItemRefTooltip, ItemRefShoppingTooltip1, ItemRefShoppingTooltip2, ShoppingTooltip1, ShoppingTooltip2,
    QuestScrollFrame.WarCampaignTooltip, QuestScrollFrame.StoryTooltip,
    QueueStatusFrame,
    EmbeddedItemTooltip,
    NamePlateTooltip,
    SettingsTooltip
}

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

-- Apply the Scaling to all Tooltips
function BetterTooltip:ApplyScalingToTooltips()
    for _, tooltip in pairs(tooltipTypes) do
        if tooltip then
            tooltip:SetScript("OnShow", function(self, data)
                local initialValue = (self == SettingsTooltip) and 0.64 or 1
                BetterTooltip:SetTooltipScale(self, initialValue)
            end)
        end
    end
end

-- Apply the scaling based on the initial value
function BetterTooltip:SetTooltipScale(tooltip, initalValue)
    if not tooltip then return end

    local scale
    if GetOptionValue("toggleScaling") then
        scale = (GetOptionValue("tooltipScale") / 100) * initalValue
    else
        scale = initalValue
    end

    tooltip:SetScale(scale)
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
    BetterTooltipUtils:AddPrefixedText(tooltip, prefix, parts[6])
end

-- Generic function to add the Id to the Tooltip
function BetterTooltip:AddId(tooltip, data, prefixKey, defaultPrefix)
    if not data.id then return end

    local prefix = GetPrefix(prefixKey) or defaultPrefix
    BetterTooltipUtils:AddPrefixedText(tooltip, prefix, data.id)
end

-- Add the current Mythic+ Score to the Tooltip
function BetterTooltip:AddMythicScore(tooltip)
    if BetterTooltipUtils:IsPlayerHovered(tooltip) then
        local summary = C_PlayerInfo.GetPlayerMythicPlusRatingSummary("mouseover")

        local prefix = GetPrefix("showMythicPlusScore")
        if summary then
            BetterTooltipUtils:AddPrefixedText(tooltip, prefix, summary.currentSeasonScore)
        end
    end
end

-- Add Player Mount to the Tooltip
function BetterTooltip:AddPlayerMount(tooltip)
    if not BetterTooltipUtils:IsPlayerHovered(tooltip) then return end

    for i = 1, 40 do
        local aura = C_UnitAuras.GetAuraDataByIndex("mouseover", i)

        if not aura then break end

        if BetterTooltipUtils:IsAuraMount(aura) then
            local prefix = GetPrefix("showPlayerMount")
            BetterTooltipUtils:AddPrefixedText(tooltip, prefix, aura.name)
        end
    end
end

-- Add the current Target to the Tooltip
function BetterTooltip:AddPlayerTarget(tooltip)
    if not BetterTooltipUtils:IsPlayerHovered(tooltip) then return end

    if not UnitIsUnit("player", tooltip:GetUnit()) then
        local unitName, unitId = tooltip:GetUnit()
        local targetName = UnitName(unitId .. "target")

        local prefix = GetPrefix("showPlayerTarget")
        BetterTooltipUtils:AddPrefixedText(tooltip, prefix, targetName)
    end
end