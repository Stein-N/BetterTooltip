local _, addon = ...
PlayerTooltipModule = {}

local function IsUnitPlayer(unit)
    if unit == nil then return false end
    local guid = UnitGUID(unit)
    local type = strsplit("-", guid)

    return type:lower() == "player"
end

function PlayerTooltipModule.AddMountName(tooltip)
    if not BTSettings.displayPlayerInfoActive.mount then return end

    for i = 1, 10 do
        local aura = C_UnitAuras.GetAuraDataByIndex("mouseover", i)
        if aura ~= nil and aura.name and aura.spellId then
            if C_MountJournal.GetMountFromSpell(aura.spellId) ~= nil then
                local lang = addon.Locale.mount

                TooltipUtils.AddPrefixedLine(tooltip, lang.label, aura.name)
                return
            end
        end
    end
end

function PlayerTooltipModule.AddMythicScore(tooltip)
    if not BTSettings.displayPlayerInfoActive.rank then return end

    local summary = C_PlayerInfo.GetPlayerMythicPlusRatingSummary("mouseover")
    if summary ~= nil and summary.currentSeasonScore ~= 0 then
        local lang = addon.Locale.score

        local color = C_ChallengeMode.GetDungeonScoreRarityColor(summary.currentSeasonScore)
        local colorString = "|c" .. color:GenerateHexColor()

        TooltipUtils.AddPrefixedLine(tooltip, lang.label, summary.currentSeasonScore, colorString)
    end
end

function PlayerTooltipModule.AddTargetName(tooltip)
    if not BTSettings.displayPlayerInfoActive.target then return end
    if not tooltip.GetUnit then return end

    local _, unit = tooltip:GetUnit()
    if unit == nil then return end

    local targetUnit = unit .. "target"
    local targetName = UnitName(targetUnit)
    if targetName == nil then return end

    local lang = addon.Locale.target
    local _, class = UnitClass(targetUnit)
    if class == nil then return end

    local color = RAID_CLASS_COLORS[class]

    if color ~= nil and IsUnitPlayer(targetUnit) then
        local colorString = "|c" .. color:GenerateHexColor()
        TooltipUtils.AddPrefixedLine(tooltip, lang.label, targetName, colorString)
    else
        local npcLabel = addon.Locale.npc.label
        local formattedName = string.format("%s (%s)", targetName, npcLabel)
        TooltipUtils.AddPrefixedLine(tooltip, lang.label, formattedName)
    end
end

function PlayerTooltipModule.AddLanguage(tooltip)
    if not BTSettings.displayPlayerInfoActive.language then return end

    local _, unit = tooltip:GetUnit()
    if unit ~= nil then
        local language = RegionUtils:GetLanguageFromUnit(unit)
        local lang = addon.Locale.language

        TooltipUtils.AddPrefixedLine(tooltip, lang.label, language)
    end
end

function PlayerTooltipModule.AddGuildRank(tooltip)
    if not BTSettings.displayPlayerInfoActive.rank then return end

    if tooltip.GetUnit ~= nil then
        local _, unit = tooltip:GetUnit()
        local name, rank = GetGuildInfo(unit)
        local line = _G["GameTooltipTextLeft2"]

        if name ~= nil and rank ~= nil and line ~= nil then
            line:SetText(line:GetText() .. " - " .. rank)
        end
    end
end

function PlayerTooltipModule.ApplyColor(tooltip)
    if not BTSettings.tooltipColor then return end

    if tooltip.GetUnit ~= nil then
        local _, unit = tooltip:GetUnit()

        local _, class = UnitClass(unit)
        local color = RAID_CLASS_COLORS[class:upper()]:GenerateHexColor()

        local function editLine(index, c)
            local line = _G["GameTooltipTextLeft" .. index]
            if line then line:SetText("|c" .. c .. line:GetText()) end
        end

        editLine(1, color)

        local guildName = GetGuildInfo(unit)
        if guildName then
            editLine(2, "009999ff")
            editLine(4, color)
        else
            editLine(3, color)
        end
    end
end

function PlayerTooltipModule:Init()
    TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Unit, function(tooltip)
        if not TooltipUtils.IsPlayerHovered(tooltip) then return end

        if BTSettings.hideTooltipActive.player and UnitAffectingCombat("player") then
            tooltip:Hide()
            return
        end

        if not (InCombatLockdown() or addon.RestrictedArea) then
            PlayerTooltipModule.AddMythicScore(tooltip)
            PlayerTooltipModule.AddTargetName(tooltip)
            PlayerTooltipModule.AddMountName(tooltip)
        end

        PlayerTooltipModule.ApplyColor(tooltip)
        PlayerTooltipModule.AddGuildRank(tooltip)
        PlayerTooltipModule.AddLanguage(tooltip)
    end)
end

addon.AddModule(PlayerTooltipModule)