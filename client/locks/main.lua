
RegisterNetEvent('ax_locks:start')
AddEventHandler('ax_locks:start', function()
    editor.start()
end)

RegisterNetEvent('ax_locks:update-locks')
AddEventHandler('ax_locks:update-locks', function(locks)
    Locks = locks

    for i, lock in ipairs(Locks) do
        for j, door in ipairs(lock.doors) do
            if not IsDoorRegisteredWithSystem(door.id) then
                AddDoorToSystem(door.id, door.hash, door.x, door.y, door.z)
                DoorSystemSetDoorState(door.id, lock.state)
            end
        end
    end
end)
TriggerServerEvent('ax_locks:get-locks') -- server will trigger ax_locks:update to get all locks


RegisterNetEvent('ax_locks:update-state')
AddEventHandler('ax_locks:update-state', function(lockId, state)
    for i, lock in ipairs(Locks) do
        if lock.id == lockId then
            Locks[i].state = state

            for j, door in ipairs(lock.doors) do
                DoorSystemSetDoorState(door.id, state)
            end
        end
    end
end)

RegisterNetEvent('ax_locks:delete')
AddEventHandler('ax_locks:delete', function(lockId)
    local index = nil

    for i, lock in ipairs(Locks) do
        if lock.id == lockId then
            index = i
            for j, door in ipairs(lock.doors) do
                RemoveDoorFromSystem(door.id)
            end
        end
    end

    if index then
        table.remove(Locks, index)
    end
end)

local lastNotification = nil
RegisterNetEvent('ax_locks:notify')
AddEventHandler('ax_locks:notify', function(msg, error)
    if lastNotification ~= nil then
        ThefeedRemoveItem(lastNotification)
    end
    BeginTextCommandThefeedPost("STRING")
    AddTextComponentSubstringPlayerName(msg)
    local currentNotification = EndTextCommandThefeedPostTicker(true, true)
    if error == true then
        PlaySoundFrontend(-1, "ERROR", "HUD_AMMO_SHOP_SOUNDSET", 1)
    else
        PlaySoundFrontend(-1, "5_SEC_WARNING", "HUD_MINI_GAME_SOUNDSET", 1)
    end
    lastNotification = currentNotification
    CreateThread(function()
        Wait(1200)
        if lastNotification == currentNotification and lastNotification ~= nil then
            ThefeedRemoveItem(currentNotification)
            lastNotification = nil
        end
    end)
end)

RegisterCommand('ax_locks:open', function() 
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)

    local inVehicle = IsPedInAnyVehicle(playerPed, false)

    local lock, distance = Helpers.Locks.GetNearestLock(playerCoords.x,playerCoords.y,playerCoords.z)

    if lock == nil then return end
    if lock.settings.interaction_range <= distance then return end

    TriggerServerEvent('ax_locks:toggle', lock.id, inVehicle)
end)    

RegisterKeyMapping('ax_locks:open', 'Öffne Tür', 'keyboard', 'E')

--
-- Lockpick und Hackerlaptop
--
-- RegisterNetEvent('ax_locks:use_item')
-- AddEventHandler('ax_locks:use_item', function(itemName) 
--     local playerPed = PlayerPedId()
--     local playerCoords = GetEntityCoords(playerPed)
--     local lock, distance = Helpers.Locks.GetNearestLock(playerCoords.x,playerCoords.y,playerCoords.z)

--     if itemName == 'lockpick' then
--         if not lock.break_in.pickable then
--             return
--         end

--         if lock.state == 0 then
--             ESX.ShowNotification("Das Schloss ist bereits offen")
--             return
--         end

--         if distance > 5 then
--             return
--         end
        
--         TriggerEvent("lockpick:StartMinigame",lock.break_in.pickable_options.pins,
--             function(did_win) 
--                 TriggerServerEvent('ax_locks:lockpick', lock.id, did_win)
--             end
--         )
--     elseif itemName == 'laptop_h' then
--         if not lock.break_in.pickable then
--             return
--         end

--         if lock.state == 0 then
--             ESX.ShowNotification("Das Schloss ist bereits offen")
--             return
--         end
    
--         if distance > 5 then
--             return
--         end
        
--         TriggerEvent("pd-safe:show")
--         TriggerEvent("pd-safe:start",lock.break_in.hackable_options.letters,lock.break_in.hackable_options.time,
--             function(did_win) 
--                 TriggerServerEvent('ax_locks:hacking', lock.id, did_win)
--                 TriggerEvent("pd-safe:hide")
--             end
--         )
--     end
-- end)


--
-- Notify break in
--
RegisterNetEvent('ax_locks:notify_break_in')
AddEventHandler('ax_locks:notify_break_in', function(lockId, won, coords) 
    local lock = Helpers.Locks.GetLock(lockId)

    if lock == nil then return end

    if lock.break_in.notify == nil or not Helpers.Table.Exists(lock.break_in.notify, ESX.PlayerData.job.name) then return end

    CreateThread(function()
        local start_time = GetGameTimer()
        local help_text = "Jemand versucht eine Tür aufzubrechen!\nDrücke ~INPUT_CONTEXT~ um den Wegpunkt zu setzen"

        if won then
            help_text = "Jemand hat eine Tür aufgebrochen!\nDrücke ~INPUT_CONTEXT~ um den Wegpunkt zu setzen"
        end

        while (GetGameTimer() - start_time) < (45 * 1000) do
            AddTextEntry('ax_locks:break-in', help_text)
            DisplayHelpTextThisFrame('ax_locks:break-in', false)
            if IsControlJustPressed(0,38) then
              SetNewWaypoint(coords.x, coords.y)
              return
            end
            Wait(0)
          end
    end)
end)