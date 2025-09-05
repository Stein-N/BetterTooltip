-- ================================ --
-- ==   Contains all Addon Data  == --
-- ==   and Settings with Lang   == --
-- ================================ --


BetterTooltipsData = {
    ["addonName"] = "BetterTooltip"
}

BetterTooltipOptions = {
    toggleAnchor = {
        ["key"] = "Tooltip_Toggle_Anchor",
        ["default"] = false,
        ["deDE"] = {
            ["name"] = "Tooltip am Curser befestigen",
            ["tooltip"] = "Alle Tooltips werden am Curser Befestigt, die Position kann verändert werden."
        },
        ["enEN"] = {
            ["name"] = "Fixate Tooltip",
            ["tooltip"] = "Fixate all Tooltips to the Cursor, the position can be changed."
        }
    },

    anchorPosition = {
        ["key"] = "Tooltip_Anchor_Position",
        ["default"] = "ANCHOR_CURSOR_RIGHT",
        ["deDE"] = {
            ["name"] = "Tooltip Position",
            ["tooltip"] = "Wähle die Position, an welcher der Tooltip befestigt wird.",
            ["options"] = {"Rechts", "Mitte", "Links"}
        },
        ["enEN"] = {
            ["name"] = "Tooltip position",
            ["tooltip"] = "Choose the anchor position.",
            ["options"] = {"Right", "Center", "Left"}
        }
    },

    hideTooltipHealthbar = {
        ["key"] = "Tooltip_Hide_Healthbar",
        ["default"] = false,
        ["deDE"] = {
            ["name"] = "Lebensbalken verstecken",
            ["tooltip"] = "Deaktiviere den Lebensbalken am Tooltip"
        },
        ["enEN"] = {
            ["name"] = "Hide Healthbar",
            ["tooltip"] = "Hide the Healthbar"
        }
    },

    hideTooltips = {
        ["key"] = "Tooltip_Hide",
        ["default"] = false,
        ["deDE"] = {
            ["name"] = "Tooltip verstecken",
            ["tooltip"] = "Versteckt alle Tooltips während des Kampfes"
        },
        ["enEN"] = {
            ["name"] = "Hide Tooltips",
            ["tooltip"] = "Hide all toolitps while fighting"
        }
    },

    showUnitIds = {
        ["key"] = "Tooltip_Show_Unit_ID",
        ["default"] = false,
        ["deDE"] = {
            ["name"] = "Zeige Einheiten ID",
            ["tooltip"] = "Fügt dem Tooltip die Einheiten ID hinzu"
        },
        ["enEN"] = {
            ["name"] = "Show Unit ID",
            ["tooltip"] = "Adds the Unit Id to the Tooltip"
        }
    }
}