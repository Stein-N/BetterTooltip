-- ================================ --
-- ==   Contains all Addon Data  == --
-- ==   and Settings with Lang   == --
-- ================================ --


BetterTooltipsData = {
    ["addonName"] = "BetterTooltip",
    ["optionCategories"] = {
        ["deDE"] = {
            ["visibleIds"] = "Sichtbare IDs",
            ["playerInfos"] = "Spieler Informationen"
        },
        ["enEN"] = {
            ["visibleIds"] = "Visible IDs",
            ["playerInfos"] = "Player Informations"
        }
    },
    ["playerInfoHeader"] = {
        ["deDE"] = {
            ["general"] = "Generelle Informationen",
            ["mythic"] = "Mythisch Plus"
        },
        ["enEN"] = {
            ["general"] = "General Informations",
            ["mythic"] = "Mythic Plus"
        }
    }
}

BetterTooltipOptions = {
    toggleAnchor = {
        ["key"] = "Tooltip_Toggle_Anchor",
        ["default"] = true,
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
            ["values"] = {"Rechts", "Mitte", "Links"}
        },
        ["enEN"] = {
            ["name"] = "Tooltip position",
            ["tooltip"] = "Choose the anchor position.",
            ["values"] = {"Right", "Center", "Left"}
        }
    },

    hideTooltipHealthbar = {
        ["key"] = "Tooltip_Hide_Healthbar",
        ["default"] = true,
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
        ["default"] = true,
        ["deDE"] = {
            ["name"] = "Tooltip verstecken",
            ["tooltip"] = "Versteckt alle Tooltips während des Kampfes"
        },
        ["enEN"] = {
            ["name"] = "Hide Tooltips",
            ["tooltip"] = "Hide all toolitps while fighting"
        }
    },

    showUnitId = {
        ["key"] = "Tooltip_Show_Unit_ID",
        ["default"] = true,
        ["deDE"] = {
            ["name"] = "Zeige Einheiten ID",
            ["tooltip"] = "Fügt dem Tooltip die Einheiten ID hinzu",
            ["prefix"] = "Einheits-ID"
        },
        ["enEN"] = {
            ["name"] = "Show Unit ID",
            ["tooltip"] = "Adds the Unit Id to the Tooltip",
            ["prefix"] = "Unit-ID"
        }
    },

    showSpellId = {
        ["key"] = "Tooltip_Show_Spell_ID",
        ["default"] = true,
        ["deDE"] = {
            ["name"] = "Zeige Zauber ID",
            ["tooltip"] = "Fügt dem Tooltip die Zauber ID hinzu",
            ["prefix"] = "Zauber-ID"
        },
        ["enEN"] = {
            ["name"] = "Show Spell ID",
            ["tooltip"] = "Adds the Spell Id to the Tooltip",
            ["prefix"] = "Spell-ID"
        }
    },

    showMountId = {
        ["key"] = "Tooltip_Show_Mount_ID",
        ["default"] = true,
        ["deDE"] = {
            ["name"] = "Zeige Reittier ID",
            ["tooltip"] = "Fügt dem Tooltip die Reittier ID hinzu",
            ["prefix"] = "Reittier-ID"
        },
        ["enEN"] = {
            ["name"] = "Show Mount ID",
            ["tooltip"] = "Adds the Mount Id to the Tooltip",
            ["prefix"] = "Mount-ID"
        }
    },

    showAuraId = {
        ["key"] = "Tooltip_Show_Aura_ID",
        ["default"] = true,
        ["deDE"] = {
            ["name"] = "Zeige Aura ID",
            ["tooltip"] = "Fügt dem Tooltip die Aura ID hinzu",
            ["prefix"] = "Aura-ID"
        },
        ["enEN"] = {
            ["name"] = "Show Aura ID",
            ["tooltip"] = "Adds the Aura Id to the Tooltip",
            ["prefix"] = "Aura-ID"
        }
    },

    showItemId = {
        ["key"] = "Tooltip_Show_Item_ID",
        ["default"] = true,
        ["deDE"] = {
            ["name"] = "Zeige Item ID",
            ["tooltip"] = "Fügt dem Tooltip die Item ID hinzu",
            ["prefix"] = "Item-ID"
        },
        ["enEN"] = {
            ["name"] = "Show Item ID",
            ["tooltip"] = "Adds the Item Id to the Tooltip",
            ["prefix"] = "Item-ID"
        }
    },

    showToyId = {
        ["key"] = "Tooltip_Show_Toy_ID",
        ["default"] = true,
        ["deDE"] = {
            ["name"] = "Zeige Spielzeug ID",
            ["tooltip"] = "Fügt dem Tooltip die Spielzeug ID hinzu",
            ["prefix"] = "Spielzeug-ID"
        },
        ["enEN"] = {
            ["name"] = "Show Toy ID",
            ["tooltip"] = "Adds the Toy Id to the Tooltip",
            ["prefix"] = "Toy-ID"
        }
    },

    showCurrencyId = {
        ["key"] = "Tooltip_Show_Currency_ID",
        ["default"] = true,
        ["deDE"] = {
            ["name"] = "Zeige Währungs ID",
            ["tooltip"] = "Fügt dem Tooltip die Währungs ID hinzu",
            ["prefix"] = "Währung-ID"
        },
        ["enEN"] = {
            ["name"] = "Show Currency ID",
            ["tooltip"] = "Adds the Curreny Id to the Tooltip",
            ["prefix"] = "Currency-ID"
        }
    },

    showQuestId = {
        ["key"] = "Tooltip_Show_Quest_ID",
        ["default"] = true,
        ["deDE"] = {
            ["name"] = "Zeige Quest ID",
            ["tooltip"] = "Fügt dem Tooltip die Quest ID hinzu",
            ["prefix"] = "Quest-ID"
        },
        ["enEN"] = {
            ["name"] = "Show Quest ID",
            ["tooltip"] = "Adds the Quest Id to the Tooltip",
            ["prefix"] = "Quest-ID"
        }
    },

    showBattlePetId = {
        ["key"] = "Tooltip_Show_Battle_Pet_ID",
        ["default"] = true,
        ["deDE"] = {
            ["name"] = "Zeige Haustier ID",
            ["tooltip"] = "Fügt dem Tooltip die Haustier ID hinzu",
            ["prefix"] = "Haustier-ID"
        },
        ["enEN"] = {
            ["name"] = "Show Battle Pet ID",
            ["tooltip"] = "Adds the Battle Pet Id to the Tooltip",
            ["prefix"] = "Battlepet-ID"
        }
    },

    showMacroId = {
        ["key"] = "Tooltip_Show_Macro_ID",
        ["default"] = false,
        ["deDE"] = {
            ["name"] = "Zeige Makro ID",
            ["tooltip"] = "Fügt dem Tooltip die Makro ID hinzu",
            ["prefix"] = "Makro-ID"
        },
        ["enEN"] = {
            ["name"] = "Show Macro ID",
            ["tooltip"] = "Adds the Macro ID to the Tooltip",
            ["prefix"] = "Macro-ID"
        }
    },

    showMythicPlusScore = {
        ["key"] = "Tooltip_Show_Mythic_Plus_Score",
        ["default"] = true,
        ["deDE"] = {
            ["name"] = "Zeige den Mythisch+ Score",
            ["tooltip"] = "Fügt dem Tooltip den Mythisch+ Score hinzu",
            ["prefix"] = "Mythisch+ Score"
        },
        ["enEN"] = {
            ["name"] = "Show Mythic+ Score",
            ["tooltip"] = "Adds the Mythic+ Score to the Tooltip",
            ["prefix"] = "Mythic+ Score"
        }
    },

    showPlayerMount = {
        ["key"] = "Tooltip_Show_Player_Mount",
        ["default"] = true,
        ["deDE"] = {
            ["name"] = "Zeige Spieler Reittier",
            ["tooltip"] = "Fügt dem Tooltip das aktuelle Reittier des Spielers hinzu",
            ["prefix"] = "Reittier"
        },
        ["enEN"] = {
            ["name"] = "Show Player Mount",
            ["tooltip"] = "Adds the current Player Mount to the Tooltip",
            ["prefix"] = "Mount"
        }
    },

    showPlayerTarget = {
        ["key"] = "Tooltip_Show_Player_Target",
        ["default"] = true,
        ["deDE"] = {
            ["name"] = "Zeige Ziel des Spielers",
            ["tooltip"] = "Fügt dem Tooltip anderer Spieler das aktuelle Ziel hinzu",
            ["prefix"] = "Ziel"
        },
        ["enEN"] = {
            ["name"] = "Show Player Target",
            ["tooltip"] = "Adds the current Target of other Players to the Tooltip",
            ["prefix"] = "Target"
        }
    }
}