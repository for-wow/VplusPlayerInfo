CreateFrame('FRAME', 'VPHT_Frame', UIParent)
VPHT_Frame:SetBackdrop({
    bgFile = 'Interface\\DialogFrame\\UI-DialogBox-Background', 
    edgeFile = 'Interface\\Tooltips\\UI-Tooltip-Border',
    tile = true, tileSize = 16, edgeSize = 16, 
    insets = { left = 4, right = 4, top = 4, bottom = 4 }
})
VPHT_Frame:SetPoint('CENTER', UIParent)
VPHT_Frame:SetWidth(120)
VPHT_Frame:SetHeight(60)
VPHT_Frame:SetMovable(true)
VPHT_Frame:EnableMouse(true)
VPHT_Frame:RegisterForDrag('LeftButton')
VPHT_Frame:SetScript('OnDragStart', function() this:StartMoving() end)
VPHT_Frame:SetScript('OnDragStop',  function() this:StopMovingOrSizing() end)
VPHT_Frame:Show()

CreateFrame('CheckButton', 'VPHT_Check', VPHT_Frame, 'UICheckButtonTemplate')
VPHT_Check:SetPoint('TOPLEFT', VPHT_Frame)
VPHT_Check:SetCheckedTexture('Interface\\Buttons\\UI-CheckBox-SwordCheck')
VPHT_Check:GetCheckedTexture():SetPoint('TOPLEFT', VPHT_Check, 8, -10)

VPHT_Frame:CreateFontString('VPHT_ValueTimer', 'OVERLAY', 'GameFontHighlight')
VPHT_ValueTimer:SetPoint('LEFT', VPHT_Check, 'RIGHT')

VPHT_Frame:CreateFontString('VPHT_TitleTimer', 'OVERLAY', 'GameFontHighlight')
VPHT_TitleTimer:SetPoint('LEFT', VPHT_ValueTimer, 'RIGHT')
VPHT_TitleTimer:SetText('- Timer')

VPHT_Frame:CreateFontString('VPHT_ValueEvent', 'OVERLAY', 'GameFontHighlight')
VPHT_ValueEvent:SetPoint('LEFT', VPHT_Check, 'RIGHT', 0, -20)

VPHT_Frame:CreateFontString('VPHT_TitleEvent', 'OVERLAY', 'GameFontHighlight')
VPHT_TitleEvent:SetPoint('LEFT', VPHT_ValueEvent, 'RIGHT')
VPHT_TitleEvent:SetText('- Event')



VPHT_Check:SetScript('OnClick', function()
    if this:GetChecked() then
        VPHT_ValueTimer:SetFontObject('GameFontHighlight')
        VPHT_Frame:SetScript('OnUpdate', HastTest)
    else
        VPHT_ValueTimer:SetFontObject('GameFontDisable')
        VPHT_Frame:SetScript('OnUpdate', nil)
    end
end)

function HastTest()
    local mainSpeed, offSpeed = UnitAttackSpeed('player')
    VPHT_ValueTimer:SetText(string.format('%0.2f', mainSpeed))
end



VPHT_Frame:RegisterEvent('UNIT_DAMAGE')
VPHT_Frame:RegisterEvent('PLAYER_DAMAGE_DONE_MODS')
VPHT_Frame:RegisterEvent('UNIT_ATTACK_SPEED')
VPHT_Frame:RegisterEvent('UNIT_RANGEDDAMAGE')
VPHT_Frame:SetScript('OnEvent', function()
    local mainSpeed, offSpeed = UnitAttackSpeed('player')
    VPHT_ValueEvent:SetText(string.format('%0.2f', mainSpeed))
end)
