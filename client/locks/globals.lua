Helpers = {}
Locks = {}

CreateThread(function()
    Wait(10000) -- Warten Sie 5 Sekunden, um sicherzustellen, dass alle Abhängigkeiten geladen sind
    while ESX == nil do
        Wait(10)
    end

    while ESX.GetPlayerData().job == nil do Wait(10) end

    ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job
end)

-- Locks = {
--     {
--         id = 2,
--         doors = {
--             {
--                 id =  20
--                 hash = 23132,
--                 x = 1,
--                 y = 1,
--                 z = 1
--             }
--         },
--         settings = {
--             locked_on_start = true,
--             interaction_range = 2.5,
--             interaction_in_car = false,
--         },
--         break_in = {
--             hackable = false,
--             hackable_options = {
--                 time = 45,
--                 letters = 5
--             },
--             pickable = false,
--             pickable_options = {
--                 pins = 5
--             }
--         },
--         permissions = {
--             jobs = {
--                 { name = 'pd', min_grade = 2}
--             },
--             keys = {
--                 'key_item_name_187',
--                 'key_item_name_234',
--             }
--         }
--     }
-- }



