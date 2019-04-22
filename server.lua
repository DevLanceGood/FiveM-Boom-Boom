local cooldown = 0

RegisterCommand("boomboom", function(source, args, raw) 
    if (cooldown == 0) then
        TriggerClientEvent("Boom-Boom:AllowDetonation", source)
        TriggerClientEvent("chatMessage", source, "[^1Boom-Boom^0]", {255, 255, 255}, "Hit \"" + Config.BoomBoom.ControlsTitle + "\" to detonate your bomb. There is no going back.")
        cooldown = Config.BoomBoom.Cooldown
    else
        TriggerClientEvent("chatMessage", source, "[^1Boom-Boom^0]", {255, 255, 255}, "There is an active cooldown on going boom-boom of " .. cooldown .. " minutes.")
    end
end, false)

RegisterNetEvent("Boom-Boom:AnnounceDetonation")
AddEventHandler("Boom-Boom:AnnounceDetonation", function()
    TriggerClientEvent("chatMessage", -1, "[^1Boom-Boom^0]", {255, 255, 255}, GetPlayerName(source) .. " just blew themselves up!")
end)

Citizen.CreateThread(function()
    while true do
        if (cooldown > 0) then
            Citizen.Wait(60000)
            cooldown = cooldown - 1;
        end
    end
end)