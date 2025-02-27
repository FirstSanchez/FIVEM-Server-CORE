-- Join
AddEventHandler('playerConnecting', function()
    local playerId = source
    exports['sanchez_base']:log(source, 'Join - Log', 'Der Spieler **' .. GetPlayerName(playerId) .. '** verbindet sich zum Server!', 'WEBHOOK_HERE')
end)

-- Leave
AddEventHandler('playerDropped', function(reason)
    local playerId = source
    exports['sanchez_base']:log(source, 'Leave - Log', 'Der Spieler **' .. GetPlayerName(playerId) .. '** mit der **ID: ' .. playerId .. '** trennt die Verbindung zum Server (Grund: ' .. reason ..')!', 'WEBHOOK_HERE')
end)

-- Kick
AddEventHandler('txAdmin:events:playerKicked', function(eventData)
    local name = GetPlayerName(eventData.target)
    sendToDiscord('Spieler wurde gekickt', 'Der Spieler **'..name..' (ID: '..eventData.target..')** wurde von **'..eventData.author..'** gekickt. \n\nGrund: **'..eventData.reason..'**', 'Tx-Admin Logs', 'WEBHOOK_HERE')
end)

AddEventHandler('txAdmin:events:actionRevoked', function(eventData)
    local id = eventData.actionId
    local atype = eventData.actionType
    local reason = eventData.actionReason
    local actionAuthor = eventData.actionAuthor
    local playerName = eventData.playerName
    local identifiers = extractIdentifiers(eventData.playerIds)
    local revokedBy = eventData.revokedBy
    
    if atype == 'ban' then
        sendToDiscord('Ban wurde widerrufen', 'Widerrufen von: '..revokedBy..'\n\n----------------Bandaten---------------\nGebannt von: **'..actionAuthor..'**\nBangrund: **'..reason..'**\nBan-ID: `'..id..'`\nSpielername: **'..playerName..'**\nDiscord: <@'..identifiers.discord..'>\nSteam: '..identifiers.steamid..'\nLicense: '..identifiers.license..'\nLicense2: '..identifiers.license2..'\nXBL: '..identifiers.xbl..'\nIP: '..identifiers.ip..'\nLiveID: '..identifiers.liveid..'', 'Tx-Admin Logs', 'WEBHOOK_HERE')
    elseif atype == 'warn' then 
        sendToDiscord('Warn wurde widerrufen', 'Widerrufen von: '..revokedBy..'\n\n---------------Warndaten---------------\nGewarnt von: **'..actionAuthor..'**\nWarngrund: **'..reason..'**\nWarn-ID: `'..id..'`\nSpielername: **'..playerName..'**\nDiscord: <@'..identifiers.discord..'>\nSteam: '..identifiers.steamid..'\nLicense: '..identifiers.license..'\nLicense2: '..identifiers.license2..'\nXBL: '..identifiers.xbl..'\nIP: '..identifiers.ip..'\nLiveID: '..identifiers.liveid..'', 'Tx-Admin Logs', 'WEBHOOK_HERE')
    else
        sendToDiscord('Aktion wurde widerrufen', 'Widerrufen von: '..revokedBy..'\n\n------------Aktionsdaten--------------\nAktion von: **'..actionAuthor..'**\nAktionsgrund: **'..reason..'**\nAktions-ID: `'..id..'`\nSpielername: **'..playerName..'**\nDiscord: <@'..identifiers.discord..'>\nSteam: '..identifiers.steamid..'\nLicense: '..identifiers.license..'\nLicense2: '..identifiers.license2..'\nXBL: '..identifiers.xbl..'\nIP: '..identifiers.ip..'\nLiveID: '..identifiers.liveid..'', 'Tx-Admin Logs', 'WEBHOOK_HERE')
    end
end)

--> Functions

function sendToDiscord(title, text, footer, link)
    local embed = {
        {
            ['title'] = '**' .. title .. '**',
            ['thumbnail'] = {
                ['url'] = 'https://cdn.discordapp.com/attachments/1174010791930900510/1178707379668389918/Discord-Animated-Logo.gif',
            },
            ['color'] = '3447003',
            ['description'] = text,
            ['footer'] = {
                ['text'] = footer .. ' - ESX - '.. os.date('%d.%m.%y') .. ' - ' .. os.date('%X') .. ' Uhr', 
                ['icon_url'] = 'https://cdn.discordapp.com/attachments/1174010791930900510/1178707379668389918/Discord-Animated-Logo.gif',
            },
            ['author'] = {
                ['name'] = 'ESX',
                ['url'] = 'discord.gg/esx-hub',
                ['icon_url'] = 'https://cdn.discordapp.com/attachments/1174010791930900510/1178707379668389918/Discord-Animated-Logo.gif',
            }
        }
    }
    PerformHttpRequest('WEBHOOK_HERE', function(err, text, headers) end, 'POST', json.encode({username = Config.name, embeds = embed}), { ['Content-Type'] = 'application/json' })
end

function toint(n)
    local s = tostring(n)
    local i, j = s:find('%.')
    if i then
        return tonumber(s:sub(1, i-1))
    else
        return n
    end
end

function extractIdentifiers(identifiers)
    local result = {
        steamid = 'not found',
        license = 'not found',
        license2 = 'not found',
        xbl = 'not found',
        ip = 'not found',
        discord = 'not found',
        liveid = 'not found',
        fivem = 'not found',
    }

    for _, v in pairs(identifiers) do
        if string.sub(v, 1, string.len('steam:')) == 'steam:' then
            result.steamid = v
        elseif string.sub(v, 1, string.len('license:')) == 'license:' then
            result.license = v
        elseif string.sub(v, 1, string.len('fivem:')) == 'fivem:' then
            result.fivem = v
        elseif string.sub(v, 1, string.len('license2:')) == 'license2:' then
            result.license2 = v
        elseif string.sub(v, 1, string.len('xbl:')) == 'xbl:' then
            result.xbl = v
        elseif string.sub(v, 1, string.len('ip:')) == 'ip:' then
            result.ip = v
        elseif string.sub(v, 1, string.len('discord:')) == 'discord:' then
            local discordID = {}
            for str in string.gmatch(v, '([^:]+)') do
                table.insert(discordID, str)
            end
            result.discord = discordID[2]
        elseif string.sub(v, 1, string.len('live:')) == 'live:' then
            result.liveid = v
        end
    end

    return result
end