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

    for key, option in pairs(BetterTooltipOptions) do
        SetDefaultSettings(option)

        if type(option["default"]) == "boolean" then
            RegisterCheckbox(category, option, option[langCode] or option["enEN"])
        else
            RegisterDropdown(category, option, option[langCode] or option["enEN"], BuildAnchorOptions)
        end
    end

    Settings.RegisterAddOnCategory(category)
end