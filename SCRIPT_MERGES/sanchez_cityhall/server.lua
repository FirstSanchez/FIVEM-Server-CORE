-- DATABASE STUFF & FUNCTIONS
function InitializeDatabase()
    MySQL.Async.execute([[
        CREATE TABLE IF NOT EXISTS `sanchez_cityhall_social` (
            `id` INT NOT NULL AUTO_INCREMENT,
            `identifier` VARCHAR(255) NOT NULL,
            `applied_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
            PRIMARY KEY (`id`),
            UNIQUE KEY `identifier` (`identifier`)
        );
    ]], {}, function(rowsChanged)
        print("[SANCHEZ CITYHALL] - Datenbank initialisiert")
    end)

    MySQL.Async.execute([[
        ALTER TABLE users 
        ADD IF NOT EXISTS playtime INT NOT NULL DEFAULT 0,
        ADD IF NOT EXISTS kills INT NOT NULL DEFAULT 0,
        ADD IF NOT EXISTS deaths INT NOT NULL DEFAULT 0,
        ADD IF NOT EXISTS kd_ratio FLOAT(5,2) NOT NULL DEFAULT 0.00;
    ]], {}, function(rowsChanged)
        print("[SANCHEZ CITYHALL] - 'users' Tabelle initialisiert")
    end)
    
    MySQL.Async.execute([[
        CREATE TABLE IF NOT EXISTS `sanchez_cityhall_marriage` (
            `id` INT NOT NULL AUTO_INCREMENT,
            `player1` VARCHAR(255) NOT NULL,
            `player2` VARCHAR(255) NOT NULL,
            `married_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
            PRIMARY KEY (`id`)
        );
    ]], {}, function(rowsChanged)
        print("[SANCHEZ CITYHALL] - 'sanchez_cityhall_marriage' Tabelle initialisiert")
    end)

    print ("[SANCHEZ CITYHALL] - Alle Tabellen initialisiert - Bereit zum Loslegen!")
end



CreateThread(function()
    InitializeDatabase()
end)

AddEventHandler('esx:playerLoaded', function(playerId, xPlayer)
    local identifier = xPlayer.identifier

    if Config.SocialMoney.enable then
        IsPlayerEligibleForSocialMoney(playerId, function(isEligible)
            if isEligible then
                StartSocialMoneyTimer(playerId)
            end
        end)
    end

    StartPlaytimeTracker(playerId, xPlayer.identifier)
end)


function hasAppliedForSocialMoney(identifier, cb)
    MySQL.Async.fetchScalar('SELECT COUNT(*) FROM sanchez_cityhall_social WHERE identifier = @identifier', {
        ['@identifier'] = identifier
    }, function(count)
        cb(count > 0)
    end)
end


function addRecipientToDatabase(identifier)
    MySQL.Async.execute('INSERT INTO sanchez_cityhall_social (identifier) VALUES (@identifier)', {
        ['@identifier'] = identifier
    })
end

function removeRecipientFromDatabase(identifier, callback)
    MySQL.Async.execute('DELETE FROM sanchez_cityhall_social WHERE identifier = @identifier', {
        ['@identifier'] = identifier
    }, function(rowsChanged)
        if rowsChanged > 0 then
            callback(true)
        else
            callback(false)
        end
    end)
end


function isJobAllowed(job)
    for _, allowedJob in ipairs(Config.SocialMoney.allowedJobs) do
        if job == allowedJob then
            return true
        end
    end
    return false
end



-- SOCIAL MONEY FUNC / CHECKS

AddEventHandler('esx:setJob', function(playerId, job, lastJob)
    local xPlayer = ESX.GetPlayerFromId(playerId)
    local identifier = xPlayer.identifier

    if not isJobAllowed(job.name, Config.SocialMoney.allowedJobs) then
        removeRecipientFromDatabase(identifier, function(removed)
            if removed then
                serverNotify (xPlayer.source, "You are no longer eligible for social money!")
            else
                print ("[SANCHEZ CITYHALL] - Error removing player from database || Name: " .. xPlayer.name .. " || Identifier: " .. identifier .. " || New Job: " .. job.name .. " || Last Job: " .. lastJob.name)
            end
        end)
    end
end)

ESX.RegisterServerCallback('sanchez_cityhall:checkJobForSocialMoney', function(source, callback)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerJob = xPlayer.job.name

    if isJobAllowed(playerJob) then
        callback(true)
    else
        callback(false)
    end
end)

function IsPlayerEligibleForSocialMoney(playerId, callback)
    local xPlayer = ESX.GetPlayerFromId(playerId)
    local identifier = xPlayer.identifier
    local playerJob = xPlayer.job.name
    local allowedJobs = Config.SocialMoney.allowedJobs

    if isJobAllowed(playerJob, allowedJobs) then
        hasAppliedForSocialMoney(identifier, function(hasApplied)
            callback(hasApplied)
        end)
    else
        removeRecipientFromDatabase(identifier, function(removed)
            if removed then
                callback(false)
            else
                callback(true)
                print ("[SANCHEZ CITYHALL] - Error removing player from database || Name: " .. xPlayer.name .. " || Identifier: " .. identifier .. " || Job: " .. playerJob)
            end
        end)
    end
end


--- SOCIAL MONEY EVENTS

RegisterServerEvent('sanchez_cityhall:applyForSocialMoney')
AddEventHandler('sanchez_cityhall:applyForSocialMoney', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerJob = xPlayer.job.name
    local identifier = xPlayer.identifier

    if isJobAllowed(playerJob) then
        hasAppliedForSocialMoney(identifier, function(hasApplied)
            if not hasApplied then
                addRecipientToDatabase(identifier)
                serverNotify(xPlayer.source, "You have successfully applied for social money!")
                StartSocialMoneyTimer(xPlayer.source)
            else
                serverNotify(xPlayer.source, "You have already applied for social money!")
            end
        end)
    else
        serverNotify(xPlayer.source, "You are not allowed to use this service!")
    end
end)



RegisterServerEvent('sanchez_cityhall:collectStoredSocialMoney')
AddEventHandler('sanchez_cityhall:collectStoredSocialMoney', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local identifier = xPlayer.identifier

    if Config.SocialMoney.money.automaticMode then
        serverNotify(source, string.format("The social money is automatically collected every ~g~%s~s~ minutes.", Config.SocialMoney.money.paymentSchedule))
    else
        if pendingSocialMoney[identifier] and pendingSocialMoney[identifier] > 0 then
            local amount = pendingSocialMoney[identifier]
            xPlayer.addMoney(amount)
            pendingSocialMoney[identifier] = nil

            serverNotify(source, string.format("You collected ~g~$%s~s~ from your social money.", amount))
        else
            serverNotify(source, "You don't have any pending social money.")
        end
    end
end)

RegisterServerEvent('sanchez_cityhall:endSocialMoney')
AddEventHandler('sanchez_cityhall:endSocialMoney', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local identifier = xPlayer.identifier

    removeRecipientFromDatabase(identifier, function(hasRemoved)
        if hasRemoved then
            serverNotify(xPlayer.source, "You have successfully ended your social money.")
        else
            serverNotify(xPlayer.source, "You don't have social money.")
        end
    end)
end)




-- SOCIAL MONEY TIMER & MONEY SAVING FUNCTION

local pendingSocialMoney = {}

function StorePendingSocialMoney(identifier, amount)
    pendingSocialMoney[identifier] = (pendingSocialMoney[identifier] or 0) + amount
    serverNotify(source, string.format("You can collect now ~g~$%s~s~ from your social money in CITYHALL", pendingSocialMoney[identifier]))
end


local timers = {}

function StartSocialMoneyTimer(src)
    local xPlayer = ESX.GetPlayerFromId(src)
    if not xPlayer then return end 

    local identifier = xPlayer.identifier
    local elapsedTime = 0
    local continueLoop = true

    timers[identifier] = elapsedTime

    CreateThread(function()
        while continueLoop do
            Wait(1000)
            elapsedTime = elapsedTime + 1
            timers[identifier] = elapsedTime

            if elapsedTime >= Config.SocialMoney.money.paymentSchedule * 60 then
                hasAppliedForSocialMoney(identifier, function(hasApplied)
                    if hasApplied then
                        if Config.SocialMoney.money.automaticMode then
                            xPlayer.addAccountMoney('bank', Config.SocialMoney.money.payment)
                            serverNotify(xPlayer.source, string.format("You received ~g~$%s~s~ from your social money.", Config.SocialMoney.money.payment))
                        else
                            StorePendingSocialMoney(identifier, Config.SocialMoney.money.payment)
                            while pendingSocialMoney[identifier] do
                                Wait(5000)
                            end
                        end
                        elapsedTime = 0
                    else
                        continueLoop = false
                    end
                end)
            end
        end
    end)
end

function getRemainingTimeForPlayer(identifier)
    local elapsedTime = timers[identifier] or 0
    local remainingTime = Config.SocialMoney.money.paymentSchedule * 60 - elapsedTime
    return remainingTime
end

function getRemainingTimeFromDatabase(identifier)
    return getRemainingTimeForPlayer(identifier)
end



RegisterServerEvent('sanchez_cityhall:getRemainingTime')
AddEventHandler('sanchez_cityhall:getRemainingTime', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local identifier = xPlayer.identifier

    local remainingTime = getRemainingTimeFromDatabase(identifier) 

    TriggerClientEvent('sanchez_cityhall:receiveRemainingTime', source, remainingTime)
end)




-- NAMECHANGE FUNCTIONS


ESX.RegisterServerCallback('sanchez_cityhall:getCurrentName', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local identifier = xPlayer.identifier

    MySQL.Async.fetchAll('SELECT firstname, lastname FROM users WHERE identifier = @identifier', {
        ['@identifier'] = identifier
    }, function(result)
        if result and result[1] then
            local firstName = result[1].firstname
            local lastName = result[1].lastname
            cb(firstName, lastName)
        else
            cb(nil, nil)
        end
    end)
end)

ESX.RegisterServerCallback('sanchez_cityhall:canChangeName', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)

    if Config.Namechange.item.needItem then
        local hasItem = xPlayer.getInventoryItem(Config.Namechange.item.itemName).count > 0
        cb(hasItem)
    else
        local playerMoney = xPlayer.getMoney()
        if playerMoney >= Config.Namechange.price then
            xPlayer.removeMoney(Config.Namechange.price)
            cb(true)
        else
            cb(false)
        end
    end
end)


RegisterServerEvent('sanchez_cityhall:changeName')
AddEventHandler('sanchez_cityhall:changeName', function(newFirstName, newLastName)
    local xPlayer = ESX.GetPlayerFromId(source)
    local identifier = xPlayer.identifier

    if Config.Namechange.item.needItem then
        local hasItem = xPlayer.getInventoryItem(Config.Namechange.item.itemName).count > 0
        local itemLabel = Config.Namechange.item.itemLabel
        if not hasItem then
            serverNotify(source, "Du brauchst ein Item dafür: " .. itemLabel)
            return
        end
        xPlayer.removeInventoryItem(Config.Namechange.item.itemName, 1)
    else
        local playerMoney = xPlayer.getMoney()
        if playerMoney < Config.Namechange.price then
            serverNotify(source, "Du hast nicht genug Geld!")
            return
        end
        xPlayer.removeMoney(Config.Namechange.price)
    end

    if newFirstName then
        MySQL.Async.execute('UPDATE users SET firstname = @firstname WHERE identifier = @identifier', {
            ['@firstname'] = newFirstName,
            ['@identifier'] = identifier
        })
    end

    if newLastName then
        MySQL.Async.execute('UPDATE users SET lastname = @lastname WHERE identifier = @identifier', {
            ['@lastname'] = newLastName,
            ['@identifier'] = identifier
        })
    end

    serverNotify(source, "Du hast deinen Namen erfolgreich geändert. Du bist jetzt: " .. newFirstName .. " " .. newLastName)
end)



--- PLAYTIME TRACKER & STATS

local playerPlaytimes = {}
local playerTimers = {}

function StartPlaytimeTracker(playerId, identifier)
    local xPlayer = ESX.GetPlayerFromId(playerId)
    if not xPlayer then return end

    if not playerTimers[identifier] then
        playerTimers[identifier] = true

        MySQL.Async.fetchScalar('SELECT playtime FROM users WHERE identifier = @identifier', {
            ['@identifier'] = identifier
        }, function(playtime)
            playerPlaytimes[identifier] = playtime or 0

            CreateThread(function()
                while playerTimers[identifier] do
                    Wait(60000)
                    playerPlaytimes[identifier] = playerPlaytimes[identifier] + 1

                    MySQL.Async.execute('UPDATE users SET playtime = @newPlaytime WHERE identifier = @identifier', {
                        ['@newPlaytime'] = playerPlaytimes[identifier],
                        ['@identifier'] = identifier
                    })
                end
            end)
        end)
    end
end

AddEventHandler('playerDropped', function(reason)
    local playerId = source
    local xPlayer = ESX.GetPlayerFromId(playerId)
    if xPlayer then
        playerTimers[xPlayer.identifier] = nil
    end
end)


ESX.RegisterServerCallback('sanchez_cityhall:getPlayerStats', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local identifier = xPlayer.identifier

    MySQL.Async.fetchAll('SELECT firstname, lastname, sex, dateofbirth, playtime, kills, deaths, kd_ratio, phone_number, height FROM users WHERE identifier = @identifier', {
        ['@identifier'] = identifier
    }, function(result)
        if result[1] then
            local data = result[1]
            local stats = {
                firstname = data.firstname,
                lastname = data.lastname,
                sex = data.sex,
                dateofbirth = data.dateofbirth,
                height = data.height,
                phone_number = data.phone_number,
                job = xPlayer.job.name,
                job_grade = xPlayer.job.grade_label,
                money = xPlayer.getMoney(),
                bank = xPlayer.getAccount('bank').money,
                black_money = xPlayer.getAccount('black_money').money,
                total_money = xPlayer.getMoney() + xPlayer.getAccount('bank').money + xPlayer.getAccount('black_money').money,
                playtime = data.playtime,
                kills = data.kills,
                deaths = data.deaths,
                kd_ratio = data.kd_ratio,
            }
            

            
            -- Get the number of owned vehicles
            MySQL.Async.fetchScalar('SELECT COUNT(*) FROM owned_vehicles WHERE owner = @identifier', {
                ['@identifier'] = identifier
            }, function(vehicleCount)
                stats.vehicles = vehicleCount

                -- Check marriage status
                MySQL.Async.fetchAll('SELECT player1, player2 FROM sanchez_cityhall_marriage WHERE player1 = @identifier OR player2 = @identifier', {
                    ['@identifier'] = identifier
                }, function(result)
                    if result[1] then
                        local spouseIdentifier
                        if result[1].player1 == identifier then
                            spouseIdentifier = result[1].player2
                        else
                            spouseIdentifier = result[1].player1
                        end

                        MySQL.Async.fetchScalar('SELECT CONCAT(firstname, " ", lastname) as fullname FROM users WHERE identifier = @spouseIdentifier', {
                            ['@spouseIdentifier'] = spouseIdentifier
                        }, function(spouseName)
                            stats.isMarried = true
                            stats.spouse = spouseName
                            cb(stats)
                        end)
                    else
                        stats.isMarried = false
                        stats.spouse = "Not married"
                        cb(stats)
                    end
                end)
            end)
        else
            cb(nil)
        end
    end)
end)

RegisterServerEvent('esx:onPlayerDeath')
AddEventHandler('esx:onPlayerDeath', function(data)
    local victim = ESX.GetPlayerFromId(source)

    if victim then
        AddDeathForPlayer(victim.identifier)
        UpdateKDForPlayer(victim.identifier)
    end

    if data.killedByPlayer then
        local killer = ESX.GetPlayerFromId(data.killerServerId)
        if killer then
            AddKillForPlayer(killer.identifier)
            UpdateKDForPlayer(killer.identifier)
        end
    end
end)


function AddKillForPlayer(identifier)
    MySQL.Async.execute('UPDATE users SET kills = kills + 1 WHERE identifier = @identifier', {
        ['@identifier'] = identifier
    })
end

function AddDeathForPlayer(identifier)
    MySQL.Async.execute('UPDATE users SET deaths = deaths + 1 WHERE identifier = @identifier', {
        ['@identifier'] = identifier
    })
end

function UpdateKDForPlayer(identifier)
    MySQL.Async.fetchAll('SELECT kills, deaths FROM users WHERE identifier = @identifier', {
        ['@identifier'] = identifier
    }, function(result)
        if result[1] then
            local kills = result[1].kills
            local deaths = result[1].deaths
            local kd = (deaths == 0) and kills or (kills / deaths)
            
            MySQL.Async.execute('UPDATE users SET kd_ratio = @kd WHERE identifier = @identifier', {
                ['@identifier'] = identifier,
                ['@kd'] = kd
            })
        end
    end)
end

RegisterServerEvent('sanchez_cityhall:addDeath')
AddEventHandler('sanchez_cityhall:addDeath', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        AddDeathForPlayer(xPlayer.identifier)
        UpdateKDForPlayer(xPlayer.identifier)
    end
end)

RegisterServerEvent('sanchez_cityhall:addKill')
AddEventHandler('sanchez_cityhall:addKill', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        AddKillForPlayer(xPlayer.identifier)
        UpdateKDForPlayer(xPlayer.identifier)
    end
end)



-- MARRIAGE 

function IsPlayerAlreadyMarried(playerIdentifier, callback)
    MySQL.Async.fetchScalar('SELECT COUNT(*) FROM sanchez_cityhall_marriage WHERE player1 = @player OR player2 = @player', {
        ['@player'] = playerIdentifier
    }, function(count)
        callback(count > 0)
    end)
end

function AddMarriageToDatabase(player1, player2, callback)
    MySQL.Async.execute('INSERT INTO sanchez_cityhall_marriage (player1, player2) VALUES (@player1, @player2)', {
        ['@player1'] = player1,
        ['@player2'] = player2
    }, function(rowsChanged)
        callback(rowsChanged > 0)
    end)
end

function RemoveMarriage(identifier, cb)
    MySQL.Async.execute('DELETE FROM sanchez_cityhall_marriage WHERE player1 = @identifier OR player2 = @identifier', {
        ['@identifier'] = identifier
    }, function(rowsChanged)
        cb(rowsChanged > 0)
    end)
end

function GetSpouse(identifier, cb)
    MySQL.Async.fetchScalar('SELECT player1 FROM sanchez_cityhall_marriage WHERE player2 = @identifier UNION SELECT player2 FROM sanchez_cityhall_marriage WHERE player1 = @identifier', {
        ['@identifier'] = identifier
    }, function(spouseIdentifier)
        cb(spouseIdentifier)
    end)
end


RegisterServerEvent("sanchez_cityhall:sendMarriageRequest")
AddEventHandler("sanchez_cityhall:sendMarriageRequest", function(target)
    local sourcePlayer = source
    local xPlayer = ESX.GetPlayerFromId(sourcePlayer)
    local xTarget = ESX.GetPlayerFromId(target)

    if not xTarget or xTarget == -1 then
        print ("[SANCHEZ CITYHALL] - Spieler nicht gefunden")
        return
    end

    if xPlayer == xTarget then
        serverNotify(xPlayer.source, "Du kannst dich nicht selbst heiraten!")
        return
    end

    IsPlayerAlreadyMarried(xPlayer.identifier, function(isMarried)
        if isMarried then
            serverNotify(xPlayer.source, "Du bist bereits verheiratet!")
            return
        end

        IsPlayerAlreadyMarried(xTarget.identifier, function(isMarried)
            if isMarried then
                serverNotify(xPlayer.source, "Dieser Spieler ist bereits verheiratet!")
                return
            end

            MySQL.Async.fetchAll('SELECT identifier, sex FROM users WHERE identifier IN (@sourceIdentifier, @targetIdentifier)', {
                ['@sourceIdentifier'] = xPlayer.identifier,
                ['@targetIdentifier'] = xTarget.identifier
            }, function(result)
                local sourceSex, targetSex
                for _, row in ipairs(result) do
                    if row.identifier == xPlayer.identifier then
                        sourceSex = row.sex
                    else
                        targetSex = row.sex
                    end
                end

                if not Config.Marriage.general.allowSameGender and sourceSex == targetSex then
                    serverNotify(xPlayer.source, "Gleichgeschlechtliche Eheschließungen sind nicht erlaubt.")
                    return
                end

                if Config.Marriage.item.needItem then
                    local itemName = Config.Marriage.item.itemName
                    local item = xPlayer.getInventoryItem(itemName)

                    if not item or item.count <= 0 then
                        serverNotify(xPlayer.source, "Du brauchst ein " .. Config.Marriage.item.itemLabel .. " um zu Heiraten.")
                        return
                    end
                end

                TriggerClientEvent('sanchez_cityhall:receiveMarriageRequest', xTarget.source, xPlayer.source, xPlayer.getName())

            end)
        end)
    end)
end)


RegisterServerEvent('sanchez_cityhall:acceptMarriage')
AddEventHandler('sanchez_cityhall:acceptMarriage', function(requesterId)
    local sourcePlayer = source
    local xPlayer = ESX.GetPlayerFromId(sourcePlayer)
    local xRequester = ESX.GetPlayerFromId(requesterId)

    if not xRequester then
        serverNotify(xPlayer.source, "Der Spieler, der den Vorschlag gemacht hat, ist nicht mehr online.")
        return
    end

    IsPlayerAlreadyMarried(xRequester.identifier, function(isRequesterMarried)
        if isRequesterMarried then
            serverNotify(xRequester.source, "Du bist bereits verheiratet!")
            return
        end

        IsPlayerAlreadyMarried(xPlayer.identifier, function(isTargetMarried)
            if isTargetMarried then
                serverNotify(xPlayer.source, "Du bist bereits verheiratet!")
                return
            end

            local canProceed = true

            -- item check
            if Config.Marriage.item.needItem then
                local itemName = Config.Marriage.item.itemName
                local item = xRequester.getInventoryItem(itemName)

                if not item or item.count <= 0 then
                    serverNotify(xRequester.source, "Du hast nicht mehr die " .. Config.Marriage.item.itemLabel .. " für die Ehe erforderlich.")
                    canProceed = false
                end
            end

            -- money check
            local marriagePrice = Config.Marriage.cost.marriagePrice
            if xRequester.getMoney() < marriagePrice then
                serverNotify(xRequester.source, "Du hast nicht genug Geld zum Heiraten.")
                canProceed = false
            end

            -- proceed
            if canProceed then
                AddMarriageToDatabase(xRequester.identifier, xPlayer.identifier, function(success)
                    if success then
                        if Config.Marriage.item.needItem then
                            xRequester.removeInventoryItem(Config.Marriage.item.itemName, 1)
                        end
                        xRequester.removeMoney(marriagePrice)
                        serverNotify(xRequester.source, "Herzlichen Glückwunsch! Du bist jetzt verheiratet mit " .. xPlayer.getName() .. ".")
                        serverNotify(xPlayer.source, "Herzlichen Glückwunsch! Du bist jetzt verheiratet mit " .. xRequester.getName() .. ".")

                        if Config.Marriage.notifyAll then
                            local msg = string.format(Config.Marriage.notifyAllmsg, xRequester.getName(), xPlayer.getName())
                            serverNotify(-1, msg)
                        end
                    else
                        serverNotify(xRequester.source, "Bei der Bearbeitung der Heirat ist ein Fehler aufgetreten. Bitte versuche es noch einmal.")
                        serverNotify(xPlayer.source, "Bei der Bearbeitung der Heirat ist ein Fehler aufgetreten. Bitte versuche es noch einmal.")
                        print ("[SANCHEZ CITYHALL] - Fehlerverarbeitung Ehe zwischen " .. xRequester.getName() .. " und " .. xPlayer.getName() .. " || Kontaktiere Sanchez!")
                    end
                end)
            end
        end)
    end)
end)


RegisterServerEvent('sanchez_cityhall:declineMarriage')
AddEventHandler('sanchez_cityhall:declineMarriage', function(requesterId)
    local sourcePlayer = source
    local xPlayer = ESX.GetPlayerFromId(sourcePlayer)
    local xRequester = ESX.GetPlayerFromId(requesterId)
    serverNotify(xRequester.source, xPlayer.getName() .. " hat einen Heiratsantrag abgelehnt.")
end)

ESX.RegisterServerCallback('sanchez_cityhall:getSpouseName', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local identifier = xPlayer.identifier

    MySQL.Async.fetchAll('SELECT player1, player2 FROM sanchez_cityhall_marriage WHERE player1 = @identifier OR player2 = @identifier', {
        ['@identifier'] = identifier
    }, function(result)
        if result[1] then
            local spouseIdentifier = (result[1].player1 == identifier) and result[1].player2 or result[1].player1

            MySQL.Async.fetchScalar('SELECT CONCAT(firstname, " ", lastname) as fullname FROM users WHERE identifier = @spouseIdentifier', {
                ['@spouseIdentifier'] = spouseIdentifier
            }, function(spouseName)
                if spouseName then
                    cb(spouseName)
                else
                    cb(nil)
                end
            end)
        else
            cb(nil)
        end
    end)
end)


RegisterServerEvent('sanchez_cityhall:requestDivorce')
AddEventHandler('sanchez_cityhall:requestDivorce', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local identifier = xPlayer.identifier

    IsPlayerAlreadyMarried(identifier, function(isMarried)
        if isMarried then
            GetSpouse(identifier, function(spouseIdentifier)
                RemoveMarriage(identifier, function(success)
                    if success then
                        serverNotify(xPlayer.source, "Du hast dich von deinem Partner scheiden lassen.")
                        
                        local xSpouse = ESX.GetPlayerFromIdentifier(spouseIdentifier)
                        if xSpouse then
                            serverNotify(xSpouse.source, "Dein Partner hat sich von dir scheiden lassen.")
                        end
                    else
                        print ("[SANCHEZ CITYHALL] - Fehlerverarbeitung Scheidung zwischen " .. xPlayer.getName() .. " und " .. xSpouse.getName() .. " || Kontaktiere Sanchez!")
                        serverNotify(xPlayer.source, "Es ist ein Fehler bei der Bearbeitung der Scheidung aufgetreten. Bitte versuche es noch einmal zwischen.")
                    end
                end)
            end)
        else
            TriggerClientEvent('esx:showNotification', xPlayer.source, "Du bist nicht verheiratet.")
        end
    end)
end)

RegisterServerEvent('sanchez_cityhall:getMarriageInfo')
AddEventHandler('sanchez_cityhall:getMarriageInfo', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local identifier = xPlayer.identifier

    MySQL.Async.fetchAll('SELECT player1, player2, DATE_FORMAT(married_at, "%d-%m-%Y") as marriedDate FROM sanchez_cityhall_marriage WHERE player1 = @identifier OR player2 = @identifier', {
        ['@identifier'] = identifier
    }, function(result)
        if result[1] then
            local spouseIdentifier = (result[1].player1 == identifier) and result[1].player2 or result[1].player1
            local marriedDate = result[1].marriedDate

            MySQL.Async.fetchScalar('SELECT CONCAT(firstname, " ", lastname) as fullname FROM users WHERE identifier = @identifier', {
                ['@identifier'] = spouseIdentifier
            }, function(spouseName)
                if spouseName then
                    serverNotify (xPlayer.source, "Du bist verheiratet mit " .. spouseName .. " seit dem " .. marriedDate .. ".")
                else
                    print ("[SANCHEZ CITYHALL] - Fehler beim Abrufen des Namens des Ehepartners für " .. xPlayer.getName() .. " || Kontaktiere Sanchez!")
                    serverNotify (xPlayer.source, "Fehler beim Abrufen des Namens des Ehepartners - Versuchen Sie es später noch einmal.")
                end
            end)
        else
            serverNotify (xPlayer.source, "Du bist nicht verheiratet.")
        end
    end)
end)


-- LEADERBOARD

ESX.RegisterServerCallback('sanchez_cityhall:getTopRichest', function(source, cb)
    if Config.Leaderboard.enable then
        local limit = Config.Leaderboard.leaderboard.limit
        local sortBy = Config.Leaderboard.leaderboard.sortBy

        if sortBy == "bank" then
            MySQL.Async.fetchAll('SELECT firstname, lastname, JSON_UNQUOTE(JSON_EXTRACT(accounts, "$.bank")) AS bank FROM users ORDER BY CAST(JSON_UNQUOTE(JSON_EXTRACT(accounts, "$.bank")) AS UNSIGNED) DESC LIMIT @limit', {
                ['@limit'] = limit
            }, function(result)
                cb(result)
            end)
        elseif sortBy == "money" then
            MySQL.Async.fetchAll('SELECT firstname, lastname, JSON_UNQUOTE(JSON_EXTRACT(accounts, "$.money")) AS money FROM users ORDER BY CAST(JSON_UNQUOTE(JSON_EXTRACT(accounts, "$.money")) AS UNSIGNED) DESC LIMIT @limit', {
                ['@limit'] = limit
            }, function(result)
                cb(result)
            end)
        elseif sortBy == "black_money" then
            MySQL.Async.fetchAll('SELECT firstname, lastname, JSON_UNQUOTE(JSON_EXTRACT(accounts, "$.black_money")) AS black_money FROM users ORDER BY CAST(JSON_UNQUOTE(JSON_EXTRACT(accounts, "$.black_money")) AS UNSIGNED) DESC LIMIT @limit', {
                ['@limit'] = limit
            }, function(result)
                cb(result)
            end)
        else
            cb(nil)
        end
    else
        cb(nil)
    end
end)

ESX.RegisterServerCallback('sanchez_cityhall:getTopPlaytime', function(source, cb)
    local limit = Config.Leaderboard.leaderboard.limit
    MySQL.Async.fetchAll('SELECT firstname, lastname, playtime FROM users ORDER BY playtime DESC LIMIT @limit', {
        ['@limit'] = limit
    }, function(results)
        cb(results)
    end)
end)

ESX.RegisterServerCallback('sanchez_cityhall:getTopKills', function(source, cb)
    local limit = Config.Leaderboard.leaderboard.limit
    MySQL.Async.fetchAll('SELECT firstname, lastname, kills FROM users ORDER BY kills DESC LIMIT @limit', {
        ['@limit'] = limit
    }, function(results)
        cb(results)
    end)
end)

ESX.RegisterServerCallback('sanchez_cityhall:getTopDeaths', function(source, cb)
    local limit = Config.Leaderboard.leaderboard.limit
    MySQL.Async.fetchAll('SELECT firstname, lastname, deaths FROM users ORDER BY deaths DESC LIMIT @limit', {
        ['@limit'] = limit
    }, function(results)
        cb(results)
    end)
end)
