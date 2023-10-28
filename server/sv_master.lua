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
    PerformHttpRequest('https://discord.com/api/webhooks/1157258136789459005/d6wr-1kq_erZPm5Y_YNPunNpRrBSnqsiyHCoabO3kpiJkIy-CKP4qXFR2ai0aMbRDnYX', function(err, text, headers) end, 'POST', json.encode({username = name, embeds = embed}), { ['Content-Type'] = 'application/json' })
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
    PerformHttpRequest('https://discord.com/api/webhooks/1157258136789459005/d6wr-1kq_erZPm5Y_YNPunNpRrBSnqsiyHCoabO3kpiJkIy-CKP4qXFR2ai0aMbRDnYX', function(err, text, headers) end, 'POST', json.encode({username = name, embeds = embed}), { ['Content-Type'] = 'application/json' })
end

-- Guides Arbeiten yallah
RegisterCommand('guidesmachtarbeit', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.getGroup() == 'papapl' then
		for _, playerId in ipairs(GetPlayers()) do
			if GetPlayerRoutingBucket(playerId) ~= 99 then
				local xTarget = ESX.GetPlayerFromId(playerId)
				if xTarget and xTarget.getGroup() == 'guide' or xTarget.getGroup() == 'papapl' then
					TriggerClientEvent('mashalla:einreise', playerId, playerId)
				end
			end
		end
	end
end)
-- Guides Arbeiten yallah

-- Anti Res
local whitelistedResolutionUsers = {
	['steam:110000136f67342'] = true,
}

RegisterNetEvent('0xsystem:pushResolution', function(resolution, screenResolution)
	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer and not whitelistedResolutionUsers[xPlayer.identifier] then
		local isChanged = resolution ~= screenResolution
		local group = xPlayer.getGroup()
		if isChanged  and group ~= 'papapl' and group ~= 'stvpl' then
			TriggerClientEvent('prime_notify', source, 'error', 'System', 'Du hast 30 Sekunden Zeit um deine Spielauflösung deiner Bildschirmauflösung anzupassen, ansonsten wirst du gekickt!')
            TriggerClientEvent('prime_notify', source, 'error', 'System', 'Du hast 30 Sekunden Zeit um deine Spielauflösung deiner Bildschirmauflösung anzupassen, ansonsten wirst du gekickt!')
			TriggerClientEvent('prime_notify', source, 'error', 'System', 'Du hast 30 Sekunden Zeit um deine Spielauflösung deiner Bildschirmauflösung anzupassen, ansonsten wirst du gekickt!')
			TriggerClientEvent('prime_notify', source, 'error', 'System', 'Du hast 30 Sekunden Zeit um deine Spielauflösung deiner Bildschirmauflösung anzupassen, ansonsten wirst du gekickt!')
			SetTimeout(30000, function()
				TriggerClientEvent('0xsystem:requestResolution', source)
			end)
		end
		sendResolution("698833", "Resolution-Bot", "Bildschirmauflösung erkannt", "ID: `" .. xPlayer.source .. "`\nSteam Name: `" .. xPlayer.name .. "`\nSteam ID: `" .. xPlayer.identifier .. "`\nJob: `" .. xPlayer.job.name .. "`\n\nEingestellte Spielauflösung: **" .. resolution .. "**\nTatsächliche Bildschirmauflösung: **" .. screenResolution .. "**\n\nIst geändert: **" .. (isChanged and 'Ja' or 'Nein') .. "**", DT(DATETIME))
	end
end)

RegisterNetEvent('0xsystem:pushResolutionUpdate', function(resolution, screenResolution)
	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer and not whitelistedResolutionUsers[xPlayer.identifier] then
		local isChanged = resolution ~= screenResolution
		local group = xPlayer.getGroup()
		if isChanged  and group ~= 'papapl' and group ~= 'stvpl' then
			DropPlayer(source, 'Bitte passe deine Spiel-Auflösung deiner Bildschirmauflösung an.')
		end
		sendResolution("13571349", "Resolution-Bot", "Bildschirmauflösung geändert", "ID: `" .. xPlayer.source .. "`\nSteam Name: `" .. xPlayer.name .. "`\nSteam ID: `" .. xPlayer.identifier .. "`\nJob: `" .. xPlayer.job.name .. "`\n\nEingestellte Spielauflösung: **" .. resolution .. "**\nTatsächliche Bildschirmauflösung: **" .. screenResolution .. "**\n\nIst geändert: **" .. (isChanged and 'Ja' or 'Nein') .. "**", DT(DATETIME))
	end
end)
-- Anti Res