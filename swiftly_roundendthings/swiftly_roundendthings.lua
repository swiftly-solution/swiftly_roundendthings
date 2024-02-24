events:on("OnRoundEnd", function(winner, reason, message, legacy, playercount, nomusic)
    for playerid = 0, playermanager:GetPlayerCap() - 1, 1 do
        local player = GetPlayer(playerid)
        if not player then
            goto OnRoundEndcontinue
        end

        local EnableSpeed = config:Fetch("roundendthings.Settings.Speed.Enable")
        local EnableBhop = config:Fetch("roundendthings.Settings.BHOP.Enable")
        local EnableGravity = config:Fetch("roundendthings.Settings.Gravity.Enable")

        if EnableSpeed == 1 then
            local SpeedValue = config:Fetch("roundendthings.Settings.Speed.SpeedValue")
            player:speed():Set(SpeedValue)
        end

        if EnableGravity == 1 then
            local GravityValue = config:Fetch("roundendthings.Settings.Gravity.GravityValue")
            player:gravity():Set(GravityValue)
        end

        if EnableBhop == 1 then
            convar:Set("sv_cheats", true)
            convar:Set("sv_enablebunnyhopping", true)
            convar:Set("sv_autobunnyhopping", true)
            convar:Set("sv_cheats", false)
        end  
        ::OnRoundEndcontinue::
    end
end)

events:on("OnRoundStart", function(winner, reason, message, legacy, playercount, nomusic)
    local EnableBhop = config:Fetch("roundendthings.Settings.BHOP.Enable")

    if EnableBhop == 1 then
        convar:Set("sv_enablebunnyhopping", false)
        convar:Set("sv_autobunnyhopping", false)
    end
    ::OnRoundStartcontinue::
end)

commands:Register("ret_reload", function(playerid, args, argsCount, silent)
    local IsAdmin = exports["swiftly_admins"]:CallExport("HasFlags", playerid, "z")

    if playerid == -1 then
        config:Reload("roundendthings")
        print("The config has been reloaded.")
    else
        local player = GetPlayer(playerid)
        if not player then return end

        if IsAdmin == 1 then
            config:Reload("roundendthings")
            player:SendMsg(MessageType.Chat, config:Fetch("roundendthings.Messages.ReloadMessage"))
        end

        if IsAdmin == 0 then
            player:SendMsg(MessageType.Chat, config:Fetch("roundendthings.Messages.NoPremissionsMessage"))
        end
    end
end)

function GetPluginAuthor()
    return "Swiftly Solution"
end

function GetPluginVersion()
    return "v1.0.0"
end

function GetPluginName()
    return "Swiftly Round End Things"
end

function GetPluginWebsite()
    return "https://github.com/swiftly-solution/swiftly_roundendthings"
end
