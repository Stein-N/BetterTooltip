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

-- function to register a new Checkbox
local function RegisterCheckbox(category, settingObj, langObj)
    local setting = RegisterSetting(category, settingObj, langObj)
    setting:SetValueChangedCallback(UpdateSetting)

    Settings.CreateCheckbox(category, setting, langObj["tooltip"])
end

-- Build the Settings tab
function BetterTooltipSettings:BuildSettingsTab()
    local langCode = GetLocale()
    local category, layout = Settings.RegisterVerticalLayoutCategory(BetterTooltipsData["addonName"])

    local toggleAnchor = BetterTooltipOptions["toggleAnchor"]
    local anchorPosition = BetterTooltipOptions["anchorPosition"]
    local hideTooltips = BetterTooltipOptions["hideTooltips"]
    local hideTooltipHealthbar = BetterTooltipOptions["hideTooltipHealthbar"]

    SetDefaultSettings(toggleAnchor)
    SetDefaultSettings(anchorPosition)
    SetDefaultSettings(hideTooltips)
    SetDefaultSettings(hideTooltipHealthbar)

    RegisterCheckbox(category, toggleAnchor, toggleAnchor[langCode] or toggleAnchor["enEN"])
    RegisterCheckbox(category, hideTooltips, hideTooltips[langCode] or hideTooltips["enEN"])
    RegisterCheckbox(category, hideTooltipHealthbar, hideTooltipHealthbar[langCode] or hideTooltipHealthbar["enEN"])

    Settings.RegisterAddOnCategory(category)
end