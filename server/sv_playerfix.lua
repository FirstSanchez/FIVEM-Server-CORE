local players = {}

local restart = false

AddEventHandler('txAdmin:events:scheduledRestart', function(eventData)
    if eventData.secondsRemaining <= 300 then
        restart = true
    else
        restart = false
    end
end)

function isRestart()
    return restart
end

AddEventHandler('le_core:esx:playerLoaded', function(playerId, xPlayer)
    if not players[playerId] then
        players[playerId] = {}
        players[playerId].playerId = playerId
        players[playerId].job = xPlayer.getJob().name
        players[playerId].jobLabel = xPlayer.getJob().label
        players[playerId].jobGrade = xPlayer.getJob().grade
        players[playerId].job3 = xPlayer.getJob3().name
        players[playerId].job3Label = xPlayer.getJob3().label
        players[playerId].job3Grade = xPlayer.getJob3().grade
        players[playerId].group = xPlayer.getGroup()
        players[playerId].identifier = xPlayer.getIdentifier()
        players[playerId].jobDienst = xPlayer.getJob().dienst
        players[playerId].rpName = xPlayer.getRPName()

        SetPlayerCullingRadius(playerId, 275.0)
    end
end)

AddEventHandler('esx:setJob', function(playerId, job, lastJob)
    if players[playerId] then
        players[playerId].job = job.name
        players[playerId].jobLabel = job.label
        players[playerId].jobGrade = job.grade
    end
end)

AddEventHandler('esx:setJob3', function(playerId, job, lastJob)
    if players[playerId] then
        players[playerId].job3 = job.name
        players[playerId].job3Label = job.label
        players[playerId].job3Grade = job.grade
    end
end)

AddEventHandler('esx:setJobDienst', function(playerId, job, state)
    if players[playerId] then
        players[playerId].jobDienst = state
    end
end)

AddEventHandler('playerDropped', function(reason)
    local playerId = source
    if players[playerId] then
        players[playerId] = nil
    end
end)

local function isJobLegal(jobName)
    if jobName == 'unicorn' or jobName == 'justice' or jobName == 'police' or jobName == 'fib' or jobName == 'sheriff' or jobName == 'ambulance' then
        return true
    end
    
    return false
end

local function GetPlayersFix()
    return players
end

exports('GetPlayersFix', GetPlayersFix)
exports('isJobLegal', isJobLegal)


function GetAllIdentifiers(playerId)
    local string = ''

    for k, v in pairs(GetPlayerIdentifiers(playerId)) do
        if string.find(v, 'steam') then
            string = string .. v
        elseif string.find(v, 'license') then
            string = string .. '\n' .. v
        elseif string.find(v, 'xbl') then
            string = string .. '\n' .. v
        elseif string.find(v, 'discord') then
            string = string .. '\n' .. v
        elseif string.find(v, 'live') then
            string = string .. '\n' .. v
        elseif string.find(v, 'fivem') then
            string = string .. '\n' .. v
        end
    end

    return string
end

function GetAllIdentifiers2(playerId)
    local string = ''

    for k, v in pairs(GetPlayerIdentifiers(playerId)) do
        if string.find(v, 'steam') then
            string = string .. v
        elseif string.find(v, 'license') then
            string = string .. '\n' .. v
        elseif string.find(v, 'xbl') then
            string = string .. '\n' .. v
        elseif string.find(v, 'discord') then
            string = string .. '\n' .. v
        elseif string.find(v, 'live') then
            string = string .. '\n' .. v
        elseif string.find(v, 'fivem') then
            string = string .. '\n' .. v
        elseif string.find(v, 'ip') then
            string = string .. '\n' .. v
        end
    end

    return string
end

function log(playerId, title, message, webhook)
    local embed = {
        {
            ['color'] = '3447003',
            ['title'] = '**' .. title .. '**',
            ['description'] = message .. '\n ```' .. GetAllIdentifiers(playerId) .. '```',
            ['footer'] = {
                ['text'] = title .. ' - ESX - '.. os.date('%d.%m.%y') .. ' - ' .. os.date('%X') .. ' Uhr',
                ['icon_url'] = 'https://cdn.discordapp.com/attachments/1174010791930900510/1178707379668389918/Discord-Animated-Logo.gif',
            },
            ['author'] = {
                ['name'] = 'ESX',
                ['url'] = 'discord.gg/esx-hub',
                ['icon_url'] = 'https://cdn.discordapp.com/attachments/1174010791930900510/1178707379668389918/Discord-Animated-Logo.gif',
            }
        }
    }

    PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = 'ESX', embeds = embed, avatar_url = 'https://cdn.discordapp.com/attachments/1174010791930900510/1178707379668389918/Discord-Animated-Logo.gif'}), { ['Content-Type'] = 'application/json' })
end

function togLog(playerId, anotherId, title, message, webhook)
    local embed = {
        {
            ['color'] = '3447003',
            ['title'] = '**' .. title .. '**',
            ['description'] = message .. '\n\n' .. GetPlayerName(playerId) .. ': \n ```' .. GetAllIdentifiers(playerId) .. '```\n ' .. GetPlayerName(anotherId) .. ': ```' .. GetAllIdentifiers(anotherId) .. '```',
            ['footer'] = {
                ['text'] = title .. ' - ESX - '.. os.date('%d.%m.%y') .. ' - ' .. os.date('%X') .. ' Uhr',
                ['icon_url'] = 'https://cdn.discordapp.com/attachments/1174010791930900510/1178707379668389918/Discord-Animated-Logo.gif',
            },
            ['author'] = {
                ['name'] = 'ESX',
                ['url'] = 'discord.gg/esx-hub',
                ['icon_url'] = 'https://cdn.discordapp.com/attachments/1174010791930900510/1178707379668389918/Discord-Animated-Logo.gif',
            }
        }
    }

    PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = 'ESX', embeds = embed, avatar_url = 'https://cdn.discordapp.com/attachments/1174010791930900510/1178707379668389918/Discord-Animated-Logo.gif'}), { ['Content-Type'] = 'application/json' })
end


exports('log', log)
exports('doubleLog', togLog)
exports('logExploit', logExploit)
exports('logHttp', logHttp)
exports('doubleLogHttp', togLogHttp)
exports('isRestart', isRestart)
exports('randomString', string.random)