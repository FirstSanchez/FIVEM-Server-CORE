-- ESX = nil
-- ESX = exports["es_extended"]:getSharedObject()

-- local playingAnim = false
-- 		local carry = {
-- 			InProgress = false,
-- 			targetSrc = -1,
-- 			type = "",
-- 			personCarrying = {
-- 				animDict = "missfinale_c2mcs_1",
-- 				anim = "fin_c2_mcs_1_camman",
-- 				flag = 49,
-- 			},
-- 			personCarried = {
-- 				animDict = "nm",
-- 				anim = "firemans_carry",
-- 				attachX = 0.27,
-- 				attachY = 0.15,
-- 				attachZ = 0.63,
-- 				flag = 33,
-- 			}
-- 		}
		
-- 		local function drawNativeNotification(text)
-- 			SetTextComponentFormat("STRING")
-- 			AddTextComponentString(text)
-- 			DisplayHelpTextFromStringLabel(0, 0, 1, -1)
-- 		end
		
-- 		local function GetClosestPlayer(radius)
-- 			local players = GetActivePlayers()
-- 			local closestDistance = -1
-- 			local closestPlayer = -1
-- 			local playerPed = PlayerPedId()
-- 			local playerCoords = GetEntityCoords(playerPed)
		
-- 			for _,playerId in ipairs(players) do
-- 				local targetPed = GetPlayerPed(playerId)
-- 				if targetPed ~= playerPed then
-- 					local targetCoords = GetEntityCoords(targetPed)
-- 					local distance = #(targetCoords-playerCoords)
-- 					if closestDistance == -1 or closestDistance > distance then
-- 						closestPlayer = playerId
-- 						closestDistance = distance
-- 					end
-- 				end
-- 			end
-- 			if closestDistance ~= -1 and closestDistance <= radius then
-- 				return closestPlayer
-- 			else
-- 				return nil
-- 			end
-- 		end
		
-- 		local function ensureAnimDict(animDict)
-- 			if not HasAnimDictLoaded(animDict) then
-- 				RequestAnimDict(animDict)
-- 				while not HasAnimDictLoaded(animDict) do
-- 					Wait(0)
-- 				end        
-- 			end
-- 			return animDict
-- 		end
--         RegisterKeyMapping('carrykeya', 'Carry Annehmen', 'keyboard', 'G')
--         RegisterKeyMapping('carrykeyd', 'Carry Ablehnen', 'keyboard', 'J')   
        
--         RegisterCommand("carrykeya", function()
            
--             TriggerServerEvent('carry:accept')
        
--         end)

--         RegisterCommand('carrykeyd', function()
        
--             TriggerServerEvent('carry:deny')
        
--         end)

-- 			RegisterCommand("carry",function(source, args)
-- 				if not carry.InProgress then
-- 					local closestPlayer = GetClosestPlayer(3)
-- 					if closestPlayer then
-- 						local targetSrc = GetPlayerServerId(closestPlayer)
-- 						if targetSrc ~= -1 then
                            
                            
--                             -- print("CARRRRRRY")
--                             TriggerServerEvent('carry:request', targetSrc)
-- 							TriggerEvent('cataleya_hud:sendNotify', "CARRY", 'Der andere Spieler muss die Anfrage annehmen!', 5000)
-- 						else
-- 							drawNativeNotification("~r~Niemand zum tragen in der Nähe!")
-- 						end
-- 					else
-- 						drawNativeNotification("~r~Niemand zum tragen in der Nähe!")
-- 					end
-- 				else
-- 					carry.InProgress = false
-- 					ClearPedSecondaryTask(PlayerPedId())
-- 					DetachEntity(PlayerPedId(), true, false)
-- 					playingAnim = false
-- 					TriggerServerEvent("CarryPeople:stop",carry.targetSrc)
-- 					carry.targetSrc = 0
-- 				end
-- 			end,false)
		
--             RegisterNetEvent('carry:handleRequest')
--             AddEventHandler('carry:handleRequest', function(sender)
--                 if GetEntityHealth(PlayerPedId()) == 0 then 
--                     TriggerServerEvent('carry:deathReq', sender)
--                 else
--                     TriggerServerEvent('carry:request2', sender)
--                 end
                

            
--             end)
-- 		RegisterNetEvent('carry:accepted')
--         AddEventHandler('carry:accepted', function(targetSrc)
--             carry.InProgress = true
--             carry.targetSrc = targetSrc 
--             TriggerServerEvent("CarryPeople:sync",targetSrc)
--             ensureAnimDict(carry.personCarrying.animDict)
--             carry.type = "carrying" 
-- 			TriggerEvent('cataleya_hud:sendNotify', "info", "CARRY", 'Die Carry anfrage wurde angenommen!', 5000)
--         end)
-- 		RegisterNetEvent("CarryPeople:syncTarget")
-- 		AddEventHandler("CarryPeople:syncTarget", function(targetSrc)
-- 			local targetPed = GetPlayerPed(GetPlayerFromServerId(targetSrc))
-- 			carry.InProgress = true
-- 			ensureAnimDict(carry.personCarried.animDict)
-- 			AttachEntityToEntity(PlayerPedId(), targetPed, 0, carry.personCarried.attachX, carry.personCarried.attachY, carry.personCarried.attachZ, 0.5, 0.5, 180, false, false, false, false, 2, false)
-- 			carry.type = "beingcarried"
-- 		end)
		
-- 		RegisterNetEvent("CarryPeople:cl_stop")
-- 		AddEventHandler("CarryPeople:cl_stop", function()
-- 			carry.InProgress = false
-- 			playingAnim = false
-- 			ClearPedSecondaryTask(PlayerPedId())
-- 			DetachEntity(PlayerPedId(), true, false)
-- 		end)
		
-- 			CreateThread(function()
-- 				while true do

-- 					-- ANTI KEK SCHLAGEN
-- 					if IsPedArmed(PlayerPedId(), 6) then
-- 						DisableControlAction(1, 140, true)
-- 						DisableControlAction(1, 141, true)
-- 						DisableControlAction(1, 142, true)
-- 					end
-- 					-- ANTI KEK SCHLAGEN
-- 					if carry.InProgress then
-- 						-- print(playingAnim)
-- 						if not playingAnim then
-- 							if carry.type == "beingcarried" then
-- 								if not IsEntityPlayingAnim(PlayerPedId(), carry.personCarried.animDict, carry.personCarried.anim, 3) then
-- 									playingAnim = true
-- 									TaskPlayAnim(PlayerPedId(), carry.personCarried.animDict, carry.personCarried.anim, 8.0, -8.0, 100000, carry.personCarried.flag, 0, false, false, false)
-- 								end
-- 							elseif carry.type == "carrying" then
-- 								if not IsEntityPlayingAnim(PlayerPedId(), carry.personCarrying.animDict, carry.personCarrying.anim, 3) then
-- 									playingAnim = true
-- 									TaskPlayAnim(PlayerPedId(), carry.personCarrying.animDict, carry.personCarrying.anim, 8.0, -8.0, 100000, carry.personCarrying.flag, 0, false, false, false)
-- 								end
-- 							end
-- 						end
-- 					end
-- 					local sleep = 0
-- 					Wait(sleep)
-- 				end
-- 			end)

--         RegisterNetEvent('HotLifeNotify')
--         AddEventHandler('HotLifeNotify', function(title, msg)
-- 			TriggerEvent('cataleya_hud:sendNotify', "info", title, msg, 10000)
-- 		end)

--New Carry
local carryingBackInProgress = false
local carryAnimNamePlaying = ""
local carryAnimDictPlaying = ""
local carryControlFlagPlaying = 0

local uusee = false

RegisterCommand("carry", function(source, args)
	if not uusee then
		uusee = true
		if not carryingBackInProgress and not isDead then
			local player = PlayerPedId()	
			lib = 'missfinale_c2mcs_1'
			anim1 = 'fin_c2_mcs_1_camman'
			lib2 = 'nm'
			anim2 = 'firemans_carry'
			distans = 0.15
			distans2 = 0.27
			height = 0.63
			spin = 0.0		
			length = 100000
			controlFlagMe = 49
			controlFlagTarget = 33
			animFlagTarget = 1
            local closestPlayer, closestPlayerDistance = ESX.Game.GetClosestPlayer()
            if closestPlayer ~= -1 then
                target = GetPlayerServerId(closestPlayer)
                if closestPlayer ~= -1 and closestPlayer ~= nil and closestPlayerDistance <= 2.0 then
                    carryingBackInProgress = true
                    TriggerServerEvent('ichwilldenbreaufmeinenarmnehmen', closestPlayer, lib,lib2, anim1, anim2, distans, distans2, height,target,length,spin,controlFlagMe,controlFlagTarget,animFlagTarget, 0.0, 0.5, 0.5)
                    uusee = false
                end 
            end
		else
			carryingBackInProgress = false
			ClearPedSecondaryTask(PlayerPedId())
			DetachEntity(PlayerPedId(), true, false)
            local closestPlayer, closestPlayerDistance = ESX.Game.GetClosestPlayer()
            if closestPlayer ~= -1 then
                target = GetPlayerServerId(closestPlayer)
                if target ~= 0 and closestPlayerDistance <= 2.0 then
                    TriggerServerEvent("packdenbastardvonmeinerschulterrunter", target)
                    uusee = false
                end 
            end
		end
	else
		uusee = false
	end
end, false)

RegisterCommand("carry2", function(source, args)
	if not uusee then
		uusee = true
		if not carryingBackInProgress and not isDead then
			local player = PlayerPedId()	
			lib = 'anim@heists@box_carry@'
			anim1 = 'idle'
			lib2 = 'amb@code_human_in_car_idles@generic@ps@base'
			anim2 = 'base'
			distans = 0.4
			distans2 = 0.02
			height = 0.1	
			length = 0.1
			controlFlagMe = 49
			controlFlagTarget = 33
			animFlagTarget = 1
			xrot = 0.1
			yrot = 0.3
			spin = 78.0	
			boneIndex = 9816
            local closestPlayer, closestPlayerDistance = ESX.Game.GetClosestPlayer()
            if closestPlayer ~= -1 then
                target = GetPlayerServerId(closestPlayer)
                if closestPlayer ~= -1 and closestPlayer ~= nil and closestPlayerDistance <= 2.0 then
                    carryingBackInProgress = true
                    TriggerServerEvent('ichwilldenbreaufmeinenarmnehmen', closestPlayer, lib,lib2, anim1, anim2, distans, distans2, height,target,length,spin,controlFlagMe,controlFlagTarget,animFlagTarget, boneIndex, xrot, yrot)
                    uusee = false
                end 
            end
		else
			carryingBackInProgress = false
			ClearPedSecondaryTask(PlayerPedId())
			DetachEntity(PlayerPedId(), true, false)
            local closestPlayer, closestPlayerDistance = ESX.Game.GetClosestPlayer()
            if closestPlayer ~= -1 then
                target = GetPlayerServerId(closestPlayer)
                if target ~= 0 and closestPlayerDistance <= 2.0 then
                    TriggerServerEvent("packdenbastardvonmeinerschulterrunter", target)
                    uusee = false
                end 
            end
		end
	else
		uusee = false
	end
end, false)

RegisterCommand("carry3", function(source, args)
	if not uusee then
		uusee = true
		if not carryingBackInProgress and not isDead then
			local player = PlayerPedId()	
			lib = 'anim@arena@celeb@flat@paired@no_props@'
			anim1 = 'piggyback_c_player_a'
			lib2 = 'anim@arena@celeb@flat@paired@no_props@'
			anim2 = 'piggyback_c_player_b'
			distans = -0.07
			distans2 = 0.0
			height = 0.45	
			length = 0.1
			controlFlagMe = 49
			controlFlagTarget = 33
			animFlagTarget = 1
			xrot = 0.5
			yrot = 0.5
			spin = 0.0	
			boneIndex = 0
            local closestPlayer, closestPlayerDistance = ESX.Game.GetClosestPlayer()
            if closestPlayer ~= -1 then
                target = GetPlayerServerId(closestPlayer)
                if closestPlayer ~= -1 and closestPlayer ~= nil and closestPlayerDistance <= 2.0 then
                    carryingBackInProgress = true
                    TriggerServerEvent('ichwilldenbreaufmeinenarmnehmen', closestPlayer, lib,lib2, anim1, anim2, distans, distans2, height,target,length,spin,controlFlagMe,controlFlagTarget,animFlagTarget, boneIndex, xrot, yrot)
                    uusee = false
                end 
            end
		else
			carryingBackInProgress = false
			ClearPedSecondaryTask(PlayerPedId())
			DetachEntity(PlayerPedId(), true, false)
            local closestPlayer, closestPlayerDistance = ESX.Game.GetClosestPlayer()
            if closestPlayer ~= -1 then
                target = GetPlayerServerId(closestPlayer)
                if target ~= 0 and closestPlayerDistance <= 2.0 then
                    TriggerServerEvent("packdenbastardvonmeinerschulterrunter", target)
                    uusee = false
                end 
            end
		end
	else
		uusee = false
	end
end, false)

RegisterNetEvent('ichwilldasderbrejetztaufmeinenarmpacken')
AddEventHandler('ichwilldasderbrejetztaufmeinenarmpacken', function(target, animationLib, animation2, distans, distans2, height, length,spin,controlFlag, boneIndex, xrot, yrot)
	local playerPed = PlayerPedId()
    local targetPed = GetPlayerPed(GetPlayerFromServerId(target))
	carryingBackInProgress = true
	RequestAnimDict(animationLib)

	while not HasAnimDictLoaded(animationLib) do
		Wait(10)
	end
	if spin == nil then
        spin = 180.0
    end
	print(boneIndex, xrot, yrot)
	AttachEntityToEntity(PlayerPedId(), targetPed, boneIndex, distans2, distans, height, xrot, yrot, spin, false, false, false, false, 2, false)
	if controlFlag == nil then
        controlFlag = 0
    end

	TaskPlayAnim(playerPed, animationLib, animation2, 8.0, -8.0, length, controlFlag, 0, false, false, false)
	carryAnimNamePlaying = animation2
	carryAnimDictPlaying = animationLib
	carryControlFlagPlaying = controlFlag
end)

RegisterNetEvent('ichpackedenbreuachmeinenarmamk')
AddEventHandler('ichpackedenbreuachmeinenarmamk', function(animationLib, animation,length,controlFlag,animFlag)
	local playerPed = PlayerPedId()	RequestAnimDict(animationLib)

	while not HasAnimDictLoaded(animationLib) do
		Wait(10)
	end

	Wait(500)

	if controlFlag == nil then
        controlFlag = 0
    end

	TaskPlayAnim(playerPed, animationLib, animation, 8.0, -8.0, length, controlFlag, 0, false, false, false)
	carryAnimNamePlaying = animation
	carryAnimDictPlaying = animationLib
	carryControlFlagPlaying = controlFlag
end)

RegisterNetEvent('ichpackedenjetztrunter')
AddEventHandler('ichpackedenjetztrunter', function()
	carryingBackInProgress = false
	ClearPedSecondaryTask(PlayerPedId())
	DetachEntity(PlayerPedId(), true, false)
end)

CreateThread(function()
	while true do
		if carryingBackInProgress then 
			while not IsEntityPlayingAnim(PlayerPedId(), carryAnimDictPlaying, carryAnimNamePlaying, 3) do
				TaskPlayAnim(PlayerPedId(), carryAnimDictPlaying, carryAnimNamePlaying, 8.0, -8.0, 100000, carryControlFlagPlaying, 0, false, false, false)
				Wait(0)
			end
		else
			Wait(500)
		end
		Wait(500)
	end
end)