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
    BetterTooltip:ApplyScalingToTooltips()
end

-- Build the OPtionstab when the Addon was loaded
function handler.ADDON_LOADED(name)
    if name == BetterTooltipsData["addonName"] then
        BetterTooltipSettings:BuildOptionsMenu()
    end

    BetterTooltip:ApplyScalingToTooltips()
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

local modifications = {
    { type = Enum.TooltipDataType.Spell, option = "showSpellId", fallback = "Spell-ID" },
    { type = Enum.TooltipDataType.Mount, option = "showMountId", fallback = "Mount-ID" },
    { type = Enum.TooltipDataType.UnitAura, option = "showAuraId", fallback = "Aura-ID" },
    { type = Enum.TooltipDataType.Item, option = "showItemId", fallback = "Item-ID" },
    { type = Enum.TooltipDataType.Toy, option = "showToyId", fallback = "Toy-ID" },
    { type = Enum.TooltipDataType.Currency, option = "showCurrencyId", fallback = "Currency-ID" },
    { type = Enum.TooltipDataType.Quest, option = "showQuestId", fallback = "Quest-ID" },
    { type = Enum.TooltipDataType.Macro, option = "showMacroId", fallback = "Macro-ID" }
}

-- Apply TooltipModififcations
for _, modifier in ipairs(modifications) do
    TooltipDataProcessor.AddTooltipPostCall(modifier.type, function(tooltip, data)
        if BetterTooltip:IsEnabled(modifier.option) then
            BetterTooltip:AddId(tooltip, data, modifier.option, modifier.fallback)
        end
    end)
end

-- Add extra Data to the Tooltip when a Unit is hovered
TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Unit, function(tooltip, data)
    if UnitAffectingCombat("player") then return end

    if BetterTooltip:IsEnabled("showUnitId") then BetterTooltip:AddUnitId(tooltip) end
    if BetterTooltip:IsEnabled("showPlayerTarget") then BetterTooltip:AddPlayerTarget(tooltip) end
    if BetterTooltip:IsEnabled("showPlayerMount") then BetterTooltip:AddPlayerMount(tooltip) end
    if BetterTooltip:IsEnabled("showMythicPlusScore") then BetterTooltip:AddMythicScore(tooltip) end
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