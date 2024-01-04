ESX = nil

function string.random(length)
    local str = ''  
    for i = 1, length do
        str = str .. string.char(math.random(97, 122))
    end
    return str
end

local token = string.random(10)

RegisterNetEvent('HotLife_backpacks:syncToken', function()
    local src = source
    TriggerClientEvent('HotLife_backpacks:syncToken', src, token)
end)

if exports['es_extended']:getSharedObject() then
    ESX = exports['es_extended']:getSharedObject()
else
    TriggerEvent(HotLife.SharedObject['Server'], function(obj) ESX = obj end)
end

RegisterNetEvent('HotLife_backpacks:setWeight', function() 

    local xPlayer = ESX.GetPlayerFromId(source) 

    local playerId = xPlayer.getIdentifier()

    local result = MySQL.Sync.fetchAll('SELECT * FROM users WHERE identifier = @id', { ['@id'] = playerId })
    result = result[1]

    if result.backpack == 0 then
        return
    end
    xPlayer.setMaxWeight(HotLife.backpacklvl[result.backpack])
    
end)

RegisterNetEvent('HotLife_backpacks:updateBackpackLVL', function(xPlayer, lvl, tok) 

    if tok ~= token then 

        return 
    end

    MySQL.Async.execute('UPDATE `users` SET backpack = @lvl WHERE identifier = @id', { ['@lvl'] = lvl, ['@id'] = xPlayer.getIdentifier() }, function(affectedRows) 
        if affectedRows > 0 then 
            xPlayer.triggerEvent('cataleya_hud:sendNotify', 'success', 'Rucksack', 'Du hast nun mehr Platz im Inventar', 5000)
            print(xPlayer.getName() .. ' hat einen Rucksack eingelöst')
            print(xPlayer.getName() .. ' hat einen Rucksack eingelöst')
            print(xPlayer.getName() .. ' hat einen Rucksack eingelöst')

            xPlayer.triggerEvent('HotLife_backpacks:neuerBackpack')
        end
    end)
end)

for k, v in pairs(HotLife.backpackItems) do 

    ESX.RegisterUsableItem(v, function(playerId)
        local xPlayer = ESX.GetPlayerFromId(playerId)
        xPlayer.removeInventoryItem(v, 1)
        TriggerEvent('HotLife_backpacks:updateBackpackLVL', xPlayer, k, token)
    end)

end
