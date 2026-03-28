local _, addon = ...
local _lang = GetLocale()

addon.Modules = {}
addon.Events = {}

---Return the localized string for a specific key
function addon.GetLocale(key)
    local lang = addon.Locale[_lang] or addon.Locale.enUS
    return lang[key]
end

---Splits the given string at the given separator
---@param input string
---@param separator string
function addon.SplitString(input, separator)
    local result = {}
    separator = separator or "%s"

    for part in string.gmatch(input, "([^" .. separator .. "]+)") do
        table.insert(result, part)
    end

    return result
end

---Register a new Module that gets initialized when the event ADDON_LOADED Event was triggered
---@param  module table
function addon.AddModule(module)
    table.insert(addon.Modules, module)
end

---Register Events that are needed for Modules
---@param event string
---@param func function
function addon.AddEvent(event, func)
    if addon.Events[event] == nil then
        addon.Events[event] = {}
    end

    table.insert(addon.Events[event], func)
end