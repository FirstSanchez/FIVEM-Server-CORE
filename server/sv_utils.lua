-- Weste HOWDY 03.11.2023
ESX.RegisterUsableItem('bulletproof', function (source)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeInventoryItem('bulletproof', 1)
    TriggerClientEvent('westeHowdyLOL:kevlar', source)
end)
-- Weste HOWDY 03.11.2023


--Tempomat

local vehicleSpeed = 0


RegisterCommand('tempo', function()
    if not IsDriver() then return end
    if isBoot() then
        TriggerClientEvent('esx:showNotification', source, 'Du kannst bei einem Boot kein Tempomat einstellen')
        return
    end
    TriggerCruiseControl()
end, false)

RegisterKeyMapping('tempo', 'Tempomat', 'keyboard', 'o')

local CruisedSpeed, CruisedSpeedKm = 0, 0

function TriggerCruiseControl()
    if CruisedSpeed == 0 and IsDriving() then
        if GetVehiculeSpeed() > 0 then
            CruisedSpeed = GetVehiculeSpeed()
            CruisedSpeedKm = TransformToKm(CruisedSpeed)
            TriggerClientEvent('esx:showNotification', source, 'Tempomat: ' .. math.floor(CruisedSpeed * 3.6 + 0.5) .. ' km/h')
            CreateThread(function ()
                while CruisedSpeed > 0 and IsInVehicle() == PlayerPedId() do
                    Wait(0)
                    
                    if not IsTurningOrHandBraking() and GetVehiculeSpeed() < (CruisedSpeed - 1.5) then
                        CruisedSpeed = 0
                        TriggerClientEvent('esx:showNotification', source, 'Tempomat deaktiviert')
                        Wait(2000)
                        break
                    end
                    
                    if not IsTurningOrHandBraking() and IsVehicleOnAllWheels(GetVehicle()) and GetVehiculeSpeed() < CruisedSpeed then
                        SetVehicleForwardSpeed(GetVehicle(), CruisedSpeed)
                    end
                    
                    if IsControlJustPressed(1, 246) then
                        CruisedSpeed = GetVehiculeSpeed()
                        CruisedSpeedKm = TransformToKm(CruisedSpeed)
                    end

                    if IsControlJustPressed(2, 72) then
                        CruisedSpeed = 0
                        TriggerClientEvent('esx:showNotification', source, 'Tempomat deaktiviert')
                        Wait(2000)
                        break
                    end
                end
            end)
        end
    end
end
  
function IsTurningOrHandBraking()
    return IsControlPressed(2, 76) or IsControlPressed(2, 63) or IsControlPressed(2, 64)
end
  
function IsDriving()
    return IsPedInAnyVehicle(PlayerPedId(), false)
end

function isBoot()
    local class = GetVehicleClass(GetVehicle(), false)
    
    if class == 14 then
        return true
    end

    return false
end
  
function GetVehicle()
    return GetVehiclePedIsIn(PlayerPedId(), false)
end
  
function IsInVehicle()
    return GetPedInVehicleSeat(GetVehicle(), -1)
end
  
function IsDriver()
    return GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId(), false), -1) == PlayerPedId()
end
  
function GetVehiculeSpeed()
    return GetEntitySpeed(GetVehicle())
end
  
function TransformToKm(speed)
    return math.floor(speed * 3.6 + 0.5)
end
--Tempomat

local vehicleCruiser
local vehiclesCars = {0,1,2,3,4,5,6,7,8,9,10,11,12,17,18,19,20};

 function has_value(tab, val)
     for index, value in ipairs(tab) do
         if value == val then
            return true
         end
     end

     return false
end

RegisterCommand('begrenzer', function(source, args)
    local player = PlayerPedId()
 	local vehicle = GetVehiclePedIsIn(player, false)
 	local vehicleClass = GetVehicleClass(vehicle)

    if GetPedInVehicleSeat(vehicle, -1) == player and (has_value(vehiclesCars, vehicleClass) == true) then
		
 	local vehicleSpeedSource = GetEntitySpeed(vehicle)

 	if vehicleCruiser == 'on' then
 		vehicleCruiser = 'off'
        SetEntityMaxSpeed(vehicle, 98.0)
        TriggerClientEvent('esx:showNotification', source, 'Begrenzer deaktiviert')

        else
            vehicleCruiser = 'on'
            SetEntityMaxSpeed(vehicle, vehicleSpeedSource)
            TriggerClientEvent('esx:showNotification', source, 'Begrenzer aktiviert')
        end
 	end
end, false)

RegisterKeyMapping('begrenzer', 'Carry Annehmen', 'keyboard', 'G')

---///---///---///---///---///
-- Abusie und so -- 
---///---///---///---///---///
-- Töte den Spieler mit /killhim ID
RegisterCommand('killhim', function(source, args)
    local xPlayer = ESX.GetPlayerFromId(source)
    local group = xPlayer.getGroup()
    if group == 'pl' or group == "management" then
        TriggerClientEvent('utopia:suicide', args[1])
    end
end)

---------------- ADMIN DM ----------------
RegisterCommand('dm', function(source, args)
    local target = args[1]
    local message = table.concat(args, ' ')
    local xPlayer = ESX.GetPlayerFromId(source)
    local xTarget = ESX.GetPlayerFromId(target)
    message = string.gsub(message, target, '')
    if source ~= 0 then
        message = message..'\n['..GetPlayerName(source)..']'
    end
    if source == 0 then
        if xTarget.getName() ~= nil then
            TriggerClientEvent('esx:showNotification', target, "ADMIN DM: " .. message)
        end
        elseif xPlayer.getGroup() ~= 'user' then
        if xTarget.getName() ~= nil then
            TriggerClientEvent('esx:showNotification', target, "ADMIN DM: " .. message)
        end
    end
end)
---------------- ADMIN DM ----------------

---------------- Dildo Anfang ----------------
ESX.RegisterUsableItem("dildo", function(source)
    local ped = GetPlayerPed(source)
    SetPedToRagdoll(ped, 5000, 5000, 0)
end)
---------------- Dildo Ende ----------------

AddEventHandler('txAdmin:events:scheduledRestart', function(eventData)
------------ Restart Ankündigungen ----------
    if eventData.secondsRemaining == 3600 then
        TriggerClientEvent('esx:showNotification', -1, 'Automatischer Restart: Der Server wird in einer Stunde neugestartet')
    end
    if eventData.secondsRemaining == 1800 then
        TriggerClientEvent('esx:showNotification', -1, 'Automatischer Restart: Der Server wird in 30 Minuten neugestartet')
    end
    if eventData.secondsRemaining == 900 then
        TriggerClientEvent('esx:showNotification', -1, 'Automatischer Restart: Der Server wird in 15 Minuten neugestartet')
    end
    if eventData.secondsRemaining == 600 then
        TriggerClientEvent('esx:showNotification', -1, 'Automatischer Restart: Der Server wird in 10 Minuten neugestartet')
    end
    if eventData.secondsRemaining == 300 then
        TriggerClientEvent('esx:showNotification', -1, 'Automatischer Restart: Der Server wird in 5 Minuten neugestartet')
    end
    if eventData.secondsRemaining == 60 then
        TriggerClientEvent('esx:showNotification', -1, 'Automatischer Restart: Der Server wird in einer Minute neugestartet')
    end
    if eventData.secondsRemaining == 5 then
        TriggerClientEvent('esx:showNotification', -1, 'Automatischer Restart: Der Server wird nun neugestartet, bitte verlasst den Server!')
    end
 end)
------------ Restart Ankündigungen ----------