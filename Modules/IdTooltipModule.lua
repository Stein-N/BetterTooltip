local _, addon = ...
IdTooltipModule = {}
local types = Enum.TooltipDataType

local function AddPostProcessor(type, func)
    if type ~= nil and func ~= nil then
        TooltipDataProcessor.AddTooltipPostCall(type, func)
    end
end

function IdTooltipModule.AddUnitID(tooltip)
    if not BTSettings.displayExtraInfoActive.unit then return end

    if tooltip.GetUnit ~= nil then
        local _, unit = tooltip:GetUnit()

        if unit ~= nil then
            local guid = UnitGUID(unit)

            if guid ~= nil then
                local _, _, _, _, _, id = strsplit("%-", guid)
                local lang = addon.Locale.unit

                if id ~= nil then
                    TooltipUtils.AddPrefixedLine(tooltip, lang.label, id)
                end
            end
        end
    end
end

function IdTooltipModule.AddID(tooltip, data, key)
    if not BTSettings.displayExtraInfoActive[key] then return end

    if data.id ~= nil then
        local lang = addon.Locale[key]
        TooltipUtils.AddPrefixedLine(tooltip, lang.label, data.id)
    end
end

function IdTooltipModule.AddIconID(tooltip, data, key)
    if not BTSettings.displayExtraInfoActive.icon then return end
    local lang = addon.Locale.icon
    local func = IdUtils[key]
    if func ~= nil and data.id ~= nil then
        local iconID = func(data.id)
        if iconID ~= nil then
            TooltipUtils.AddPrefixedLine(tooltip, lang.label, iconID)
        end
    end
end

local function HideTooltipInFight(tooltip, key)
    if UnitAffectingCombat("player") and BTSettings.hideTooltipActive[key] then
        tooltip:Hide()
        return true
    end
    return false
end

function IdTooltipModule:Init()
    AddPostProcessor(types.Unit, function(tooltip, _)
        if TooltipUtils.IsPlayerHovered(tooltip) then return end

        if not HideTooltipInFight(tooltip, "unit") then
            IdTooltipModule.AddUnitID(tooltip)
        end
    end)

    AddPostProcessor(types.Spell, function(tooltip, data)
        if not HideTooltipInFight(tooltip, "spell") then
            IdTooltipModule.AddID(tooltip, data, "spell")
            IdTooltipModule.AddIconID(tooltip, data, "spell")
        end
    end)

    AddPostProcessor(types.Mount, function(tooltip, data)
        IdTooltipModule.AddID(tooltip, data, "mount")
        IdTooltipModule.AddIconID(tooltip, data, "mount")
    end)

    AddPostProcessor(types.Currency, function(tooltip, data)
        if not HideTooltipInFight(tooltip, "currency") then
            IdTooltipModule.AddID(tooltip, data, "currency")
            IdTooltipModule.AddIconID(tooltip, data, "currency")
        end
    end)

    AddPostProcessor(types.UnitAura, function(tooltip, data)
        if not HideTooltipInFight(tooltip, "unitaura") then
            if not (InCombatLockdown() or addon.RestrictedArea) then
                IdTooltipModule.AddID(tooltip, data, "unitaura")
                IdTooltipModule.AddIconID(tooltip, data, "spell")
            end
        end
    end)

    AddPostProcessor(types.Macro, function(tooltip, data)
        if not HideTooltipInFight(tooltip, "macro") then
            IdTooltipModule.AddID(tooltip, data, "macro")
            IdTooltipModule.AddIconID(tooltip, data, "macro")
        end
    end)

    AddPostProcessor(types.Item, function(tooltip, data)
        if not HideTooltipInFight(tooltip, "item") then
            IdTooltipModule.AddID(tooltip, data, "item")
            IdTooltipModule.AddIconID(tooltip, data, "item")
        end
    end)

    AddPostProcessor(types.Toy, function(tooltip, data)
        if not HideTooltipInFight(tooltip, "toy") then
            IdTooltipModule.AddID(tooltip, data, "toy")
            IdTooltipModule.AddIconID(tooltip, data, "spell")
        end
    end)

    AddPostProcessor(types.Achievement, function(tooltip, data)
        if not HideTooltipInFight(tooltip, "achievement") then
            IdTooltipModule.AddID(tooltip, data, "achievement")
        end
    end)

    AddPostProcessor(types.Quest, function(tooltip, data)
        if not HideTooltipInFight(tooltip, "quest") then
            IdTooltipModule.AddID(tooltip, data, "quest")
        end
    end)

    hooksecurefunc("QuestMapLogTitleButton_OnEnter", function(b)
        local lang = addon.Locale.quest
        if b.questID ~= nil then
            TooltipUtils.AddPrefixedLine(GameTooltip, lang.label, b.questID)
        end
    end)

    AddPostProcessor(types.QuestPartyProgress, function(tooltip, data)
        if not HideTooltipInFight(tooltip, "quest") then
            IdTooltipModule.AddID(tooltip, data, "quest")
        end
    end)
end

addon.AddModule(IdTooltipModule)