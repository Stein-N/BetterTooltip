local _, addon = ...

addon.Settings = {
    hideHealthbar = true,
    toggleAnchor = true,
    anchorPosition = "ANCHOR_CURSOR_RIGHT",
    toggleScaling = false,
    tooltipScale = 100,
    tooltipColor = true,

    hideTooltip = 971,
    hideTooltipActive = {},

    displayExtraInfo = 0,
    displayExtraInfoActive = {},

    displayPlayerInfo = 0,
    displayPlayerInfoActive = {}
}

addon.TooltipTypes = { "player", "unit", "spell", "mount", "unitaura", "item", "toy", "macro" }
addon.ExtraInfos = { "unit", "spell", "mount", "unitaura", "item", "toy", "currency", "quest", "macro", "icon" }
addon.PlayerInfo = { "mount", "target", "score", "rank", "language" }