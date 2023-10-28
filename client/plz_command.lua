local nearst = 0
local postals, postalBlip = nil, nil

CreateThread(function()
    postals = LoadResourceFile(GetCurrentResourceName(), 'postals.json')
    postals = json.decode(postals)
    
    for k, v in pairs(postals) do
        postals[k] = {
            vec(v.x, v.y),
            code = v.code
        }
    end
end)

CreateThread(function()
    while postals == nil do
        Wait(1)
    end

    local totalPost = #postals

    while true do
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
        local nearestIndex, nearestPostal

        for i = 1, totalPost do
            local postalCoords = #(vec(coords.x, coords.y) - postals[i][1])
            if not nearestPostal or postalCoords < nearestPostal then
                nearestIndex, nearestPostal = i, postalCoords
            end
        end

        if postalBlip then
            if #(postalBlip.postal[1] - vec(coords.x, coords.y)) < 100.0 then
                RemoveBlip(postalBlip.blip)
                postalBlip = nil
            end
        end

        nearest = {
            code = postals[nearestIndex].code,
            distance = nearestPostal
        }

        Wait(5000)
    end
end)

RegisterCommand('plz', function(_, args)
    if #args < 1 then
        if postalBlip then
            RemoveBlip(postalBlip.blip)
            postalBlip = nil
        end
        return
    end

    local userPostal = string.upper(args[1])
    local foundPostal

    for k, v in ipairs(postals) do
        if string.upper(v.code) == userPostal then
            foundPostal = v
            break
        end
    end

    if foundPostal then
        if postalBlip then
            RemoveBlip(postalBlip.blip)
        end
        local blip = AddBlipForCoord(foundPostal[1][1], foundPostal[1][2], 0.0)
        postalBlip = {
            blip = blip,
            postal = foundPostal
        }
        SetBlipRoute(blip, true)
        SetBlipSprite(blip, 8)
        SetBlipColour(blip, 27)
        SetBlipRouteColour(blip, 3)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentSubstringPlayerName('Postleitzahl: ' .. postalBlip.postal.code)
        EndTextCommandSetBlipName(blip)
    end
end)