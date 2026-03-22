local _, addon = ...

addon.Settings = {
    hideHealthbar = true,
    hideTooltip = false,
    toggleAnchor = true,
    anchorPosition = "ANCHOR_CURSOR_RIGHT",
    toggleScaling = false,
    tooltipScale = 100,
    tooltipColor = true,

    displayExtraInfo = 0,
    activeExtraInfo = {},

    displayPlayerInfo = 0,
    activePlayerInfo = {}
}

addon.Locale = {
    enUS = {
        header = {
            general = "General",
            extra = "Extras"
        },

        hideHealthbar = { label = "Hide Healthbar", tooltip = "Hide the Tooltip Healthbar." },
        hideTooltip = { label = "Hide Tooltip", tooltip = "Hide all Tooltip while fighting" },
        toggleAnchor = { label = "Cursor Anchor", tooltip = "Anchor most Tooltips to the cursor" },
        anchorPosition = { label = "", tooltip = "" },
        toggleScaling = { label = "Tooltip Scaling", tooltip = "Change the Tooltip scale" },
        tooltipColor = { label = "Tooltip Coloring", tooltip = "Highlights the important information in the corresponding class color" },

        displayExtraInfo = { label = "Show IDs for", tooltip = "Shows the id inside the Tooltip" },
        displayPlayerInfo = { label = "Show Player Info", tooltip = "Shows extra information for hovered player." },

        unit = { label = "", tooltip = "" },
        spell = { label = "", tooltip = "" },
        mount = { label = "", tooltip = "" },
        unitaura = { label = "", tooltip = "" },
        item = { label = "", tooltip = "" },
        toy = { label = "", tooltip = "" },
        currency = { label = "", tooltip = "" },
        quest = { label = "", tooltip = "" },
        macro = { label = "", tooltip = "" },
        target = { label = "", tooltip = "" },
        score = { label = "", tooltip = "" },
        rank = { label = "", tooltip = "" },
        icon = { label = "", tooltip = "" }
    }
}

addon.ExtraInfos = { "unit", "spell", "mount", "unitaura", "item", "toy", "currency", "quest", "macro", "icon" }
addon.PlayerInfo = { "mount", "target", "score", "rank" }