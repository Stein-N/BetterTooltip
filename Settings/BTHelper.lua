BTHelper = {}

function BTHelper.IdSetter(displayKey, activeKey, table, value)
    BTSettings[displayKey] = value

    if not BTSettings[activeKey] then BTSettings[activeKey] = {} end

    for i = #table, 1, -1 do
        if (value - (2^(i-1))) >= 0 then
            BTSettings[activeKey][table[i]] = true
            value = value - 2^(i-1)
        else
            BTSettings[activeKey][table[i]] = false
        end
    end
end

function BTHelper.IdGetter(displayKey)
    return BTSettings[displayKey] or 0
end