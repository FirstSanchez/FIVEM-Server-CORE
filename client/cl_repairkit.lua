ESX = nil

CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Wait(0)
    end
end)

local CurrentAction		= nil
local PlayerData		= {}

RegisterNetEvent('esx_repairkit:onUse')
  AddEventHandler('esx_repairkit:onUse', function()
      local playerPed		= PlayerPedId()
      local coords		= GetEntityCoords(playerPed)
  
      if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
          local vehicle = nil
  
          if IsPedInAnyVehicle(playerPed, false) then
              vehicle = GetVehiclePedIsIn(playerPed, false)
          else
              vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
          end
  
          if DoesEntityExist(vehicle) then
              if Config_Repairkit.IgnoreAbort then
                  TriggerServerEvent('esx_repairkit:removeKit')
              end
              TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_BUM_BIN", 0, true)
  
              CreateThread(function()
                  ThreadID = GetIdOfThisThread()
                  CurrentAction = 'repair'
  
                  Wait(Config_Repairkit.RepairTime * 1000)
  
                  if CurrentAction ~= nil then
                      SetVehicleFixed(vehicle)
                      SetVehicleDeformationFixed(vehicle)
                      SetVehicleUndriveable(vehicle, false)
                      SetVehicleEngineOn(vehicle, true, true)
                      ClearPedTasksImmediately(playerPed)
  
                      ESX.ShowNotification('Du hast das Fahrzeug repariert!')
                  end
  
                  if not Config_Repairkit.IgnoreAbort then
                      TriggerServerEvent('esx_repairkit:removeKit')
                  end
  
                  CurrentAction = nil
                  TerminateThisThread()
              end)
          end
  
          CreateThread(function()
              Wait(0)
  
              if CurrentAction ~= nil then
                  SetTextComponentFormat('STRING')
                  AddTextComponentString('Drücke X um den Vorgang abzubrechen')
                  DisplayHelpTextFromStringLabel(0, 0, 1, -1)
  
                  if IsControlJustReleased(0, Keys["X"]) then
                      TerminateThread(ThreadID)
                      ESX.ShowNotification('Du hast die Reparatur abgebrochen!')
                      CurrentAction = nil
                  end
              end
  
          end)
      else
          ESX.ShowNotification('Kein Fahrzeug in der Nähe')
      end
end)