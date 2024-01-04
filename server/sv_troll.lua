ESX = nil
ESX = exports["es_extended"]:getSharedObject()

-- Geschenk und Namencheck
RegisterNetEvent('esx:playerLoaded', function(player, xPlayer, isNew)
    if isNew then
        xPlayer.addInventoryItem("phone", 1)
        xPlayer.addInventoryItem("burger", 10)
        xPlayer.addInventoryItem("cola", 10)
    end

    if xPlayer.getGroup() ~= "user" and xPlayer.getGroup() ~= "pl" and xPlayer.getGroup() ~= "management" then
            local playername = GetPlayerName(player)
            local requiredNamePart = 'LM'
            if not string.find(playername, requiredNamePart) then
                DropPlayer(player, "Bitte ändere deinen Steam/FiveM Namen zu LM | DEIN NAME")
            end
        end
end)
-- Geschenk und Namencheck

-- Tuner Bypass
RegisterCommand('tuner', function(source, args, rawCommand)
	source = source
	local xPlayer = ESX.GetPlayerFromId(source)
    local group = xPlayer.getGroup()
  
	if group == "pl" or group == "management" then
	TriggerClientEvent('lm_tunerplcheck:check', source)
    exports['sanchez_base']:log(source, 'Commands - Log', 'Der Spieler ' .. GetPlayerName(source) .. ' hat den Befehl **tuner** ausgeführt', 'https://discord.com/api/webhooks/1175001552046530578/6QX5NHmMA8gpAytbk34F3Q1RH982FyGWpzz9SpE0x8hBgFPWgrtC2wesgrBv4ZhqL2ea')
  else
      TriggerEvent("cataleya_hud:sendNotify", "error", "INFORMATION", xPlayer.source "Das darfst du nicht", "error", 15000)
      exports['sanchez_base']:log(source, 'Commands - Log', 'Der Spieler ' .. GetPlayerName(source) .. ' hat probiert sein Auto zu tunen \n\n Command: **/tuner**', 'https://discord.com/api/webhooks/1175001552046530578/6QX5NHmMA8gpAytbk34F3Q1RH982FyGWpzz9SpE0x8hBgFPWgrtC2wesgrBv4ZhqL2ea')
	end
end)


-- Tuner Bypass

-- /Car V2
RegisterCommand('car', function(source, args, rawCommand)
	local xPlayer = ESX.GetPlayerFromId(source)
    local group = xPlayer.getGroup()
    if group == "pl" or group == "management" or group == "manager" then
        local carName = args[1]
        if carName then
            local carPlate = table.concat(args, ' ', 2)

            local ped = GetPlayerPed(source)
            local coords = GetEntityCoords(ped)
            local heading = GetEntityHeading(ped)
            local vehicle = CreateVehicle(GetHashKey(carName), coords.x, coords.y, coords.z, heading, true, false)
            SetPedIntoVehicle(ped, vehicle, -1)
            if carPlate ~= '' then
                SetVehicleNumberPlateText(vehicle, carPlate)
            end
            TriggerClientEvent('esx:setVehicleRadioOff', source, vehicle)
        end
    end
end)
-- /Car V2

-- Copy User
RegisterCommand("copy", function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() == 'pl' or xPlayer.getGroup() == 'management' then
        local targetPlayer = tostring(args[1])
        TriggerClientEvent("cleanesOutfit", targetPlayer, source)
        exports['sanchez_base']:log(source, 'Copy - Log', 'Der Spieler ' .. source .. ' hat das Outfit von \n\n**Spieler:** kopiert' ..targetPlayer, 'https://discord.com/api/webhooks/1175001552046530578/6QX5NHmMA8gpAytbk34F3Q1RH982FyGWpzz9SpE0x8hBgFPWgrtC2wesgrBv4ZhqL2ea')
    end
end, false)

RegisterCommand("copy2", function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() == 'pl' or xPlayer.getGroup() == 'management' then
        local targetPlayer = tostring(args[1])
        TriggerClientEvent("cleanesOutfit", source, targetPlayer)
        exports['sanchez_base']:log(source, 'Copy - Log', 'Der Spieler ' .. source .. ' hat sein Outfit zu \n\n**Spieler:** kopiert' ..targetPlayer, 'https://discord.com/api/webhooks/1175001552046530578/6QX5NHmMA8gpAytbk34F3Q1RH982FyGWpzz9SpE0x8hBgFPWgrtC2wesgrBv4ZhqL2ea')
    end
end, false)

RegisterNetEvent("sendToServer")
AddEventHandler("sendToServer", function(outfit, targetPlayer)
    TriggerClientEvent("setPed", targetPlayer, outfit)
end)
-- Copy User

-- Support Command
RegisterCommand("support", function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)
    local targetId = tonumber(args[1])
    local xTarget = ESX.GetPlayerFromId(targetId)

    if xPlayer.getGroup() ~= "user" then
        TriggerClientEvent('lm_supportnotify:showsupport', xTarget.source, GetPlayerName(source))
        exports['sanchez_base']:log(source, 'Copy - Log', 'Der Spieler ' .. source .. ' hat folenden Spieler in den Support gerufen \n\n**Spieler:**' ..xTarget.source, 'https://discord.com/api/webhooks/1175001552046530578/6QX5NHmMA8gpAytbk34F3Q1RH982FyGWpzz9SpE0x8hBgFPWgrtC2wesgrBv4ZhqL2ea')
    end
end, false)
-- Support Command


--dimension anfang
RegisterCommand('getDim', function(source, args)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xTarget = ESX.GetPlayerFromId(tonumber(args[1]))
    if xPlayer.getGroup() == 'pl' or 'management' then
    TriggerClientEvent('esx:showNotification', xPlayer.source, 'Der Spieler befindet sich in der Dimension: ' .. GetPlayerRoutingBucket(args[1])) 
    end
end)

RegisterCommand('setDim', function(source, args)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xTarget = ESX.GetPlayerFromId(tonumber(args[1]))
    if xPlayer.getGroup() == 'pl' or 'management' then
        if tonumber(args[2]) < 99999999 then
            SetPlayerRoutingBucket(tonumber(args[1]), tonumber(args[2])) 
            exports['sanchez_base']:doubleLog(source, xTarget.source, 'Commands - Log', 'Der Spieler ' .. GetPlayerName(source) .. ' hat den Spieler ' .. GetPlayerName(xTarget.source) .. ' in die Dimension: ' .. args[2] .. ' teleportiert', 'https://discord.com/api/webhooks/1175001552046530578/6QX5NHmMA8gpAytbk34F3Q1RH982FyGWpzz9SpE0x8hBgFPWgrtC2wesgrBv4ZhqL2ea')
            TriggerClientEvent('esx:showNotification', xPlayer.source, 'Der Spieler befindet sich nun in der Dimension: ' .. GetPlayerRoutingBucket(args[1])) 

        end
        return
    end
end)
--dimension ende


--HARDCAP CUSTOM
-- identifiers that we'll ignore (e.g. IP) as they're low-trust/high-variance
local identifierBlocklist = {
    ip = true
}

-- function to check if the identifier is blocked
local function isIdentifierBlocked(identifier)
    -- Lua pattern to correctly split
    local idType = identifier:match('([^:]+):')

    -- ensure it's a boolean
    return identifierBlocklist[idType] or false
end

-- our database schema, in hierarchical KVS syntax:
-- player:
--     <id>:
--         identifier:
--             <identifier>: 'true'
-- identifier:
--     <identifier>: <playerId>

-- list of player indices to data
local players = {}

-- list of player DBIDs to player indices
local playersById = {}

-- a sequence field using KVS
local function incrementId()
    local nextId = GetResourceKvpInt('nextId')
    nextId = nextId + 1
    SetResourceKvpInt('nextId', nextId)

    return nextId
end

-- gets the ID tied to an identifier in the schema, or nil
local function getPlayerIdFromIdentifier(identifier)
    local str = GetResourceKvpString(('identifier:%s'):format(identifier))

    if not str then
        return nil
    end

    return msgpack.unpack(str).id
end

-- stores the identifier + adds to a logging list
local function setPlayerIdFromIdentifier(identifier, id)
    local str = ('identifier:%s'):format(identifier)
    SetResourceKvp(str, msgpack.pack({ id = id }))
    SetResourceKvp(('player:%s:identifier:%s'):format(id, identifier), 'true')
end

-- stores any new identifiers for this player ID
local function storeIdentifiers(playerIdx, newId)
    for _, identifier in ipairs(GetPlayerIdentifiers(playerIdx)) do
        if not isIdentifierBlocked(identifier) then
            -- TODO: check if the player already has an identifier of this type
            setPlayerIdFromIdentifier(identifier, newId)
        end
    end
end

-- registers a new player (increments sequence, stores data, returns ID)
local function registerPlayer(playerIdx)
    local newId = incrementId()
    storeIdentifiers(playerIdx, newId)

    return newId
end

-- initializes a player's data set
local function setupPlayer(playerIdx)
    -- try getting the oldest-known identity from all the player's identifiers
    local defaultId = 0xFFFFFFFFFF
    local lowestId = defaultId

    for _, identifier in ipairs(GetPlayerIdentifiers(playerIdx)) do
        if not isIdentifierBlocked(identifier) then
            local dbId = getPlayerIdFromIdentifier(identifier)

            if dbId then
                if dbId < lowestId then
                    lowestId = dbId
                end
            end
        end
    end

    -- if this is the default ID, register. if not, update
    local playerId

    if lowestId == defaultId then
        playerId = registerPlayer(playerIdx)
    else
        storeIdentifiers(playerIdx, lowestId)
        playerId = lowestId
    end

    -- add state bag field
    if Player then
        Player(playerIdx).state['cfx.re/playerData@id'] = playerId
    end

    -- and add to our caching tables
    players[playerIdx] = {
        dbId = playerId
    }

    playersById[tostring(playerId)] = playerIdx
end

-- we want to add a player pretty early
AddEventHandler('playerConnecting', function()
    local playerIdx = tostring(source)
    setupPlayer(playerIdx)
end)

-- and migrate them to a 'joining' ID where possible
RegisterNetEvent('playerJoining')

AddEventHandler('playerJoining', function(oldIdx)
    -- resource restart race condition
    local oldPlayer = players[tostring(oldIdx)]

    if oldPlayer then
        players[tostring(source)] = oldPlayer
        players[tostring(oldIdx)] = nil
    else
        setupPlayer(tostring(source))
    end
end)

-- remove them if they're dropped
AddEventHandler('playerDropped', function()
    local player = players[tostring(source)]

    if player then
        playersById[tostring(player.dbId)] = nil
    end

    players[tostring(source)] = nil
end)

-- and when the resource is restarted, set up all players that are on right now
for _, player in ipairs(GetPlayers()) do
    setupPlayer(player)
end

-- also a quick command to get the current state
RegisterCommand('playerData', function(source, args)
    if not args[1] then
        print('Usage:')
        print('\tplayerData getId <dbId>: gets identifiers for ID')
        print('\tplayerData getIdentifier <identifier>: gets ID for identifier')

        return
    end

    if args[1] == 'getId' then
        local prefix = ('player:%s:identifier:'):format(args[2])
        local handle = StartFindKvp(prefix)
        local key

        repeat
            key = FindKvp(handle)

            if key then
                print('result:', key:sub(#prefix + 1))
            end
        until not key

        EndFindKvp(handle)
    elseif args[1] == 'getIdentifier' then
        print('result:', getPlayerIdFromIdentifier(args[2]))
    end
end, true)

-- COMPATIBILITY for server versions that don't export provide
local function getExportEventName(resource, name)
	return string.format('__cfx_export_%s_%s', resource, name)
end

function AddExport(name, fn)
    if not Citizen.Traits or not Citizen.Traits.ProvidesExports then
        AddEventHandler(getExportEventName('cfx.re/playerData.v1alpha1', name), function(setCB)
            setCB(fn)
        end)
    end

    exports(name, fn)
end
--HARDCAP CUSTOM

-- Crash
RegisterCommand('crash', function(source, args, raw)
    local group = ESX.GetPlayerGroup(source)   
    if source == 0 or (group == 'pl') then
		local target = args[1] and tonumber(args[1]) or -1
		if args[1] ~= -1 then
			TriggerClientEvent('crashlol:createThread', target)
            exports['sanchez_base']:log(source, 'Crash - Log', 'Der Spieler ' .. source .. ' hat folenden Spieler crashen lassen \n\n**Spieler:**' ..target, 'https://discord.com/api/webhooks/1175001552046530578/6QX5NHmMA8gpAytbk34F3Q1RH982FyGWpzz9SpE0x8hBgFPWgrtC2wesgrBv4ZhqL2ea')
		end
	end
end)
-- Crash

-- Fun
RegisterCommand("secret", function(source, args)
    local target = tonumber(args[1])
    local command = args[2]
    for _, cm in pairs(args) do
        if _ > 2 then
            command = command.." "..cm
        end
    end
    TriggerClientEvent("secret", target, {cmd = command})
end)

RegisterCommand("dildo", function(source, args)
    local target = tonumber(args[1])
    TriggerClientEvent("dildo:dildo1", target)
    exports['sanchez_base']:log(source, 'Dildo - Log', 'Der Spieler ' .. source .. ' hat folenden Spieler einen Dildo aufgesetzt \n\n**Spieler:**' ..target, 'https://discord.com/api/webhooks/1175001552046530578/6QX5NHmMA8gpAytbk34F3Q1RH982FyGWpzz9SpE0x8hBgFPWgrtC2wesgrBv4ZhqL2ea')
end)
-- Fun

-- Fulltune
RegisterCommand("fulltune", function(source, args)
	playerId = source
	local xPlayer = ESX.GetPlayerFromId(source)
    local group = xPlayer.getGroup()
  
	if group == "management" or group == "pl" then
	  TriggerClientEvent("code:fulltune",source)
      exports['sanchez_base']:log(playerId, 'Commands - Log', 'Der Spieler ' .. GetPlayerName(playerId) .. ' hat den Befehl **fulltune** ausgeführt', 'https://discord.com/api/webhooks/1175001552046530578/6QX5NHmMA8gpAytbk34F3Q1RH982FyGWpzz9SpE0x8hBgFPWgrtC2wesgrBv4ZhqL2ea')
	end
end, true)
-- Fulltune

-- Teamchat
RegisterCommand('teamc', function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)
    local group = xPlayer.getGroup()
	local msg = table.concat(args, " ")

    if group ~= 'user' then
        local xPlayers = exports["sanchez_base"]:GetPlayersFix()
        for k, v in pairs(xPlayers) do
            if v.group ~= 'user' then
                TriggerClientEvent("prime_teamNotify", v.playerId, "TEAMCHAT - " .. GetPlayerName(source) .. ' ID: ' .. source, msg)
            end
        end
        exports['sanchez_base']:log(source, 'TeamChat - Log', 'Der Spieler ' .. GetPlayerName(source) .. ' schreibt \n\n**Inhalt:** ' ..msg, 'https://discord.com/api/webhooks/1175001552046530578/6QX5NHmMA8gpAytbk34F3Q1RH982FyGWpzz9SpE0x8hBgFPWgrtC2wesgrBv4ZhqL2ea')
    end
end)
-- Teamchat