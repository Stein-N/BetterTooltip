local _, addon = ...
local _lang = GetLocale()

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