-- ===================================== --
-- ==         Saved Variables         == --
-- ===================================== --
BetterTooltipDB = {}


-- ===================================== --
-- ==         Addon Variables         == --
-- ===================================== --
local frame = CreateFrame("Frame")
local handler = {}


-- ============================== --
-- ==    Event Handler Logic   == --
-- ============================== --

-- Event Handler when fights starts
function handler.PLAYER_REGEN_DISABLED()
    BetterTooltip:HideTooltips()
end

-- Event Handler when fights ends
function handler.PLAYER_REGEN_ENABLED()
    BetterTooltip:ShowTooltip()
end

-- Build the OPtionstab when the Addon was loaded
function handler.ADDON_LOADED(name)
    if name == BetterTooltipsData["addonName"] then
        BetterTooltipSettings:BuildSettingsTab()
    end
end


-- ============================== --
-- ==     Core Addon Logic     == --
-- ============================== --

-- Apply the Tooltip Anchor Position
hooksecurefunc("GameTooltip_SetDefaultAnchor", function(tooltip, parent)
    local enabled = BetterTooltip:IsEnabled("toggleAnchor")
    local anchor = BetterTooltip:GetAnchorPosition()

    if enabled then
        if not tooltip or tooltip:IsForbidden() then return end

        BetterTooltip:SetDefaultBehaviour(tooltip)
        tooltip:SetOwner(parent or UIParent, anchor)
    end

    BetterTooltip:HideHealthBar()
end)

-- Register Events to the Frame
frame:RegisterEvent("PLAYER_REGEN_DISABLED") -- Fight begins
frame:RegisterEvent("PLAYER_REGEN_ENABLED")  -- Fight ends
frame:RegisterEvent("ADDON_LOADED") -- Addons loaded

-- Execute all Event Handler
frame:SetScript("OnEvent", function(self, event, ...)
    local func = handler[event]
    if func then return func(...) end
end)


-- ============================ --
-- ==   Tooltip Extra Data   == --
-- ============================ --

-- Add extra Data to the Tooltip when a Unit is hovered
TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Unit, function(tooltip, data)
    if BetterTooltip:IsEnabled("showUnitId") then BetterTooltip:AddUnitId(tooltip) end
end)

-- Add extra Data to the Tooltip when a Spell is hovered
TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Spell, function(tooltip, data)
    if BetterTooltip:IsEnabled("showSpellId") then BetterTooltip:AddId(tooltip, data, "showSpellId", "Spell-ID") end
end)

-- Add extra Data to the Tooltip when a Mount is hovered
TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Mount, function(tooltip, data)
    if BetterTooltip:IsEnabled("showMountId") then BetterTooltip:AddId(tooltip, data, "showMountId", "Mount-ID") end
end)

-- Add extra Data to the Tooltip when a UnitAura is hovered
TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.UnitAura, function(tooltip, data)
    if BetterTooltip:IsEnabled("showAuraId") then BetterTooltip:AddId(tooltip, data, "showAuraId", "Aura-ID") end
end)

-- Add extra Data to the Tooltip when a Item is hovered
TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Item, function(tooltip, data)
    if BetterTooltip:IsEnabled("showItemId") then BetterTooltip:AddId(tooltip, data, "showItemId", "Item-ID") end
end)

-- Add extra Data to the Tooltip when a Toy is hovered
TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Toy, function(tooltip, data)
    if BetterTooltip:IsEnabled("showToyId") then BetterTooltip:AddId(tooltip, data, "showToyId", "Toy-ID") end
end)

-- Add extra Data to the Tooltip when a Currency is hovered
TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Currency, function(tooltip, data)
    if BetterTooltip:IsEnabled("showCurrencyId") then BetterTooltip:AddId(tooltip, data, "showCurrencyId", "Currency-ID") end
end)

-- Add extra Data to the Tooltip when a Quest is hovered in BtWQuest or a linked quest is clicked
TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Quest, function(tooltip, data)
    if BetterTooltip:IsEnabled("showQuestId") then BetterTooltip:AddId(tooltip, data, "showQuestId", "Quest-ID") end
end)

-- Adds the Quest Id to the Quest Tooltip inside the Questlog
hooksecurefunc("QuestMapLogTitleButton_OnEnter", function(button)
    local data = { id = button.questID} -- quick and dirty workaround to prevent duplicate code
    if BetterTooltip:IsEnabled("showQuestId") then BetterTooltip:AddId(GameTooltip, data, "showQuestId", "Quest-ID") end
end)

-- Adds the BattlePet id to the Tooltip
-- Tooltip in Auctionhouse get overflowed a bit, but dont know why
hooksecurefunc("BattlePetTooltipTemplate_SetBattlePet", function(tooltip, petData)
    local data = { id = petData.speciesID}
    if BetterTooltip:IsEnabled("showBattlePetId") then BetterTooltip:AddId(tooltip, data, "showBattlePetId", "BattlePet-ID") end
end)