ANTITROLL_KILLSLIST = {}

function Logg(title, msg)
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
          name = "LIMITLESS Anti Hurensohn LOGS",
          url = "https://discord.gg/LIMITLESSRP"
        }
		  }
		},
		username = "LIMITLESS - MODDERKILLS"
	}
	PerformHttpRequest("https://discord.com/api/webhooks/1157258136789459005/d6wr-1kq_erZPm5Y_YNPunNpRrBSnqsiyHCoabO3kpiJkIy-CKP4qXFR2ai0aMbRDnYX", function(err, text, headers)end, 'POST', json.encode(EMBED), { ['Content-Type']= 'application/json' })
end

RegisterNetEvent('esx:onPlayerDeath')
AddEventHandler('esx:onPlayerDeath', function(data)
    data.victim = source
    if data.killedByPlayer then
        local killer = tonumber(data.killerServerId)
        if GetPlayerName(killer) then
            if not ANTITROLL_KILLSLIST[killer] then
                ANTITROLL_KILLSLIST[killer] = 1
                Logg("SPIELER GEUPDATED", "Der Spieler " ..GetPlayerName(killer).. " hat aktuell " ..tostring(ANTITROLL_KILLSLIST[killer]).. " Kills innerhalb von 1 Minute")
            elseif ANTITROLL_KILLSLIST[killer] > 5 then -- HIER DADDY
                Logg("SPIELER GEBANNT", "Der Spieler " ..GetPlayerName(killer).. " hat 6 Spieler innerhalb von 1 Minute getötet!")
                TriggerEvent("EasyAdmin:addBan", killer, "(!) Anti Hurensohn: Du wurdest gebannt, da du 6 Leute innerhalb von einer Minute getötet hast", "Anti-Troll",  10444633200)
                Wait(5000)
                if GetPlayerName(killer) ~= nil then
                    DropPlayer(killer, "(!) Anti Hurensohn: Du wurdest gekickt, da du 6 Leute innerhalb von einer Minute getötet hast!")
                end
            else
                ANTITROLL_KILLSLIST[killer] = ANTITROLL_KILLSLIST[killer] + 1
                Logg("SPIELER GEUPDATED", "Der Spieler " ..GetPlayerName(killer).. " hat aktuell " ..tostring(ANTITROLL_KILLSLIST[killer]).. " Kills innerhalb von 1 Minute")
                CreateThread(function ()
                    Wait(60000)
                    ANTITROLL_KILLSLIST[killer] = 0
                end)
            end
        end
    end
end)
