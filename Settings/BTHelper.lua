BTHelper = {}

function BTHelper.IdValueGetter()
    return BTSettings.displayIds or 0
end

-- todo: needs to change boolean values for later use
function BTHelper.IdValueSetter(value)
    BTSettings.displayIds = value
end