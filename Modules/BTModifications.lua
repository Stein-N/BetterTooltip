BTModifications = {}
BM = BTModifications

function BM.SetTooltipAnchor(tooltip, parent)
    if not BTSettings.toggleAnchor then return end

    if tooltip and not tooltip:IsForbidden() then
        local anchor = BTSettings.anchorPosition
        if anchor then
            tooltip:SetOwner(parent or UIParent, anchor)
        end
    end
end

function BM.SetTooltipScale(tooltip)
    if BTSettings.toggleScaling then
        if tooltip and not tooltip:IsForbidden() then
            local scale = BTSettings.tooltipScale
            if scale then
                tooltip:SetScale(scale / 100)
            end
        end
    else
        tooltip:SetScale(1)
    end
end

function BM.HideTooltipInCombat(tooltip)
    if BTSettings.hideTooltip and UnitAffectingCombat("player") then
        tooltip:Hide()
    end
end

function BM.ApplyTooltipHealthbar()
    if BTSettings.hideHealthbar then
        GameTooltipStatusBarTexture:SetTexture(nil)
    else
        GameTooltipStatusBarTexture:SetTexture(137014)
    end
end