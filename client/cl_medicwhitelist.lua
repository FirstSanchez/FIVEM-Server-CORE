CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj)
            ESX = obj
        end)
        Wait(0)
    end
    PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

-- Hier die Fahrzeuge von den Medics
carblacklist = {
    "ambulance",
    "ambulancev2",
    "dodgeEMS",
    "ghispo3",
    "ambulance2"
}

function KickPlayerFromVehicle(playerPed)
    local vehicle = GetVehiclePedIsIn(playerPed, false)
    if vehicle ~= 0 then
        TaskLeaveVehicle(playerPed, vehicle, 16)
    end
end

CreateThread(function()
    while true do
        Wait(500)
        local playerPed = PlayerPedId()
        if playerPed then
            local playerVehicle = GetVehiclePedIsIn(playerPed, false)
            if playerVehicle ~= 0 and GetPedInVehicleSeat(playerVehicle, -1) == playerPed then
                checkCar(playerVehicle)
                local x, y, z = table.unpack(GetEntityCoords(playerPed, true))
                for _, blacklistedCar in pairs(carblacklist) do
                    checkCar(GetPedInVehicleSeat(playerVehicle, -1))
                end
            end
        end
    end
end)

function checkCar(car)
    if car then
        local carModel = GetEntityModel(car)
        local ped = PlayerPedId()
        PlayerData = ESX.GetPlayerData()
        if isCarBlacklisted(carModel) and PlayerData.job ~= nil and PlayerData.job.name ~= 'ambulance' then
            KickPlayerFromVehicle(PlayerPedId())
            TriggerEvent('prime_notify', 'error', 'LIMITLESS | System', 'Du kannst nur als Medic auf den Fahrersitz', 3000)
        end
    end
end

function isCarBlacklisted(model)
    for _, blacklistedCar in pairs(carblacklist) do
        if model == GetHashKey(blacklistedCar) then
            return true
        end
    end
    return false
end