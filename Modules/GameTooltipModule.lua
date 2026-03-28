local _, addon = ...
GameTooltipModule = {}

---Set the Tooltip Anchor to the cursor, can be switched between left, center and right
---@param tooltip table
---@param parent any
function GameTooltipModule.SetAnchor(tooltip, parent)
    if not BTSettings.toggleAnchor then return end

    if tooltip ~= nil and not tooltip:IsForbidden() then
        local anchor = BTSettings.anchorPosition
        if anchor ~= nil then
            tooltip:SetOwner(parent or UIParent, anchor)
        end
    end
end

--TODO: fix so that all Tooltips get involved/scaled
---Changes the scale of nearly all Tooltips
---@param tooltip table
function GameTooltipModule.SetScale(tooltip)
    if not BTSettings.toggleScaling then
        tooltip:SetScale(1)
        return
    end

    local scale = BTSettings.tooltipScale

    if scale ~= nil then
        tooltip:SetScale(scale / 100)
    end
end

---Hides the Healthbar from all Tooltips
function GameTooltipModule.HideHealthbar()
    if BTSettings.hideHealthbar then
        GameTooltipStatusBarTexture:SetTexture(nil)
    else
        GameTooltipStatusBarTexture:SetTexture(137014)
    end
end

function GameTooltipModule:Init()
    hooksecurefunc("GameTooltip_SetDefaultAnchor",  GameTooltipModule.SetAnchor)

    hooksecurefunc(GameTooltip, "Show", function(tooltip)
        GameTooltipModule.SetScale(tooltip)
        GameTooltipModule.HideHealthbar()
    end)
end

addon.AddModule(GameTooltipModule)