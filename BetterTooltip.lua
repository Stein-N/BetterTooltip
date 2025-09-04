-- ===================================== --
-- ==         Saved Variables         == --
-- ===================================== --
BetterTooltipDB = {}




-- ===================================== --
-- ==         Addon Variablen         == --
-- ===================================== --
local addonName = "BetterTooltip"
local frame = CreateFrame("Frame")
local handlers = {}
local ANCHOR_POSITION = "ANCHOR_CURSOR_RIGHT"
local category, layout = Settings.RegisterVerticalLayoutCategory(addonName)




-- ===================================== --
-- ==        Options Variablen        == --
-- ===================================== --
local toggleAnchor = {
    ["key"] = "Tooltip_Toggle_Anchor",
    ["name"] = "Aktiviere Tooltip Anchor",
    ["tooltip"] = "Tooltips werden am Curser angezeigt",
    ["default"] = false
}

local anchorPosition = {
    ["key"] = "Tooltip_Anchor_Position",
    ["name"] = "Tooltip Position",
    ["tooltip"] = "Wähle die Tooltip Position",
    ["default"] = "ANCHOR_CURSOR_RIGHT"
}

local hideTooltips = {
    ["key"] = "Tooltip_Hide",
    ["name"] = "Tooltips verstecken",
    ["tooltip"] = "Versteckt Tooltips während des Kampfes",
    ["default"] = false
}

local hideQuestlog = {
    ["key"] = "Questlog_Hide",
    ["name"] = "Questlog verstecken",
    ["tooltip"] = "Versteckt Questlog während des Kampfes",
    ["default"] = false
}




-- ====================================== --
-- ==        Options Funktionen        == --
-- ====================================== --
local function SetDefaultSetting(obj)
    if BetterTooltipDB[obj["key"]] == nil then
        BetterTooltipDB[obj["key"]] = obj["default"]
    end
end

-- Generische update Funktion
local function UpdateSetting(setting, value)
    local key = setting:GetVariable()
    BetterTooltipDB[key] = value
end

-- registriert die Option anhand des Objektes und gibt das setting objekt zurück
local function RegisterSetting(obj)
    return Settings.RegisterAddOnSetting(category, obj["key"], obj["key"], BetterTooltipDB, type(obj["default"]), obj["name"], BetterTooltipDB[obj["key"]])
end

-- Erstellt eine Checkbox anhand eines Objektes
local function RegisterCheckboxSetting(obj)
    local setting = RegisterSetting(obj)
    setting:SetValueChangedCallback(UpdateSetting)

    Settings.CreateCheckbox(category, setting, obj["tooltip"])
end

do 
    -- Standardwerte setzen
    SetDefaultSetting(toggleAnchor)
    SetDefaultSetting(hideTooltips)
    SetDefaultSetting(hideQuestlog)
end




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
    if name == addonName then
        RegisterCheckboxSetting(toggleAnchor)
        RegisterCheckboxSetting(hideTooltips)
        RegisterCheckboxSetting(hideQuestlog)

        Settings.RegisterAddOnCategory(category)
    end
end




-- ===================================== --
-- ==     Eigentliche Addon Logik     == --
-- ===================================== --

-- Tooltip Anchor Point setzen
hooksecurefunc("GameTooltip_SetDefaultAnchor", function(tooltip, parent)
    if BetterTooltipDB[toggleAnchor["key"]] then 
        if not tooltip or tooltip:IsForbidden() then return end
        SetDefaultBehaviour(tooltip) -- verhindert das Tooltips aus dem Bild ragen
        tooltip:SetOwner(parent or UIParent, ANCHOR_POSITION)
    end
end)

-- Kampf begin und end Event registrieren
frame:RegisterEvent("PLAYER_REGEN_DISABLED") -- Kampfbeginn
frame:RegisterEvent("PLAYER_REGEN_ENABLED")  -- Kampfende
frame:RegisterEvent("ADDON_LOADED") -- Alle Addons wurden geladen

-- Event Handler basierend auf Events ausführen
frame:SetScript("OnEvent", function(self, event, ...)
    local func = handlers[event]
    if func then return func(...) end
end)