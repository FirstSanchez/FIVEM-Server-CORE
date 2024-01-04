ESX = nil

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
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()
end)

local sperrzone_cooldown = 0

CreateThread(function()
    while true do
        Wait(1000)
    if sperrzone_cooldown == 1 then
        Wait(15000)
        sperrzone_cooldown = 0
        end
    end
end)

RegisterNetEvent('lm__sperrzone:setBlips')
AddEventHandler('lm__sperrzone:setBlips', function(officerName, officerServerId, officerPlayer, blipVector, streetName, sizeclient)
    if sperrzone_cooldown == 1 then
        TriggerEvent('cataleya_hud:sendNotify', "error", "HotLife | System", "Du kannst Sperrzonen nicht so schnell neu erstellen", 3000)
    else
		RemoveBlip(blipX)
		RemoveBlip(blipY)

		blipX = AddBlipForCoord(blipVector.x, blipVector.y, blipVector.z)
		blipY = AddBlipForRadius(blipVector.x, blipVector.y, blipVector.z, sizeclient)
		PlaySoundFrontend(-1, "ROUND_ENDING_STINGER_CUSTOM", "CELEBRATION_SOUNDSET", 1)
		SetBlipSprite(blipX, 161)
		SetBlipAsShortRange(blipX, true)
		SetBlipColour(blipX, Config_Sperrzone.color)
		SetBlipScale(blipX, Config_Sperrzone.blipXradius)
		PulseBlip(blipX)
		BeginTextCommandSetBlipName('STRING')
    	AddTextComponentString(Config_Sperrzone.blipTitle)
    	EndTextCommandSetBlipName(blipX)
        sperrzone_cooldown = sperrzone_cooldown + 1

		SetBlipAlpha(blipY, 80)
    	SetBlipColour(blipY, Config_Sperrzone.color)
    end

end)

RegisterNetEvent('lm__sperrzone:removeBlips')
AddEventHandler('lm__sperrzone:removeBlips', function(officerName, officerServerId, officerPlayer, blipVector, streetName)
	RemoveBlip(blipX)
	RemoveBlip(blipY)
end)

RegisterNetEvent('lm__sperrzone:SperrzoneMenu')
AddEventHandler('lm__sperrzone:SperrzoneMenu', function(job)
    if job == "police" or job == "FIB" or job == "secret_service" or job == "army" then
	    SperrzoneMenu(job)
    end
end)

function SperrzoneMenu(job)
    if job == "police" or job == "FIB" or job == "secret_service" or job == "army" then
        if not cooldown then 
            cooldown = true
            ESX.UI.Menu.Open(
                'default', GetCurrentResourceName(), 'menu',
                {
                    title    = Config_Sperrzone.MenuTitle,
                    align    = 'right',
                    elements = {
                        { label = Config_Sperrzone.Menu1, value = "sperrzone_erstellen" },
                        { label = Config_Sperrzone.Menu2, value = "sperrzone_delete" }
                    }
                }, 

            function(data, menu)

                local action = data.current.value
                PlayerData = ESX.GetPlayerData()

                if action == "sperrzone_erstellen" then

                ESX.UI.Menu.Open(
                'default', GetCurrentResourceName(), 'timeforsperr',
                {
                    title    = Config_Sperrzone.MenuTitle,
                    align    = 'right',
                    elements = {
                        { label = "150 Meter", value = "onefive" },
                        { label = "200 Meter", value = "two" },
                        { label = "250 Meter", value = "twofive" },
                        { label = "300 Meter", value = "three" },
                        { label = "350 Meter", value = "threefive" },
                        { label = "400 Meter", value = "four" },
                    }
                }, 
                function(data, menu)
                    local action = data.current.value
                    local blipVector = vector3(GetEntityCoords(GetPlayerPed(PlayerId()), true))
                    local officerName = GetPlayerName(PlayerId())
                    local officerServerId = GetPlayerServerId(PlayerId())
                    local officerPlayer = GetPlayerFromServerId(officerServerId)
                    local x, y, z = table.unpack(GetEntityCoords(PlayerPedId()))
                    local streetName, crossing = GetStreetNameAtCoord(x, y, z)
                    local streetName = GetStreetNameFromHashKey(streetName)

                if action == "onefive" then
                    --menu.close()
                    TriggerServerEvent('lm__sperrzone:setBlips', officerName, officerServerId, officerPlayer, blipVector, streetName, 150.0, TOKEN)
                elseif action == "two" then
                    --menu.close()
                    TriggerServerEvent('lm__sperrzone:setBlips', officerName, officerServerId, officerPlayer, blipVector, streetName, 200.0, TOKEN)
                elseif action == "twofive" then
                    --menu.close()
                    TriggerServerEvent('lm__sperrzone:setBlips', officerName, officerServerId, officerPlayer, blipVector, streetName, 250.0, TOKEN)
                elseif action == "three" then
                    --menu.close()
                    TriggerServerEvent('lm__sperrzone:setBlips', officerName, officerServerId, officerPlayer, blipVector, streetName, 300.0, TOKEN)
                elseif action == "threefive" then
                    --menu.close()
                    TriggerServerEvent('lm__sperrzone:setBlips', officerName, officerServerId, officerPlayer, blipVector, streetName, 350.0, TOKEN)
                elseif action == "four" then
                    -- menu.close()
                    TriggerServerEvent('lm__sperrzone:setBlips', officerName, officerServerId, officerPlayer, blipVector, streetName, 400.0)
                end

            end, function(data, menu)
                menu.close()
            end)	

                elseif action == "sperrzone_delete" then

                    local blipVector = vector3(GetEntityCoords(GetPlayerPed(PlayerId()), true))
                    local officerName = GetPlayerName(PlayerId())
                    local officerServerId = GetPlayerServerId(PlayerId())
                    local officerPlayer = GetPlayerFromServerId(officerServerId)
                    local x, y, z = table.unpack(GetEntityCoords(PlayerPedId()))
                    local streetName, crossing = GetStreetNameAtCoord(x, y, z)
                    local streetName = GetStreetNameFromHashKey(streetName)

                    --menu.close()
                    TriggerServerEvent('lm__sperrzone:removeBlips', officerName, officerServerId, officerPlayer, blipVector, streetName, TOKEN)

                end
            end, function(data, menu)
                menu.close()
            end)
            Wait(5000)
            cooldown = false	
        end
    end
end