local name, addon = ...
DungeonTooltipModule = {}
DTM = DungeonTooltipModule

local modelFrame = CreateFrame("PlayerModel")

function DungeonTooltipModule:GetModelID(unit)
    modelFrame:SetUnit(unit)
    local id = modelFrame:GetModelFileID()

    if id ~= nil and id > 0 and not issecretvalue(id) then
        return id
    end

    return nil
end

function DungeonTooltipModule:GetHelpfulBuffCount(unit)
    if not C_UnitAuras then return end

    local count = 0;
    for i = 1, 20 do
        local aura = C_UnitAuras.GetAuraDataByIndex(unit, i, "HELPFUL")
        if aura ~= nil then
            count = count + 1
        end
    end

    return count
end

function DungeonTooltipModule:GetBaseFingerprint(unit)
    if unit == nil then return nil end

    local modelID = self:GetModelID(unit)
    if modelID == nil then return nil end

    local level = UnitLevel(unit) or 0
    local classification = UnitClassification(unit) or "?"
    local sex = UnitSex(unit) or 0
    local class = select(2, UnitClass(unit)) or "?"
    local powerType = UnitPowerType(unit) or -1

    local relativeLevel = level % 10

    return string.format("%d:%d:%s:%d:%s:%d",
            modelID, relativeLevel, classification, sex, class, powerType)
end

function DungeonTooltipModule:GetExtendedFingerprint(base)
    if base == nil then return nil end

    local buffCount = self:GetHelpfulBuffCount("mouseover")
    return string.format("%s:%d", base, buffCount)
end

function DungeonTooltipModule:GetUnitID(unit)
    if unit ~= nil and not issecretvalue(unit) then
        return UnitCreatureID(unit)
    end

    local fingerprint = self:GetBaseFingerprint("mouseover")
    local id = addon.DungeonFingerprints[fingerprint]

    if id ~= nil then return id end

    local extended = self:GetExtendedFingerprint(fingerprint)
    id = addon.DungeonFingerprints[extended]

    if id ~= nil then return id end

    return nil
end

function DungeonTooltipModule:Init()
    TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Unit, function(tooltip, data)
        if TooltipUtils.IsPlayerHovered(tooltip) then return end
        if not C_ChallengeMode.IsChallengeModeActive() then return end

        local unit = select(2, tooltip:GetUnit())
        local unitID = DTM:GetUnitID(unit)

        if unitID ~= nil then
            local lang = addon.Locale.contributes
            local numerical = addon.DungeonData.forces[unitID].count
            local percentage = (100 / addon.DungeonData.neededForces) * numerical
            local displayNumerical = BTSettings.displayMythicPlusInfoActive.forcesProgressNumerical
            local displayPercentage = BTSettings.displayMythicPlusInfoActive.forcesProgressPercentage

            local text = ""
            if displayNumerical and displayPercentage then
                text = string.format("%d (%.3f%s", numerical, percentage, "%)")
            end

            if not displayNumerical and displayPercentage then
                text = string.format("%.3f%s", percentage, "%")
            end

            if displayNumerical and not displayPercentage then
                text = string.format("%d", numerical)
            end

            if lang ~= nil and text ~= nil then
                TooltipUtils.AddPrefixedLine(tooltip, lang.label, text)
            end
        end
    end)
end

addon.AddModule(DungeonTooltipModule)