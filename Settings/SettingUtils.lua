local _, addon = ...

SettingUtils = {}

---Creates a simple getter function for multichoice dropdown menus
---@param variables table
---@param key string
function SettingUtils.CreateGetter(variables, key)
    return function()
        return variables[key] or 0
    end
end

---Creates a simple setter function for multichoice dropdown menus.
---@param variables table
---@param key string
---@param entryTable table
---@param value number
function SettingUtils.CreateSetter(variables, key, entryTable)
    return function(value)
        variables[key] = value
        local activeTable = variables[key .. "Active"]

        if activeTable == nil then
            activeTable = {}
        end

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

--- Create a single choice option builder based onn the given entry table
---@param entryTable table
---@param addTooltip boolean
function SettingUtils.CreateCheckboxOptionBuilder(entryTable, addTooltip)
    return function()
        local container = Settings.CreateControlTextContainer()

        for index, value in ipairs(entryTable) do
            local lang = addon.Locale[value]
            container:AddCheckbox(index, lang.label, addTooltip and lang.tooltip or nil)
        end

        return container:GetData()
    end
end

--- Create Dropdown options for Cursor Anchor
function SettingUtils.BuildAnchorOptions()
    local c = Settings.CreateControlTextContainer()
    local lang = addon.Locale.anchorPositions

    c:Add("ANCHOR_CURSOR_LEFT", lang.left.label)
    c:Add("ANCHOR_CURSOR", lang.center.label)
    c:Add("ANCHOR_CURSOR_RIGHT", lang.right.label)

    return c:GetData()
end

function SettingUtils.BuildMountColorOptions()
    local c = Settings.CreateControlTextContainer()
    local lang = addon.Locale.mountColorStyles

    c:Add("COLOR", lang.color.label, lang.color.tooltip)
    c:Add("SYMBOL", lang.symbol.label, lang.symbol.tooltip)

    return c:GetData()
end