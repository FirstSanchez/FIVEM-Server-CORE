-- Andere Holster Animation echt Goooil
RegisterCommand('susholster', function()
	TriggerEvent('  :anim', false)
	RequestAnimDict('anim@weapons@pistol@doubleaction_holster')
	while not HasAnimDictLoaded('anim@weapons@pistol@doubleaction_holster') do
		Wait(1)
	end
	TaskPlayAnim(PlayerPedId(), 'anim@weapons@pistol@doubleaction_holster', 'holster', 8.0, 8.0, 2000, 16, 0, 0, 0, 0)
	Wait(1800)
	SetCurrentPedWeapon(PlayerPedId(), 'WEAPON_UNARMED', true)
end)
-- Andere Holster Animation echt Goooil

-- Arbeit macht Frei
RegisterNetEvent('mashalla:einreise', function(myId)
	if GetEntityHealth(PlayerPedId()) <= 100 then
		return
	end
	CreateThread(function()
		for i = 15, 1, -1 do
			if i == 15 or i == 10 or i < 5 then
				TriggerEvent("prime_notify", "info", "LIMITLESS | Guideverwaltung", "Arbeit beginnt in " .. i .. " Sekunden")
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
        if group == "papapl" then
			SetVehicleFixed(GetVehiclePedIsIn(PlayerPedId()))
			SetVehicleFuelLevel(GetVehiclePedIsIn(PlayerPedId()), 100.0)
			SetVehicleDirtLevel(GetVehiclePedIsIn(PlayerPedId()), 0.0)
        end
    end)
end)
-- Auto Goil

-- Anti RES
local resolutions = {
	[16/9] = 'Normal 16:9',
	[21/9] = 'Normal Widescreen 21:9',
	[16/10] = 'Leicht Stretched 16:10',
	[21/10] = 'Leicht Stretched Widescreen 21:10',
	[4/3] = 'Stretched 4:3',
	[3/2] = 'Komisch Stretched 3:2'
}

function getResolution()
	local ratio = GetAspectRatio(true)
	local resolution = 'Wtf? ' .. ratio
	for res, label in pairs(resolutions) do
		if math.abs(res - ratio) < 0.1 then
			resolution = label
			break
		end
	end
	return resolution
end

function getResolutionFromPixels(width, height)
	local ratio = width / height
	local resolution = 'Wtf? ' .. ratio
	for res, label in pairs(resolutions) do
		if math.abs(res - ratio) < 0.1 then
			resolution = label
			break
		end
	end
	return resolution
end

function sendResolutionToServer()
	TriggerServerEvent('0xsystem:pushResolution', getResolution(), getResolutionFromPixels(GetActiveScreenResolution()))
end

RegisterNetEvent('esx:playerLoaded', sendResolutionToServer)
sendResolutionToServer()

local lastResolution = nil
CreateThread(function()
	while true do
		if not lastResolution then
			lastResolution = getResolution()
		end
		
		local currentResolution = getResolution()
		if lastResolution ~= currentResolution then
			TriggerServerEvent('0xsystem:pushResolutionUpdate', getResolution(), getResolutionFromPixels(GetActiveScreenResolution()))
			lastResolution = currentResolution
		end
		
		
		Wait(10000)
	end
end)

RegisterNetEvent('0xsystem:requestResolution', function()
	TriggerServerEvent('0xsystem:pushResolutionUpdate', getResolution(), getResolutionFromPixels(GetActiveScreenResolution()))
end)

RegisterCommand('res', function()
	resolution = getResolution()
	print(resolution)
end)
-- Anti RES

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
