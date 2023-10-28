-- BELOVE IS YOUR SETTINGS, CHANGE THEM TO WHATEVER YOU'D LIKE & MORE SETTINGS WILL COME IN THE FUTURE! --
local useCameraSound = true -- OPTIONS: (true/false)
local useFlashingScreen = true -- OPTIONS: (true/false)
local useBlips = true -- OPTIONS: (true/false)
local alertPolice = false -- OPTIONS: (true/false)
local alertSpeed = 200 -- OPTIONS: (1-5000 KMH)

local defaultPrice60 = 200 -- THIS IS THE DEFAULT PRICE WITHOUT EXTRA COST FOR 60 ZONES
local defaultPrice80 = 1500 -- THIS IS THE DEFAULT PRICE WITHOUT EXTRA COST FOR 80 ZONES
local defaultPrice120 = 2000 -- THIS IS THE DEFAULT PRICE WITHOUT EXTRA COST FOR 120 ZONES

local extraZonePrice10 = 400 -- THIS IS THE EXTRA COST IF 10 KM/H ABOVE LIMIT (REQUIRES "useBilling" to be set to true)
local extraZonePrice20 = 1000 -- THIS IS THE EXTRA COST IF 20 KM/H ABOVE LIMIT (REQUIRES "useBilling" to be set to true)
local extraZonePrice30 = 2500 -- THIS IS THE EXTRA COST IF 30 KM/H ABOVE LIMIT (REQUIRES "useBilling" to be set to true)
-- ABOVE IS YOUR SETTINGS, CHANGE THEM TO WHATEVER YOU'D LIKE & MORE SETTINGS WILL COME IN THE FUTURE!  --

local TheWhitelistedVehicles = {
	"" -- POLICE CARS EINFÜGEN LAAAAN | HOWDY #1
}

ESX = nil
local hasBeenCaught = false
local finalBillingPrice = 0;

CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Wait(0)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

function hintToDisplay(text)
	SetTextComponentFormat("STRING")
	AddTextComponentString(text)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

-- BLIP FOR SPEEDCAMERAS
local blips = {
	-- 60KM/H ZONES
	{title="Blitzer (60KM/H)", colour=3, id=1, x = -524.2645, y = -1776.3569, z = 21.3384}, -- 60KM/H ZONE
	{title="Blitzer (60KM/H)", colour=3, id=1, x = 399.51, y = -988.51, z = 29.09}, -- 60KM/H ZONE
	{title="Blitzer (60KM/H)", colour=3, id=1, x = -322.49, y = -395.12, z = 30.43}, -- 60KM/H ZONE

	-- 80KM/H ZONES
	{title="Blitzer (80KM/H)", colour=3, id=1, x = 2506.0671, y = 4145.2431, z = 38.1054}, -- 80KM/H ZONE
	{title="Blitzer (80KM/H)", colour=3, id=1, x = 1258.2006, y = 789.4199, z = 104.2190}, -- 80KM/H ZONE
	{title="Blitzer (80KM/H)", colour=3, id=1, x = 980.9982, y = 407.4164, z = 92.2374}, -- 80KM/H ZONE
	{title="Blitzer (80KM/H)", colour=3, id=1, x = 45.84, y = -236.27, z = 49.62}, -- 80KM/H ZONE

	
	-- 120KM/H ZONES
	{title="Blitzer (120KM/H)", colour=3, id=1, x = 1584.9281, y = -993.4557, z = 59.3923}, -- 120KM/H ZONE
	{title="Blitzer (120KM/H)", colour=3, id=1, x = 2442.2006, y = -134.6004, z = 88.7765}, -- 120KM/H ZONE
	{title="Blitzer (120KM/H)", colour=3, id=1, x = 2871.7951, y = 3540.5795, z = 53.0930}, -- 120KM/H ZONE
	{title="Blitzer (120KM/H)", colour=3, id=1, x = 174.35, y = -825.15, z = 31.17}, -- 120KM/H ZONE
	{title="Blitzer (120KM/H)", colour=3, id=1, x = 289.5, y = -858.2, z = 28.9}, -- 120KM/H ZONE
	{title="Blitzer (120KM/H)", colour=3, id=1, x = 223.14, y = -1040.9, z = 29.02}, -- 120KM/H ZONE
	{title="Blitzer (120KM/H)", colour=3, id=1, x = 109.52, y = -1000.05, z = 29.05}, -- 120KM/H ZONE
	
        }

CreateThread(function()
	for _, info in pairs(blips) do
		if useBlips == true then
			info.blip = AddBlipForCoord(info.x, info.y, info.z)
			SetBlipSprite(info.blip, info.id)
			SetBlipDisplay(info.blip, 4)
			SetBlipScale(info.blip, 0.5)
			SetBlipColour(info.blip, info.colour)
			SetBlipAsShortRange(info.blip, true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(info.title)
			EndTextCommandSetBlipName(info.blip)
		end
	end
end)

-- AREAS
local Speedcamera60Zone = {
    {x = -524.2645,y = -1776.3569,z = 21.3384},
	{x = 399.34,y = -988.51,z = 29.09}
}

local Speedcamera80Zone = {
    {x = 2506.0671,y = 4145.2431,z = 38.1054},
    {x = 1258.2006,y = 789.4199,z = 103.2190},
    {x = 980.9982,y = 407.4164,z = 92.2374},
	
}

local Speedcamera120Zone = {
    {x = 1584.9281,y = -993.4557,z = 59.3923},
    {x = 2442.2006,y = -134.6004,z = 88.7765},
    {x = 2871.7951,y = 3540.5795,z = 53.0930},
	{x = 178.89,y = -817.69,z = 31.17},
	{x = 289.5,y = -858.2,z = 28.9},
	{x = 223.14,y = -1040.9,z = 29.02},
	{x = 109.52,y = -1000.05,z = 29.05}
}

-- ZONES
CreateThread(function()
    while true do
        Wait(500)

		local canSleep = true

		-- 60 zone
        for k in pairs(Speedcamera60Zone) do
            local plyCoords = GetEntityCoords(PlayerPedId(), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, Speedcamera60Zone[k].x, Speedcamera60Zone[k].y, Speedcamera60Zone[k].z)

            if dist <= 20.0 then
				canSleep = false
				local playerPed = PlayerPedId()
				local playerCar = GetVehiclePedIsIn(playerPed, false)
				local veh = GetVehiclePedIsIn(playerPed)
				local SpeedKM = GetEntitySpeed(playerPed)*3.6
				local maxSpeed = 65.0 -- THIS IS THE MAX SPEED IN KM/H
				
				if SpeedKM > maxSpeed then
					if IsPedInAnyVehicle(playerPed, false) then
						if (GetPedInVehicleSeat(playerCar, -1) == playerPed) then
							if hasBeenCaught == false then
								local whitelisted = false
								for k,v in pairs(TheWhitelistedVehicles) do
									if GetEntityModel(veh) == GetHashKey(v) then
										whitelisted = true
									end
								end
								if whitelisted then
								elseif GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "POLICE" then -- BLACKLISTED VEHICLE
								elseif GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "POLICE2" then -- BLACKLISTED VEHICLE
								elseif GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "POLICE4" then -- BLACKLISTED VEHICLE
								elseif GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "POLICEB" then -- BLACKLISTED VEHICLE
								elseif GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "SHERIFF" then -- BLACKLISTED VEHICLE
								elseif GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "FIRETRUK" then -- BLACKLISTED VEHICLE
								elseif GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "AMBULAN" then -- BLACKLISTED VEHICLE
                                                                elseif GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "AMBULANCE" then -- BLACKLISTED VEHICLE
                                                                elseif GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "MARKED_BMWm7_3" then -- BLACKLISTED VEHICLE
																elseif GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "MARKED_Cadillac" then -- BLACKLISTED VEHICLE
								-- VEHICLES ABOVE ARE BLACKLISTED
								else
									-- ALERT POLICE (START)
									if alertPolice == true then
										if SpeedKM > alertSpeed then
											local x,y,z = table.unpack(GetEntityCoords(PlayerPedId(), false))
											TriggerServerEvent('esx_phone:send', 'police', ' Jemand ist am Blitzer vorbeigefahren ' .. alertSpeed.. ' KMH', true, {x =x, y =y, z =z})
										end
									end
									-- ALERT POLICE (END)								
								
									-- FLASHING EFFECT (START)
									if useFlashingScreen == true then
										TriggerServerEvent('esx_speedcamera:openGUI')
									end
									
									if useCameraSound == true then
										TriggerServerEvent("InteractSound_SV:PlayOnSource", "speedcamera", 0.5)
									end
									
									if useFlashingScreen == true then
										Wait(200)
										TriggerServerEvent('esx_speedcamera:closeGUI')
									end
									-- FLASHING EFFECT (END)								
									
									TriggerEvent('prime_notify', "info", "LIMITLESS | Blitzer", "Du hast eine Rechnung bezahlt! Du bist " .. math.floor(SpeedKM) .. " KM/H zu schnell gefahren!",5000)
									TriggerServerEvent('esx_speedcamera:PayBill60Zone')
										
									hasBeenCaught = true
									Wait(5000) -- This is here to make sure the player won't get fined over and over again by the same camera!
								end
							end
						end
					end
					
					hasBeenCaught = false
				end
            end
        end
		
		-- 80 zone
		for k in pairs(Speedcamera80Zone) do
            local plyCoords = GetEntityCoords(PlayerPedId(), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, Speedcamera80Zone[k].x, Speedcamera80Zone[k].y, Speedcamera80Zone[k].z)

            if dist <= 20.0 then
				canSleep = false
				local playerPed = PlayerPedId()
				local playerCar = GetVehiclePedIsIn(playerPed, false)
				local veh = GetVehiclePedIsIn(playerPed)
				local SpeedKM = GetEntitySpeed(playerPed)*3.6
				local maxSpeed = 85.0 -- THIS IS THE MAX SPEED IN KM/H
				
				if SpeedKM > maxSpeed then
					if IsPedInAnyVehicle(playerPed, false) then
						if (GetPedInVehicleSeat(playerCar, -1) == playerPed) then					
							if hasBeenCaught == false then
								local whitelisted = false
								for k,v in pairs(TheWhitelistedVehicles) do
									if GetEntityModel(veh) == GetHashKey(v) then
										whitelisted = true
									end
								end
								if whitelisted then
								elseif GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "POLICE" then -- BLACKLISTED VEHICLE
								elseif GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "POLICE2" then -- BLACKLISTED VEHICLE
								elseif GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "POLICE3" then -- BLACKLISTED VEHICLE
								elseif GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "POLICE4" then -- BLACKLISTED VEHICLE
								elseif GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "POLICEB" then -- BLACKLISTED VEHICLE
								elseif GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "POLICET" then -- BLACKLISTED VEHICLE
								elseif GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "FIRETRUK" then -- BLACKLISTED VEHICLE
								elseif GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "AMBULAN" then -- BLACKLISTED VEHICLE
								-- VEHICLES ABOVE ARE BLACKLISTED
								else
									-- ALERT POLICE (START)
									if alertPolice == true then
										if SpeedKM > alertSpeed then
											local x,y,z = table.unpack(GetEntityCoords(PlayerPedId(), false))
											TriggerServerEvent('esx_phone:send', 'police', ' Someone passed the speed camera, above ' .. alertSpeed.. ' KMH', true, {x =x, y =y, z =z})
										end
									end
									-- ALERT POLICE (END)								
								
									-- FLASHING EFFECT (START)
									if useFlashingScreen == true then
										TriggerServerEvent('esx_speedcamera:openGUI')
									end
									
									if useCameraSound == true then
										TriggerServerEvent("InteractSound_SV:PlayOnSource", "speedcamera", 0.5)
									end
									
									if useFlashingScreen == true then
										Wait(200)
										TriggerServerEvent('esx_speedcamera:closeGUI')
									end
									-- FLASHING EFFECT (END)								
								
									TriggerEvent('prime_notify', "info", "LIMITLESS | Blitzer", "Du hast eine Rechnung bezahlt! Du bist " .. math.floor(SpeedKM) .. " KM/H zu schnell gefahren!",5000)				
									
									TriggerServerEvent('esx_speedcamera:PayBill80Zone')
										
									hasBeenCaught = true
									Wait(5000) -- This is here to make sure the player won't get fined over and over again by the same camera!
								end
							end
						end
					end
					
					hasBeenCaught = false
				end
            end
        end
		
		-- 120 zone
		for k in pairs(Speedcamera120Zone) do
            local plyCoords = GetEntityCoords(PlayerPedId(), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, Speedcamera120Zone[k].x, Speedcamera120Zone[k].y, Speedcamera120Zone[k].z)

            if dist <= 20.0 then
				canSleep = false
				local playerPed = PlayerPedId()
				local playerCar = GetVehiclePedIsIn(playerPed, false)
				local veh = GetVehiclePedIsIn(playerPed)
				local SpeedKM = GetEntitySpeed(playerPed)*3.6
				local maxSpeed = 125.0 -- THIS IS THE MAX SPEED IN KM/H
				
				if SpeedKM > maxSpeed then
					if IsPedInAnyVehicle(playerPed, false) then
						if (GetPedInVehicleSeat(playerCar, -1) == playerPed) then 
							if hasBeenCaught == false then
								local whitelisted = false
								for k,v in pairs(TheWhitelistedVehicles) do
									if GetEntityModel(veh) == GetHashKey(v) then
										whitelisted = true
									end
								end
								if whitelisted then
								elseif GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "POLICE" then -- BLACKLISTED VEHICLE
								elseif GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "POLICE2" then -- BLACKLISTED VEHICLE
								elseif GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "POLICE3" then -- BLACKLISTED VEHICLE
								elseif GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "POLICE4" then -- BLACKLISTED VEHICLE
								elseif GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "POLICEB" then -- BLACKLISTED VEHICLE
								elseif GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "POLICET" then -- BLACKLISTED VEHICLE
								elseif GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "FIRETRUK" then -- BLACKLISTED VEHICLE
								elseif GetDisplayNameFromVehicleModel(GetEntityModel(veh)) == "AMBULAN" then -- BLACKLISTED VEHICLE
								-- VEHICLES ABOVE ARE BLACKLISTED
								else
									-- ALERT POLICE (START)
									if alertPolice == true then
										if SpeedKM > alertSpeed then
											local x,y,z = table.unpack(GetEntityCoords(PlayerPedId(), false))
											TriggerServerEvent('esx_phone:send', 'police', ' Someone passed the speed camera, above ' .. alertSpeed.. ' KMH', true, {x =x, y =y, z =z})
										end
									end
									-- ALERT POLICE (END)
								
									-- FLASHING EFFECT (START)
									if useFlashingScreen == true then
										TriggerServerEvent('esx_speedcamera:openGUI')
									end
									
									if useCameraSound == true then
										TriggerServerEvent("InteractSound_SV:PlayOnSource", "speedcamera", 0.5)
									end
									
									if useFlashingScreen == true then
										Wait(200)
										TriggerServerEvent('esx_speedcamera:closeGUI')
									end
									-- FLASHING EFFECT (END)
								
									TriggerEvent('prime_notify', "info", "LIMITLESS | Blitzer", "Du hast eine Rechnung bezahlt! Du bist " .. math.floor(SpeedKM) .. " KM/H zu schnell gefahren!",5000)							
									

										TriggerServerEvent('esx_speedcamera:PayBill120Zone')
										
									hasBeenCaught = true
									Wait(5000) -- This is here to make sure the player won't get fined over and over again by the same camera!
								end
							end
						end
					end
					
					hasBeenCaught = false
				end
            end
        end

		if canSleep then 
			Wait(1000)
		end
    end
end)

RegisterNetEvent('esx_speedcamera:openGUI')
AddEventHandler('esx_speedcamera:openGUI', function()
    SetNuiFocus(false,false)
    SendNUIMessage({type = 'openSpeedcamera'})
end)   

RegisterNetEvent('esx_speedcamera:closeGUI')
AddEventHandler('esx_speedcamera:closeGUI', function()
    SendNUIMessage({type = 'closeSpeedcamera'})
end)