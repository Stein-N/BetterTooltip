-- ===================================== --
-- ==         Saved Variables         == --
-- ===================================== --
BetterTooltipDB = {}




-- ===================================== --
-- ==         Addon Variablen         == --
-- ===================================== --
local frame = CreateFrame("Frame")
local handlers = {}
local ANCHOR_POSITION = "ANCHOR_CURSOR_RIGHT"





-- ===================================== --
-- ==        Behilfsfunktionen        == --
-- ===================================== --
-- Tooltips innerhalb des Bildschirms halten
local function SetDefaultBehaviour(tip)
    if not tip or tip:IsForbidden() then return end
    if tip.SetClampedToScreen then
        tip:SetClampedToScreen(true);
    end
end

-- Tooltips deaktivieren
local function HideTooltips()
    if not BetterTooltipDB[hideTooltips["key"]] then return end

    GameTooltip:Hide()
    GameTooltip:SetScript("OnShow", GameTooltip.Hide)
end

-- Tooltips reaktivieren
local function ShowTooltips()
    GameTooltip:Show()
    GameTooltip:SetScript("OnShow", nil)
end

-- Questlog ausblenden
local function HideQuestlog()
    if not BetterTooltipDB[hideQuestlog["key"]] then return end

    if ObjectiveTrackerFrame then
        ObjectiveTrackerFrame:Hide()
    end
end

-- Questlog einblenden
local function ShowQuestlog()
    if ObjectiveTrackerFrame then
        ObjectiveTrackerFrame:Show()
    end
end




-- ===================================== --
-- ==     Aufbau der Event Handler    == --
-- ===================================== --

-- Handler für den Kampfbeginn
function handlers.PLAYER_REGEN_DISABLED()
    HideQuestlog()
    HideTooltips()
end

-- Handler für Kampfende
function handlers.PLAYER_REGEN_ENABLED()
    ShowQuestlog()
    ShowTooltips()
end


-- Alles was nach dem Laden des Addons passiert
function handlers.ADDON_LOADED(name)
    -- Aufbau des Optionsmenüs
    if name == BetterTooltipsData["addonName"] then
        print("Ich habe was gemacht")
        BetterTooltipSettings:BuildSettingsTab()
    end
end



-- ============================== --
-- ==     Core Addon Logic     == --
-- ============================== --

-- Tooltip Anchor Point setzen
-- hooksecurefunc("GameTooltip_SetDefaultAnchor", function(tooltip, parent)
--     if BetterTooltipDB[toggleAnchor["key"]] then 
--         if not tooltip or tooltip:IsForbidden() then return end
--         SetDefaultBehaviour(tooltip) -- verhindert das Tooltips aus dem Bild ragen
--         tooltip:SetOwner(parent or UIParent, ANCHOR_POSITION)
--     end
-- end)

-- -- Kampf begin und end Event registrieren
-- frame:RegisterEvent("PLAYER_REGEN_DISABLED") -- Kampfbeginn
-- frame:RegisterEvent("PLAYER_REGEN_ENABLED")  -- Kampfende
frame:RegisterEvent("ADDON_LOADED") -- Alle Addons wurden geladen

-- Event Handler basierend auf Events ausführen
frame:SetScript("OnEvent", function(self, event, ...)
    local func = handlers[event]
    if func then return func(...) end
end)