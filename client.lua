local enabled = false

local DetonatePlayer = function()
    local ped = GetPlayerPed(-1)
    local dpos = GetEntityCoords(ped)
    AddExplosion(dpos.x, dpos.y, dpos.z, 9, 20.0, true, false, true)
    enabled = false
    TriggerServerEvent("Boom-Boom:AnnounceDetonation")
end

Citizen.CreateThread(function()
    while true do
        if IsEntityDead(GetPlayerPed(-1)) then
            TriggerEvent("chatMessage", source, "[^1Boom-Boom^0]", {255, 255, 255}, "Hit \"" + Config.BoomBoom.ControlsTitle + "\" to detonate your bomb.")
            TriggerEvent("chatMessage", source, "[^1Boom-Boom^0]", {255, 255, 255}, "There is no going back, however if you die you will be disarmed.")
            enabled = false
        end
        if ( IsControlJustPressed(Config.BoomBoom.Controls[1], Config.BoomBoom.Controls[2]) and enabled) then
            DetonatePlayer()
        end
        Citizen.Wait(0)
    end
end)

RegisterNetEvent("Boom-Boom:AllowDetonation")
AddEventHandler("Boom-Boom:AllowDetonation", function() 
    enabled = true
end)