function TableContains(t, v)
    for key, value in pairs(t) do
        if (value == v) then
            return true
        end
    end

    return false
end

function IsPlayerAllowedToHaveItem(job, item)
    if (Config_Blacklist.Items[item] ~= nil and not TableContains(Config_Blacklist.Items[item], job)) then
        return false
    end

    return true
end

function IsPlayerAllowedToHaveWeapon(job, weapon)
    if (Config_Blacklist.Weapons[weapon] ~= nil and not TableContains(Config_Blacklist.Weapons[weapon], job)) then
        return false
    end

    return true
end

ESX.RegisterServerCallback("corbo_restricteditems:gotItem", function(source, cb, item)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xItem = xPlayer.getInventoryItem(item)

    if (not IsPlayerAllowedToHaveItem(xPlayer.getJob().name, item)) then
        xPlayer.showNotification("Du darfst das Item nicht besitzen")
        xPlayer.removeInventoryItem(item, xItem.count)
    end

    cb(true)
end)


ESX.RegisterServerCallback("corbo_restricteditems:gotWeapon", function(source, cb, weapon)
    local xPlayer = ESX.GetPlayerFromId(source)

    if (not IsPlayerAllowedToHaveWeapon(xPlayer.getJob().name, weapon)) then
        xPlayer.showNotification("Du darfst diese Waffe nicht besitzen")
        xPlayer.removeWeapon(weapon)
    end

    cb(true)
end)

AddEventHandler("esx:setJob", function(source, job)
    local xPlayer = ESX.GetPlayerFromId(source)

    job = job.name

    for key, value in pairs(xPlayer.getInventory(true)) do
        if (not IsPlayerAllowedToHaveItem(job, key)) then
            local xItem = xPlayer.getInventoryItem(key)
            xPlayer.showNotification("Du darfst das Item nicht besitzen")
            xPlayer.removeInventoryItem(key, xItem.count)
        end
    end

    for key, value in ipairs(xPlayer.getLoadout()) do
        if (not IsPlayerAllowedToHaveWeapon(job, value.name)) then
            xPlayer.showNotification("Du darfst diese Waffe nicht besitzen")
            xPlayer.removeWeapon(value.name)
        end
    end
end)
