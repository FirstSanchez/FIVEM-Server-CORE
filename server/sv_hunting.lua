local uniqueId = 100
local playerIds = {}

RegisterServerEvent('uc:hunting:enter')
AddEventHandler('uc:hunting:enter', function()
    local playerId = source
    if playerIds[playerId] == nil then
        playerIds[playerId] = 0
    end
    if playerIds[playerId] == 0 then
        uniqueId = uniqueId + 1
        playerIds[playerId] = uniqueId
        SetPlayerRoutingBucket(playerId, uniqueId)
        TriggerClientEvent('uc:hunting:enter', playerId)
    else
        playerIds[playerId] = 0
        SetPlayerRoutingBucket(playerId, 0)
        TriggerClientEvent('uc:hunting:leave', playerId)
    end
end)

RegisterServerEvent('uc:hunting:getItem')
AddEventHandler('uc:hunting:getItem', function(index)
    local playerId = source
    local base = Config_Hunt.Entitys[index]
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addInventoryItem(base.reward, base.count)
end)