BTHelper = {}

function BTHelper.IdValueGetter()
    return BTSettings.displayIds
end

function BTHelper.IdValueSetter(value)
    BTSettings.displayIds = value
    local temp = value
    for i = 9, 1, -1 do
        local obj = BTIdValues[i]
        if (temp - obj.value) >= 0 then
            BTSettings.activeIds[obj.key] = true
            temp = temp - obj.value
        else
            BTSettings.activeIds[obj.key] = false
        end
    end
end