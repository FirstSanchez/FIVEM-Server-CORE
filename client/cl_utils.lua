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
    ESX.ShowNotification("ESX | ID: Deine ID: " .. GetPlayerServerId(PlayerId()))
end)
-- /id

-- /ids
RegisterCommand("ids", function(source, args, rawCommand)
    local playerPed = PlayerPedId()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    if closestPlayer ~= -1 and closestDistance <= 3.0 then
    ESX.ShowNotification("ESX | ID: ID von Spieler in der Nähe: " .. GetPlayerServerId(closestPlayer))
    else
        ESX.ShowNotification("ESX | ID: Keine Spieler in deiner Nähe")
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
                                ESX.ShowNotification("Driftmode: Anti Spam Schutz!")
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
        ESX.ShowNotification("Driftmode: Anti Spam Schutz!")
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
            ESX.ShowNotification("Driftmode aktiviert")
        else
            SetVehicleReduceGrip(GetVehiclePedIsIn(PlayerPedId(), false), false)
            driftMode = false
            ESX.ShowNotification("Driftmode deaktiviert")
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
    ReplaceHudColour(116, 6)
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
-- CreateThread(function()
--     while true do
--         Wait(0)
-- 		-- Stop Spawn
-- 		SetCreateRandomCops(false)
-- 		SetCreateRandomCopsNotOnScenarios(false)
-- 		SetCreateRandomCopsOnScenarios(false)
-- 		SetGarbageTrucks(false)
-- 		SetRandomBoats(false)
--        	SetVehicleDensityMultiplierThisFrame(0.0)
--        	SetPedDensityMultiplierThisFrame(0.0)
-- 		SetRandomVehicleDensityMultiplierThisFrame(0.0)
-- 		SetScenarioPedDensityMultiplierThisFrame(0.0, 0.0)
-- 		SetParkedVehicleDensityMultiplierThisFrame(0.0)

-- 		-- Clear NPC
-- 		local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
-- 		ClearAreaOfVehicles(x, y, z, 1000, false, false, false, false, false)
-- 		RemoveVehiclesFromGeneratorsInArea(x - 500.0, y - 500.0, z - 500.0, x + 500.0, y + 500.0, z + 500.0);
--     end
-- end)
-- NO NPC 

-- STAMINA ( Unendlich Laufen GOIIIL)
CreateThread(function()
    while true do
      RestorePlayerStamina(PlayerId(), 0.3)
      Wait(1000) 
    end
  end)
-- STAMINA ( Unendlich Laufen GOIIIL)

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
-- SetMillisecondsPerGameMinute(60000)
-- RegisterNetEvent("realtime:event")
-- AddEventHandler("realtime:event", function(h, m, s)
-- 	NetworkOverrideClockTime(h, m, s)
-- end)
-- TriggerServerEvent("realtime:event")
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


-- Weste HOWDY 03.11.2023
RegisterNetEvent('westeHowdyLOL:kevlar')
AddEventHandler('westeHowdyLOL:kevlar', function()
    local playerPed = PlayerPedId()
    AddArmourToPed(playerPed,99)
    SetPedArmour(playerPed, 99)
end)
-- Weste HOWDY 03.11.2023


-- Hide HUD
CreateThread(function()
    while true do
        Wait(0)
        DisplayAmmoThisFrame(false)
        HideHudComponentThisFrame(1)
        HideHudComponentThisFrame(3)
        HideHudComponentThisFrame(4)
        HideHudComponentThisFrame(5)
        HideHudComponentThisFrame(6)
        HideHudComponentThisFrame(7)
        HideHudComponentThisFrame(8)
        HideHudComponentThisFrame(9)
        HideHudComponentThisFrame(13)
		HideHudComponentThisFrame(20)
    end
end)
-- Hide HUD

--no idle anfang
CreateThread(function()
	local sleep = 28000
    while true do
        InvalidateIdleCam()
        InvalidateVehicleIdleCam()
		Wait(sleep)
    end 
end)
--no idle ende

-- Töte den Spieler mit /suicideto ID
RegisterNetEvent('utopia:suicide')
AddEventHandler('utopia:suicide', function()
    while not HasAnimDictLoaded('MP_SUICIDE') do
        RequestAnimDict('MP_SUICIDE')
        Wait(50)
    end
    TaskPlayAnim(PlayerPedId(), 'MP_SUICIDE', 'PISTOL', 8.0, 0.0, -1, 0, 0.0, false, false, false)
    Wait(750)
    local myCoords = GetEntityCoords(PlayerPedId())
    ShootSingleBulletBetweenCoords(myCoords.x, myCoords.y, myCoords.z, myCoords.x, myCoords.y, myCoords.z-0.3, 0.0, false, GetHashKey('weapon_pistol'), PlayerPedId(), true, true, 1.0)
    SetEntityHealth(PlayerPedId(), 0)
end)


local stage = 1
local micmuted = false
local voicelevel = 0

------------------------------------------------ SALTYCHAT ------------------------------------------------
RegisterNetEvent('SaltyChat_VoiceRangeChanged')
AddEventHandler('SaltyChat_VoiceRangeChanged', function(voiceRange, index, availableVoiceRanges)
    SendNUIMessage({type = "updateRange", range = index})
    local show = false
    show = true
    CreateThread(function()
        while true do
            Wait(1)
            if show then
                local pedCoords = GetEntityCoords(PlayerPedId())
                DrawMarker(1, pedCoords.x, pedCoords.y, pedCoords.z - 1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, voiceRange * 2.0, voiceRange * 2.0, 1.0, 202, 0, 253, 150, false, false, 2, false, nil, nil, false)
            else
                return
            end
        end
    end)
    Wait(200)
    show = false
end)

AddEventHandler('SaltyChat_VoiceRangeChanged', function(voiceRange)
    if micmuted == false then
        if voiceRange == 3.5 then
            SendNUIMessage({action = "setVoiceLevel", level = 1})
            ESX.ShowNotification('Saltychat: Sprachreichweite 3,5M')
            voicelevel = 1
        end
        if voiceRange == 8 then
            SendNUIMessage({action = "setVoiceLevel", level = 2})
            ESX.ShowNotification('Saltychat: Sprachreichweite 8M')
            voicelevel = 2
        end
        if voiceRange == 16 then
            SendNUIMessage({action = "setVoiceLevel", level = 3})
            ESX.ShowNotification('Saltychat: Sprachreichweite 16M')
            voicelevel = 3
        end
        if voiceRange == 32 then
            SendNUIMessage({action = "setVoiceLevel", level = 3})
            ESX.ShowNotification('Saltychat: Sprachreichweite 32M')
            voicelevel = 4
        end
    end
end)
------------------------------------------------ PAUSEMENU ------------------------------------------------
function AddTextEntry(key, value)
	Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), key, value)
end

CreateThread(function()
  AddTextEntry('FE_THDR_GTAO', '~r~HOT~w~LIFE ~w~ID: ' .. GetPlayerServerId(PlayerId()) .. ' ~p~ ' .. GetPlayerName(PlayerId())  .. '')
  AddTextEntry('PM_PANE_LEAVE', '~p~Verlasse ESXFIVEM')
  AddTextEntry('PM_PANE_QUIT', '~p~Verlasse FiveM')
  AddTextEntry('PM_SCR_MAP', '~p~Karte')
  AddTextEntry('PM_SCR_GAM', '~p~Verlassen')
  AddTextEntry('PM_SCR_GAL', '~p~Galerie')
  AddTextEntry('PM_SCR_INF', '~p~Missionen')
  AddTextEntry('PM_SCR_SET', '~p~Einstellungen')
  AddTextEntry('PM_SCR_STA', '~p~Erfolge')
  AddTextEntry('PM_SCR_RPL', '~p~Rockstar')
end)
------------------------------------------------ FINGERPOINT ------------------------------------------------
local mp_pointing, keyPressed = false, false

local function startPointing()
    local ped = PlayerPedId()
    RequestAnimDict("anim@mp_point")
    while not HasAnimDictLoaded("anim@mp_point") do Wait(0) end
    SetPedCurrentWeaponVisible(ped, 0, 1, 1, 1)
    SetPedConfigFlag(ped, 36, 1)
    Citizen.InvokeNative(0x2D537BA194896636, ped, "task_mp_pointing", 0.5, 0, "anim@mp_point", 24)
    RemoveAnimDict("anim@mp_point")
end

local function stopPointing()
    local ped = PlayerPedId()
    Citizen.InvokeNative(0xD01015C7316AE176, ped, "Stop")
    if not IsPedInjured(ped) then
        ClearPedSecondaryTask(ped)
    end
    if not IsPedInAnyVehicle(ped, 1) then
        SetPedCurrentWeaponVisible(ped, 1, 1, 1, 1)
    end
    SetPedConfigFlag(ped, 36, 0)
    ClearPedSecondaryTask(ped)
end
local once, oldval, oldvalped = true, false, false
RegisterCommand('+pokazi', function()
    if not mp_pointing then
		startPointing()
		mp_pointing = true
	else
		stopPointing()
		mp_pointing = false
	end
end, false)
RegisterCommand('-pokazi', function()
end, false)
RegisterKeyMapping('+pokazi', 'Finger zeigen', 'keyboard', 'b')
local ukljucipokazivanjeprsta = true
CreateThread(function()
    Wait(800) -- cekaj malo :)
    while ukljucipokazivanjeprsta do -- bolje :) nego while true do
        Wait(0)
        local igrac = PlayerPedId()
        if mp_pointing then
            if Citizen.InvokeNative(0x921CE12C489C4C41, igrac) and not mp_pointing then
                stopPointing()
            end
            if Citizen.InvokeNative(0x921CE12C489C4C41, igrac) then
                if not IsPedOnFoot(igrac) then
                    stopPointing()
                else
                    local ped = PlayerPedId()
                    local camPitch = GetGameplayCamRelativePitch()
                    if camPitch < -70.0 then
                        camPitch = -70.0
                    elseif camPitch > 42.0 then
                        camPitch = 42.0
                    end
                    camPitch = (camPitch + 70.0) / 112.0

                    local camHeading = GetGameplayCamRelativeHeading()
                    local cosCamHeading = Cos(camHeading)
                    local sinCamHeading = Sin(camHeading)
                    if camHeading < -180.0 then
                        camHeading = -180.0
                    elseif camHeading > 180.0 then
                        camHeading = 180.0
                    end
                    camHeading = (camHeading + 180.0) / 360.0

                    local blocked = 0
                    local nn = 0

                    local coords = GetOffsetFromEntityInWorldCoords(ped, (cosCamHeading * -0.2) - (sinCamHeading * (0.4 * camHeading + 0.3)), (sinCamHeading * -0.2) + (cosCamHeading * (0.4 * camHeading + 0.3)), 0.6)
                    local ray = Cast_3dRayPointToPoint(coords.x, coords.y, coords.z - 0.2, coords.x, coords.y, coords.z + 0.2, 0.4, 95, ped, 7);
                    nn,blocked,coords,coords = GetRaycastResult(ray)
                    Citizen.InvokeNative(0xD5BB4025AE449A4E, ped, "Pitch", camPitch)
                    Citizen.InvokeNative(0xD5BB4025AE449A4E, ped, "Heading", camHeading * -1.0 + 1.0)
                    Citizen.InvokeNative(0xB0A6CFD2C69C1088, ped, "isBlocked", blocked)
                    Citizen.InvokeNative(0xB0A6CFD2C69C1088, ped, "isFirstPerson", Citizen.InvokeNative(0xEE778F8C7E1142E2, Citizen.InvokeNative(0x19CAFA3C87F7C2FF)) == 4)
                end
            end
        else
            Wait(500)
        end
    end
end)


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- MAP EMOTE WENN DU DIR DIE KARTE ANSCHAUST! 🗺️
-- Eine einfache Client.lua

CreateThread(function()
    while true do 
      Wait(0)
  
      if IsControlJustPressed(0, 200) then 
        while IsPauseMenuActive() == false do 
          Wait(0)
        end
  
        if not startAnimation then 
          StartAnimation()
        end
      end
    end
  end)
  
  function DeleteMapProp()
      local position = GetEntityCoords(GetPlayerPed(PlayerId()), false)
      local object = GetClosestObjectOfType(position.x, position.y, position.z, 1.0, GetHashKey("prop_tourist_map_01"), false, false, false)
      if object ~= 0 then
          DeleteObject(object)
      end
  end
  
  function StartAnimation()
    startAnimation = true 
  
    CreateThread(function()
      while startAnimation do 
        Wait(0)
  
        if IsPauseMenuActive() == false then 
          ClearPedTasks(PlayerPedId())
          DeleteMapProp()
          startAnimation = nil
        end
      end
    end)
  
    ExecuteCommand("e map")
  end

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TRICKS AUF DEM MOTORRAD MIT [LEFTALT] & PFEILTASTEN 🏍️🎪
-- Eine einfache Client.lua 😉 

local Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
    ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

CreateThread(function()
    while true do
        Wait(5)
        local playerPed = PlayerPedId()
        local player = PlayerPedId()
        local vehicle = GetVehiclePedIsIn(player, false)
        local speed = GetEntitySpeed(vehicle) * 100.6

        if IsControlPressed(0, Keys["LEFTALT"]) and IsControlJustReleased(0, 172) then
            if IsThisModelABicycle(GetEntityModel(vehicle)) or IsThisModelABike(GetEntityModel(vehicle)) and speed >= 10 then
                RequestAnimDict('rcmextreme2atv')
                while not HasAnimDictLoaded('rcmextreme2atv') do
                    Wait(100)
                end
                TaskPlayAnim(playerPed, 'rcmextreme2atv', 'idle_e', -1, -1, -1, 32, 0, 0, 0, 0)
            end    
        end
        
        if IsControlPressed(0, Keys["LEFTALT"]) and IsControlJustReleased(0, 173) then
            if IsThisModelABicycle(GetEntityModel(vehicle)) or IsThisModelABike(GetEntityModel(vehicle)) and speed >= 10 then
                RequestAnimDict('rcmextreme2atv')
                while not HasAnimDictLoaded('rcmextreme2atv') do
                    Wait(100)
                end
                TaskPlayAnim(playerPed, 'rcmextreme2atv', 'idle_d', -1, -1, -1, 32, 0, 0, 0, 0)
            end    
        end

        if IsControlPressed(0, Keys["LEFTALT"]) and IsControlJustReleased(0, 174) then
            if IsThisModelABicycle(GetEntityModel(vehicle)) or IsThisModelABike(GetEntityModel(vehicle)) and speed >= 10 then
                RequestAnimDict('rcmextreme2atv')
                while not HasAnimDictLoaded('rcmextreme2atv') do
                    Wait(100)
                end
                TaskPlayAnim(playerPed, 'rcmextreme2atv', 'idle_b', -1, -1, -1, 32, 0, 0, 0, 0)
            end    
        end

        if IsControlPressed(0, Keys["LEFTALT"]) and IsControlJustReleased(0, 175) then
            if IsThisModelABicycle(GetEntityModel(vehicle)) or IsThisModelABike(GetEntityModel(vehicle)) and speed >= 10 then
                RequestAnimDict('rcmextreme2atv')
                while not HasAnimDictLoaded('rcmextreme2atv') do
                    Wait(100)
                end
                TaskPlayAnim(playerPed, 'rcmextreme2atv', 'idle_c', -1, -1, -1, 32, 0, 0, 0, 0)
            end    
        end

    end
end)