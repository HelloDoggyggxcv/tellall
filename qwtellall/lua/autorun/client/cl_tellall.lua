-- By First
-- Qweep Studios
-- qweepstudios@yandex.ru

sound.Add({
    name = "notification_sound",
    channel = CHAN_STATIC,
    volume = 1.0,
    sound = "up_notifications2.wav"
})

surface.CreateFont('qwtellall.font0', {
    font = 'Overpass Bold',
    extended = true,
    size = math.ceil(45 / 1800 * ScrH())
})

local currentPanel = nil

local tellallcol = Color(37, 40, 47)

net.Receive("TellAllMessage", function()
    local message = net.ReadString()
    
    local textWidth, textHeight = surface.GetTextSize(message)
    local panelHeight = textHeight + 20
    
    local panel = vgui.Create("DPanel")
    panel:SetSize(math.max(textWidth + 20, 400), panelHeight)
    panel:SetAlpha(0)
    panel:SetBackgroundColor(Color(0, 0, 0, 200))

    if currentPanel then
        panel:SetPos(ScrW()/2 - panel:GetWide()/2, currentPanel:GetY() + currentPanel:GetTall() + 10)
    else
        panel:SetPos(ScrW()/2 - panel:GetWide()/2, 50)
    end

    panel.Paint = function(self, w, h)
        draw.RoundedBox(10, 0, 0, w, h, tellallcol)
        draw.SimpleText(message, "qwtellall.font0", w/2, h/2, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end

    surface.PlaySound("notification_sound")

    panel:AlphaTo(255, 0.3, 0, function()
        timer.Simple(5, function()
            if IsValid(panel) then
                panel:AlphaTo(0, 0.3, 0, function() 
                    panel:Remove() 
                    if currentPanel == panel then
                        currentPanel = nil
                    end
                end)
            end
        end)
    end)

    currentPanel = panel
end)

-- By First
-- Qweep Studios
-- qweepstudios@yandex.ru
