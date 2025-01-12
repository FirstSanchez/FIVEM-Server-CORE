ESX = nil
local token = nil
CreateThread(function()
if exports['es_extended']:getSharedObject() then
    ESX = exports['es_extended']:getSharedObject()
else
    while ESX == nil do
    TriggerEvent(HotLife.SharedObject['Client'], function(obj) ESX = obj end)
    Wait(0)
    end
    ESX.PlayerData = ESX.GetPlayerData()
end

TriggerServerEvent('HotLife_backpacks:syncToken')
end)


RegisterNetEvent('HotLife_backpacks:syncToken', function(tok)
    token = tok
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded',function(xPlayer, isNew, skin)

    TriggerServerEvent('HotLife_backpacks:setWeight')

end)

RegisterNetEvent('HotLife_backpacks:neuerBackpack', function() 
    TriggerServerEvent('HotLife_backpacks:setWeight')
end)
