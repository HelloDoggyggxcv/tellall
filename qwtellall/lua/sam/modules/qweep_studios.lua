-- By First
-- Qweep Studios
-- qweepstudios@yandex.ru

if SAM_LOADED then return end

sam.command.set_category('Qweep Studios')

sam.command.new("tellall")
    :SetPermission("tellall", "admin")

    :AddArg("text", {hint = "message", check = function(str)
        return str:match("%S") ~= nil
    end})

    :GetRestArgs()

    :Help("Displaying a message on the screen of all players")

    :OnExecute(function(ply, message)
        local allmessageCommand = string.format("!allmessage %s", message)

        ply:ConCommand("say " .. allmessageCommand)
    end)
:End()

-- By First
-- Qweep Studios
-- qweepstudios@yandex.ru