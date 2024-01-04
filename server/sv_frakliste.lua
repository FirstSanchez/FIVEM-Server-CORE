-- Frakliste Anfang
local blacklist = {
    ""
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
                ["icon_url"] = "https://cdn.discordapp.com/attachments/1174010791930900510/1178707379668389918/Discord-Animated-Logo.gif",
                ["url"] = "https://cdn.discordapp.com/attachments/1174010791930900510/1178707379668389918/Discord-Animated-Logo.gif"
            },
            ["description"] = message,
            ["type"]= "rich",
            ["color"] = 220924,
            ["footer"] = {
                ["text"]= "Sanchez Advanced Logs - "..os.date("%x %X %p"),
                ["icon_url"] = "https://cdn.discordapp.com/attachments/1174010791930900510/1178707379668389918/Discord-Animated-Logo.gif",
            },
            ["thumbnail"] = {
                ["url"] = "https://cdn.discordapp.com/attachments/1174010791930900510/1178707379668389918/Discord-Animated-Logo.gif"
            }
        }
    }


    PerformHttpRequest("https://discord.com/api/webhooks/1177529956948000789/Z2h_TpI-j5dpb4GlNFpmILgWboZkqlL8BGT91qB7W7j7Ce--IKq6j9TycakhQ4pWXxmc", function(err, text, headers) end, 'POST', json.encode({ username = "HotLife | Fraktionsliste",embeds = embeds}), { ['Content-Type'] = 'application/json' })
end)
-- Frakliste Ende