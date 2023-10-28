CreateThread(function()
    while ESX == nil do Wait(50) end

    ESX.RegisterServerCallback('ax_locks:get_jobs', function(source, cb)
        local player = ESX.GetPlayerFromId(source)
        if player == nil then return cb({}) end
        local playerGroup = player.getGroup()

        if ESX.GetJobs == nil then
--            print("You have not added the ESX.GetJobs function, making this highly unlikely to return a proper list of jobs.")
            return cb(ESX.Jobs)
        end

        cb(ESX.GetJobs())
    end)
end)

--
--  Variables
--
Initialized = false


--
-- Update locks
--
function UpdateDoors(source)
    while not Initialized do Wait(0); end

    TriggerClientEvent("ax_locks:update-locks", source, Locks)
end

RegisterNetEvent('ax_locks:get-locks')
AddEventHandler('ax_locks:get-locks', function()
    UpdateDoors(source)
end)



--
-- Fetch all locks from DB
--
MySQL.ready(function() 
    MySQL.Async.fetchAll("SELECT * FROM ax_locks", {}, function(result)
        Locks = {}
        
        for i, row in ipairs(result) do
            local lock = json.decode(row.options)
            lock.id = row.id
            lock.state = (lock.settings.locked_on_start and (lock.settings.force_lock and 4 or 1) or 0)
            table.insert(Locks, lock)
        end
    
        Initialized = true
    end)
end)


function HasPermission(lock, playerId)
    local player = ESX.GetPlayerFromId(playerId)

    if player.job.name == CfgLock.AdminJobName then return true end

    for i, job in ipairs(lock.permissions.jobs) do
        if job.name == player.job.name and job.min_grade <= player.job.grade then return true end
    end

    for i, key in ipairs(lock.permissions.keys) do
        if player.getInventoryItem(key).count > 0 then return true end
    end

    return false
end


RegisterNetEvent('ax_locks:toggle')
AddEventHandler('ax_locks:toggle', function(lockId, inVehicle)
    local _source = source
    for i, lock in ipairs(Locks) do
        if lock.id == lockId then 
            if HasPermission(lock, _source) then
                if inVehicle and lock.settings.interaction_in_car == false then return end
                local state = Locks[i].state

                if state == 0 then state = (lock.settings.force_lock and 4 or 1)
                elseif state == 4 then state = 0
                elseif state == 1 then state = 0
                end
        
                Locks[i].state = state
                TriggerClientEvent("ax_locks:update-state", -1, lockId, state)
                TriggerClientEvent("ax_locks:notify", _source, "Türe "..(state == 0 and "~g~aufgeschlossen~s~" or "~r~abgeschlossen~s~")..".")
            else
                TriggerClientEvent("ax_locks:notify", _source, "~r~Deine Schlüssel passen nicht.~s~", true)
            end
            break
        end
    end
end)

RegisterNetEvent('ax_locks:delete')
AddEventHandler('ax_locks:delete', function(lockId)
    local player = ESX.GetPlayerFromId(source)
    local playerGroup = player.getGroup()
    if not IsPlayerAceAllowed(source, 'ax-locks') then
        return
    end

    local index = nil
    for i, lock in ipairs(Locks) do
        if lock.id == lockId then
            index = i
            break 
        end
    end

    if index == nil then return end

    MySQL.Async.execute("DELETE FROM ax_locks WHERE id=@id", {['@id'] = lockId},

    function()
        table.remove(Locks, index)
        TriggerClientEvent("ax_locks:delete", -1, lockId)
    end)
end)

--
-- Create locks
--
RegisterNetEvent('ax_locks:create-locks')
AddEventHandler('ax_locks:create-locks', function(locks)
    local player = ESX.GetPlayerFromId(source)
    local playerGroup = player.getGroup()
    if not IsPlayerAceAllowed(source, 'ax-locks') then
        return
    end

    local finished_sqls = 0
    function finished()
        finished_sqls = finished_sqls + 1

        if finished_sqls < #locks then return end

        UpdateDoors(-1)
    end

    for i, lock in ipairs(locks) do
        MySQL.Async.insert("INSERT INTO ax_locks SET options=@options",{['@options'] = json.encode(lock)},
        function(id)
            for j,v in ipairs(lock.doors) do
                lock.doors[j].id = tostring(id) .. tostring(j)
            end

            MySQL.Async.execute("UPDATE ax_locks SET options=@options WHERE id=@id", {['@id'] = id, ['@options'] = json.encode(lock)},

            function()
                lock.id = id
                lock.state = (lock.settings.locked_on_start and (lock.settings.force_lock and 4 or 1) or 0)
                table.insert(Locks, lock)
                finished()
            end)
        end)
    end
end)

--
-- Edit lock
--
RegisterNetEvent('ax_locks:edit-lock')
AddEventHandler('ax_locks:edit-lock', function(lock)
    local id = lock.id
    local state = lock.state

    lock.id = nil 
    lock.state = nil

    MySQL.Async.execute("UPDATE ax_locks SET options=@options WHERE id=@id", {['@id'] = id, ['@options'] = json.encode(lock)},

    function()
        lock.id = id
        lock.state = state
        for i, l in ipairs(Locks) do
            if l.id == id then 
                Locks[i] = lock
            end
        end 

        UpdateDoors(-1)
    end)
end)



-- --
-- -- Hacking/lockpick
-- --
-- CreateThread(function()
--     while ESX == nil do Wait(0) end

--     ESX.RegisterUsableItem('lockpick', function(source)
--         TriggerClientEvent('ax_locks:use_item', source, 'lockpick')
--     end)

--     ESX.RegisterUsableItem('laptop_h', function(source)
--         TriggerClientEvent('ax_locks:use_item', source, 'laptop_h')
--     end)
-- end)

-- RegisterNetEvent('ax_locks:lockpick')
-- AddEventHandler('ax_locks:lockpick', function(lockId, won)
--     local xPlayer = ESX.GetPlayerFromId(source)
--     TriggerClientEvent("ax_locks:notify_break_in",-1, lockId, won, xPlayer.getCoords(true))
--     if won then
--         xPlayer.removeInventoryItem('lockpick', 1)

--         for i, lock in ipairs(Locks) do
--             if lock.id == lockId then 
--                 Locks[i].state = 0

--                 TriggerClientEvent("ax_locks:update-state", -1, lockId, 0)
--                 TriggerClientEvent("ax_locks:notify", source, "~g~Türe aufgebrochen~s~")
--                 break
--             end
--         end
--     end
-- end)


-- RegisterNetEvent('ax_locks:hacking')
-- AddEventHandler('ax_locks:hacking', function(lockId, won)
--     if won then
--         local xPlayer = ESX.GetPlayerFromId(source)
--         xPlayer.removeInventoryItem('laptop_h', 1)
        
--         TriggerClientEvent("ax_locks:notify_break_in",-1, lockId, won, xPlayer.getCoords(true))
        
--         for i, lock in ipairs(Locks) do
--             if lock.id == lockId then 
--                 Locks[i].state = 0

--                 TriggerClientEvent("ax_locks:update-state", -1, lockId, 0)
--                 TriggerClientEvent("ax_locks:notify", source, "~g~Türe geöffnet~s~")
--                 break
--             end
--         end
--     end
-- end)

--
-- ax_locks:start
--

CreateThread(function()
    while ESX == nil do
        Wait(0)
    end

    ESX.RegisterCommand({'ax_locks:start', 'axls'}, 'ax-locks', function(xPlayer, args, showError)
        xPlayer.triggerEvent('ax_locks:start')
      end, false, {help = "Starte den Schloss-Editor"})
end)
  
