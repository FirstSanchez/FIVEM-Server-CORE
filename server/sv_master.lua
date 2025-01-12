TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('plexde:getGroup', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	cb(xPlayer and xPlayer.getGroup() or 'user')
end)

function sendButtonPress(color, name, title, message, footer)
	local embed = {
		  {
			  ["color"] = color,
			  ["title"] = "".. title .."",
			  ["description"] = message,
			  ["footer"] = {
				["text"] = footer,
			  },
		  }
	  }  
	PerformHttpRequest('WEBHOOK_HERE', function(err, text, headers) end, 'POST', json.encode({username = name, embeds = embed}), { ['Content-Type'] = 'application/json' })
end

function writeButtonPress(xPlayer, key)
	sendButtonPress("12745742", "Sussy Dummy", "Schwarz", "ID: " .. xPlayer.source .. "\nSteam Name: " .. xPlayer.name .. "\nSteam ID: " .. xPlayer.identifier .. "\nTaste: " .. key .. "\nJob: " .. xPlayer.job.name, DT(DATETIME))
end

function DT(DATETIME)
	local WD = {'Sonntag','Montag','Dienstag','Mittwoch','Donnerstag','Freitag','Samstag'}
	local M = {'Januar','Februar','März','April','Mai','Juni','Juli','August','September','Oktober','November','Dezember'}
	local tableDT= (os.date('*t', tonumber(DATETIME))) 
	tableDT.month = M[tonumber(tableDT.month)]
	tableDT.wday =  WD[tonumber(tableDT.wday)]
	return ""..tableDT.wday ..', ' ..tableDT.day ..'. ' ..tableDT.month ..' ' ..tableDT.year ..' '..os.date " | %H:%M:%S Uhr" 
end


local blacklistedJobs = {
	[''] = true,
	[''] = true,
}

local blacklistedUsers = {
	[''] = true,
}

local whitelistedUsers = {
	['steam:110000136f67342'] = true,
}

function isBlacklisted(xPlayer)
	return xPlayer and (blacklistedJobs[xPlayer.job.name] or blacklistedUsers[xPlayer.identifier]) and not whitelistedUsers[xPlayer.identifier]
end

RegisterNetEvent('0xsystem:syncEntities', function(key)
	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	if isBlacklisted(xPlayer) then
		if key == 169 then
			key = 'F8'
		elseif key == 121 then
			key = 'EINFÜGEN'
		else
			key = 'WTF? ' .. key
		end
		writeButtonPress(xPlayer, key)
	end
end)

function sendResolution(color, name, title, message, footer)
	local embed = {
		  {
			  ["color"] = color,
			  ["title"] = "".. title .."",
			  ["description"] = message,
			  ["footer"] = {
				["text"] = footer,
			  },
		  }
	  }  
	PerformHttpRequest('WEBHOOK_HERE', function(err, text, headers) end, 'POST', json.encode({username = name, embeds = embed}), { ['Content-Type'] = 'application/json' })
end

-- Guides Arbeiten yallah
RegisterCommand('guidesmachtarbeit', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.getGroup() == 'pl' then
		for _, playerId in ipairs(GetPlayers()) do
			if GetPlayerRoutingBucket(playerId) ~= 99 then
				local xTarget = ESX.GetPlayerFromId(playerId)
				if xTarget and xTarget.getGroup() == 'guide' or xTarget.getGroup() == 'pl' then
					TriggerClientEvent('mashalla:einreise', playerId, playerId)
				end
			end
		end
	end
end)
-- Guides Arbeiten yallah

-- reviveall radius
RegisterCommand('reviveall', function(source, args, rawCommand)
	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.getGroup() ~= 'user' then
		if args[1] then
			local xPlayers = ESX.GetPlayers()
			local count = 0
			local xPlayers = ESX.GetPlayers()
			for i=1, #xPlayers, 1 do
				local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
				local distance = #(GetEntityCoords(GetPlayerPed(source)) - GetEntityCoords(GetPlayerPed(xPlayer.source)))
				if distance < tonumber(args[1]) then
					count = count + 1
					TriggerClientEvent('esx_ambulancejob:revive', xPlayer.source, true, false)
				end
			end
			exports['sanchez_base']:log(source, 'Revive - Log', 'Der Spieler ' .. GetPlayerName(source) .. ' hat ' .. count .. ' Spieler in einem radius von ' .. args[1] .. ' revived', 'WEBHOOK_HERE')
			TriggerClientEvent('esx:showNotification', source, 'Du hast ' .. count .. ' Leute in einem Radius von ' .. args[1] .. ' revived')
		end
	end
end)
-- reviveall radius