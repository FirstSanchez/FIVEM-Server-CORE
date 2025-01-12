function DeleteCar(tipo)
    local Weapons = {'WEAPON_RUN_OVER_BY_CAR', 'WEAPON_RAMMED_BY_CAR'}
    for i, CurrentWeapon in ipairs(Weapons) do
        if GetHashKey(CurrentWeapon) == tipo then
            return true
        end
    end
    return false
end

CreateThread(function()
    local DeathReason, Killer, DeathCauseHash, Weapon
    while true do
        local playerPed = PlayerPedId()
        Wait(250)
        if IsEntityDead(playerPed) then
            DeathCauseHash = GetPedCauseOfDeath(playerPed)
            if DeleteCar(DeathCauseHash) then
                Wait(1000)
                TriggerEvent("esx_ambulancejob:revive")
                ESX.ShowNotification("ESX | AntiVDM: Du wurdest VDMt und revived")
            end
        end
        while IsEntityDead(playerPed) do
            Wait(1000)
        end
    end
end)