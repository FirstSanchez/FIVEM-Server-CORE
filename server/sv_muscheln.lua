local players = {}

ESX.RegisterServerCallback('corbo_muscheln:sammeln', function(src, cb)
    local xPlayer = ESX.GetPlayerFromId(src)

    if (xPlayer ~= nil) then
        if ((players[src] ~= nil and (GetGameTimer() - players[src] >= 4900)) or players[src] == nil) then
            if (xPlayer.canCarryItem("muschel", 1)) then
                xPlayer.addInventoryItem("muschel", 1)
            else
                xPlayer.showNotification("Du hast kein Platz für eine Muschel in deinem Inventar")
            end
        end
        players[src] = GetGameTimer()
    end

    cb(true)
end)

ESX.RegisterServerCallback('corbo_muscheln:cansell', function(src, cb)
    local xPlayer = ESX.GetPlayerFromId(src)

    if (xPlayer ~= nil) then
        local pearls = xPlayer.getInventoryItem("pearl").count
        local diamonds = xPlayer.getInventoryItem("diamond").count

        if (pearls > 0 or diamonds > 0) then
            cb(true)
        else
            cb(false)
        end
    end
end)

ESX.RegisterServerCallback('corbo_muscheln:sell', function(src, cb)
    local xPlayer = ESX.GetPlayerFromId(src)

    if (xPlayer ~= nil) then
        local money = 0

        local pearls = xPlayer.getInventoryItem("pearl").count
        local diamonds = xPlayer.getInventoryItem("diamond").count

        if (pearls > 0) then
            xPlayer.removeInventoryItem("pearl", pearls)
            money = money + (Confing_Muscheln.Prices.Pearl * pearls)
        end

        if (diamonds > 0) then
            xPlayer.removeInventoryItem("diamond", diamonds)
            money = money + (Confing_Muscheln.Prices.Diamond * diamonds)
        end

        xPlayer.addMoney(money)
        cb(money, pearls, diamonds)
    end
end)

ESX.RegisterUsableItem('muschel', function(playerId)
    local xPlayer = ESX.GetPlayerFromId(playerId)

    if (xPlayer ~= nil) then
        xPlayer.removeInventoryItem("muschel", 1)
        local percentage = math.random(0, 100)

        if (percentage >= 50) then
            if (percentage >= 75 and math.random(0, 3) == math.random(0, 3)) then
                if (xPlayer.canCarryItem("diamond", 1)) then
                    xPlayer.addInventoryItem("diamond", 1)
                else
                    xPlayer.showNotification("Du hast kein Platz für einen Diamanten in deinem Inventar")
                end
            else
                if (percentage >= 70) then
                    if (xPlayer.canCarryItem("pearl", 1)) then
                        xPlayer.addInventoryItem("pearl", 1)
                    else
                        xPlayer.showNotification("Du hast kein Platz für eine Perle in deinem Inventar")
                    end
                end
            end
        end
    end
end)
