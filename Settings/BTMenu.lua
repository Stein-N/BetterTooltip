BTMenu = {}

local _category, _layout = Settings.RegisterVerticalLayoutCategory(BTData.addonName)
local _lang = GetLocale()

local function InitSettings()
    for _, value in ipairs(BTOptions) do
        if value and value.key then
            local key = value.key
            if BTSettings and not BTSettings[key] then
                BTSettings[key] = value.default
            end
        end
    end
end

local function GetLang(key)
    local lang = BTLocale[_lang] or BTLocale.enUS
    if lang then return lang[key] end
end

local function CreateSetting(key)
    local option = BTOptions[key]
    local lang = GetLang(key)

    if option and lang then
        local set = Settings.RegisterAddOnSetting(_category, option.key, option.key,
                        BTSettings, type(option.default), lang.label, option.default)
        set:SetValueChangedCallback(function(s, v) BTSettings[s:GetVariable()] = v end)
        return set, lang
    end
end

local function CreateCheckbox(key)
    local s, l = CreateSetting(key)
    if s and l then
        Settings.CreateCheckbox(_category, s, l.tooltip)
    end
end

local function CreateSlider(cKey, sKey, min, max, step, suffix)
    local cSet, cLang = CreateSetting(cKey)
    local sSet, sLang = CreateSetting(sKey)

    local sOptions = Settings.CreateSliderOptions(min, max, step)
    sOptions:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right,
        function(v) return v .. (suffix or "") end)

    if cSet and cLang and sSet and sLang then
        local init = CreateSettingsCheckboxSliderInitializer(cSet, cLang.label, cLang.tooltip, sSet, sOptions, sLang.label, sLang.tooltip)
        _layout:AddInitializer(init)
    end
end

local function CreateDropdown(cKey, dKey, dOptions)
    local cSet, cLang = CreateSetting(cKey)
    local dSet = CreateSetting(dKey)

    if cSet and cLang and dSet then
        local init = CreateSettingsCheckboxDropdownInitializer(cSet, cLang.label, cLang.tooltip, dSet, dOptions)
        _layout:AddInitializer(init)
        return init
    end
end

local function CreateHeader(text)
    local init = CreateSettingsListSectionHeaderInitializer(text)
    _layout:AddInitializer(init)
end

local function BuildAnchorOptions()
    local c = Settings.CreateControlTextContainer()
    c:Add("ANCHOR_CURSOR_LEFT", "Left")
    c:Add("ANCHOR_CURSOR", "Center")
    c:Add("ANCHOR_CURSOR_RIGHT", "Right")

    return c:GetData()
end

local function BuildIdOptions()
    local c = Settings.CreateControlTextContainer()
    c:AddCheckbox(1, "Spell")
    c:AddCheckbox(2, "Mount")
    c:AddCheckbox(3, "Aura")
    c:AddCheckbox(4, "Item")
    c:AddCheckbox(5, "Toy")
    c:AddCheckbox(6, "Currency")
    c:AddCheckbox(7, "Quest")
    c:AddCheckbox(8, "Macro")
    return c:GetData()
end

function BTMenu.BuildSettings()
    InitSettings()

    local header = GetLang("header")

    CreateHeader(header.general)
    CreateCheckbox("hideHealthbar")
    CreateCheckbox("hideTooltip")

    CreateDropdown("toggleAnchor", "anchorPosition", BuildAnchorOptions)
    CreateSlider("toggleScaling", "tooltipScale", 5, 250, 5, "%")

    CreateHeader(header.extra)

    -- Todo: rebuild with own template
    local s = BTOptions.displayIds
    local lang = GetLang("displayIds")
    local proxy = Settings.RegisterProxySetting(_category, s.key, Settings.VarType.Number, lang.label, s.default, BTHelper.IdValueGetter, BTHelper.IdValueSetter)
    local init = Settings.CreateDropdown(_category, proxy, BuildIdOptions)
    init.getSelectionTextFunc = function(selections) if #selections == 0 then return "None" else return nil end end

    Settings.RegisterAddOnCategory(_category)
end