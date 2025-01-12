local fraksperren = {}
local bypass = {}

AddEventHandler('esx:setJob', function(source, newJob, oldJob)
local src = source
local xPlayer = ESX.GetPlayerFromId(src)

if bypass[src] then
    bypass[src] = false
    return
end

if newJob.name ~= oldJob.name then
    if newJob.name ~= Config_Fraksperre.unemployed then
        local bool, time = activeSperre(src)
        if bool then
            bypass[src] = true
            xPlayer.setJob(oldJob.name, oldJob.grade)
            TriggerClientEvent('esx:showNotification', 'Du kannst nicht in eine Fraktion wechseln, da du eine Fraksperre hast!')
        end
    else
        bypass[src] = true
        xPlayer.setJob(Config_Fraksperre.unemployed, 0)
        table.insert(fraksperren, {identifier = xPlayer.identifier, timestamp = os.time()})
        SaveResourceFile(GetCurrentResourceName(), "fraksperren.json", json.encode(fraksperren, {indent = true}), -1) 
        local Embed = EmbedPreset
        Embed.description = ("Der Spieler " .. xPlayer.getName() .. " hat eine Fraksperre erhalten!")
        Embed.fields = {
            {
                name = "Ingame Name",
                value = xPlayer.getName()
            },
            {
                name = "Source Identifiers",
                value = getIdentifiers(xPlayer.source)
            },
        }
        sendWebhook("WEBHOOK_HERE", {Embed})
    end
end
end)

function activeSperre(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    for k,v in pairs(fraksperren) do
        if v.identifier == xPlayer.identifier then
            if math.floor((os.time() - tonumber(v.timestamp)) / 60) < Config_Fraksperre.time then
                return true, math.floor(((Config_Fraksperre.time * 60) - (os.time() - tonumber(v.timestamp))) / 3600)
            else
                for k,v in pairs(fraksperren) do
                    if v.identifier == xPlayer.identifier then
                        table.remove(fraksperren, k)
                    end
                end
                SaveResourceFile(GetCurrentResourceName(), "fraksperren.json", json.encode(fraksperren, {indent = true}), -1) 
                return false
            end
        end
    end
    return false
end

AddEventHandler("onResourceStart", function(r)
    if r ~= GetCurrentResourceName() then return end
    fraksperren = json.decode(LoadResourceFile(GetCurrentResourceName(), "fraksperren.json"))
end)

RegisterCommand(Config_Fraksperre.CommandName, function(source, args)
    if source > 0 then
        local xSource = ESX.GetPlayerFromId(source)
        local target = source
        if #args > 0 and tonumber(args[1]) ~= nil then target = args[1] end
        local xPlayer = ESX.GetPlayerFromId(target)
        for k,v in pairs(Config_Fraksperre.CommandAllowedGroups) do
            if xSource.getGroup() == v then
                for k,v in pairs(fraksperren) do
                    if v.identifier == xPlayer.identifier then
                        table.remove(fraksperren, k)
                        SaveResourceFile(GetCurrentResourceName(), "fraksperren.json", json.encode(fraksperren, {indent = true}), -1)
                        if target ~= source then
                            TriggerClientEvent('esx:showNotification', 'Fraksperre wurde entfernt!')
                        end
                        TriggerClientEvent('esx:showNotification', 'Deine Fraksperre wurde entfernt!')
                        local Embed = EmbedPreset
                        Embed.description = ("Der Spieler " .. xPlayer.getName() .. " hat seine Fraksperre entfernt bekommen von " .. xSource.getName())
                        Embed.fields = {
                            {
                                name = "Spieler Name",
                                value = xPlayer.getName()
                            },
                            {
                                name = "Teamler Name",
                                value = xSource.getName()
                            },
                            {
                                name = "Spieler Identifiers",
                                value = getIdentifiers(xPlayer.source)
                            },
                            {
                                name = "Teamler Identifiers",
                                value = getIdentifiers(xSource.source)
                            },
                        }
                        sendWebhook("WEBHOOK_HERE", {Embed})
                    end
                end
            end
        end
    end
end, false)