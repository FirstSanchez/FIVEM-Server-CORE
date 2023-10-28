ESX = nil

function string.random(length)
    local str = ''  
    for i = 1, length do
        str = str .. string.char(math.random(97, 122))
    end
    return str
end

local token = string.random(10)

RegisterNetEvent('UTOPIA_backpacks:syncToken', function()
    local src = source
    TriggerClientEvent('UTOPIA_backpacks:syncToken', src, token)
end)

if exports['es_extended']:getSharedObject() then
    ESX = exports['es_extended']:getSharedObject()
else
    TriggerEvent(UTOPIA.SharedObject['Server'], function(obj) ESX = obj end)
end

RegisterNetEvent('UTOPIA_backpacks:setWeight', function() 

    local xPlayer = ESX.GetPlayerFromId(source) 

    local playerId = xPlayer.getIdentifier()

    local result = MySQL.Sync.fetchAll('SELECT * FROM users WHERE identifier = @id', { ['@id'] = playerId })
    result = result[1]

    if result.backpack == 0 then
        return
    end
    xPlayer.setMaxWeight(UTOPIA.backpacklvl[result.backpack])
    
end)

RegisterNetEvent('UTOPIA_backpacks:updateBackpackLVL', function(xPlayer, lvl, tok) 

    if tok ~= token then 

        return 
    end

    MySQL.Async.execute('UPDATE `users` SET backpack = @lvl WHERE identifier = @id', { ['@lvl'] = lvl, ['@id'] = xPlayer.getIdentifier() }, function(affectedRows) 
        if affectedRows > 0 then 
            xPlayer.triggerEvent('prime_notify', 'success', 'Rucksack', 'Du hast nun mehr Platz im Inventar', 5000)
            print(xPlayer.getName() .. ' hat einen Rucksack eingelöst')
            print(xPlayer.getName() .. ' hat einen Rucksack eingelöst')
            print(xPlayer.getName() .. ' hat einen Rucksack eingelöst')

            xPlayer.triggerEvent('UTOPIA_backpacks:neuerBackpack')
        end
    end)
end)

for k, v in pairs(UTOPIA.backpackItems) do 

    ESX.RegisterUsableItem(v, function(playerId)
        local xPlayer = ESX.GetPlayerFromId(playerId)
        xPlayer.removeInventoryItem(v, 1)
        TriggerEvent('UTOPIA_backpacks:updateBackpackLVL', xPlayer, k, token)
    end)

end
