BTHelper = {}

function BTHelper.IdValueGetter()
    return BTSettings.displayIds or 0
end

function BTHelper.IdValueSetter(value)
    BTSettings.displayIds = value
    local temp = value
    for i = 9, 1, -1 do
        local obj = BTIdValues[i]

        if not BTSettings.activeIds then BTSettings.activeIds = {} end
        if (temp - obj.value) >= 0 then
            BTSettings.activeIds[obj.key] = true
            temp = temp - obj.value
        else
            BTSettings.activeIds[obj.key] = false
        end
    end
end

function BTHelper.PlayerInfoGetter()
    return BTSettings.displayPlayerInfo or 0
end

function BTHelper.PlayerInfoSetter(value)
    BTSettings.displayPlayerInfo = value
    local temp = value
    for i = 4, 1, -1 do
        local obj = BTPlayerInfoValues[i]

        if not BTSettings.activePlayerInfo then BTSettings.activePlayerInfo = {} end
        if (temp - obj.value) >= 0 then
            BTSettings.activePlayerInfo[obj.key] = true
            temp = temp - obj.value
        else
            BTSettings.activePlayerInfo[obj.key] = false
        end
    end
end