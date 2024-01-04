ESX = exports['es_extended']:getSharedObject()

RegisterServerEvent('HotLife_vendingmachine:machine:buyDrink')
AddEventHandler('HotLife_vendingmachine:machine:buyDrink', function(index, amount, mType)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerId = source
    local base = Config_Machine.Drinks[mType][index]
    local itemName, itemPrice = index, base.price * amount

    if xPlayer.getMoney(playerId) >= itemPrice then
            xPlayer.removeMoney(itemPrice)
            xPlayer.addInventoryItem(itemName, amount)
    end
end)

RegisterServerEvent('HotLife_vendingmachine:machine:buySnack')
AddEventHandler('HotLife_vendingmachine:machine:buySnack', function(index, amount)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerId = source
    local base = Config_Machine.Snacks[index]
    local itemName, itemPrice = index, base.price * amount

    if xPlayer.getMoney(playerId) >= itemPrice then
            xPlayer.removeMoney(itemPrice)
            xPlayer.addInventoryItem(itemName, amount)
    end
end)

function Notify(sendTo, title, message, type)
    TriggerEvent('cataleya_hud:sendNotify', title, message, type, 5000)
end