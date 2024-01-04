ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('sanchez_deskbell:alert_s')
AddEventHandler('sanchez_deskbell:alert_s', function(job)
TriggerClientEvent('sanchez_deskbell:alert_c', -1, job)
end)