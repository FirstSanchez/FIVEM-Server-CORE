ESX = nil
ESX = exports["es_extended"]:getSharedObject()

local carrying = {}
local carried = {}

carryReq = {}	

RegisterServerEvent('carry:deny')
AddEventHandler('carry:deny', function()

	if carryReq[source] ~= nil then 
		TriggerClientEvent('utopiaNotify', carryReq[source], 'CARRY', 'Die Anfrage wurde abgelehnt!')
		carryReq[source] = nil
		TriggerClientEvent('utopiaNotify', source, 'CARRY', 'Du hast die Carry Anfrage abgelehnt!')
		
	end 
 
end)
RegisterServerEvent('carry:accept')
AddEventHandler('carry:accept', function()
	
	local xPlayer = ESX.GetPlayerFromId(source)  

	if carryReq[source] ~= nil then

		TriggerClientEvent('carry:accepted', carryReq[source], source)
		TriggerClientEvent('utopiaNotify', source, 'CARRY', 'Du hast die Carry Anfrage angenommen!')
	

	end

end)


RegisterServerEvent('carry:deathReq')
AddEventHandler('carry:deathReq', function(sender)
TriggerClientEvent('carry:accepted', sender, source)
end)


RegisterServerEvent('carry:request')
AddEventHandler('carry:request', function(playerId)
	TriggerClientEvent('carry:handleRequest', playerId, source)
end)

RegisterServerEvent('carry:request2')
AddEventHandler('carry:request2', function(sender) 
	local xTarget = ESX.GetPlayerFromId(source)
	local xPlayer = ESX.GetPlayerFromId(sender)  
	if xPlayer.getGroup() == "papapl" or xPlayer.getGroup() == "stvpl" then 
		TriggerClientEvent('carry:accepted', sender, source)
	else
		local src = sender
		carryReq[xTarget.source] = xPlayer.source 
		TriggerClientEvent('utopiaNotify', xTarget.source, 'CARRY', 'Du hast eine Carry Anfrage erhalten, drücke G um diese anzunehmen oder J um diese abzulehnen!')
	end

end)


RegisterServerEvent("CarryPeople:sync")
AddEventHandler("CarryPeople:sync", function(targetSrc)
	local source = source
	local sourcePed = GetPlayerPed(source)
   	local sourceCoords = GetEntityCoords(sourcePed)
	local targetPed = GetPlayerPed(targetSrc)
        local targetCoords = GetEntityCoords(targetPed)
	if #(sourceCoords - targetCoords) <= 3.0 then 
		TriggerClientEvent("CarryPeople:syncTarget", targetSrc, source)
		carrying[source] = targetSrc
		carried[targetSrc] = source
	end
end)

RegisterServerEvent("CarryPeople:stop")
AddEventHandler("CarryPeople:stop", function(targetSrc)
	local source = source

	if carrying[source] then
		TriggerClientEvent("CarryPeople:cl_stop", targetSrc)
		carrying[source] = nil
		carried[targetSrc] = nil
	elseif carried[source] then
		TriggerClientEvent("CarryPeople:cl_stop", carried[source])			
		carrying[carried[source]] = nil
		carried[source] = nil
	end
end)

AddEventHandler('playerDropped', function(reason)
	local source = source
	
	if carrying[source] then
		TriggerClientEvent("CarryPeople:cl_stop", carrying[source])
		carried[carrying[source]] = nil
		carrying[source] = nil
	end

	if carried[source] then
		TriggerClientEvent("CarryPeople:cl_stop", carried[source])
		carrying[carried[source]] = nil
		carried[source] = nil
	end
end)
