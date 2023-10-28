RegisterNetEvent("corbo_tiktok:vehicleProps", function(model, plate)
    ESX.Game.SpawnVehicle(model,
        vector3(GetEntityCoords(PlayerPedId()).x, GetEntityCoords(PlayerPedId()).y,
            GetEntityCoords(PlayerPedId()).z + 20.0), 0.0, function(vehicle)
            SetEntityVisible(vehicle, false, false)
            SetEntityCollision(vehicle, false)
            SetVehicleNumberPlateText(vehicle, plate)
            local props = ESX.Game.GetVehicleProperties(vehicle)
            props.fuel = 100
            TriggerServerEvent("corbo_tiktok:sendProps", plate, json.encode(props))
            ESX.Game.DeleteVehicle(vehicle)
        end)
end)

-- SQL INSERT FALLS NEUE DB - # LOLOL #1

-- ALTER TABLE
--     `users`
-- ADD
--     `hasReceiveTikTokCar` BOOLEAN NOT NULL DEFAULT FALSE;

-- SQL INSERT FALLS NEUE DB - # LOLOL #1