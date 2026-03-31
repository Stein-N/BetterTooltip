local _, addon = ...
PlayerTooltipModule = {}

function PlayerTooltipModule.AddMountName(tooltip)
    if not BTSettings.displayPlayerInfoActive.mount then return end

    for i = 1, 10 do
        local aura = C_UnitAuras.GetAuraDataByIndex("mouseover", i)
        if aura ~= nil and aura.name and aura.spellId then
            if C_MountJournal.GetMountFromSpell(aura.spellId) ~= nil then
                local lang = addon.GetLocale("mount")
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
        local lang = addon.GetLocale("score")

        local color = C_ChallengeMode.GetDungeonScoreRarityColor(summary.currentSeasonScore)
        local colorString = "|c" .. color:GenerateHexColor()

        TooltipUtils.AddPrefixedLine(tooltip, lang.label, summary.currentSeasonScore, colorString)
    end
end

function PlayerTooltipModule.AddTargetName(tooltip)
    if not BTSettings.displayPlayerInfoActive.target then return end

    if tooltip.GetUnit ~= nil then
        local _, unit = tooltip:GetUnit()

        if unit ~= nil and not UnitIsUnit("player", unit) then
            local name = UnitName(unit .. "target")

            if name ~= nil then
                local class = UnitClass(unit .. "target")
                local color = RAID_CLASS_COLORS[class:upper()]
                local lang = addon.GetLocale("target")

                if color ~= nil then
                    local colorString = "|c" .. color:GenerateHexColor()
                    TooltipUtils.AddPrefixedLine(tooltip, lang.label, name, colorString)
                    return
                end

                local npcTag = addon.GetLocale("npc")
                TooltipUtils.AddPrefixedLine(tooltip, lang.label, name .. " (" .. npcTag.label ..")")
            end
        end
    end
end

function PlayerTooltipModule.AddRegion(tooltip)
    if not BTSettings.displayPlayerInfoActive.region then return end

    local server, region = TooltipUtils.GetPlayerRegion(tooltip)
    local lang = addon.GetLocale("region")

    if server ~= nil and region ~= nil then
        TooltipUtils.AddPrefixedLine(tooltip, lang.label, server .. " - " .. region)
    end
end

function PlayerTooltipModule.AddGuildRank(tooltip)
    if not BTSettings.displayPlayerInfoActive.rank then return end

    if tooltip.GetUnit ~= nil and TooltipUtils.IsPlayerHovered(tooltip) then
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

        if not TooltipUtils.IsPlayerHovered(tooltip) then return end

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
    TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Unit, function(tooltip, _)
        PlayerTooltipModule.ApplyColor(tooltip)
        PlayerTooltipModule.AddGuildRank(tooltip)

        -- Player Infos will not be displayed when
        if not (InCombatLockdown() and addon.RestrictedArea) then
            PlayerTooltipModule.AddMythicScore(tooltip)
            PlayerTooltipModule.AddTargetName(tooltip)
            PlayerTooltipModule.AddMountName(tooltip)
            PlayerTooltipModule.AddRegion(tooltip)
        end
    end)


    hooksecurefunc("LFGListUtil_SetSearchEntryTooltip", function(tooltip, resultID)
        if not BTSettings.displayPlayerInfoActive.region or resultID == nil then return end

        local resultInfo = C_LFGList.GetSearchResultInfo(resultID)
        if resultInfo ~= nil then
            local _, realm = strsplit("-", resultInfo.leaderName)
            local regionName = GetCurrentRegionName()
            realm = realm:gsub("[%s']", ""):lower()

            local regionData = addon.Regions[regionName]

            if regionData ~= nil and regionData[realm] then
                local realmData = regionData[realm]
                local regionLang = addon.GetLocale("serverRegion")
                local realmLang = addon.GetLocale("categories")
                local lang = addon.GetLocale("region")

                if regionLang[regionName] ~= nil and realmLang[realmData.category] then
                    TooltipUtils.AddPrefixedLine(tooltip, lang.label, regionLang[regionName] .. " - " .. realmLang[realmData.category])
                end
            end
        end
    end)
end

addon.AddModule(PlayerTooltipModule)