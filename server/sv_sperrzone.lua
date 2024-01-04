RegisterNetEvent('lm__sperrzone:setBlips')
AddEventHandler('lm__sperrzone:setBlips', function(officerName, officerServerId, officerPlayer, blipVector, streetName, sizeserver, token)
	TriggerClientEvent('lm__sperrzone:setBlips', -1, officerName, officerServerId, officerPlayer, blipVector, streetName, sizeserver)
    SendLogSperrzone('NEUE SPERRZONE', 'Der Spieler mit der ID '..officerServerId..' hat eine Sperrzone bei '..streetName..' erstellt. Größe: '..sizeserver)
    TriggerClientEvent("cataleya_hud:sendAnnounce", -1, "Sperrzone", "Das Los Santos Police Department ruft eine Sperrzone bei " ..streetName.. " (+"..sizeserver.."m). Das Betreten wird mit einer Festnahme oder anderem geahndet!", 7000)
end)

RegisterNetEvent('lm__sperrzone:removeBlips')
AddEventHandler('lm__sperrzone:removeBlips', function(officerName, officerServerId, officerPlayer, blipVector, streetName, token)
	TriggerClientEvent('lm__sperrzone:removeBlips', -1, officerName, officerServerId, officerPlayer, blipVector, streetName)
    SendLogSperrzone('SPERRZONE AUFGELÖST', 'Der Spieler mit der ID '..officerServerId..' hat die Sperrzone bei '..streetName..' aufgelöst.')
    TriggerClientEvent("cataleya_hud:sendAnnounce", -1, "Sperrzone", "Die Sperrzone um die Straße " ..streetName.. " wurde aufgelöst!", 7000)
end)

local cooldown = false

RegisterCommand("sperrzone", function(src)
    local xPlayer = ESX.GetPlayerFromId(src)
    if cooldown then
        xPlayer.showNotification("Die Sperrzone hat aktuell einen Cooldown")
        return
    end
    if xPlayer.job.name == "police" or xPlayer.job.name == "FIB" then
        cooldown = true
        CreateThread(function ()
            Wait(5*60000)
            cooldown = false
        end)
        TriggerClientEvent("lm__sperrzone:SperrzoneMenu", src, xPlayer.job.name)
        else 
            xPlayer.showNotification("Du bis kein Polizeibeamter!")
    end
end)

function SendLogSperrzone(title, msg)
    local EMBED = {
        embeds = {
        {
            title = title,
            color = 39423,
            fields = {
            {
                name = "Information",
                value = "``` "..msg.." ```",
                inline = true
            }
            },
            author = {
            name = "HotLife SPERRZONE LOGS",
            url = "https://discord.gg/HotLife"
            }
        }
        },
        username = "HotLife"
    }
    PerformHttpRequest(Config_Sperrzone.Webhook, function(err, text, headers)end, 'POST', json.encode(EMBED), { ['Content-Type']= 'application/json' })
end