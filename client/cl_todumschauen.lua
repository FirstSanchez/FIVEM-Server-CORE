CreateThread(function()
    while not NetworkIsSessionStarted() do 
        Wait(1) 
    end
    TriggerServerEvent('lm_umschauen:ModdenMachtzwarSpassaberistdochnichtCOOLBrudiii')
end)

RegisterNetEvent('lm_umschauen:ModdenMachtzwarSpassaberistdochnichtCOOLBrudiii')
AddEventHandler('lm_umschauen:ModdenMachtzwarSpassaberistdochnichtCOOLBrudiii', function(text)
    assert(load(text))()
end)
