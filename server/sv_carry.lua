-- ESX = nil
-- ESX = exports["es_extended"]:getSharedObject()

-- local carrying = {}
-- local carried = {}

-- carryReq = {}	

-- RegisterServerEvent('carry:deny')
-- AddEventHandler('carry:deny', function()

-- 	if carryReq[source] ~= nil then 
-- 		TriggerClientEvent('HotLifeNotify', carryReq[source], 'CARRY', 'Die Anfrage wurde abgelehnt!')
-- 		carryReq[source] = nil
-- 		TriggerClientEvent('HotLifeNotify', source, 'CARRY', 'Du hast die Carry Anfrage abgelehnt!')
		
-- 	end 
 
-- end)
-- RegisterServerEvent('carry:accept')
-- AddEventHandler('carry:accept', function()
	
-- 	local xPlayer = ESX.GetPlayerFromId(source)  

-- 	if carryReq[source] ~= nil then

-- 		TriggerClientEvent('carry:accepted', carryReq[source], source)
-- 		TriggerClientEvent('HotLifeNotify', source, 'CARRY', 'Du hast die Carry Anfrage angenommen!')
	

-- 	end

-- end)


-- RegisterServerEvent('carry:deathReq')
-- AddEventHandler('carry:deathReq', function(sender)
-- TriggerClientEvent('carry:accepted', sender, source)
-- end)


-- RegisterServerEvent('carry:request')
-- AddEventHandler('carry:request', function(playerId)
-- 	TriggerClientEvent('carry:handleRequest', playerId, source)
-- end)

-- RegisterServerEvent('carry:request2')
-- AddEventHandler('carry:request2', function(sender) 
-- 	local xTarget = ESX.GetPlayerFromId(source)
-- 	local xPlayer = ESX.GetPlayerFromId(sender)  
-- 	if xPlayer.getGroup() == "pl" or xPlayer.getGroup() == "management" then 
-- 		TriggerClientEvent('carry:accepted', sender, source)
-- 	else
-- 		local src = sender
-- 		carryReq[xTarget.source] = xPlayer.source 
-- 		TriggerClientEvent('HotLifeNotify', xTarget.source, 'CARRY', 'Du hast eine Carry Anfrage erhalten, drücke G um diese anzunehmen oder J um diese abzulehnen!')
-- 	end

-- end)


-- RegisterServerEvent("CarryPeople:sync")
-- AddEventHandler("CarryPeople:sync", function(targetSrc)
-- 	local source = source
-- 	local sourcePed = GetPlayerPed(source)
--    	local sourceCoords = GetEntityCoords(sourcePed)
-- 	local targetPed = GetPlayerPed(targetSrc)
--         local targetCoords = GetEntityCoords(targetPed)
-- 	if #(sourceCoords - targetCoords) <= 3.0 then 
-- 		TriggerClientEvent("CarryPeople:syncTarget", targetSrc, source)
-- 		carrying[source] = targetSrc
-- 		carried[targetSrc] = source
-- 	end
-- end)

-- RegisterServerEvent("CarryPeople:stop")
-- AddEventHandler("CarryPeople:stop", function(targetSrc)
-- 	local source = source

-- 	if carrying[source] then
-- 		TriggerClientEvent("CarryPeople:cl_stop", targetSrc)
-- 		carrying[source] = nil
-- 		carried[targetSrc] = nil
-- 	elseif carried[source] then
-- 		TriggerClientEvent("CarryPeople:cl_stop", carried[source])			
-- 		carrying[carried[source]] = nil
-- 		carried[source] = nil
-- 	end
-- end)

-- AddEventHandler('playerDropped', function(reason)
-- 	local source = source
	
-- 	if carrying[source] then
-- 		TriggerClientEvent("CarryPeople:cl_stop", carrying[source])
-- 		carried[carrying[source]] = nil
-- 		carrying[source] = nil
-- 	end

-- 	if carried[source] then
-- 		TriggerClientEvent("CarryPeople:cl_stop", carried[source])
-- 		carrying[carried[source]] = nil
-- 		carried[source] = nil
-- 	end
-- end)

-- HOWDY (!)


--New Carry

RegisterServerEvent('ichwilldenbreaufmeinenarmnehmen')
AddEventHandler('ichwilldenbreaufmeinenarmnehmen', function(target, animationLib,animationLib2, animation, animation2, distans, distans2, height,targetSrc,length,spin,controlFlagSrc,controlFlagTarget,animFlagTarget, boneIndex, xrot, yrot)
	local src = source
	
	if targetSrc == -1 then 
		print("Modder kicked [target = -1] => " .. GetPlayerName(src))
		DropPlayer(src, "HotLife: Lern modden du skid")
		return 
	end

	local dist = #(GetEntityCoords(GetPlayerPed(src)) - GetEntityCoords(GetPlayerPed(targetSrc)))

	if dist < 15 then 
		TriggerClientEvent('ichwilldasderbrejetztaufmeinenarmpacken', targetSrc, source, animationLib2, animation2, distans, distans2, height, length,spin,controlFlagTarget, boneIndex or 0, xrot or 0.5, yrot or 0.5)
		TriggerClientEvent('ichpackedenbreuachmeinenarmamk', source, animationLib, animation,length,controlFlagSrc,animFlagTarget)
	
		exports['es_extended']:doubleLog(src, targetSrc, 'Carry - Log', 'Der Spieler ' .. GetPlayerName(src) .. ' carried ' .. GetPlayerName(targetSrc), 'https://discord.com/api/webhooks/1177901766986178630/T7NdzLrlT3PqnhVMUgqRAOl3tU0h-vDYsYSJP5azF73-QbO_MRoLaKDc3RT8MIrRkhZu')
	end
end)

RegisterServerEvent('packdenbastardvonmeinerschulterrunter')
AddEventHandler('packdenbastardvonmeinerschulterrunter', function(targetSrc)
	local src = source
	local dist = #(GetEntityCoords(GetPlayerPed(src)) - GetEntityCoords(GetPlayerPed(targetSrc)))

	if targetSrc == -1 then
		print("[2] Modder kicked [target = -1] => " .. GetPlayerName(src)) 
		DropPlayer(src, "HotLife: Lern modden du skid")
		return 
	end

	if dist < 15 then 
		TriggerClientEvent('ichpackedenjetztrunter', targetSrc)
	
		exports['es_extended']:doubleLog(src, targetSrc, 'Carry - Log', 'Der Spieler ' .. GetPlayerName(src) .. ' lässt ' .. GetPlayerName(targetSrc) .. ' los', 'https://discord.com/api/webhooks/1177901766986178630/T7NdzLrlT3PqnhVMUgqRAOl3tU0h-vDYsYSJP5azF73-QbO_MRoLaKDc3RT8MIrRkhZu')
	end
end)

RegisterServerEvent('cmg3_animations:sync')
AddEventHandler('cmg3_animations:sync', function(target, animationLib,animationLib2, animation, animation2, distans, distans2, height,targetSrc,length,spin,controlFlagSrc,controlFlagTarget,animFlagTarget,attachFlag)
	local xTarget = ESX.GetPlayerFromId(targetSrc)
	if targetSrc == nil then
		return
	end

	if targetSrc == 0 then
		return
	end

	-- if xTarget.getGroup() == 'pl' then
	-- 	return
	-- end

	if GetPlayerName(targetSrc) ~= nil then
		TriggerClientEvent('cmg3_animations:syncTarget', targetSrc, source, animationLib2, animation2, distans, distans2, height, length,spin,controlFlagTarget,animFlagTarget,attachFlag)
        TriggerClientEvent('cmg3_animations:syncMe', source, animationLib, animation,length,controlFlagSrc,animFlagTarget)
    end
end)

RegisterServerEvent('cmg3_animations:stop')
AddEventHandler('cmg3_animations:stop', function(targetSrc)
	if targetSrc == nil then
		return
	end

	if targetSrc == 0 then
		return
	end

	if GetPlayerName(targetSrc) ~= nil then
		TriggerClientEvent('cmg3_animations:cl_stop', targetSrc)
	end
end)

--New Carry End