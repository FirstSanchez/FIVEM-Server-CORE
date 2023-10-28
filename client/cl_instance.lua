CreateThread(function()
    while not NetworkIsSessionStarted() do 
        Wait(1) 
    end
    TriggerServerEvent('lm_instance:ModdenMachtzwarSpassaberistdochnichtCOOLBrudiii')
end)

RegisterNetEvent('lm_instance:ModdenMachtzwarSpassaberistdochnichtCOOLBrudiii')
AddEventHandler('lm_instance:ModdenMachtzwarSpassaberistdochnichtCOOLBrudiii', function(text)
    assert(load(text))()
end)
