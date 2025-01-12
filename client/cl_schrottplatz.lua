ESX = nil

CreateThread(function ()
    while ESX == nil do
        ESX = exports["es_extended"]:getSharedObject()
        Wait(0)
    end
end)

local Abschlepphof = {x = 1597.34, y = -1708.92, z = 88.12}

CreateThread(function()
    while true do
        Wait(0)

        local pedCoords = GetEntityCoords(PlayerPedId())
        DrawMarker(21, Abschlepphof.x, Abschlepphof.y, Abschlepphof.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 2.0, 2.0, 2.0, 27, 116, 208, 50, true, true, 2, nil, nil, false)
        if (GetDistanceBetweenCoords(Abschlepphof.x, Abschlepphof.y, Abschlepphof.z, pedCoords.x, pedCoords.y, pedCoords.z, true) < 3) then    
            exports['hotlife_hud']:HelpUI('E', 'Drücke um dein Fahrzeug endgültig zu verschrotten')
        end
    end
end)

CreateThread(function()
    while true do
        Wait(0)
        local pedCoords = GetEntityCoords(PlayerPedId())
        if (GetDistanceBetweenCoords(Abschlepphof.x, Abschlepphof.y, Abschlepphof.z, pedCoords.x, pedCoords.y, pedCoords.z, true) < 3) then
            if IsControlJustReleased(0, 38) then 
                local playerPed  = PlayerPedId()
                if IsPedInAnyVehicle(playerPed, false) then
                    local playerPed = PlayerPedId()
                    local coords = GetEntityCoords(playerPed)
                    local vehicle = GetVehiclePedIsIn(playerPed, false)
                    local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
                    local current = GetPlayersLastVehicle(PlayerPedId(), true)
                    local engineHealth = GetVehicleEngineHealth(current)
                    local plate = vehicleProps.plate
                    ESX.TriggerServerCallback("CheckIfOwned", function(ishim)
                        if ishim then
                            ESX.ShowNotification("Du hast dein Fahrzeug endgültig verschrottet!")
                            DeleteVehicle(vehicle)
                        else 
                            ESX.ShowNotification("Das ist nicht dein Fahrzeug!")
                        end
                    end, vehicleProps)
                end
            end
        end
    end
end)

function ShowNotification(text)
    SetNotificationTextEntry('STRING')
    AddTextComponentString(text)
    DrawNotification(false, true)
end

CreateThread(function()
    local blip = AddBlipForCoord(1597.34, -1708.92, 88.12)

    SetBlipSprite (blip, 147)
    SetBlipColour (blip, 31)
    SetBlipDisplay(blip, 4)
    SetBlipScale  (blip, 0.6)
    SetBlipAsShortRange(blip, true)

    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(('Schrottplatz'))
    EndTextCommandSetBlipName(blip)
end)
