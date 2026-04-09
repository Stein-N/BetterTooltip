local name, addon = ...

local _category, _layout = Settings.RegisterVerticalLayoutCategory(name)

---Initialize the default settings inside the BTSetting SavedVariables
local function InitSettings()
    for key, value in pairs(addon.Settings) do
        if BTSettings[key] == nil then
            BTSettings[key] = value
        end
    end

    local tables = { TooltipTypes = "hideTooltip", ExtraInfos = "displayExtraInfo", PlayerInfo = "displayPlayerInfo" }

    for key, valueKey in pairs(tables) do
        local entryTable = addon[key]
        local value = BTSettings[valueKey]
        local activeTable = BTSettings[valueKey .. "Active"]

        if #activeTable == 0 then
            for i = #entryTable, 1, -1 do
                if (value - (2^(i-1))) >= 0 then
                    activeTable[entryTable[i]] = true
                    value = value - 2^(i-1)
                else
                    activeTable[entryTable[i]] = false
                end
            end
        end
    end
end

---Create a proper AddOn Setting for the new Settings API
---@param key string
local function CreateSetting(key)
    local option = addon.Settings[key]
    local lang = addon.Locale[key]

    if option ~= nil and lang ~= nil then
        local setting = Settings.RegisterAddOnSetting(_category, key, key, BTSettings, type(option), lang.label, option)
        setting:SetValueChangedCallback(function(s, v) BTSettings[s:GetVariable()] = v end)
        return setting, lang
    end
end

---Create a separation Header
---@param key string
local function CreateHeader(key)
    local lang = addon.Locale.header
    local init = CreateSettingsListSectionHeaderInitializer(lang[key])
    _layout:AddInitializer(init)
    return init
end

---Create a checkbox settings entry
---@param key string
local function CreateCheckbox(key)
    local setting, lang = CreateSetting(key)

    if setting ~= nil and lang ~= nil then
        return Settings.CreateCheckbox(_category, setting, lang.tooltip)
    end
end

---Create a slider settings entry
---@param cKey string
---@param sKey string
---@param min number
---@param max number
---@param steps number
---@param suffix string
local function CreateCheckboxSlider(cKey, sKey, min, max, steps, suffix)
    local cSet, cLang = CreateSetting(cKey)
    local sSet, sLang = CreateSetting(sKey)

    if cSet ~= nil and cLang ~= nil and sSet ~= nil and sLang ~= nil then
        local sOption = Settings.CreateSliderOptions(min, max, steps)
        sOption:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right, function(v) return v .. (suffix or "") end)

        local init = CreateSettingsCheckboxSliderInitializer(cSet, cLang.label, cLang.tooltip, sSet, sOption, sLang.label, sLang.tooltip)
        _layout:AddInitializer(init)
        return init
    end
end

---Create a single choice dropdown menu with an Checkbox
---@param cKey string
---@param dKey string
---@param dOptions table
local function CreateCheckboxSingleChoiceDropdown(cKey, dKey, dOptions)
    local cSet, cLang = CreateSetting(cKey)
    local dSet = CreateSetting(dKey)

    if cSet ~= nil and cLang ~= nil and dSet ~= nil then
        local init = CreateSettingsCheckboxDropdownInitializer(cSet, cLang.label, cLang.tooltip, dSet, dOptions)
        _layout:AddInitializer(init)
        return init
    end
end

---Create a multi choice dropdown menu introduced with the 120000 API
---@param key string
---@param entryTable table
---@param optionBuilder function
local function CreateMultiChoiceDropdown(variables, key, entryTable, addTooltips)
    local lang = addon.Locale[key]
    local proxy = Settings.RegisterProxySetting(_category, key, Settings.VarType.Number, lang.label, addon.Settings[key],
            SettingUtils.CreateGetter(variables, key), SettingUtils.CreateSetter(variables, key, entryTable))
    local init = Settings.CreateDropdown(_category, proxy, SettingUtils.CreateCheckboxOptionBuilder(entryTable, addTooltips), lang.tooltip)
    init.getSelectionTextFunc = function(selections) if #selections == 0 then return "None" else return nil end end

    return init
end

function addon.InitSettingsMenu()
    InitSettings()

    CreateHeader("general")

    CreateCheckbox("hideHealthbar")
    CreateCheckbox("tooltipColor")
    CreateCheckboxSingleChoiceDropdown("toggleAnchor", "anchorPosition", SettingUtils.BuildAnchorOptions)
    CreateCheckboxSlider("toggleScaling", "tooltipScale", 5, 300, 5, "%")
    CreateMultiChoiceDropdown(BTSettings, "hideTooltip", addon.TooltipTypes, false)

    CreateHeader("extra")
    CreateMultiChoiceDropdown(BTSettings, "displayExtraInfo", addon.ExtraInfos, false)
    CreateMultiChoiceDropdown(BTSettings, "displayPlayerInfo", addon.PlayerInfo, true)
    CreateMultiChoiceDropdown(BTSettings, "displayMythicPlusInfo", addon.MythicPlusInfo, true)

    Settings.RegisterAddOnCategory(_category)
end