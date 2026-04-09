local _, addon = ...

BetterTooltipLocals = {
    enUS = {
        header = {
            general = "General",
            extra = "More Information"
        },
        languages = {
            enUS = "English",
            enGB = "English",
            deDE = "German",
            frFR = "French",
            ptPT = "Polish",
            itIT = "Italian",
            esES = "Spanish",
            ruRU = "Russian",
            koKR = "Korean",
            zhTW = "trad. Chinese",
            esMX = "Mexican Spanish",
            ptBR = "Brazilian Portuguese"
        },

        hideHealthbar = { label = "Hide Healthbar", tooltip = "Hide the Tooltip Healthbar." },
        toggleAnchor = { label = "Cursor Anchor", tooltip = "Anchor most Tooltips to the cursor" },
        anchorPosition = { label = "", tooltip = "" },
        toggleScaling = { label = "Tooltip Scaling", tooltip = "Change the Tooltip scale" },
        tooltipScale = { label = "", tooltip = "" },
        tooltipColor = { label = "Tooltip Coloring", tooltip = "Highlights the important information in the corresponding class color" },

        hideTooltip = { label = "Hide Tooltip", tooltip = "Decide which Tooltip should be hidden while fighting" },
        displayExtraInfo = { label = "Show IDs for", tooltip = "Shows the id inside the Tooltip" },
        displayPlayerInfo = { label = "Show Player Info", tooltip = "Shows extra information for hovered player." },
        displayMythicPlusInfo = { label = "Show Mythic Plus Info", tooltip = "Display how many points/percent a single unit provides in Mythic plus dungeons." },

        player = { label = "Player", tooltip = "Player Tooltip" },
        unit = { label = "Unit", tooltip = "" },
        spell = { label = "Spell", tooltip = "" },
        mount = { label = "Mount", tooltip = "Display the name of the current Mount." },
        unitaura = { label = "Aura", tooltip = "" },
        item = { label = "Item", tooltip = "" },
        toy = { label = "Toy", tooltip = "" },
        currency = { label = "Currency", tooltip = "" },
        quest = { label = "Quest", tooltip = "" },
        macro = { label = "Macro", tooltip = "" },
        target = { label = "Target", tooltip = "Display the targets name of the Hovered Player" },
        score = { label = "M+ Score", tooltip = "Display the score of the current Mythic plus season" },
        rank = { label = "Guildrank", tooltip = "Add the rank next to the guild name" },
        icon = { label = "Icon", tooltip = "" },
        language = { label = "Language", tooltip = "Show the Language of the player" },
        npc = { label = "NPC", tooltip = "" },
        achievement = { label = "Achievement", tooltip = "" },
        contributes = {label = "M+ Contribution", tooltip = "" },

        forcesProgressNumerical = { label = "Forces Contribution (Numerical)", tooltip = "Shows the amount a single unit contributes in numbers." },
        forcesProgressPercentage = { label = "Forces Contribution (Percentage)", tooltip = "Shows the amount a single unit contributes in percentage." },
    }
}

function BetterTooltipLocals:Init()
    local lang = GetLocale()
    addon.Locale = BetterTooltipLocals[lang] or BetterTooltipLocals.enUS
end