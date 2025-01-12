RegisterNetEvent('esx_ammo:checkWeapon')
AddEventHandler('esx_ammo:checkWeapon', function()
    local playerPed = PlayerPedId()
    local hash = GetSelectedPedWeapon(playerPed)
    
    if IsPedArmed(playerPed, 4) then
        if hash ~= nil then
            local weapon = ESX.GetWeaponFromHash(hash)

            TaskReloadWeapon(playerPed, 1)
            TriggerServerEvent('esx_ammo:giveWeaponAmmo', weapon.name)
        end
    end
end)