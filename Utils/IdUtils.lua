local name, addon = ...
IdUtils = {}

function IdUtils.GetIdFromGUID(guid)
    if guid ~= nil and not issecretvalue(guid) then
        local _, _, _, _, _, id = strsplit("-", guid)
        return id
    end

    return nil
end

function IdUtils.GetIdFromUnit(unit)
    if unit ~= nil and not issecretvalue(unit) then
        local id = UnitCreatureID(unit)
        if id == nil then
            local guid = UnitGUID(unit)
            id = IdUtils.GetIdFromGUID(guid)
        end

        return id
    end
end

function IdUtils.spell(spellID)
    if spellID ~= nil then
        local spellInfo = C_Spell.GetSpellInfo(spellID)
        return spellInfo.iconID
    end
end

function IdUtils.mount(mountID)
    if mountID ~= nil then
        local _, _, icon = C_MountJournal.GetMountInfoByID(mountID)
        return icon
    end
end

function IdUtils.currency(currencyID)
    if currencyID ~= nil then
        local cInfo = C_CurrencyInfo.GetCurrencyInfo(currencyID)
        if cInfo ~= nil then
            return cInfo.iconFileID
        end
    end
end

function IdUtils.macro(macroID)
    if macroID ~= nil then
        local _, icon = GetMacroInfo(macroID)
        if icon ~= nil then
            return icon
        end
    end
end

function IdUtils.item(itemID)
    if itemID ~= nil then
        local icon = C_Item.GetItemIconByID(itemID)
        if icon ~= nil then
            return icon
        end
    end
end