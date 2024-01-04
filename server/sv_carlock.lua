ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('lm_carlock:isVehicleOwner', function(source, cb, plate)
    local xPlayer = ESX.GetPlayerFromId(source)
	local identifier = xPlayer.getIdentifier()

	MySQL.Async.fetchAll('SELECT owner FROM owned_vehicles WHERE plate = @plate AND owner = @identifier', {
		['@plate'] = plate,
        ['@identifier'] = identifier
	}, function(result)
		if result[1] then
			cb(true)
		else
			cb(false)
		end
	end)
end)