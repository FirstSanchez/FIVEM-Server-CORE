local currentJobKey = nil
	local lastPosition = nil
	local currentVehicle = nil
	local checkpointCount = 0
	local isCollecting =  false
	local Blips = {}
	
	CreateThread(function()
		while true do
			local sleep = 500
			local found = false
			local coords = GetEntityCoords(PlayerPedId())
			for k, v in pairs(DConfig.Jobs) do
				local dist = #(coords - v.MarkerPosition)
				if dist <= 30.0 then
					found = true
					DrawMarker(0, v.MarkerPosition, 0, 0, 0, 0, 0, 0, 0.5 , 0.5 , 0.5 , 8, 155, 143, 100, 0, 0, 0, true, 0, 0, 0)
					if dist <= 1.5 then
						ESX.ShowHelpNotification("Drücke [E] um zu interagieren.")
						if IsControlJustPressed(0, 51) then
							Interact(k)
						end
					end
				end
			end
			if found then
				sleep = 0
			end
			Wait(sleep)
		end
	end)
	
	function CreateCheckpointThread(key)
		CreateThread(function()
			while currentJobKey == key do
				Wait(0)
				local coords = GetEntityCoords(PlayerPedId())
				local dist = #(coords - lastPosition)
				if key == "Elektriker Job" or key == "Paket Job" or key == "Liefer Job" then
					if IsPedInVehicle(PlayerPedId(), currentVehicle, false) == false then
						DrawMarker(0, lastPosition.x, lastPosition.y, lastPosition.z, 0, 0, 0, 0, 0, 0, 0.5 ,0.5 , 0.5 , 8, 155, 143, 100, 0, 0, 0, true, 0, 0, 0)
						if dist <= 2.0 then
							ESX.ShowHelpNotification("Drücke [E] um zu interagieren.")
							if IsControlJustPressed(0, 51) then
								StartCount(key)
								Wait(0)
							end
						end
					end
				else
					if dist <= 30.0 and IsPedInVehicle(PlayerPedId(), currentVehicle, false) then
						DrawMarker(4, lastPosition.x, lastPosition.y, lastPosition.z + 1, 0, 0, 0, 0, 0, 0, 5.0, 5.0, 5.0, 8, 155, 143, 100, 0, 0, 0, true, 0, 0, 0)
						if dist <= 5.0 then
							ESX.ShowHelpNotification("Drücke [E] um zu interagieren.")
							if IsControlJustPressed(0, 51) then
								StartCollect(key)
								Wait(0)
							end
						end
					end
				end
			end
		end)
	end
	
	function StartCount(key)
		if isCollecting then
			return
		end
		isCollecting = true
		FreezeEntityPosition(PlayerPedId(), true)
		FreezeEntityPosition(GetVehiclePedIsIn(PlayerPedId(), false), true)
		CreateThread(function()
			while isCollecting do
				Wait(0)
	
				DisableAllControlActions(0)
				EnableControlAction(0, 1, true)
				EnableControlAction(0, 2, true)
			end
		end)
	
		if key == "Paket Job" or key == "Bus Job" or key == "Liefer Job" then 
            TriggerEvent("jobs_creator:startProgressBar", 1000)
			Wait(1000)
		else
			TaskStartScenarioInPlace(PlayerPedId(), 'WORLD_HUMAN_WELDING', 0, true)
            TriggerEvent("jobs_creator:startProgressBar", 1000)
            Wait(1000)
		end
	
		ClearPedTasks(PlayerPedId())
	
		FreezeEntityPosition(PlayerPedId(), false)
		FreezeEntityPosition(GetVehiclePedIsIn(PlayerPedId(), false), false)
	
		local position = GenerateRoute(key)
		RemoveBlip(Blips['delivery'])
		Blips['delivery'] = AddBlipForCoord(position.x, position.y)
		SetBlipSprite (Blips['delivery'], 1)
		SetBlipAsShortRange(Blips['delivery'], true)
		SetBlipRoute(Blips['delivery'], true)
		SetBlipColour(Blips['delivery'], 43)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('blip_delivery')
		EndTextCommandSetBlipName(Blips['delivery'])
	    TriggerEvent("prime_notify", "info", "JOB-SYSTEM", "Fahre zum nächsten Wegpunkt", 5000)	
	
		checkpointCount = checkpointCount + 1
	
		isCollecting = false
	end
	
	function StartCollect(key)
		if isCollecting then
			return
		end
	
		isCollecting = true
	
		FreezeEntityPosition(PlayerPedId(), true)
		FreezeEntityPosition(GetVehiclePedIsIn(PlayerPedId(), false), true)
	
		CreateThread(function()
			while isCollecting do
				Wait(0)
	
				DisableAllControlActions(0)
				EnableControlAction(0, 1, true)
				EnableControlAction(0, 2, true)
			end
		end)
        TriggerEvent("jobs_creator:startProgressBar", 1000)
		Wait(1000)
		ClearPedTasks(PlayerPedId())
	
		FreezeEntityPosition(PlayerPedId(), false)
		FreezeEntityPosition(GetVehiclePedIsIn(PlayerPedId(), false), false)
	
		local position = GenerateRoute(key)
		RemoveBlip(Blips['delivery'])
		Blips['delivery'] = AddBlipForCoord(position.x, position.y)
		SetBlipSprite (Blips['delivery'], 1)
		SetBlipAsShortRange(Blips['delivery'], true)
		SetBlipRoute(Blips['delivery'], true)
		SetBlipColour(Blips['delivery'], 43)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('blip_delivery')
		EndTextCommandSetBlipName(Blips['delivery'])
        TriggerEvent("prime_notify", "info", "JOB-SYSTEM", "Fahre zum nächsten Wegpunkt", 5000)	
		checkpointCount = checkpointCount + 1
	
		isCollecting = false
	end
	
	function Interact(key)
		if DConfig.Jobs[key] == nil then
			return
		end
	
		local DConfig = DConfig.Jobs[key]
	
		if currentJobKey ~= nil and currentJobKey ~= key then
            TriggerEvent("prime_notify", "error", "JOB-SYSTEM", "Du bist bereits in einem anderen Job. Bitte beende ihn vorher!", 5000)
			return
		end
	
		local elements = {}
		table.insert(elements, {label = "Starten",value = "starten"})
		if currentJobKey == key then
			table.insert(elements, {label = "Kündigen",value = "stop"})
		end
		ESX.UI.Menu.CloseAll()
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'menu', {
			title    = key,
			elements = elements,
			align    = 'top-left'
		}, function(data, menu)
			if data.current.value == 'stop' then
				ESX.TriggerServerCallback('diaz_jobs:getkey', function(has)
					if has then
						if currentVehicle then
							DeleteVehicle(currentVehicle)
							RemoveBlip(Blips['delivery'])
						end
							
						if checkpointCount > 0 then
							TriggerServerEvent("diaz_jobs:getcashmash", has, currentJobKey, checkpointCount)
						end
                        TriggerEvent("prime_notify", "info", "JOB-SYSTEM", "Du hast den gekündigt.", 5000)
						currentJobKey = nil
						currentVehicle = nil
						checkpointCount = 0
						SetWaypointOff()
						menu.close()
						return
					end
				end)
			elseif data.current.value == 'starten' then
							menu.close()
							local flag = ESX.Game.IsSpawnPointClear(DConfig.VehiclePosition, 5.0)
	
							if flag == false then
                                TriggerEvent("prime_notify", "info", "JOB-SYSTEM", "Spawnpunkt belegt. Bitte warte kurz.", 5000)
								return
							end
						
							ESX.Game.SpawnVehicle(DConfig.Vehicle,
								vector3(DConfig.VehiclePosition.x, DConfig.VehiclePosition.y, DConfig.VehiclePosition.z), DConfig.VehiclePosition.w,
								function(vehicle)
									currentVehicle = vehicle
									currentJobKey = key
									SetVehicleFixed(vehicle)
									SetVehicleFuelLevel(vehicle, 100.0)
									TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)							
									local position = GenerateRoute(key)
									Blips['delivery'] = AddBlipForCoord(position.x, position.y)
									SetBlipSprite (Blips['delivery'], 1)
									SetBlipAsShortRange(Blips['delivery'], true)
									SetBlipRoute(Blips['delivery'], true)
									SetBlipColour(Blips['delivery'], 43)
									BeginTextCommandSetBlipName("STRING")
									AddTextComponentString('blip_delivery')
									EndTextCommandSetBlipName(Blips['delivery'])
									TriggerEvent("prime_notify", "info", "JOB-SYSTEM", "Fahre zum nächsten Wegpunkt", 5000)
									CreateCheckpointThread(key)
									SetVehicleNumberPlateText(vehicle, "LM")
							end)
							ESX.ShowAdvancedNotification('Andrew S.', key, 'Hey...Ähm, du bist also der neue Fahrer, richtig? Fahre einfach wie besprochen zum vereinbarten Standort. Und übrigens vielen Dank, dass du das übernimmst.', "CHAR_ANDREAS", 2)
							ESX.ShowAdvancedNotification('Andrew S.', key, 'Wenn du kein Bock mehr hast Komm hierher germe zurück.', "CHAR_ANDREAS", 2)

			end
		end, function(data, menu)
			menu.close()
		end)
	end
	
	function GenerateRoute(key)
		local positions = DConfig.Jobs[key].Positions
		local position = positions[math.random(#positions)]
		if lastPosition then
			local distance = #(lastPosition - position)
			if lastPosition == position or distance <= 100.0 then
				CreateThread(function()
					while true do
						Wait(0)
						position = positions[math.random(#positions)]
	
						if lastPosition ~= position then
							break
						end
					end
				end)
			end
		end
		lastPosition = position
		return position
	end
	
	--Blips
	CreateThread(function()
		for k, v in pairs(DConfig.Jobs) do
			if v.Blip then
				if v.Blip.Enable then
					local blip = AddBlipForCoord(v.MarkerPosition)
					SetBlipSprite(blip, v.Blip.Sprite)
					SetBlipDisplay(blip, 4)
					SetBlipScale(blip,v.Blip.Size)
					SetBlipColour(blip, v.Blip.Color)
					SetBlipAsShortRange(blip, true)
					BeginTextCommandSetBlipName("STRING")
					AddTextComponentString(k)
					EndTextCommandSetBlipName(blip)
				end
			end
		end
	end)