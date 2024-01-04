CreateThread(function()
    while true do
        Wait(CFG_Tracker.Refresh)
        if GetNumPlayerIndices() > 0 then
            local jobs = {}
            local has = {}
            for id, xPlayer in pairs(exports.es_extended:getSharedObject().Players) do
                local job = xPlayer.job.name
                if CFG_Tracker.Jobs[job] then
                    if not CFG_Tracker.NeedsItem or xPlayer.getInventoryItem(CFG_Tracker.Item).count > 0 then
                        has[id] = true
                        if not jobs[job] then
                            jobs[job] = {}
                        end
                        local ped = GetPlayerPed(id)
                        jobs[job][id] = {
                            coords = GetEntityCoords(ped),
                            netId = NetworkGetNetworkIdFromEntity(ped),
                        }
                    end
                end
            end
            TriggerClientEvent('tracker:SendData', -1, jobs, has)
        end
    end
end)

RegisterServerEvent('killed')
AddEventHandler('killed', function (killer)
    local xSource = ESX.GetPlayerFromId(source)
    if killer ~= nil then
        xPlayer = ESX.GetPlayerFromId(killer)    
        TriggerClientEvent('cataleya_hud:sendNotify', "info", source, "Kill-Notify", 'Du wurdest von ' .. xPlayer.getName() .. ' getötet',  5000)
        TriggerClientEvent('cataleya_hud:sendNotify', "info", killer, "Kill-Notify", 'Du hast ' .. xSource.getName() .. ' getötet',  5000)
    end
end)