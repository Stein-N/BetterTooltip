local _, addon = ...
PlayerTooltipModule = {}

local function IsUnitPlayer(unit)
    if unit == nil or issecretvalue(unit) then return false end
    local guid = UnitGUID(unit)
    local type = strsplit("-", guid)

    return type:lower() == "player"
end

function PlayerTooltipModule.AddMountName(tooltip)
    if not BTSettings.displayPlayerInfoActive.mount then return end

    for i = 1, 10 do
        local aura = C_UnitAuras.GetAuraDataByIndex("mouseover", i)
        if aura ~= nil and aura.name and aura.spellId then
            local mountID = C_MountJournal.GetMountFromSpell(aura.spellId)



            if mountID ~= nil then
                local lang = addon.Locale.mount

                TooltipUtils.AddPrefixedLine(tooltip, lang.label, aura.name)
                return
            end
        end
    end
end

function PlayerTooltipModule.AddMythicScore(tooltip)
    if not BTSettings.displayPlayerInfoActive.score then return end

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

    local targetUnit = "mouseover" .. "target"
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

    local language = RegionUtils:GetLanguageFromUnit("mouseover")
    local lang = addon.Locale.language

    if language ~= nil then
        TooltipUtils.AddPrefixedLine(tooltip, lang.label, language)
    end
end

function PlayerTooltipModule.AddGuildRank()
    if not BTSettings.displayPlayerInfoActive.rank then return end

    local name, rank = GetGuildInfo("mouseover")
    local line = _G["GameTooltipTextLeft2"]

    if name ~= nil and rank ~= nil and line ~= nil then
        line:SetText(line:GetText() .. " - " .. rank)
    end
end

function PlayerTooltipModule.ApplyColor()
    if not BTSettings.tooltipColor then return end

    local _, class = UnitClass("mouseover")
    local color = RAID_CLASS_COLORS[class]:GenerateHexColor()

    local function editLine(index, c)
        local line = _G["GameTooltipTextLeft" .. index]
        if line then line:SetText("|c" .. c .. line:GetText()) end
    end

    editLine(1, color)

    local guildName = GetGuildInfo("mouseover")
    if guildName then
        editLine(2, "009999ff")
        editLine(4, color)
    else
        editLine(3, color)
    end
end

addon.itemLevelCache = {}
local _lastRequest = 0
function PlayerTooltipModule.AddItemLevel(tooltip, guid)
    if not BTSettings.displayPlayerInfoActive.itemLevel then return end

    if guid ~= nil then
        if not UnitExists("mouseover") or not CanInspect("mouseover") then return end
        local prefix = addon.Locale.itemLevel
        local loading = addon.Locale.loading

        if addon.itemLevelCache[guid] then
            TooltipUtils.AddPrefixedLine(tooltip, prefix.label, addon.itemLevelCache[guid])

            return
        end

        if InspectFrame and not InspectFrame:IsShown() then INSPECTED_UNIT = "mouseover" end
        local now = GetTime()
        local throttle = now - _lastRequest

        if throttle >= 1 then
            _lastRequest = now
            NotifyInspect("mouseover")
        else
            C_Timer.After(1, function() NotifyInspect("mouseover") end)
            _lastRequest = now + 1
        end

        TooltipUtils.AddPrefixedLine(tooltip, prefix.label, loading.label)
    end
end

function PlayerTooltipModule:Init()
    TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Unit, function(tooltip, data)
        if not BTUtils.IsPlayerHovered() then return end

        if BTSettings.hideTooltipActive.player and UnitAffectingCombat("player") then
            tooltip:Hide()
            return
        end

        PlayerTooltipModule.ApplyColor()
        PlayerTooltipModule.AddGuildRank()
        PlayerTooltipModule.AddItemLevel(tooltip, data.guid)

        if not (InCombatLockdown() or addon.RestrictedArea) then
            PlayerTooltipModule.AddMythicScore(tooltip)
            PlayerTooltipModule.AddTargetName(tooltip)
            PlayerTooltipModule.AddMountName(tooltip)
        end

        PlayerTooltipModule.AddLanguage(tooltip)
    end)
end

addon.AddModule(PlayerTooltipModule)