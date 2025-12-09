BTData = {
    addonName = "BetterTooltip"
}

BTOptions = {
    hideHealthbar = { key = "hideHealthbar", default = false },
    hideTooltip = { key = "hideTooltip", default = false },
    toggleAnchor = { key = "toggleAnchor", default = false },
    anchorPosition = { key = "anchorPosition", default = "ANCHOR_CURSOR_RIGHT" },
    toggleScaling = { key = "toggleScaling", default = false },
    tooltipScale = { key = "tooltipScale", default = 100 },
    displayIds = { key = "displayIds", default = 0 },
    displayPlayerInfo = { key = "displayPlayerInfo", default = 0 }
}

BTOptionsLocal = {
    enUS = {
        header = { general = "General", extra = "Extras" },
        hideHealthbar = { label = "Hide Healthbar", tooltip = "Hide the healthbar of all units on your tooltip" },
        hideTooltip = { label = "Hide Tooltip", tooltip = "Hide the tooltip while in combat" },
        toggleAnchor = { label = "Cursor Anchor", tooltip = "Anchor tooltips to the cursor and change the position" },
        anchorPosition = { label = "", tooltip = "" },
        toggleScaling = { label = "Tooltip Scaling", tooltip = "Activate scaling for all tooltips" },
        tooltipScale = { label = "Tooltip Scale", tooltip = "Min: 5% Max 250%" },
        displayIds = { label = "Show ID for", tooltip = "Add the id for all the chosen objects to the tooltip" },
        displayPlayerInfo = { label = "Show Player info", tooltip = "Show extra information for hovered player." }
    }
}

BTIdLocale = {
    enUS = {
        unit = { label = "Unit", tooltip = "" },
        spell = { label = "Spell", tooltip = "" },
        mount = { label = "Mount", tooltip = ""},
        unitaura = { label = "Aura", tooltip = "" },
        item = { label = "Item", tooltip = "" },
        toy = { label = "Toy", tooltip = "" },
        currency = { label = "Currency", tooltip = "" },
        quest = { label = "Quest", tooltip = "" },
        macro = { label = "Macro", tooltip = "" }
    }
}

BTIdValues = {
    [1] = { key = "unit", value = 1 },
    [2] = { key = "spell", value = 2 },
    [3] = { key = "mount", value = 4 },
    [4] = { key = "unitaura", value = 8 },
    [5] = { key = "item", value = 16 },
    [6] = { key = "toy", value = 32 },
    [7] = { key = "currency", value = 64 },
    [8] = { key = "quest", value = 128 },
    [9] = { key = "macro", value = 256 },
}

BTPlayerInfoLocale = {
    enUS = {
        mount = { label = "Mount" },
        target = { label = "Target" },
        score = { label = "Mythic+" }
    }
}

BTPlayerInfoValues = {
    [1] = { key = "mount", value = 1 },
    [2] = { key = "target", value = 2 },
    [3] = { key = "score", value = 4 },
}

BTPrefixes = {
    enUS = {
        unit = "Unit-ID",
        spell = "Spell-ID",
        mount = "Mount-ID",
        unitaura = "Aura-ID",
        item = "Item-ID",
        toy = "Toy-ID",
        currency = "Currency-ID",
        quest = "Quest-ID",
        macro = "Macro-ID",
        target = "Target",
        targetMount = "Mount",
        targetMythicScore = "Mythic Score"
    }
}