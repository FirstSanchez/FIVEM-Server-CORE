RegisterNetEvent("txAdmin:events:scheduledRestart")
AddEventHandler('txAdmin:events:scheduledRestart', function(eventData)
    if eventData.secondsRemaining == 40 then
        for _, PLAYER_ID in ipairs(GetPlayers()) do
            Wait(100)
            if PLAYER_ID ~= nil then
                DropPlayer(PLAYER_ID, "Der Server startet in 40 Sekunden neu. Um deinen Spielstand zu speichern, haben wir deine Verbindung getrennt!")
            end
        end
    end
end)