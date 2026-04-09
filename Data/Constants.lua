local _, addon = ...

addon.Settings = {
    hideHealthbar = true,
    toggleAnchor = true,
    anchorPosition = "ANCHOR_CURSOR_RIGHT",
    toggleScaling = false,
    tooltipScale = 100,
    tooltipColor = true,

    hideTooltip = 4073,
    hideTooltipActive = {},

    displayExtraInfo = 0,
    displayExtraInfoActive = {},

    displayPlayerInfo = 0,
    displayPlayerInfoActive = {},

    displayMythicPlusInfo = 0,
    displayMythicPlusInfoActive = {}
}

addon.TooltipTypes = { "player", "unit", "spell", "mount", "unitaura", "item", "toy", "currency", "quest", "macro", "achievement", "quest" }
addon.ExtraInfos = { "unit", "spell", "mount", "unitaura", "item", "toy", "currency", "quest", "macro", "achievement", "quest", "icon" }
addon.PlayerInfo = { "mount", "target", "score", "rank", "language" }
addon.MythicPlusInfo = { "forcesProgressNumerical", "forcesProgressPercentage" }