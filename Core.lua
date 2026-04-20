local addonName, addon = ...
BTSettings = {}

addon.Modules = {}

local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:RegisterEvent("PLAYER_ENTERING_WORLD")

---Register a new Module that gets initialized when the event ADDON_LOADED Event was triggered
---@param  module table
function addon.AddModule(module)
    table.insert(addon.Modules, module)
end

function addon.RegisterTempEvent(event)
    if event ~= nil then
        f:RegisterEvent(event)
    end
end

f:SetScript("OnEvent", function(_, event, ...)
    local name = ...

    if event == "PLAYER_ENTERING_WORLD" then
        local _, type = IsInInstance()
        local rTypes = { "party", "raid", "arena", "pvp", "scenario" }

        addon.RestrictedArea = tContains(rTypes, type)
    end

    if event == "INSPECT_READY" then
        local guid = ...
        local unitToken = UnitTokenFromGUID(guid)

        if unitToken ~= nil and not issecretvalue(unitToken) then
            local iLvl = C_PaperDollInfo.GetInspectItemLevel(unitToken)

            if iLvl ~= nil and iLvl > 0 then
                addon.itemLevelCache[guid] = iLvl

                if UnitGUID("mouseover") == guid then
                    TooltipUtils.UpdateItemLevelLine(GameTooltip, iLvl)
                end
            end
        end

        if InspectFrame and not InspectFrame:IsShown() then
            ClearInspectPlayer()
        end

        f:UnregisterEvent("INSPECT_READY")
    end

    if event == "ADDON_LOADED" and name == addonName then
        BetterTooltipLocals:Init()
        BetterTooltipRegions:Init()

        -- Initialize Modules
        if next(addon.Modules) ~= nil then
            for _, module in pairs(addon.Modules) do
                if module.Init ~= nil then
                    module.Init()
                end
            end
        end

        -- Initialize the default settings
        addon.InitSettingsMenu()

        -- remove the ADDON_LOADED event, reduces event trigger if more addons get loaded after this one
        f:UnregisterEvent("ADDON_LOADED")
    end
end)