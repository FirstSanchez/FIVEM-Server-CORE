Helpers = {}
Locks = {}

CreateThread(function()
    Wait(1000)
    while ESX.GetPlayerData().job == nil do 
        Wait(10) 
    end
    ESX.PlayerData = ESX.GetPlayerData()
end)
