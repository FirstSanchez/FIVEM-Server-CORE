-- Frakliste Anfang
local blacklist = {
    "unemployed"
}

function IsBlacklisted(name)
    for k,v in pairs(blacklist) do 
        if v == name then 
            return true
        end
    end
end

function firstToUpper(str)
    return (str:gsub("^%l", string.upper))
end

MySQL.ready(function()
    local message = ""

    local result = MySQL.Sync.fetchAll("SELECT job, count(*) as count FROM users GROUP by job")

for i=1, #result do 
    if IsBlacklisted(result[i].job) ~= true then 
            message = message .. " " .. firstToUpper(result[i].job) .. " | Mitglieder: " .. result[i].count .. "\n"
        end 
    end

message = message .. ""

    local embeds = {
        {
            ["title"]= "Aktuelle Fraktion Member",
            ["author"] = {
                ["name"] = "Fraktionsliste",
                ["icon_url"] = "https://cdn.discordapp.com/attachments/1155819827294896150/1155820203003875398/Logo_Transparent_5k.png",
                ["url"] = "https://cdn.discordapp.com/attachments/1155819827294896150/1155820203003875398/Logo_Transparent_5k.png"
            },
            ["description"] = message,
            ["type"]= "rich",
            ["color"] = 220924,
            ["footer"] = {
                ["text"]= "Sanchez Advanced Logs - "..os.date("%x %X %p"),
                ["icon_url"] = "https://cdn.discordapp.com/attachments/1155819827294896150/1155820203003875398/Logo_Transparent_5k.png",
            },
            ["thumbnail"] = {
                ["url"] = "https://cdn.discordapp.com/attachments/1155819827294896150/1155820203003875398/Logo_Transparent_5k.png"
            }
        }
    }


    PerformHttpRequest("https://discord.com/api/webhooks/1166234726726647838/lflqDHPqwgSg8RsuNdNyJFQ1F9lqJyt_b58Cqdgg7cXotKCEwgmUXaQMWq7jdAR0TN-E", function(err, text, headers) end, 'POST', json.encode({ username = "LIMITLESS | Fraktionsliste",embeds = embeds}), { ['Content-Type'] = 'application/json' })
end)
-- Frakliste Ende