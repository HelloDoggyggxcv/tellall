-- By First
-- Qweep Studios
-- qweepstudios@yandex.ru

util.AddNetworkString("TellAllMessage")

local allowedRanks = {
    superadmin = true,
    manager = true,
    event_curator = true,
    curator = true,
    ml_curator = true,
    assistant = true,
}

hook.Add("PlayerSay", "TellAllCommand", function(player, text, teamChat)
    if string.sub(text, 1, 12) == "!allmessage " then
        local message = string.sub(text, 13)
        if message and message ~= "" then
            -- Проверяем, имеет ли игрок нужный ранг
            if allowedRanks[player:GetUserGroup()] then
                net.Start("TellAllMessage")
                net.WriteString(message)
                net.Broadcast()
                return ""
            else
                player:ChatPrint("You don't have the rights to use this command!")
                return ""
            end
        end
    end
end)

-- By First
-- Qweep Studios
-- qweepstudios@yandex.ru