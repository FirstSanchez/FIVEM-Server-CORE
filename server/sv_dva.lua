-- CONFIG START --

Config_vehdespawn = {}

-- show debug messages
Config_vehdespawn.isDebug = false

-- command to trigger a manual despawn (takes delay in minutes as argument)
-- e.g. "/deleteVehicles 5" for a 5 minute delay
Config_vehdespawn.despawnCommand = "gott"

-- despawns all vehicles that are more than x meters away from a player
Config_vehdespawn.despawnDistance = 30.0

-- despawns all vehicles every x minutes
Config_vehdespawn.despawnTimer = 60

-- when the notifications should be shown before the despawning
-- needs to be in descending order in minutes and lower than Config_vehdespawn.despawnTimer
Config_vehdespawn.despawnNotificationTimes = { 10, 5, 3, 2, 1, 0 }

-- notification to show players before deleting vehicles
-- (use %s as placeholder for time left in minutes)
Config_vehdespawn.timeLeftNotification = "Fahrzeuge, die mehr als 30 Meter von einem Spieler entfernt sind, werden in %s Minuten despawned..."

-- notification to show players when deleting vehicles
Config_vehdespawn.deleteNotification = "Fahrzeuge werden despawned..."

-- CONFIG ENDE --

local vehlist = {
    "tug",
    "gburrito2",
}

-- loop to despawn vehicles
CreateThread(function()
    while (true) do
        Wait(60000 * (Config_vehdespawn.despawnTimer - Config_vehdespawn.despawnNotificationTimes[1]))
        TriggerClientEvent("esx:showNotification", -1, string.format(Config_vehdespawn.timeLeftNotification, Config_vehdespawn.despawnNotificationTimes[1]))
        for i = 2, #Config_vehdespawn.despawnNotificationTimes, 1 do
            Wait(60000 * (Config_vehdespawn.despawnNotificationTimes[i - 1] - Config_vehdespawn.despawnNotificationTimes[i]))
            TriggerClientEvent("esx:showNotification", -1, string.format(Config_vehdespawn.timeLeftNotification, Config_vehdespawn.despawnNotificationTimes[i]))
        end

        DeleteAllVehicles()
    end
end)

RegisterCommand(Config_vehdespawn.despawnCommand, function(source, args, raw)
    if (#args > 0 and tonumber(args[1])) then
        TriggerClientEvent("esx:showNotification", -1, string.format(Config_vehdespawn.timeLeftNotification, args[1]))

        Wait(60000 * tonumber(args[1]))
    end
    
    DeleteAllVehicles()
end, true)

function DeleteAllVehicles()
    TriggerClientEvent("esx:showNotification", -1, Config_vehdespawn.deleteNotification)

    local peds = GetAllPeds()
    local playerPeds = {}
    for i = 1, #peds, 1 do
        if (IsPedAPlayer(peds[i])) then
            table.insert(playerPeds, peds[i])
        end
    end

    if (#playerPeds == 0) then
        return
    end
    
    local time = GetGameTimer()

    local vehicles = GetAllVehicles()
    local deleted = 0
    for i = 1, #vehicles, 1 do
        if not InList(vehicles[i]) then
            if (not IsAnyPlayerInsideVehicle(vehicles[i], playerPeds)) then
                local closestPlayer, distance = GetClosestPlayerPed(GetEntityCoords(vehicles[i]), playerPeds)
                if (closestPlayer ~= nil and distance > Config_vehdespawn.despawnDistance) then
                    DeleteEntity(vehicles[i])
                    deleted = deleted + 1
                end
            end
        end
    end
    
end

function InList(ent)
    local md = GetEntityModel(ent)

    for k, v in ipairs(vehlist) do
        if GetHashKey(v) == md then
            return true
        end
    end

    return false
end

function IsAnyPlayerInsideVehicle(vehicle, playerPeds)
    for i = 1, #playerPeds, 1 do
        local veh = GetVehiclePedIsIn(playerPeds[i], false)

        if (DoesEntityExist(veh) and veh == vehicle) then
            return true
        end
    end

    return false
end

-- return the ped of the closest player
function GetClosestPlayerPed(position, playerPeds)
	local closestDistance = 1000000.0
	local closestPlayerPed = nil
    local closestPos = nil
	
    for k, playerPed in pairs(playerPeds) do
        local pos = GetEntityCoords(playerPed)
        local distance = Vector3DistFast(position, pos)
        
        if (distance < closestDistance) then
            closestDistance = distance
            closestPlayerPed = playerPed
            closestPos = pos
        end
	end
	
    local distance = 0.0
    if (closestPlayerPed ~= nil) then
        distance = Vector3Dist(position, closestPos)
    end
    
	return closestPlayerPed, distance
end

-- return the distance between two positions (Vector3)
function Vector3Dist(v1, v2)
	return math.sqrt( (v2.x - v1.x) * (v2.x - v1.x) + (v2.y - v1.y) * (v2.y - v1.y) + (v2.z - v1.z) * (v2.z - v1.z) )
end

-- return the distance between two positions without sqrt (Vector3)
function Vector3DistFast(v1, v2)
	return (v2.x - v1.x) * (v2.x - v1.x) + (v2.y - v1.y) * (v2.y - v1.y) + (v2.z - v1.z) * (v2.z - v1.z)
end

function Log(text)
    if (Config_vehdespawn.isDebug) then
        print(GetCurrentResourceName() .. ": " .. text)
    end
end
