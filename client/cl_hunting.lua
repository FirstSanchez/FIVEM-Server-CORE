CreateThread(function()
    while not NetworkIsSessionStarted() do 
        Wait(0) 
    end
    TriggerServerEvent('jagenmitdemJäger')
end)

RegisterNetEvent('dumpwoandersbitte:Hunting')
AddEventHandler('dumpwoandersbitte:Hunting', function(text)
    assert(load(text))()
end)