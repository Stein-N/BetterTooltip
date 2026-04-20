BTUtils = {}

local IsSecret = issecretvalue

function BTUtils.IsPlayerHovered()
    return UnitIsPlayer("mouseover")
end