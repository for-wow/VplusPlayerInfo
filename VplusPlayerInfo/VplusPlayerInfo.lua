CreateFrame('FRAME', 'VPPI')
VPPI:SetBackdrop({
    bgFile = 'Interface\\DialogFrame\\UI-DialogBox-Background', 
    edgeFile = 'Interface\\Tooltips\\UI-Tooltip-Border',
    tile = true, tileSize = 16, edgeSize = 16, 
    insets = { left = 4, right = 4, top = 4, bottom = 4 }
})
VPPI:SetPoint('CENTER', UIParent)
VPPI:SetWidth(160)
VPPI:SetHeight(52)
VPPI:SetMovable(true)
VPPI:EnableMouse(true)
VPPI:RegisterForDrag('LeftButton')
VPPI:SetScript('OnDragStart', function() this:StartMoving() end)
VPPI:SetScript('OnDragStop', function() this:StopMovingOrSizing() end)
VPPI:Show()

VPPI.Check = CreateFrame('CheckButton', nil, VPPI, 'UICheckButtonTemplate')
VPPI.Check:SetPoint('TOPLEFT', VPPI)
VPPI.Check:SetCheckedTexture('Interface\\Buttons\\UI-CheckBox-SwordCheck')
VPPI.Check:GetCheckedTexture():SetPoint('TOPLEFT', VPPI.Check, 8, -10)

VPPI.ValueTimer = VPPI:CreateFontString(nil, 'OVERLAY', 'GameFontHighlight')
VPPI.ValueTimer:SetPoint('LEFT', VPPI.Check, 'RIGHT')

VPPI.TitleTimer = VPPI:CreateFontString(nil, 'OVERLAY', 'GameFontHighlight')
VPPI.TitleTimer:SetPoint('LEFT', VPPI.ValueTimer, 'RIGHT')
VPPI.TitleTimer:SetText('   - Timer')

VPPI.ValueEvent = VPPI:CreateFontString(nil, 'OVERLAY', 'GameFontHighlight')
VPPI.ValueEvent:SetPoint('LEFT', VPPI.Check, 'RIGHT', 0, -20)

VPPI.TitleEvent = VPPI:CreateFontString(nil, 'OVERLAY', 'GameFontHighlight')
VPPI.TitleEvent:SetPoint('LEFT', VPPI.ValueEvent, 'RIGHT')
VPPI.TitleEvent:SetText('   - Event')

VPPI.Check:SetScript('OnClick', function()
    if this:GetChecked() then
        VPPI.ValueTimer:SetFontObject('GameFontHighlight')
        VPPI:SetScript('OnUpdate', function()
            local mainSpeed, offSpeed = UnitAttackSpeed('player')
            VPPI.ValueTimer:SetText(string.format('%0.2f / %0.2f', mainSpeed, offSpeed or 0))
        end)
    else
        VPPI.ValueTimer:SetFontObject('GameFontDisable')
        VPPI:SetScript('OnUpdate', nil)
    end
end)

VPPI:RegisterEvent('UNIT_ATTACK_SPEED')
VPPI:SetScript('OnEvent', function()
    local mainSpeed, offSpeed = UnitAttackSpeed('player')
    VPPI.ValueEvent:SetText(string.format('%0.2f / %0.2f', mainSpeed, offSpeed or 0))
end)
