RegisterCommand("tc", function(source, args)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local msg = table.concat(args, " ")

    if xPlayer then 
        if isTeam(xPlayer.getGroup()) then 
            local playerName = GetPlayerName(src)
            
            for _, playerId in pairs(ESX.GetPlayers()) do 
                local xTarget = ESX.GetPlayerFromId(playerId)

                if xTarget then 
                    if isTeam(xTarget.getGroup()) then 
                        TriggerEvent("prime_teamNotify", playerName .. " ID - " .. src .. " | " .. firstToUpper(xPlayer.getGroup()), msg, 12000)
                    end
                end
            end
        end
    end
end, false)

local teamGroups = {
    "pl",
    "management",
    "manager",
    "teamleitung",
    "frakleitung",
    "administrator",
    "moderator",
    "supporter",
    "guide",
    "event"
}

function isTeam(playerGroup)
    for _, group in pairs(teamGroups) do 
        if playerGroup == group then 
            return true 
        end
    end
    return false
end
function firstToUpper(str)
return (str:gsub("^%l", string.upper))
end