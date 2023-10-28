-- ESX DEFINE
CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj)
            ESX = obj
        end)
        Wait(0)
    end
end)
--///---///---///---///---///

-- /id
RegisterCommand("id", function(source, args, rawCommand)
    local playerPed = PlayerPedId()
    TriggerEvent("prime_notify", "info", "LIMITLESS | ID", "Deine ID: "..GetPlayerServerId(PlayerId()), 5000)
end)
-- /id

-- /ids
RegisterCommand("ids", function(source, args, rawCommand)
    local playerPed = PlayerPedId()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    if closestPlayer ~= -1 and closestDistance <= 3.0 then
    TriggerEvent("prime_notify", "info", "LIMITLESS | ID", "ID von Spieler in der Nähe: "..GetPlayerServerId(closestPlayer), 5000)
    else
        TriggerEvent("prime_notify", "error", "LIMITLESS | ID", "Keine Spieler in deiner Nähe", 4000)
    end
end)
-- /ids

-- /SUPPORT ID
RegisterNetEvent("lm_supportnotify:showsupport")
AddEventHandler("lm_supportnotify:showsupport", function(fivemname)
	ESX.Scaleform.ShowFreemodeMessage("~y~Nachricht vom Support", "~w~Bitte laufendes RP beenden und im Discord-Support einfinden! \n Gesendet von: ~r~" .. fivemname, 20)
end)
CreateThread(function()
	local sleep = 250
    while true do 
        SetPedConfigFlag(PlayerPedId(), 438, true)
        SetPedCanLosePropsOnDamage(PlayerPedId(), false, 0)
		Wait(sleep)
    end
end)
-- /SUPPORT ID

-- DRIFT MODE
local kmh, mph = 3.6, 2.23693629
local carSpeed = 0
local speed = kmh -- or mph
local speedLimit = 1000.0
local driftMode
local hasCooldown = false
local hasSecondCooldown = false
local wasDrifting = false
local shownNotify = false

CreateThread(function()
    while true do
        Wait(250)
        if not driftMode then
            if IsPedInAnyVehicle(PlayerPedId(), false) then
                carSpeed = GetEntitySpeed(GetVehiclePedIsIn(PlayerPedId())) * speed
                if GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId(), false), -1) == PlayerPedId() then
                    if (carSpeed <= speedLimit) then
                        if IsControlPressed(0, 21) then
                            if (not wasDrifting and not hasSecondCooldown) then
                                wasDrifting = true
                                SetVehicleReduceGrip(GetVehiclePedIsIn(PlayerPedId(), false), true)
                            elseif (hasSecondCooldown and not shownNotify) then
                                TriggerEvent('prime_notify', "info", "Driftmode", "Anti Spam Schutz!", 5000)
                                shownNotify = true
                                SetTimeout(1000, function()
                                    shownNotify = false
                                end)
                            end
                        else
                            if (wasDrifting) then
                                SetVehicleReduceGrip(GetVehiclePedIsIn(PlayerPedId(), false), false)
                                hasSecondCooldown = true
                                wasDrifting = false
                                SetTimeout(2000, function()
                                    hasSecondCooldown = false
                                end)
                            end
                        end
                    end
                end
            end
        end
    end
end)

RegisterCommand('driftmode', function()
    if (hasCooldown) then
		TriggerEvent('prime_notify', "info", "Driftmode", "Anti Spam Schutz!", 5000)
        return
    end

    hasCooldown = true
    SetTimeout(2000, function()
        hasCooldown = false
    end)
    if IsPedInAnyVehicle(PlayerPedId()) then
        if not driftMode then
            SetVehicleReduceGrip(GetVehiclePedIsIn(PlayerPedId(), false), true)
            driftMode = true
            TriggerEvent('prime_notify', "info", "Driftmode", "Driftmode aktiviert", 5000)
        else
            SetVehicleReduceGrip(GetVehiclePedIsIn(PlayerPedId(), false), false)
            driftMode = false
            TriggerEvent('prime_notify',"info", "Driftmode", "Driftmode deaktiviert", 5000)
        end
    end
end)
RegisterKeyMapping('driftmode', 'Driftmode aktivieren', 'keyboard', 'n')
-- DRIFT MODE

-- Beim Schießen kein Gezappel
CreateThread( function()
	while true do
	  Wait(500)
	  local ped = PlayerPedId()
	  if not GetPedConfigFlag(ped,78,1) then
		SetPedUsingActionMode(PlayerPedId(), false, -1, 0)
	  end
	end
end)
-- Beim Schießen kein Gezappel

-- HEADSHOT Setting
CreateThread(function()
	Wait(15000)
	while true do 
		Wait(0)
  
		if bodyShotActive then 
			SetPedSuffersCriticalHits(PlayerPedId(), false) -- DAS auf True bei Body ( JA MUSS AMK )
		else
			SetPedSuffersCriticalHits(PlayerPedId(), true) -- DAS auf false bei Body ( JA MUSS AMK )
			Wait(500)
		end
	end
end)
-- HEADSHOT Setting

-- HUD COLOUR
CreateThread(function()
    ReplaceHudColour(116, 9)
end)
-- HUD COLOUR

-- KEIN HELM AUF MOTORRAD ANFANG
CreateThread( function()
    while true do Wait(100)	
      SetPedConfigFlag(PlayerPedId(), 35, false)
    end
end)
-- KEIN HELM AUF MOTORRADENDE

--HARDCAP CUSTOM--
CreateThread(function()
	while true do
		Wait(0)

		if NetworkIsSessionStarted() then
			TriggerServerEvent('hardcap:playerActivated')

			return
		end
	end
end)
--HARDCAP CUSTOM--

--Basic-Gamemode--
AddEventHandler('onClientMapStart', function()
	exports.spawnmanager:setAutoSpawn(true)
	exports.spawnmanager:forceRespawn()
end)
--Basic-Gamemode--

-- NO NPC
CreateThread(function()
    while true do
        Wait(0)
		-- Stop Spawn
		SetCreateRandomCops(false)
		SetCreateRandomCopsNotOnScenarios(false)
		SetCreateRandomCopsOnScenarios(false)
		SetGarbageTrucks(false)
		SetRandomBoats(false)
       	SetVehicleDensityMultiplierThisFrame(0.0)
       	SetPedDensityMultiplierThisFrame(0.0)
		SetRandomVehicleDensityMultiplierThisFrame(0.0)
		SetScenarioPedDensityMultiplierThisFrame(0.0, 0.0)
		SetParkedVehicleDensityMultiplierThisFrame(0.0)

		-- Clear NPC
		local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
		ClearAreaOfVehicles(x, y, z, 1000, false, false, false, false, false)
		RemoveVehiclesFromGeneratorsInArea(x - 500.0, y - 500.0, z - 500.0, x + 500.0, y + 500.0, z + 500.0);
    end
end)
-- NO NPC 

-- STAMINA ( Unendlich Laufen GOIIIL)
-- CreateThread(function()
--     while true do
--       RestorePlayerStamina(PlayerId(), 0.3)
--       Wait(1000) 
--     end
--   end)
-- STAMINA ( Unendlich Laufen GOIIIL)

-- Autopilot EVENTUELL FIXXEN MIT GUTEM DEVV
local autodrive = false
local RideStarted = false
local Parking = false
local WaypointBlip = GetFirstBlipInfoId(8)
local DestinationCoord = vector3(0.0, 0.0, 0.0)

RegisterNetEvent('worky:toggle', function(state)
    autodrive = state
end)

function DriveToCoord(x, y)
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)
    local el_x = x
    local el_y = y
    local z = 20.0
    local stopRange = 8.0
    local speed = 150.0
    local drivingStyle = 0
    SetDriverAbility(ped, 1.0)
    SetDriverAggressiveness(ped, 0.0)
    TaskVehicleDriveToCoordLongrange(ped, vehicle, el_x, el_y, z, speed, drivingStyle, stopRange)
    DestinationCoord = vector3(el_x, el_y, 20.0)
end

function GetWaypointCoords()
    local WaypointBlip = GetFirstBlipInfoId(8)
    local blipX, blipY = 0.0, 0.0
    if WaypointBlip == 0 then
        WaypointBlip = GetFirstBlipInfoId(8)
        return nil, nil
    end
    WaypointBlip = GetFirstBlipInfoId(8)
    if WaypointBlip ~= 0 then
        local BlipCoords = GetBlipCoords(WaypointBlip)
        blipX = BlipCoords.x
        blipY = BlipCoords.y
        return blipX, blipY
    end
end

function DrawMidText(msg)
    SetTextFont(7)
    SetTextScale(0.0, 0.5)
    SetTextColour(255, 255, 255, 255)
    SetTextOutline()
    SetTextCentre(true)
    BeginTextCommandDisplayText('STRING')
    AddTextComponentSubstringPlayerName(msg)
    EndTextCommandDisplayText(0.5, 0.95)
end

function Kekwtext(msg)
    SetTextFont(4)
    SetTextScale(0.0, 0.5)
    SetTextColour(255, 255, 255, 255)
    SetTextOutline()
    SetTextCentre(true)
    BeginTextCommandDisplayText('STRING')
    AddTextComponentSubstringPlayerName(msg)
    EndTextCommandDisplayText(0.5, 0.95)
end

function DisableDriving()
    DisableControlAction(0, 63, true)
    DisableControlAction(0, 64, true)
    DisableControlAction(0, 71, true)
    DisableControlAction(0, 72, true)
    DisableControlAction(0, 77, true)
    DisableControlAction(0, 78, true)
end

CreateThread(function()
    while true do
        Wait(0)
        if autodrive then
            if IsPedInAnyVehicle(PlayerPedId(), false) and GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId(), false), -1) == PlayerPedId() then
                DisableDriving()
                local WaypointX, WaypointY = GetWaypointCoords()
                if WaypointX == nil then
                    Kekwtext('[~b~LIMITLESS~y~ Autopilot~s~] Bitte setze dein Ziel!')
                end
                if WaypointX ~= nil and WaypointY ~= nil then
                    if not RideStarted then
                        RideStarted = true
                        DriveToCoord(WaypointX, WaypointY)
                    end
                end
                if RideStarted then
                    if WaypointX == nil then
                        if GetEntitySpeed(GetVehiclePedIsIn(PlayerPedId(), false)) >= 1.75 then
                            ClearPedTasks(PlayerPedId())
                            Parking = false
                            RideStarted = false
                        end
                    end
                    Kekwtext('[~b~LIMITLESS~y~ Autopilot~s~] Fahre zum Wegpunkt!')
                    if #(GetEntityCoords(PlayerPedId()) - DestinationCoord) <= 75.0 then
                        if not Parking then
                            RideStarted = false
                            Wait(750)
                            Parking = true
                            Wait(750)
                            ClearPedTasks(PlayerPedId())
                            Wait(750)
                            Parking = false
                        end
                    end
                end
            else
                RideStarted = false
            end
        else
            Wait(2500)
        end
    end
end)
-- Autopilot ENDE

-- RCONLOG
RegisterNetEvent('rlUpdateNames')

AddEventHandler('rlUpdateNames', function()
    local names = {}

    for i = 0, 31 do
        if NetworkIsPlayerActive(i) then
            names[GetPlayerServerId(i)] = { id = i, name = GetPlayerName(i) }
        end
    end

    TriggerServerEvent('rlUpdateNamesResult', names)
end)

CreateThread(function()
	while true do
		Wait(0)

		if NetworkIsSessionStarted() then
			TriggerServerEvent('rlPlayerActivated')

			return
		end
	end
end)
-- RCONLOG

-- Realtime Anfang
SetMillisecondsPerGameMinute(60000)
RegisterNetEvent("realtime:event")
AddEventHandler("realtime:event", function(h, m, s)
	NetworkOverrideClockTime(h, m, s)
end)
TriggerServerEvent("realtime:event")
-- Realtime Ende

-- Disable Combat Roll
CreateThread(function()
	while true do
		Wait(0)
		if IsPedArmed(GetPlayerPed(-1), 4 | 2) and IsControlPressed(0, 25) then
			DisableControlAction(0, 22, true)
		end
	end
end)
-- Disable Combat Roll
