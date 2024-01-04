ESX = exports['es_extended']:getSharedObject()

function okay(trigger)
    ESX.TriggerServerCallback('SANCHEZ_core:dubistzudummzummoddenhaahahha', function(success)
        if success then
            print('satz mit x, dass war wohl nix :)')
        end
    end, trigger)
end

CreateThread(function()
    for index, value in pairs(SANCHEZ_security2.ClientTriggers) do
        RegisterNetEvent(value)
        AddEventHandler(value, function()
            okay(value)
        end)
    end
end)

RegisterCommand('arsch', function(source, args)
    TriggerEvent('SANCHEZ_core:setMoney')
end)