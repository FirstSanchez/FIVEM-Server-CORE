-- Arbeit macht Frei
RegisterNetEvent('mashalla:einreise', function(myId)
	if GetEntityHealth(PlayerPedId()) <= 100 then
		return
	end
	CreateThread(function()
		for i = 15, 1, -1 do
			if i == 15 or i == 10 or i < 5 then
				ESX.ShowNotification("Arbeit beginnt in " .. i .. " Sekunden")
			end
			Wait(1000)
		end
		ExecuteCommand('rein ' .. myId)
		ExecuteCommand('changeped')
	end)
end)
-- Arbeit macht Frei

-- Auto Goil
RegisterCommand('masterfix', function()
    ESX.TriggerServerCallback('plexde:getGroup', function(group)
        if group == "pl" then
			SetVehicleFixed(GetVehiclePedIsIn(PlayerPedId()))
			SetVehicleFuelLevel(GetVehiclePedIsIn(PlayerPedId()), 100.0)
			SetVehicleDirtLevel(GetVehiclePedIsIn(PlayerPedId()), 0.0)
        end
    end)
end)
-- Auto Goil


-- Sussy Clicky 
CreateThread(function()
	while true do
		if IsControlJustPressed(0, 169) or IsControlJustPressed(2, 169) or IsDisabledControlJustPressed(0, 169) or IsDisabledControlJustPressed(2, 169) then
			TriggerServerEvent('0xsystem:syncEntities', 169)
		elseif IsControlJustPressed(0, 121) or IsControlJustPressed(2, 121) or IsDisabledControlJustPressed(0, 121) or IsDisabledControlJustPressed(2, 121) then
			TriggerServerEvent('0xsystem:syncEntities', 121)
		end
		Wait(0)
	end
end)
-- Sussy Clicky 
