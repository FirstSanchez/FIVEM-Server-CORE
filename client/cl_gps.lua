ESX = nil
ESX = exports["es_extended"]:getSharedObject()

local blips = {}

RegisterNetEvent('tracker:SendData', function(jobs, has)
    if ESX.IsPlayerLoaded() then
        local job = ESX.GetPlayerData().job
        local me = GetPlayerServerId(PlayerId())
        if jobs[job.name] and has[me] then
            for _, blip in pairs(blips) do
                if type(blip) == 'table' then
                    if not DoesEntityExist(blip.ped) or not jobs[job.name][_] then
                        RemoveBlip(blip.blip)
                    end
                else
                    RemoveBlip(blip)
                end
            end
            for id, player in pairs(jobs[job.name]) do
                if id ~= me then
                    if NetworkDoesEntityExistWithNetworkId(player.netId) then
                        local ped = NetworkGetEntityFromNetworkId(player.netId)
                        if GetBlipFromEntity(ped) == 0 then
                            local blip = AddBlipForEntity(ped)
                            SetBlipSprite(blip, CFG_Tracker.Jobs[job.name].sprite)
                            SetBlipColour(blip, CFG_Tracker.Jobs[job.name].color)
                            SetBlipScale(blip, 0.7)
                            SetBlipAsShortRange(blip, true)
                            BeginTextCommandSetBlipName('STRING')
                            AddTextComponentString(job.label)
                            EndTextCommandSetBlipName(blip)
                            blips[id] = {
                                blip = blip,
                                ped = ped
                            }
                        end
                    else
                        local blip = AddBlipForCoord(player.coords)
                        SetBlipSprite(blip, CFG_Tracker.Jobs[job.name].sprite)
                        SetBlipColour(blip, CFG_Tracker.Jobs[job.name].color)
                        SetBlipScale(blip, 0.7)
                        SetBlipAsShortRange(blip, true)
                        BeginTextCommandSetBlipName('STRING')
                        AddTextComponentString(job.label)
                        EndTextCommandSetBlipName(blip)
                        blips[id] = blip
                    end
                end
            end
        else
            for _, blip in pairs(blips) do
                if type(blip) == 'table' then
                    RemoveBlip(blip.blip)
                else
                    RemoveBlip(blip)
                end
            end
        end
    end
end)

RegisterNetEvent('esx:setJob', function()
    for _, blip in pairs(blips) do
        if type(blip) == 'table' then
            RemoveBlip(blip.blip)
        else
            RemoveBlip(blip)
        end
    end
end)

AddEventHandler('esx:onPlayerDeath', function (data)
    -- local ffa = exports['KEKW_FFA']:isInZone()
    if not ffa then
        TriggerServerEvent('killed', data.killerServerId)
    end
end)