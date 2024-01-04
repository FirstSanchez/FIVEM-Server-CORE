local function OnPlayerConnecting(name, setKickReason, deferrals)
    local player = source
    local steamIdentifier = false
    local identifiers = GetPlayerIdentifiers(player)
    deferrals.defer()

    -- mandatory wait!
    Wait(0)

    deferrals.update(string.format("Hallo %s. Wir überprüfen, ob du schon auf dem Server bist...", name))

    for _, v in pairs(identifiers) do
        if string.find(v, "steam") then
            steamIdentifier = v
            break
        end
    end

    -- mandatory wait!
    Wait(0)

    if not steamIdentifier then
        deferrals.done("Du hast dein Steam nicht mit FiveM verknüpft.")
    else
        for _, PLAYER_ID in ipairs(GetPlayers()) do
            Wait(200)
            if PLAYER_ID ~= nil then
                local identifiers = GetPlayerIdentifiers(PLAYER_ID)
                local steamIdentifier2 = false
                for _, v in pairs(identifiers) do
                    if string.find(v, "steam") then
                        steamIdentifier2 = v
                        break
                    end
                end
                if steamIdentifier2 == steamIdentifier then
                    deferrals.done("(!) Ein Account mit dem selben Steam Identifier ist bereits auf dem Server")
                end
            end
        end
        deferrals.done()
    end
end

AddEventHandler("playerConnecting", OnPlayerConnecting)