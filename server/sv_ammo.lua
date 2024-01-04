--ESX = exports["es_extended"]:getSharedObject()

ESX.RegisterUsableItem(Config_Ammo.Item, function(source)
  local xPlayer = ESX.GetPlayerFromId(source)

  xPlayer.triggerEvent('esx_ammo:checkWeapon')
end)

RegisterNetEvent('esx_ammo:giveWeaponAmmo')
AddEventHandler('esx_ammo:giveWeaponAmmo', function(weaponName)
  local xPlayer = ESX.GetPlayerFromId(source)
  local hasItem = xPlayer.getInventoryItem(Config_Ammo.Item).count

  if xPlayer then
      if hasItem >= 1 then
          xPlayer.addWeaponAmmo(weaponName, Config_Ammo.Ammo)
          xPlayer.removeInventoryItem(Config_Ammo.Item, 1)
          xPlayer.showNotification('Du hast Munition benutzt')
      else
          xPlayer.showNotification('Du brauchs Munition zum Nachladen')
      end
  end
end)
