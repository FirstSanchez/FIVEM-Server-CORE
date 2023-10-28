-- Einfach RDY bei bedarf Sanchez NERVEN!!!
ESX = nil
local token = nil
CreateThread(function()
if exports['es_extended']:getSharedObject() then
    ESX = exports['es_extended']:getSharedObject()
else
    while ESX == nil do
    TriggerEvent(UTOPIA.SharedObject['Client'], function(obj) ESX = obj end)
    Wait(0)
    end
    ESX.PlayerData = ESX.GetPlayerData()
end

TriggerServerEvent('UTOPIA_backpacks:syncToken')
end)


RegisterNetEvent('UTOPIA_backpacks:syncToken', function(tok)
    token = tok
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded',function(xPlayer, isNew, skin)

    TriggerServerEvent('UTOPIA_backpacks:setWeight')

end)

RegisterNetEvent('UTOPIA_backpacks:neuerBackpack', function() 
    TriggerServerEvent('UTOPIA_backpacks:setWeight')
end)
