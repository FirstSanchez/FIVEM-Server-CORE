if cf_skating.Framework == "qb" then
    local QBCore = exports["qb-core"]:GetCoreObject()
    QBCore.Functions.CreateUseableItem(cf_skating.ItemName, function(source, item)
        local Player = QBCore.Functions.GetPlayer(source)
        TriggerClientEvent('sanchez-scripts:client:start', source, item)
    end)
    RegisterServerEvent("sanchez-scripts:server:skate", function(source)
        TriggerClientEvent("sanchez-scripts:client:skate", -1, source)
    end)
elseif cf_skating.Framework == "esx" then
    ESX = exports["es_extended"]:getSharedObject()
    ESX.RegisterUsableItem(cf_skating.ItemName, function(source, item)
        local Player = ESX.GetPlayerFromId(source)
        TriggerClientEvent('sanchez-scripts:client:start', source, item)
    end)
    RegisterServerEvent("sanchez-scripts:server:skate", function(source)
        TriggerClientEvent("sanchez-scripts:client:skate", -1, source)
    end)
end
