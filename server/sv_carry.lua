RegisterServerEvent('ichwilldenbreaufmeinenarmnehmen')
AddEventHandler('ichwilldenbreaufmeinenarmnehmen', function(target, animationLib,animationLib2, animation, animation2, distans, distans2, height,targetSrc,length,spin,controlFlagSrc,controlFlagTarget,animFlagTarget, boneIndex, xrot, yrot)
	local src = source
	
	if targetSrc == -1 then 
		print("Modder kicked [target = -1] => " .. GetPlayerName(src))
		DropPlayer(src, "ESX: Lern modden du skid")
		return 
	end

	local dist = #(GetEntityCoords(GetPlayerPed(src)) - GetEntityCoords(GetPlayerPed(targetSrc)))

	if dist < 15 then 
		TriggerClientEvent('ichwilldasderbrejetztaufmeinenarmpacken', targetSrc, source, animationLib2, animation2, distans, distans2, height, length,spin,controlFlagTarget, boneIndex or 0, xrot or 0.5, yrot or 0.5)
		TriggerClientEvent('ichpackedenbreuachmeinenarmamk', source, animationLib, animation,length,controlFlagSrc,animFlagTarget)
	
		exports['es_extended']:doubleLog(src, targetSrc, 'Carry - Log', 'Der Spieler ' .. GetPlayerName(src) .. ' carried ' .. GetPlayerName(targetSrc), 'WEBHOOK_HERE')
	end
end)

RegisterServerEvent('packdenbastardvonmeinerschulterrunter')
AddEventHandler('packdenbastardvonmeinerschulterrunter', function(targetSrc)
	local src = source
	local dist = #(GetEntityCoords(GetPlayerPed(src)) - GetEntityCoords(GetPlayerPed(targetSrc)))

	if targetSrc == -1 then
		print("[2] Modder kicked [target = -1] => " .. GetPlayerName(src)) 
		DropPlayer(src, "ESX: Lern modden du skid")
		return 
	end

	if dist < 15 then 
		TriggerClientEvent('ichpackedenjetztrunter', targetSrc)
	
		exports['es_extended']:doubleLog(src, targetSrc, 'Carry - Log', 'Der Spieler ' .. GetPlayerName(src) .. ' lässt ' .. GetPlayerName(targetSrc) .. ' los', 'WEBHOOK_HERE')
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