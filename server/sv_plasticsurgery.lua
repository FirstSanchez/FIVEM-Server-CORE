ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_plasticsurgery:pay')
AddEventHandler('esx_plasticsurgery:pay', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.removeMoney(Config_schoenheitsklinik.Price)
	TriggerClientEvent('esx:showNotification', source, _U('you_paid', ESX.Math.GroupDigits(Config_schoenheitsklinik.Price)))
end)

ESX.RegisterServerCallback('esx_plasticsurgery:checkMoney', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	cb(xPlayer.getMoney() >= Config_schoenheitsklinik.Price)
end)
