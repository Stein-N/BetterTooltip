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

hooksecurefunc("GameTooltip_SetDefaultAnchor", function(tooltip, parent)
    local enabled = BetterTooltip:IsAnchorEnabled()
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