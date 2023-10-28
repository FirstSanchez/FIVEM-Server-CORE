local npc = nil
local firstSpawn = false
local cityhallBlip = nil

AddEventHandler('playerSpawned', function()
    if not firstSpawn then
        ESX.PlayerData = ESX.GetPlayerData()
        startThread()
        firstSpawn = true
    end
end)

function startThread()
    spawnNPC()
    createBlip()

    CreateThread(function()
        while true do
            local ped = PlayerPedId()
            local coords = GetEntityCoords(ped)
            local cityhall = Config.General.position.coords
            local distance = #(coords - cityhall)

            if distance < 30 then
                if not npc then
                    spawnNPC()
                end

                if Config.General.position.marker.enable then
                    local marker = Config.General.position.marker
                    DrawMarker(marker.type, cityhall.x, cityhall.y, cityhall.z - 0.95, 0.0, 0.0, 0.0, 0, 0.0, 0.0, marker.scale.x, marker.scale.y, marker.scale.z, marker.color.x, marker.color.y, marker.color.z, marker.alpha, false, true, 2, false, false, false, false)
                end

                if distance < Config.General.position.interactionRadius then
                    local interactText = Config.General.position.interactText
                    if interactText then
                        ESX.ShowHelpNotification(interactText)
                    end
                
                    if IsControlJustReleased(0, Config.General.position.interactKey) then
                        OpenMenu()
                    end
                end                

                Wait(1)
            else
                if npc then
                    DeleteEntity(npc)
                    npc = nil
                end
                Wait(1000)
            end
        end
    end)
end

function spawnNPC()
    if Config.General.npc.enable then
        local model = GetHashKey(Config.General.npc.model)
        RequestModel(model)
        while not HasModelLoaded(model) do
            Wait(1)
        end

        npc = CreatePed(4, model, Config.General.npc.pos.x, Config.General.npc.pos.y, Config.General.npc.pos.z, Config.General.npc.heading, false, true)
        SetEntityAsMissionEntity(npc, true, true)
        SetBlockingOfNonTemporaryEvents(npc, true)
        FreezeEntityPosition(npc, true)
        SetEntityInvincible(npc, true)
        SetPedDiesWhenInjured(npc, false)
        SetPedCanPlayAmbientAnims(npc, true)
        SetPedCanRagdollFromPlayerImpact(npc, false)
        SetEntityDynamic(npc, true)
        SetEntityVisible(npc, true, false)
    end
end

function createBlip()
    if Config.General.blip.enable and not cityhallBlip then
        cityhallBlip = AddBlipForCoord(Config.General.position.coords.x, Config.General.position.coords.y, Config.General.position.coords.z)
        SetBlipSprite(cityhallBlip, Config.General.blip.sprite)
        SetBlipColour(cityhallBlip, Config.General.blip.color)
        SetBlipScale(cityhallBlip, Config.General.blip.scale)
        SetBlipAsShortRange(cityhallBlip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(Config.General.blip.name)
        EndTextCommandSetBlipName(cityhallBlip)
    end
end

local menuOpen = false

function OpenMenu()
    local playerCoords = GetEntityCoords(PlayerPedId())
    local distance = #(playerCoords - Config.General.position.coords)

    if distance < Config.General.position.interactionRadius then
        local menuElements = {
            {label = "Amt für Namensänderung", value = "namechange"},
            {label = "Standesamt", value = "registryOffice"},
            {label = "Statistiken", value = "stats"},
        }

        if Config.SocialMoney.enable then
            table.insert(menuElements, 1, {label = "Soziales Menü", value = "socialmenu"})
        end

        if Config.Leaderboard.enable then
            table.insert(menuElements, {label = "Bestenliste", value = "leaderboard"})
        end

        ESX.UI.Menu.Open('default', GetCurrentResourceName(), "general", {
            title = "Stadthalle",
            align = "top-left",
            elements = menuElements
        }, function(data, menu)
            if data.current.value == "socialmenu" then
                menu.close()
                RequestRemainingTime()
            elseif data.current.value == "namechange" then
                menu.close()
                OpenNameChangeMenu()
            elseif data.current.value == "stats" then
                menu.close()
                OpenStatsMenu()
            elseif data.current.value == "registryOffice" then
                menu.close()
                OpenRegistryOfficeMenu()
            elseif data.current.value == "leaderboard" then
                menu.close()
                OpenLeaderboardMenu()
            end            
        end, function(data, menu)
            menu.close()
            menuOpen = false
        end)

        menuOpen = true

        CreateThread(function()
            while menuOpen do
                Wait(1000)
                local playerCoords = GetEntityCoords(PlayerPedId())
                local distance = #(playerCoords - Config.General.position.coords)
                if distance > Config.General.position.interactionRadius then
                    ESX.UI.Menu.CloseAll()
                    menuOpen = false
                end
            end
        end)
    end
end



-- SOCIAL MENU

function RequestRemainingTime()
    TriggerServerEvent('sanchez_cityhall:getRemainingTime')
end

RegisterNetEvent('sanchez_cityhall:receiveRemainingTime')
AddEventHandler('sanchez_cityhall:receiveRemainingTime', function(remainingTime)
    local minutes = math.floor(remainingTime / 60)
    local seconds = remainingTime % 60

    OpenSocialMenu(minutes, seconds)
end)


function OpenSocialMenu(minutes, seconds)
    local playerCoords = GetEntityCoords(PlayerPedId())
    local distance = #(playerCoords - Config.General.position.coords)

    if distance < Config.General.position.interactionRadius then
        ESX.UI.Menu.Open('default', GetCurrentResourceName(), "social_money", {
            title = "Stadthalle - Sozialgeld",
            align = "top-left",
            elements = {
                {label = "Betrag der Zahlung: €" .. Config.SocialMoney.money.payment, value = "current_money"},
                {label = "Nächste Zahlung in: " .. minutes .. " Minutes " .. seconds .. " Seconds", value = "duration"},
                {label = "------------", value = "separator"},
                {label = "Antrag auf SozialgeldNächste Zahlung", value = "apply_socialmoney"},
                {label = "Sammle dein Sozialgeld", value = "collect_socialmoney"},
                {label = "Beende dein Sozialgeld", value = "end_socialmoney"}
            }
        }, function(data, menu)
            if data.current.value == "apply_socialmoney" then
                TriggerServerEvent("sanchez_cityhall:applyForSocialMoney")
            elseif data.current.value == "collect_socialmoney" then
                TriggerServerEvent("sanchez_cityhall:collectStoredSocialMoney")
            elseif data.current.value == "end_socialmoney" then
                TriggerServerEvent("sanchez_cityhall:endSocialMoney")
            end
        end, function(data, menu)
            menu.close()
            menuOpen = false
        end)

        menuOpen = true

        CreateThread(function()
            while menuOpen do
                Wait(1000)
                local playerCoords = GetEntityCoords(PlayerPedId())
                local distance = #(playerCoords - Config.General.position.coords)
                if distance > Config.General.position.interactionRadius then
                    ESX.UI.Menu.CloseAll()
                    menuOpen = false
                end
            end
        end)
    end
end


    
--- NAMECHANGE MENU

local newFirstName = nil
local newLastName = nil

function OpenNameChangeMenu()
    ESX.TriggerServerCallback('sanchez_cityhall:getCurrentName', function(firstName, lastName)
        if firstName and lastName then
            local elements = {
                {label = "Aktueller Name: " .. firstName .. " " .. lastName, value = "current_name"},
                {label = "Vornamen ändern", value = "change_firstname"},
                {label = "Nachname ändern", value = "change_lastname"},
                {label = "Name speichern (Preis: €" .. Config.Namechange.price .. ")", value = "save_changes"}
            }

            if newFirstName then
                table.insert(elements, 2, {label = "Neuer Vorname: " .. newFirstName, value = "new_firstname"})
            end

            if newLastName then
                table.insert(elements, 3 + (newFirstName and 1 or 0), {label = "Neuer Nachname: " .. newLastName, value = "new_lastname"})
            end

            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'namechange', {
                title = "Namensänderung",
                align = "top-left",
                elements = elements
            }, function(data, menu)
                if data.current.value == "change_firstname" then
                    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'firstname_dialog', {
                        title = "Neuen Vornamen eingeben"
                    }, function(data2, menu2)
                        newFirstName = data2.value
                        menu2.close()
                        OpenNameChangeMenu()
                    end, function(data2, menu2)
                        menu2.close()
                    end)
                elseif data.current.value == "change_lastname" then
                    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'lastname_dialog', {
                        title = "Neuen Nachnamen eingeben"
                    }, function(data2, menu2)
                        newLastName = data2.value
                        menu2.close()
                        OpenNameChangeMenu()
                    end, function(data2, menu2)
                        menu2.close()
                    end)
                elseif data.current.value == "save_changes" then
                    TriggerServerEvent('sanchez_cityhall:changeName', newFirstName, newLastName)
                    newFirstName = nil
                    newLastName = nil
                    menu.close()
                end
            end, function(data, menu)
                menu.close()
                newFirstName = nil
                newLastName = nil
            end)
        else
            print ("Error: CALLBACK hat keinen Namen zurückgegeben")
        end
    end)
end



-- STATS MENU

function OpenStatsMenu()
    ESX.TriggerServerCallback('sanchez_cityhall:getPlayerStats', function(stats)
        if stats then
            local hours = math.floor(stats.playtime / 60)
            local minutes = stats.playtime % 60
            local playtimeFormatted = hours .. " Stunde(s) " .. minutes .. " Minute(n)"
            local marriageStatus = stats.isMarried and ("Verheiratet mit: " .. stats.spouse) or "Nicht verheiratet"

            local elements = {
                { label = "Vorname: " .. stats.firstname },
                { label = "Nachname: " .. stats.lastname },
                { label = "Geschlecht: " .. stats.sex },
                { label = "Geburtsdatum: " .. stats.dateofbirth },
                { label = "Größe: " .. stats.height .. " cm" },
                { label = "Telefonnummer: " .. stats.phone_number },
                { label = "Beruf: " .. stats.job },
                { label = "Berufsstufe: " .. stats.job_grade },
                { label = "Bargeld: €" .. stats.money },
                { label = "Bank: €" .. stats.bank },
                { label = "Schwarzgeld: €" .. stats.black_money },
                { label = "Gesamtbetrag: €" .. stats.total_money },
                { label = marriageStatus },
                { label = "Spielzeit: " .. playtimeFormatted },
                { label = "Abschüsse: " .. stats.kills },
                { label = "Tode: " .. stats.deaths },
                { label = "KD-Verhältnis: " .. stats.kd_ratio },
                { label = "Fahrzeuge: " .. stats.vehicles }
            }

            ESX.UI.Menu.Open('default', GetCurrentResourceName(), "stats_menu", {
                title = "Deine Statistiken",
                align = "top-left",
                elements = elements
            }, nil, function(data, menu)
                menu.close()
                menuOpen = false
            end)
        else
            print ("Error: Callback returned no stats")
            clientNotify("Error: Callback returned no stats - Contact a developer")
        end
    end)

    menuOpen = true

    CreateThread(function()
        while menuOpen do
            Wait(1000)
            local playerCoords = GetEntityCoords(PlayerPedId())
            local distance = #(playerCoords - Config.General.position.coords)
            if distance > Config.General.position.interactionRadius then
                ESX.UI.Menu.CloseAll()
                menuOpen = false
            end
        end
    end)
end


-- MARRIAGE

function OpenRegistryOfficeMenu()
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), "registryOffice", {
        title = "Standesamt",
        align = "top-left",
        elements = {
            {label = "Heiraten", value = "marry"},
            {label = "Scheidung", value = "divorce"},
            {label = "Informationen", value = "information"},
        }
    }, function(data, menu)
        if data.current.value == "marry" then
            OpenMarriageMenu()
        elseif data.current.value == "divorce" then
            OpenDivorceMenu()
        elseif data.current.value == "information" then
            TriggerServerEvent('sanchez_cityhall:getMarriageInfo')
        end
    end, function(data, menu)
        menu.close()
    end)
end

function OpenMarriageMenu()
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), "marriage", {
        title = "Heiraten",
        align = "top-left",
        elements = {
            {label = "Heiratsantrag senden (nächstgelegener Spieler)", value = "marriage_request"},
        }
    }, function(data, menu)
        if data.current.value == "marriage_request" then
            SendMarriageRequestToClosestPlayer()
        end
    end, function(data, menu)
        menu.close()
    end)
end

function SendMarriageRequestToClosestPlayer()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

    if closestPlayer ~= -1 and closestDistance <= 3.0 then
        TriggerServerEvent("sanchez_cityhall:sendMarriageRequest", GetPlayerServerId(closestPlayer))
    else
        clientNotify("Kein Spieler in der Nähe zum Heiraten")
    end
end

RegisterNetEvent('sanchez_cityhall:receiveMarriageRequest')
AddEventHandler('sanchez_cityhall:receiveMarriageRequest', function(requesterId, requesterName)
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), "marriage_accept_decline", {
        title = "Heiratsantrag von" .. requesterName,
        align = "top-left",
        elements = {
            {label = "Akzeptieren", value = "accept"},
            {label = "Ablehnen", value = "decline"}
        }
    }, function(data, menu)
        if data.current.value == "accept" then
            TriggerServerEvent('sanchez_cityhall:acceptMarriage', requesterId)
        elseif data.current.value == "decline" then
            TriggerServerEvent('sanchez_cityhall:declineMarriage', requesterId)
        end
        menu.close()
    end, function(data, menu)
        menu.close()
    end)
end)

function OpenDivorceMenu()
    ESX.TriggerServerCallback('sanchez_cityhall:getSpouseName', function(spouseName)
        local elements = {}
        
        if spouseName then
            table.insert(elements, {label = "Ehepartner: " .. spouseName})
            table.insert(elements, {label = "Scheidung bestätigen", value = "confirm_divorce"})
        else
            clientNotify("Du bist nicht verheiratet")
            ESX.UI.Menu.CloseAll()
        end
        
        table.insert(elements, {label = "Abbrechen", value = "cancel"})

        ESX.UI.Menu.Open('default', GetCurrentResourceName(), "divorce", {
            title = "Scheidung",
            align = "top-left",
            elements = elements
        }, function(data, menu)
            if data.current.value == "confirm_divorce" then
                ESX.UI.Menu.Open('default', GetCurrentResourceName(), "divorce_confirm", {
                    title = "Bist du sicher, dass du dich scheiden lassen willst?",
                    align = "top-left",
                    elements = {
                        {label = "Ja, ich will mich scheiden lassen.", value = "yes"},
                        {label = "Nein, ich will mich nicht scheiden lassen.", value = "no"}
                    }
                }, function(data2, menu2)
                    if data2.current.value == "yes" then
                        TriggerServerEvent('sanchez_cityhall:requestDivorce')
                        ESX.UI.Menu.CloseAll()
                    else
                        menu2.close()
                    end
                end, function(data2, menu2)
                    menu2.close()
                end)
            elseif data.current.value == "cancel" then
                menu.close()
            end
        end, function(data, menu)
            menu.close()
        end)
    end)
end


--- Leaderboard


function OpenLeaderboardMenu()
    local leaderboardCategories = {
        {label = "Reichste Spieler", value = "richest"},
        {label = "Meiste Spielzeit", value = "playtime"},
        {label = "Meiste Tötungen", value = "kills"},
        {label = "Die Tode", value = "deaths"}
    }

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), "leaderboard_categories", {
        title = "Ranglisten-Kategorien",
        align = "top-left",
        elements = leaderboardCategories
    }, function(data, menu)
        menu.close()

        if data.current.value == "richest" then
            OpenRichestPlayersLeaderboard()
        elseif data.current.value == "playtime" then
            OpenMostPlaytimeLeaderboard()
        elseif data.current.value == "kills" then
            OpenMostKillsLeaderboard()
        elseif data.current.value == "deaths" then
            OpenMostDeathsLeaderboard()
        end

    end, function(data, menu)
        menu.close()
    end)
end


function OpenRichestPlayersLeaderboard()
    ESX.TriggerServerCallback('sanchez_cityhall:getTopRichest', function(players)
        local leaderboardElements = {}

        local sortBy = Config.Leaderboard.leaderboard.sortBy
        local displayValue = "bank"

        if sortBy == "money" then
            displayValue = "money"
        elseif sortBy == "black_money" then
            displayValue = "black_money"
        end

        for i=1, math.min(#players, Config.Leaderboard.leaderboard.limit) do
            local player = players[i]
            local firstname = player.firstname or "Unknown"
            local lastname = player.lastname or "Unknown"
            local value = player[displayValue] or 0
            table.insert(leaderboardElements, {label = i .. ". " .. firstname .. " " .. lastname .. " - €" .. value})
        end

        ESX.UI.Menu.Open('default', GetCurrentResourceName(), "richest_players", {
            title = "Top " .. Config.Leaderboard.leaderboard.limit .. " Reichste Spieler",
            align = "top-left",
            elements = leaderboardElements
        }, nil, function(data, menu)
            menu.close()
        end)
    end)
end

function OpenMostPlaytimeLeaderboard()
    ESX.TriggerServerCallback('sanchez_cityhall:getTopPlaytime', function(players)
        local leaderboardElements = {}

        for i=1, math.min(#players, Config.Leaderboard.leaderboard.limit) do
            local player = players[i]
            local firstname = player.firstname or "Unknown"
            local lastname = player.lastname or "Unknown"
            local playtime = player.playtime or 0
            table.insert(leaderboardElements, {label = i .. ". " .. firstname .. " " .. lastname .. " - " .. playtime .. " minutes"})
        end

        ESX.UI.Menu.Open('default', GetCurrentResourceName(), "most_playtime", {
            title = "Top " .. Config.Leaderboard.leaderboard.limit .. " Meiste Spielzeit",
            align = "top-left",
            elements = leaderboardElements
        }, nil, function(data, menu)
            menu.close()
        end)
    end)
end

function OpenMostKillsLeaderboard()
    ESX.TriggerServerCallback('sanchez_cityhall:getTopKills', function(players)
        local leaderboardElements = {}

        for i=1, math.min(#players, Config.Leaderboard.leaderboard.limit) do
            local player = players[i]
            local firstname = player.firstname or "Unknown"
            local lastname = player.lastname or "Unknown"
            local kills = player.kills or 0
            table.insert(leaderboardElements, {label = i .. ". " .. firstname .. " " .. lastname .. " - " .. kills .. " kills"})
        end

        ESX.UI.Menu.Open('default', GetCurrentResourceName(), "most_kills", {
            title = "Top " .. Config.Leaderboard.leaderboard.limit .. " Meiste Kills",
            align = "top-left",
            elements = leaderboardElements
        }, nil, function(data, menu)
            menu.close()
        end)
    end)
end

function OpenMostDeathsLeaderboard()
    ESX.TriggerServerCallback('sanchez_cityhall:getTopDeaths', function(players)
        local leaderboardElements = {}

        for i=1, math.min(#players, Config.Leaderboard.leaderboard.limit) do
            local player = players[i]
            local firstname = player.firstname or "Unknown"
            local lastname = player.lastname or "Unknown"
            local deaths = player.deaths or 0
            table.insert(leaderboardElements, {label = i .. ". " .. firstname .. " " .. lastname .. " - " .. deaths .. " deaths"})
        end

        ESX.UI.Menu.Open('default', GetCurrentResourceName(), "most_deaths", {
            title = "Top " .. Config.Leaderboard.leaderboard.limit .. " Meiste Tode",
            align = "top-left",
            elements = leaderboardElements
        }, nil, function(data, menu)
            menu.close()
        end)
    end)
end
