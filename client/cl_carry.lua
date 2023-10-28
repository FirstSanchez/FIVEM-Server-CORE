ESX = nil
ESX = exports["es_extended"]:getSharedObject()

local playingAnim = false
		local carry = {
			InProgress = false,
			targetSrc = -1,
			type = "",
			personCarrying = {
				animDict = "missfinale_c2mcs_1",
				anim = "fin_c2_mcs_1_camman",
				flag = 49,
			},
			personCarried = {
				animDict = "nm",
				anim = "firemans_carry",
				attachX = 0.27,
				attachY = 0.15,
				attachZ = 0.63,
				flag = 33,
			}
		}
		
		local function drawNativeNotification(text)
			SetTextComponentFormat("STRING")
			AddTextComponentString(text)
			DisplayHelpTextFromStringLabel(0, 0, 1, -1)
		end
		
		local function GetClosestPlayer(radius)
			local players = GetActivePlayers()
			local closestDistance = -1
			local closestPlayer = -1
			local playerPed = PlayerPedId()
			local playerCoords = GetEntityCoords(playerPed)
		
			for _,playerId in ipairs(players) do
				local targetPed = GetPlayerPed(playerId)
				if targetPed ~= playerPed then
					local targetCoords = GetEntityCoords(targetPed)
					local distance = #(targetCoords-playerCoords)
					if closestDistance == -1 or closestDistance > distance then
						closestPlayer = playerId
						closestDistance = distance
					end
				end
			end
			if closestDistance ~= -1 and closestDistance <= radius then
				return closestPlayer
			else
				return nil
			end
		end
		
		local function ensureAnimDict(animDict)
			if not HasAnimDictLoaded(animDict) then
				RequestAnimDict(animDict)
				while not HasAnimDictLoaded(animDict) do
					Wait(0)
				end        
			end
			return animDict
		end
        RegisterKeyMapping('carrykeya', 'Carry Annehmen', 'keyboard', 'G')
        RegisterKeyMapping('carrykeyd', 'Carry Ablehnen', 'keyboard', 'J')   
        
        RegisterCommand("carrykeya", function()
            
            TriggerServerEvent('carry:accept')
        
        end)

        RegisterCommand('carrykeyd', function()
        
            TriggerServerEvent('carry:deny')
        
        end)

			RegisterCommand("carry",function(source, args)
                -- print("es gibt diesen befehlt!")
				if not carry.InProgress then
					local closestPlayer = GetClosestPlayer(3)
					if closestPlayer then
						local targetSrc = GetPlayerServerId(closestPlayer)
						if targetSrc ~= -1 then
                            
                            
                            -- print("CARRRRRRY")
                            TriggerServerEvent('carry:request', targetSrc)
							TriggerEvent('prime_notify', "CARRY", 'Der andere Spieler muss die Anfrage annehmen!', 5000)
						else
							drawNativeNotification("~r~Niemand zum tragen in der Nähe!")
						end
					else
						drawNativeNotification("~r~Niemand zum tragen in der Nähe!")
					end
				else
					carry.InProgress = false
					ClearPedSecondaryTask(PlayerPedId())
					DetachEntity(PlayerPedId(), true, false)
					playingAnim = false
					TriggerServerEvent("CarryPeople:stop",carry.targetSrc)
					carry.targetSrc = 0
				end
			end,false)
		
            RegisterNetEvent('carry:handleRequest')
            AddEventHandler('carry:handleRequest', function(sender)
                if GetEntityHealth(PlayerPedId()) == 0 then 
                    TriggerServerEvent('carry:deathReq', sender)
                else
                    TriggerServerEvent('carry:request2', sender)
                end
                

            
            end)
		RegisterNetEvent('carry:accepted')
        AddEventHandler('carry:accepted', function(targetSrc)
            carry.InProgress = true
            carry.targetSrc = targetSrc 
            TriggerServerEvent("CarryPeople:sync",targetSrc)
            ensureAnimDict(carry.personCarrying.animDict)
            carry.type = "carrying" 
			TriggerEvent('prime_notify', "info", "CARRY", 'Die Carry anfrage wurde angenommen!', 5000)
        end)
		RegisterNetEvent("CarryPeople:syncTarget")
		AddEventHandler("CarryPeople:syncTarget", function(targetSrc)
			local targetPed = GetPlayerPed(GetPlayerFromServerId(targetSrc))
			carry.InProgress = true
			ensureAnimDict(carry.personCarried.animDict)
			AttachEntityToEntity(PlayerPedId(), targetPed, 0, carry.personCarried.attachX, carry.personCarried.attachY, carry.personCarried.attachZ, 0.5, 0.5, 180, false, false, false, false, 2, false)
			carry.type = "beingcarried"
		end)
		
		RegisterNetEvent("CarryPeople:cl_stop")
		AddEventHandler("CarryPeople:cl_stop", function()
			carry.InProgress = false
			playingAnim = false
			ClearPedSecondaryTask(PlayerPedId())
			DetachEntity(PlayerPedId(), true, false)
		end)
		
			CreateThread(function()
				while true do

					-- ANTI KEK SCHLAGEN
					if IsPedArmed(PlayerPedId(), 6) then
						DisableControlAction(1, 140, true)
						DisableControlAction(1, 141, true)
						DisableControlAction(1, 142, true)
					end
					-- ANTI KEK SCHLAGEN
					if carry.InProgress then
						-- print(playingAnim)
						if not playingAnim then
							if carry.type == "beingcarried" then
								if not IsEntityPlayingAnim(PlayerPedId(), carry.personCarried.animDict, carry.personCarried.anim, 3) then
									playingAnim = true
									TaskPlayAnim(PlayerPedId(), carry.personCarried.animDict, carry.personCarried.anim, 8.0, -8.0, 100000, carry.personCarried.flag, 0, false, false, false)
								end
							elseif carry.type == "carrying" then
								if not IsEntityPlayingAnim(PlayerPedId(), carry.personCarrying.animDict, carry.personCarrying.anim, 3) then
									playingAnim = true
									TaskPlayAnim(PlayerPedId(), carry.personCarrying.animDict, carry.personCarrying.anim, 8.0, -8.0, 100000, carry.personCarrying.flag, 0, false, false, false)
								end
							end
						end
					end
					local sleep = 0
					Wait(sleep)
				end
			end)

        RegisterNetEvent('utopiaNotify')
        AddEventHandler('utopiaNotify', function(title, msg)
			TriggerEvent('prime_notify', "info", title, msg, 10000)
		end)