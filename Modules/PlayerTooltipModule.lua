local _, addon = ...
PlayerTooltipModule = {}

local function GetUnit()
    if OrbitPlayerFrame and OrbitPlayerFrame.isMouseOver then
        return "player"
    end

    return UnitExists("mouseover") and "mouseover" or "player"
end

local function IsUnitPlayer(unit)
    if unit == nil or issecretvalue(unit) then return false end
    local guid = UnitGUID(unit)
    local type = strsplit("-", guid)

    return type:lower() == "player"
end

function PlayerTooltipModule.AddMountName(tooltip)
    if not BTSettings.displayPlayerInfoActive.mount then return end
    local unitToken = GetUnit()

    for i = 1, 10 do
        local aura = C_UnitAuras.GetAuraDataByIndex(unitToken, i)
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
    local unitToken = GetUnit()

    local summary = C_PlayerInfo.GetPlayerMythicPlusRatingSummary(unitToken)
    if summary ~= nil and summary.currentSeasonScore ~= 0 then
        local lang = addon.Locale.score

        local color = C_ChallengeMode.GetDungeonScoreRarityColor(summary.currentSeasonScore)
        local colorString = "|c" .. color:GenerateHexColor()

        TooltipUtils.AddPrefixedLine(tooltip, lang.label, summary.currentSeasonScore, colorString)
    end
end

function PlayerTooltipModule.AddTargetName(tooltip)
    if not BTSettings.displayPlayerInfoActive.target then return end
    local unitToken = GetUnit()

    local targetUnit = unitToken .. "target"
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
    local unitToken = GetUnit()

    local language = RegionUtils:GetLanguageFromUnit(unitToken)
    local lang = addon.Locale.language

    if language ~= nil then
        TooltipUtils.AddPrefixedLine(tooltip, lang.label, language)
    end
end

function PlayerTooltipModule.AddGuildRank()
    if not BTSettings.displayPlayerInfoActive.rank then return end
    local unitToken = GetUnit()

    local name, rank = GetGuildInfo(unitToken)
    local line = _G["GameTooltipTextLeft2"]

    if name ~= nil and rank ~= nil and line ~= nil and line:GetText() ~= nil then
        line:SetText(line:GetText() .. " - " .. rank)
    end
end

function PlayerTooltipModule.ApplyColor()
    if not BTSettings.tooltipColor then return end
    local unitToken = GetUnit()

    local _, class = UnitClass(unitToken)
    local color = RAID_CLASS_COLORS[class]:GenerateHexColor()

    local function editLine(index, c)
        local line = _G["GameTooltipTextLeft" .. index]
        if line and line:GetText() ~= nil then line:SetText("|c" .. c .. line:GetText()) end
    end

    editLine(1, color)

    local guildName = GetGuildInfo(unitToken)
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
    local unitToken = GetUnit()

    if guid ~= nil then
        addon.RegisterTempEvent("INSPECT_READY")

        if not UnitExists(unitToken) or not CanInspect(unitToken) then return end
        local prefix = addon.Locale.itemLevel
        local loading = addon.Locale.loading

        if addon.itemLevelCache[guid] then
            TooltipUtils.AddPrefixedLine(tooltip, prefix.label, addon.itemLevelCache[guid])

            return
        end

        if InspectFrame and not InspectFrame:IsShown() then INSPECTED_UNIT = unitToken end
        local now = GetTime()
        local throttle = now - _lastRequest

        if throttle >= 1 then
            _lastRequest = now
            NotifyInspect(unitToken)
        else
            C_Timer.After(1, function() NotifyInspect(unitToken) end)
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