BetterTooltipSettings = {}
local langCode = GetLocale()

-- ====================== --
-- ==  Helper Methods  == --
-- ====================== --

-- Set the default value for an Option inside the SavedVariables
local function SetDefault(option)
    local key = option["key"]
    if BetterTooltipDB[key] then return end

    BetterTooltipDB[key] = option["default"]
end

-- Basic function to update the Option Value
local function UpdateSetting(setting, value)
    BetterTooltipDB[setting:GetVariable()] = value
end

-- Register the given Option inside the Category
local function RegisterSetting(category, option, lang)
    local variable = option["key"]
    return Settings.RegisterAddOnSetting(
        category, -- Given Category, can also be a Subcategory
        variable, -- Option Variable
        variable, -- Option Variable
        BetterTooltipDB, -- AddOn Options Database
        type(option["default"]), -- Gets the Option Datatype from the default Value
        lang["name"], -- Option Name visible in the UI
        option["default"] -- Default value
    )
end

-- Loads the Option and Lang Object from the Database
local function GetOption(optionKey)
    local option = BetterTooltipOptions[optionKey]
    local lang = option[langCode] or option["enEN"]
    return option, lang
end

-- Load all AddOn Option Categories
local function GetCategories()
    local categories = BetterTooltipsData["optionCategories"]
    return categories[langCode] or categories["enEN"]
end

-- Load all PlayerInfo Header
local function GetPlayerHeader()
    local header = BetterTooltipsData["playerInfoHeader"]
    return header[langCode] or header["enEN"]
end

-- =========================== --
-- ==  UI Element Creation  == --
-- =========================== --

-- Create a new Checkbox inside the given Category
local function RegisterCheckbox(category, optionKey)
    local option, lang = GetOption(optionKey)
    local setting = RegisterSetting(category, option, lang)
    setting:SetValueChangedCallback(UpdateSetting)

    Settings.CreateCheckbox(category, setting, lang["tooltip"])
end

-- Create a new Dropdown Menu inside the given Category
local function RegisterDropdown(category, optionKey, func)
    local option, lang = GetOption(optionKey)
    local setting = RegisterSetting(category, option, lang)
    setting:SetValueChangedCallback(UpdateSetting)

    Settings.CreateDropdown(category, setting, func, lang["tooltip"])
end

-- Create a new SLider inside the given Category
local function RegisterSlider(category, optionKey, min, max, steps)
    local option, lang = GetOption(optionKey)
    local setting = RegisterSetting(category, option, lang)
    setting:SetValueChangedCallback(UpdateSetting)

    local sliderValues = Settings.CreateSliderOptions(min, max, steps)
    sliderValues:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right, function(value)
        return value .. "%"
    end)
    Settings.CreateSlider(category, setting, sliderValues, lang["tooltip"])
end

-- =========================== --
-- ==   Dropdown Builder    == --
-- =========================== --

-- Dropdown Options for AnchorPositions
local function BuildAnchorOptions()
    local container = Settings.CreateControlTextContainer()
    local _, lang = GetOption("anchorPosition")
    local values = lang["values"]

    container:Add("ANCHOR_CURSOR_RIGHT", values[1])
    container:Add("ANCHOR_CURSOR", values[2])
    container:Add("ANCHOR_CURSOR_LEFT", values[3])

    return container:GetData()
end



-- =========================== --
-- ==  Option Menu Builder  == --
-- =========================== --

function BetterTooltipSettings:BuildOptionsMenu()
    local categories = GetCategories()

    local general = Settings.RegisterVerticalLayoutCategory(BetterTooltipsData["addonName"])
    local extraInfos, extraInfosLayout = Settings.RegisterVerticalLayoutSubcategory(general, categories["extraInfos"])

    -- Register all Default Values
    for _, key in ipairs(BetterTooltipOptions) do
        local option = BetterTooltipOptions[key]
        SetDefault(option)
    end

    -- == General Tab == --
    RegisterCheckbox(general, "toggleAnchor")
    RegisterDropdown(general, "anchorPosition", BuildAnchorOptions)
    RegisterCheckbox(general, "toggleScaling")
    RegisterSlider(general, "tooltipScale", 5, 200, 5)
    RegisterCheckbox(general, "hideTooltipHealthbar")
    RegisterCheckbox(general, "hideTooltips")

    -- == Extra Info Tab == --
    local headers = GetPlayerHeader()

    extraInfosLayout:AddInitializer(CreateSettingsListSectionHeaderInitializer(headers["general"]))
    RegisterCheckbox(extraInfos, "showPlayerMount")
    RegisterCheckbox(extraInfos, "showPlayerTarget")
    RegisterCheckbox(extraInfos, "showMythicPlusScore")

    extraInfosLayout:AddInitializer(CreateSettingsListSectionHeaderInitializer(headers["tooltipIds"]))
    RegisterCheckbox(extraInfos, "showUnitId")
    RegisterCheckbox(extraInfos, "showSpellId")
    RegisterCheckbox(extraInfos, "showMountId")
    RegisterCheckbox(extraInfos, "showAuraId")
    RegisterCheckbox(extraInfos, "showItemId")
    RegisterCheckbox(extraInfos, "showToyId")
    RegisterCheckbox(extraInfos, "showCurrencyId")
    RegisterCheckbox(extraInfos, "showQuestId")
    RegisterCheckbox(extraInfos, "showBattlePetId")
    RegisterCheckbox(extraInfos, "showMacroId")

    Settings.RegisterAddOnCategory(general)
end