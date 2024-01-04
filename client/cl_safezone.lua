safezone = {}

safezone.zones = {
	{ ['x'] = -1107.5166, ['y'] = -2769.8569, ['z'] = 27.0497}, -- Einreise
	{ ['x'] = -1014.7415, ['y'] = -2828.7039, ['z'] = 49.3756}, -- Einreise2

	-- { ['x'] = 215.2167, ['y'] = -897.6418, ['z'] = 29.6668}, -- Würfelpark 
	-- { ['x'] = 178.6741, ['y'] = -973.0911, ['z'] = 29.7808}, -- Würfelpark 2
}


safezone.showNotification = true -- Show notification when in Safezone?
safezone.safezoneMessage = "You are currently in a Safezone" -- Change the message that shows when you are in a safezone
safezone.radius = 100.0 -- Change the RADIUS of the Safezone.
safezone.speedlimitinSafezone = 50.0 -- Set a speed limit in a Safezone (MPH), Set to false to disable

local SafezoneIn = false
local SafezoneOut = false
local closestZone = 1

CreateThread(function()
	while true do
		local playerPed = PlayerPedId()
		local x, y, z = table.unpack(GetEntityCoords(playerPed, true))
		local minDistance = 100000
		Wait(1)
		for i = 1, #safezone.zones, 1 do
			dist = Vdist(safezone.zones[i].x, safezone.zones[i].y, safezone.zones[i].z, x, y, z)
			if dist < minDistance then
				minDistance = dist
				closestZone = i
			end
		end
	end
end)

CreateThread(function()
	while true do
		local player = PlayerPedId()
		local x,y,z = table.unpack(GetEntityCoords(player, true))
		local dist = Vdist(safezone.zones[closestZone].x, safezone.zones[closestZone].y, safezone.zones[closestZone].z, x, y, z)
		local vehicle = GetVehiclePedIsIn(player, false)
		local speed = GetEntitySpeed(vehicle)


		if dist <= safezone.radius then
			if not SafezoneIn then
				NetworkSetFriendlyFireOption(false)
				SetEntityCanBeDamaged(vehicle, false)
				ClearPlayerWantedLevel(PlayerId())
				SetCurrentPedWeapon(player,GetHashKey("WEAPON_UNARMED"),true)
				if safezone.showNotification then
					TriggerEvent('cataleya_hud:sendNotify', "info", "Safezone", "Du bist nun in einer Safezone.", 10000)
				end
				SafezoneIn = true
				SafezoneOut = false
			end
		else
			if not SafezoneOut then
				NetworkSetFriendlyFireOption(true)
				if safezone.showNotification then
					TriggerEvent('cataleya_hud:sendNotify', "info", "Safezone", "Du hast die Safezone verlassen.", 10000)
				end
				if safezone.speedlimitinSafezone then
				SetVehicleMaxSpeed(vehicle, 1000.00)
				end
				SetEntityCanBeDamaged(vehicle, true)
				SafezoneOut = true
				SafezoneIn = false
			end
			Wait(200)
		end
		if SafezoneIn then
		Wait(10)
    if not bypass then
		DisablePlayerFiring(player, true)
		SetPlayerCanDoDriveBy(player, false)
		DisableControlAction(2, 37, true)
      	DisableControlAction(0, 106, true)
		DisableControlAction(0, 24, true)
		DisableControlAction(0, 69, true)
		DisableControlAction(0, 70, true)
		DisableControlAction(0, 92, true)
		DisableControlAction(0, 114, true)
		DisableControlAction(0, 257, true)
		DisableControlAction(0, 331, true)
		DisableControlAction(0, 68, true)
		DisableControlAction(0, 257, true)
		DisableControlAction(0, 263, true)
		DisableControlAction(0, 264, true)

		if safezone.speedlimitinSafezone then
		mphs = 2.237
		maxspeed = safezone.speedlimitinSafezone/mphs
		SetVehicleMaxSpeed(vehicle, maxspeed)
		end

			if IsDisabledControlJustPressed(2, 37) then
				SetCurrentPedWeapon(player,GetHashKey("WEAPON_UNARMED"),true)
			end
			if IsDisabledControlJustPressed(0, 106) then 
				SetCurrentPedWeapon(player,GetHashKey("WEAPON_UNARMED"),true)
			end
		end
	end
	end
end)