ESX = nil
--ESX = exports["es_extended"]:getSharedObject()
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('CORE:isPlateTaken', function(source, cb, plate)
	MySQL.scalar('SELECT plate FROM owned_vehicles WHERE plate = ?', {plate},
	function(result)
		cb(result ~= nil)
	end)
end)

ESX.RegisterServerCallback('CORE:retrieveJobVehicles', function(source, cb, type)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.query('SELECT * FROM owned_vehicles WHERE owner = ? AND type = ? AND job = ?', {xPlayer.identifier, type, xPlayer.job.name},
	function(result)
		cb(result)
	end)
end)

RegisterNetEvent('CORE:setJobVehicleState')
AddEventHandler('CORE:setJobVehicleState', function(plate, state)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.update('UPDATE owned_vehicles SET `stored` = ? WHERE plate = ? AND job = ?', {state, plate, xPlayer.job.name},
	function(rowsChanged)
		if rowsChanged == 0 then
			print(('[EXPORTS] [^3WARNING^7] %s exploited the garage!'):format(xPlayer.identifier))
		end
	end)
end)


local players = {}
local function GetPlayers()
    return players
end
AddEventHandler('esx:playerLoaded', function(playerId, xPlayer)
    if not players[playerId] then
        players[playerId] = {}
        players[playerId].playerId = playerId
        players[playerId].job = xPlayer.getJob().name
        players[playerId].jobLabel = xPlayer.getJob().label
        players[playerId].jobGrade = xPlayer.getJob().grade
        players[playerId].group = xPlayer.getGroup()
    end
end)
AddEventHandler('esx:setJob', function(playerId, job, lastJob)
    if players[playerId] then
        players[playerId].job = job.name
        players[playerId].jobLabel = job.label
        players[playerId].jobGrade = job.grade
    end
end)
AddEventHandler('playerDropped', function(reason)
    local playerId = source
    if players[playerId] then
        players[playerId] = nil
    end
end)
exports('GetPlayers', GetPlayers)