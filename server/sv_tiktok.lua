ESX.RegisterCommand(Config_Tiktok.Command, 'user', function(xPlayer, args, showError)
    MySQL.single('SELECT hasReceiveTikTokCar FROM users WHERE identifier = ?', { xPlayer.getIdentifier() }, function(row)
        if (not row.hasReceiveTikTokCar) then
            local plate = GeneratePlate()
            MySQL.update('UPDATE users SET hasReceiveTikTokCar = ? WHERE identifier = ?',
                { true, xPlayer.getIdentifier() },
                function(affectedRows)
                    xPlayer.showNotification(string.format(
                        "Du hast das TikTok Fahrzeug mit dem Kennzeichen %s bekommen", plate))
                    ExecuteCommand("_givecar " .. tostring(xPlayer.source) .. " " .. Config_Tiktok.Vehicle .. " " .. plate)
                end)
        else
            xPlayer.showNotification("Du hast dir dein TikTok Fahrzeug bereits abgeholt")
        end
    end)
end, false, { help = "Hole dir deinen TikTok Bonus ab!" })

ESX.RegisterCommand(Config_Tiktok.ResetCommand, Config_Tiktok.ResetPermissions, function(xPlayer, args, showError)
    MySQL.update('UPDATE users SET hasReceiveTikTokCar = ?', { false },
        function(affectedRows)
            xPlayer.showNotification("Du hast die TikTok Belohnungen zurück gesetzt")
        end)
end, false, { help = "Resette die TikTok Belohnungen!" })

RegisterNetEvent("corbo_tiktok:sendProps", function(plate, vehicleProps)
    local xPlayer = ESX.GetPlayerFromId(source)

    if (xPlayer ~= nil) then
        MySQL.single('SELECT * FROM owned_vehicles WHERE owner = ? AND plate = ?', { xPlayer.getIdentifier(), plate },
            function(result)
                if result then
                    MySQL.update('UPDATE owned_vehicles SET vehicle = ? WHERE plate = ? ', { vehicleProps, plate },
                        function(affectedRows)
                        end)
                end
            end)
    end
end)

local NumberCharset  = {}
local Charset        = {}

Config_Tiktok.PlateLetters  = 3
Config_Tiktok.PlateNumbers  = 3
Config_Tiktok.PlateUseSpace = true

for i = 48, 57 do table.insert(NumberCharset, string.char(i)) end

for i = 65, 90 do table.insert(Charset, string.char(i)) end
for i = 97, 122 do table.insert(Charset, string.char(i)) end

function GeneratePlate()
    math.randomseed(GetGameTimer())

    local generatedPlate = string.upper(GetRandomLetter(Config_Tiktok.PlateLetters) ..
        (Config_Tiktok.PlateUseSpace and ' ' or '') .. GetRandomNumber(Config_Tiktok.PlateNumbers))

    local isTaken = IsPlateTaken(generatedPlate)
    if isTaken then
        return GeneratePlate()
    end

    return generatedPlate
end

-- mixing async with sync tasks
function IsPlateTaken(plate)
    local p = promise.new()

    MySQL.scalar('SELECT plate FROM owned_vehicles WHERE plate = ?', { plate },
        function(isPlateTaken)
            isPlateTaken = result ~= nil
            p:resolve(isPlateTaken)
        end)

    return Citizen.Await(p)
end

function GetRandomNumber(length)
    Wait(0)
    return length > 0 and GetRandomNumber(length - 1) .. NumberCharset[math.random(1, #NumberCharset)] or ''
end

function GetRandomLetter(length)
    Wait(0)
    return length > 0 and GetRandomLetter(length - 1) .. Charset[math.random(1, #Charset)] or ''
end
