BetterTooltipSettings = {}

-- sets the default values inside the SavedVariables
local function SetDefaultSettings(settingObj)
    local key = settingObj["key"]
    if BetterTooltipDB[key] == nil then
        BetterTooltipDB[key] = settingObj["default"]
    end
end

-- simple function to update savedVariables
local function UpdateSetting(setting, value)
    BetterTooltipDB[setting:GetVariable()] = value
end

-- function to register a new option to the given categroy
local function RegisterSetting(category, settingObj, langObj)
    local variable = settingObj["key"]
    return Settings.RegisterAddOnSetting(category, variable, variable, BetterTooltipDB, type(settingObj["default"]), langObj["name"], BetterTooltipDB[variable])
end

-- Register a new Checkbox Setting
local function RegisterCheckbox(category, settingObj, langObj)
    local setting = RegisterSetting(category, settingObj, langObj)
    setting:SetValueChangedCallback(UpdateSetting)

    Settings.CreateCheckbox(category, setting, langObj["tooltip"])
end

-- Register a Dropdown Setting
local function RegisterDropdown(category, settingObj, langObj, func)
    local setting = RegisterSetting(category, settingObj, langObj)
    setting:SetValueChangedCallback(UpdateSetting)

    Settings.CreateDropdown(category, setting, func, langObj["tooltip"])
end

-- Build Dropdown menu for anchor position option
local function BuildAnchorOptions()
    local container = Settings.CreateControlTextContainer()
    local setting = BetterTooltipOptions["anchorPosition"]
    local langObj = setting[GetLocale()] or setting["enEN"]
    local options = langObj["options"]

    container:Add("ANCHOR_CURSOR_RIGHT", options[1])
    container:Add("ANCHOR_CURSOR", options[2])
    container:Add("ANCHOR_CURSOR_LEFT", options[3])

    return container:GetData()
end

-- Build the Settings tab
function BetterTooltipSettings:BuildSettingsTab()
    local langCode = GetLocale()
    local category, layout = Settings.RegisterVerticalLayoutCategory(BetterTooltipsData["addonName"])

    local toggleAnchor = BetterTooltipOptions["toggleAnchor"]
    local anchorPosition = BetterTooltipOptions["anchorPosition"]
    local hideTooltips = BetterTooltipOptions["hideTooltips"]
    local hideTooltipHealthbar = BetterTooltipOptions["hideTooltipHealthbar"]
    local showUnitId = BetterTooltipOptions["showUnitId"]
    local showSpellId = BetterTooltipOptions["showSpellId"]
    local showMountId = BetterTooltipOptions["showMountId"]
    local showAuraId = BetterTooltipOptions["showAuraId"]
    local showItemId = BetterTooltipOptions["showItemId"]
    local showToyId = BetterTooltipOptions["showToyId"]
    local showCurrencyId = BetterTooltipOptions["showCurrencyId"]
    local showQuestId = BetterTooltipOptions["showQuestId"]

    SetDefaultSettings(toggleAnchor)
    SetDefaultSettings(anchorPosition)
    SetDefaultSettings(hideTooltips)
    SetDefaultSettings(hideTooltipHealthbar)
    SetDefaultSettings(showUnitId)
    SetDefaultSettings(showSpellId)
    SetDefaultSettings(showMountId)
    SetDefaultSettings(showAuraId)
    SetDefaultSettings(showItemId)
    SetDefaultSettings(showToyId)
    SetDefaultSettings(showCurrencyId)
    SetDefaultSettings(showQuestId)

    RegisterCheckbox(category, toggleAnchor, toggleAnchor[langCode] or toggleAnchor["enEN"])
    RegisterDropdown(category, anchorPosition, anchorPosition[langCode] or anchorPosition["enEN"], BuildAnchorOptions)
    RegisterCheckbox(category, hideTooltips, hideTooltips[langCode] or hideTooltips["enEN"])
    RegisterCheckbox(category, hideTooltipHealthbar, hideTooltipHealthbar[langCode] or hideTooltipHealthbar["enEN"])
    RegisterCheckbox(category, showUnitId, showUnitId[langCode] or showUnitId["enEN"])
    RegisterCheckbox(category, showSpellId, showSpellId[langCode] or showSpellId["enEN"])
    RegisterCheckbox(category, showMountId, showMountId[langCode] or showMountId["enEN"])
    RegisterCheckbox(category, showAuraId, showAuraId[langCode] or showAuraId["enEN"])
    RegisterCheckbox(category, showItemId, showItemId[langCode] or showItemId["enEN"])
    RegisterCheckbox(category, showToyId, showToyId[langCode] or showToyId["enEN"])
    RegisterCheckbox(category, showCurrencyId, showCurrencyId[langCode] or showCurrencyId["enEN"])
    RegisterCheckbox(category, showQuestId, showQuestId[langCode] or showQuestId["enEN"])

    Settings.RegisterAddOnCategory(category)
end