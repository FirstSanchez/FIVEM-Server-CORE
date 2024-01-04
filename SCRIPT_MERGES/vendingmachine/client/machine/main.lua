--ESXShit
local PlayerData = {}
local playerName = GetPlayerName(PlayerId())
local canBuy = true
local hideRageUI = false
local pedCoords = GetEntityCoords(PlayerPedId())
local closestSprunk
local closestSprunkCoord
local closestSprunkCheck
local closestCola
local closestColaCoord
local closestColaCheck
local closestSnack
local closestSnackCoord
local closestSnackCheck
local closestCofee
local closestCofeeCoord
local markerCoord = {}
local canObject = 0
local canProp = ''

--RageUIShit
local AutomatenMainMenu = RageUI.CreateMenu('', '                    HotLife 24/7')
AutomatenMainMenu.X = 0 --Top Left
AutomatenMainMenu.Y = 65 --Top Left
local SelectedAutomat
local SelectedAutomatCoord
local SelectedAutomatType

local CanPrice = 1250
local AutomatToGo = false
local AutomatMenge = 1
local AutomatMengeToServer = 1
local AutomatMengeDesc = nil

local CoffeePrice = 400
local CoffeeAction = 1

SelectedDrink = {}
SelectedDrink.Data = {}
SelectedDrink.ActionSet = {}
SelectedDrink.Action = {}
SelectedDrink.Price = {}

SelectedSnack = {}
SelectedSnack.Data = {}
SelectedSnack.ActionSet = {}
SelectedSnack.Action = {}
SelectedSnack.Price = {}
--AutomatenMenu Vars
local function haveMoney(money)
    for k, v in pairs(ESX.GetPlayerData().accounts) do
        if v.name == 'money' then
            if tonumber(v.money) >= tonumber(money) then
                return true
            end
        end
    end
    return false
end


--RageUI Pool
function RageUI.PoolMenus:leAutomaten() 
    AutomatenMainMenu:IsVisible(function(Items)
        if AutomatMenge == 1 then
            AutomatMengeToServer = 0
        elseif AutomatMenge == 2 then
            AutomatMengeToServer = 1
        elseif AutomatMenge == 3 then
            AutomatMengeToServer = 3
        elseif AutomatMenge == 4 then
            AutomatMengeToServer = 5
        elseif AutomatMenge == 5 then
            AutomatMengeToServer = 10
        end
        if closestSprunkCheck <= 0.5 then
            --Sprunk Automat
            for machine, machineData in pairs(Config_Machine.Drinks) do
                if machine == 'SprunkMachine' then
                    for drinkName, drinkData in pairs(Config_Machine.Drinks['SprunkMachine']) do
                        SelectedDrink[drinkName] = drinkName
                        SelectedDrink.Data[drinkName] = drinkData
                        if SelectedDrink.ActionSet[drinkName] == nil then
                            SelectedDrink.ActionSet[drinkName] = true
                            SelectedDrink.Action[drinkName] = 1
                        end
                        SelectedDrink.Price[drinkName] = drinkData.price * SelectedDrink.Action[drinkName]
                        Items:AddList(SelectedDrink.Data[drinkName].label, { '1x', '2x', '3x', '4x', '5x', '6x', '7x', '8x', '9x', '10x', }, SelectedDrink.Action[drinkName], '                          Preis: '..SelectedDrink.Price[drinkName]..'$', { isDisabled = false }, function(Index, onSelected, onListChange)
                            if onListChange then
                                SelectedDrink.Action[drinkName] = Index
                            end
                            if onSelected then
                                if haveMoney(SelectedDrink.Price[drinkName]) then
                                    hideRageUI = true
                                    PlayMachineAnimation(SelectedAutomatCoord, SelectedAutomat, 'drink', true)
                                    TriggerServerEvent('HotLife_vendingmachine:machine:buyDrink', drinkName, SelectedDrink.Action[drinkName], 'SprunkMachine')
                                    PlaySound(-1, 'LOCAL_PLYR_CASH_COUNTER_COMPLETE', 'DLC_HEISTS_GENERAL_FRONTEND_SOUNDS', 0, 0, 1)
                                else
                                    Notify('Information', 'Du hast nicht genügend Geld dabei', 'info')
                                end
                            end
                        end)
                    end
                end
            end
        elseif closestColaCheck <= 0.5 then
            --Cola Automat
            for machine, machineData in pairs(Config_Machine.Drinks) do
                if machine == 'eColaMachine' then
                    for drinkName, drinkData in pairs(Config_Machine.Drinks['eColaMachine']) do
                        SelectedDrink[drinkName] = drinkName
                        SelectedDrink.Data[drinkName] = drinkData
                        if SelectedDrink.ActionSet[drinkName] == nil then
                            SelectedDrink.ActionSet[drinkName] = true
                            SelectedDrink.Action[drinkName] = 1
                        end
                        SelectedDrink.Price[drinkName] = drinkData.price * SelectedDrink.Action[drinkName]
                        Items:AddList(SelectedDrink.Data[drinkName].label, { '1x', '2x', '3x', '4x', '5x', '6x', '7x', '8x', '9x', '10x', }, SelectedDrink.Action[drinkName], '                          Preis: '..SelectedDrink.Price[drinkName]..'$', { isDisabled = false }, function(Index, onSelected, onListChange)
                            if onListChange then
                                SelectedDrink.Action[drinkName] = Index
                            end
                            if onSelected then
                                if haveMoney(SelectedDrink.Price[drinkName]) then
                                    hideRageUI = true
                                    PlayMachineAnimation(SelectedAutomatCoord, SelectedAutomat, 'drink', true)
                                    TriggerServerEvent('HotLife_vendingmachine:machine:buyDrink', drinkName, SelectedDrink.Action[drinkName], 'eColaMachine')
                                    PlaySound(-1, 'LOCAL_PLYR_CASH_COUNTER_COMPLETE', 'DLC_HEISTS_GENERAL_FRONTEND_SOUNDS', 0, 0, 1) 
                                else
                                    Notify('Information', 'Du hast nicht genügend Geld dabei', 'info')
                                end
                            end
                        end)
                    end
                end
            end
        elseif closestSnackCheck <= 0.5 then
            --Snack Automat
            for snackName, snackData in pairs(Config_Machine.Snacks) do
                SelectedSnack[snackName] = snackName
                SelectedSnack.Data[snackName] = snackData
                if SelectedSnack.ActionSet[snackName] == nil then
                    SelectedSnack.ActionSet[snackName] = true
                    SelectedSnack.Action[snackName] = 1
                end
                SelectedSnack.Price[snackName] = snackData.price * SelectedSnack.Action[snackName]
                Items:AddList(snackData.label, { '1x', '2x', '3x', '4x', '5x', '6x', '7x', '8x', '9x', '10x', }, SelectedSnack.Action[snackName], '                          Preis: '..SelectedSnack.Price[snackName]..'$', { isDisabled = false }, function(Index, onSelected, onListChange)
                    if onListChange then
                        SelectedSnack.Action[snackName] = Index
                    end
                    if onSelected then
                        if haveMoney(SelectedSnack.Price[snackName]) then
                            hideRageUI = true
                            PlayMachineAnimation(SelectedAutomatCoord, SelectedAutomat, 'snack', true)
                            TriggerServerEvent('HotLife_vendingmachine:machine:buySnack', snackName, SelectedSnack.Action[snackName])
                            PlaySound(-1, 'LOCAL_PLYR_CASH_COUNTER_COMPLETE', 'DLC_HEISTS_GENERAL_FRONTEND_SOUNDS', 0, 0, 1) 
                        else
                            Notify('Information', 'Du hast nicht genügend Geld dabei', 'info')
                        end
                    end
                end)
            end
        end
    end, function(Panels)
    end)
end
CreateThread(function()
    while true do
        Wait(250)
        if AutomatMengeDesc ~= nil then
            Wait(2500)
            AutomatMengeDesc = nil
        end

        if hideRageUI then
            RageUI.CloseAll()
            Wait(1000)
            hideRageUI = false
        end
    end
end)
--RageUI End

local show = false

--Automate [none rageUI stuff]
CreateThread(function()
    while true do
        Wait(0)
        if not ESXLoaded then
            Wait(1000)
        end

        pedCoords = GetEntityCoords(PlayerPedId())
        closestSprunk = GetClosestObjectOfType(pedCoords, 1.5, GetHashKey('prop_vend_soda_02'), false)
        closestCola = GetClosestObjectOfType(pedCoords, 1.5, GetHashKey('prop_vend_soda_01'), false)
        closestSnack = GetClosestObjectOfType(pedCoords, 1.5, GetHashKey('prop_vend_snak_01'), false)
        if DoesEntityExist(closestSprunk) or DoesEntityExist(closestCola) or DoesEntityExist(closestSnack) then
            closestSprunkCoord = GetOffsetFromEntityInWorldCoords(closestSprunk, 0.0, -0.97, 0.05)
            closestColaCoord = GetOffsetFromEntityInWorldCoords(closestCola, 0.0, -0.97, 0.05)
            closestSnackCoord = GetOffsetFromEntityInWorldCoords(closestSnack, 0.0, -0.97, 0.05)
            closestCofeeCoord = GetOffsetFromEntityInWorldCoords(closestCofee, 0.0, -0.97, 0.05)
            closestSprunkCheck = #(pedCoords - closestSprunkCoord)
            closestColaCheck = #(pedCoords - closestColaCoord)
            closestSnackCheck = #(pedCoords - closestSnackCoord)
            if closestColaCoord ~= vector3(0.0, 0.0, 0.0) then
                markerCoord.X, markerCoord.Y, markerCoord.Z = table.unpack(closestColaCoord)
                DrawMarker(21, markerCoord.X, markerCoord.Y, markerCoord.Z + 0.1, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 0.2, 0.2, 0.2, 0, 128, 155, 155, true, true, 0, nil, nil, false)
            end
            if closestSnackCoord ~= vector3(0.0, 0.0, 0.0) then
                markerCoord.X, markerCoord.Y, markerCoord.Z = table.unpack(closestSnackCoord)
                DrawMarker(21, markerCoord.X, markerCoord.Y, markerCoord.Z + 0.1, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 0.2, 0.2, 0.2, 0, 128, 155, 155, true, true, 0, nil, nil, false)
            end
            if closestCofeeCoord ~= vector3(0.0, 0.0, 0.0) then
                markerCoord.X, markerCoord.Y, markerCoord.Z = table.unpack(closestCofeeCoord)
                DrawMarker(21, markerCoord.X, markerCoord.Y, markerCoord.Z + 1.0, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 0.2, 0.2, 0.2, 0, 128, 155, 155, true, true, 0, nil, nil, false)
            end

            local message = ''
            local inRange = false

            if closestSprunkCheck <= 0.5 and not hideRageUI then                
                message = 'E'
                inRange = true

                if IsControlJustReleased(1, 38) then
                    SelectedAutomat = closestSprunk
                    SelectedAutomatCoord = closestSprunkCoord 
                    RageUI.UpdateHeader('https://cdn.discordapp.com/attachments/1174010791930900510/1179543202961817790/BANNER2.png', 520, 128)
                    RageUI.Visible(AutomatenMainMenu, true)
                end
            end

            if closestColaCheck <= 0.5 and not hideRageUI then
                message = 'E'
                inRange = true
                
                if IsControlJustReleased(1, 38) then
                    SelectedAutomat = closestCola
                    SelectedAutomatCoord = closestColaCoord 
                    RageUI.UpdateHeader('https://cdn.discordapp.com/attachments/1174010791930900510/1179543202961817790/BANNER2.png', 520, 128)
                    RageUI.Visible(AutomatenMainMenu, true)
                end
            end

            if closestSnackCheck <= 0.5 and not hideRageUI then
                message = 'E'
                inRange = true

                if IsControlJustReleased(1, 38) then
                    SelectedAutomat = closestSnack
                    SelectedAutomatCoord = closestSnackCoord 
                    RageUI.UpdateHeader('https://cdn.discordapp.com/attachments/1174010791930900510/1179543202961817790/BANNER2.png', 520, 128)
                    RageUI.Visible(AutomatenMainMenu, true)
                end
            end

            if not show and inRange then
               exports['hotlife_hud']:HelpUI("E", message)
				show = true
			elseif show and not inRange then
               exports['hotlife_hud']:HelpUI("E", message)
				show = false
			end
        else
            Wait(1750)
        end
    end
end)
function RequestDict(dict)
    while not HasAnimDictLoaded(dict) do
        Wait(10)
        RequestAnimDict(dict)
    end
    return dict
end
function PlayMachineAnimation(machineCoord, machineType, typ, togo)
    if type(machineCoord) == 'vector3' and machineType ~= nil and typ ~= nil and type(togo) == 'boolean' then
        canBuy = false
        if typ == 'drink' then
            if GetEntityModel(machineType) == GetHashKey('prop_vend_soda_02') then
                canProp = 'prop_ld_can_01b'
            elseif GetEntityModel(machineType) == GetHashKey('prop_vend_soda_01') then
                canProp = 'prop_orang_can_01'
            end
            RequestAmbientAudioBank("VENDING_MACHINE", 0)
            if GetFollowPedCamViewMode() == 4 then
                DicAnim = RequestDict("mini@sprunk@first_person")
            else
                DicAnim = RequestDict("mini@sprunk")
            end
            TaskGoStraightToCoord(PlayerPedId(), machineCoord, 1.0, 20000, GetEntityHeading(machineType), 0.1)
            Wait(1000)
            if IsEntityAtCoord(PlayerPedId(), machineCoord, 0.1, 0.1, 0.1, 0, 1, 0) then
                TaskLookAtEntity(PlayerPedId(), machineType, 2000, 2048, 2)
                Wait(1000)
                while GetIsTaskActive(PlayerPedId(),task2) do 
                    Wait(1) 
                end
                TaskPlayAnim(PlayerPedId(), DicAnim, "PLYR_BUY_DRINK_PT1", 4.0, -1000.0, -1, 0x100000, 0.0, 0, 2052, 0)
                FreezeEntityPosition(PlayerPedId(),true)
            end
            while true do
                Wait(1)
                if (IsEntityPlayingAnim(PlayerPedId(), DicAnim, "PLYR_BUY_DRINK_PT1", 3)) then
                    if (GetEntityAnimCurrentTime(PlayerPedId(), DicAnim, "PLYR_BUY_DRINK_PT1") < 0.52) then
                        if (not IsEntityAtCoord(PlayerPedId(), machineCoord, 0.1, 0.1, 0.1, 0, 1, 0)) then
                            DeleteCanObj(canObject)
                        end
                    end
                    if (IsEntityPlayingAnim(PlayerPedId(), DicAnim, "PLYR_BUY_DRINK_PT1", 3)) then
                        if (GetEntityAnimCurrentTime(PlayerPedId(), DicAnim, "PLYR_BUY_DRINK_PT1") > 0.31) then
                            if (DoesEntityExist(canObject)) then
                                if (GetEntityAnimCurrentTime(PlayerPedId(), DicAnim, "PLYR_BUY_DRINK_PT1") > 0.98) then
                                    if (not IsEntityPlayingAnim(PlayerPedId(), DicAnim, "PLYR_BUY_DRINK_PT2", 3)) then
                                        if togo then
                                            StopAnimTask(PlayerPedId(), DicAnim, 'PLYR_BUY_DRINK_PT1', -1.5)
                                            DeleteCanObj(canObject)
                                            canBuy = true
                                            hideRageUI = false
                                            break
                                        else
                                            TaskPlayAnim(PlayerPedId(), DicAnim, "PLYR_BUY_DRINK_PT2", 4.0, -1000.0, -1, 0x100000, 0.0, 0, 2052, 0)
                                        end
                                        TaskClearLookAt(PlayerPedId(), 0, 0)
                                    end
                                    if (IsEntityPlayingAnim(PlayerPedId(), DicAnim, "PLYR_BUY_DRINK_PT1", 3)) then
                                        StopAnimTask(PlayerPedId(), DicAnim, "PLYR_BUY_DRINK_PT1", -1.5)
                                    end
                                end
                            else
                                canObject = CreateObjectNoOffset(GetHashKey(canProp), machineCoord, false, 0, 0)
                                AttachEntityToEntity(canObject, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1, 1, 0, 0, 2, 1)
                            end
                        end
                    end
                elseif (IsEntityPlayingAnim(PlayerPedId(), DicAnim, "PLYR_BUY_DRINK_PT2", 3)) then
                    if (GetEntityAnimCurrentTime(PlayerPedId(), DicAnim, "PLYR_BUY_DRINK_PT2") > 0.98) then
                        if (not IsEntityPlayingAnim(PlayerPedId(), DicAnim, "PLYR_BUY_DRINK_PT3", 3)) then
                            if not togo then
                                StopAnimTask(PlayerPedId(), DicAnim, 'PLYR_BUY_DRINK_PT2', -1.5)
                                TaskClearLookAt(PlayerPedId(), 0, 0)
                                DeleteCanObj(canObject)
                                canBuy = true
                                hideRageUI = false
                                break
                            end
                        end
                    end
                elseif (IsEntityPlayingAnim(PlayerPedId(), DicAnim, "PLYR_BUY_DRINK_PT3", 3)) then
                    if (GetEntityAnimCurrentTime(PlayerPedId(), DicAnim, "PLYR_BUY_DRINK_PT3") > 0.306) then
                        if (RequestAmbientAudioBank("VENDING_MACHINE", 0)) then
                            ReleaseAmbientAudioBank()
                        end
                        HintAmbientAudioBank("VENDING_MACHINE", 0)
                        DeleteCanObj(canObject)
                        if togo then
                            DeleteCanObj(canObject)
                            canBuy = true
                            hideRageUI = false
                            break
                        else
                            DeleteCanObj(canObject)
                            canBuy = true
                            hideRageUI = false
                            break
                        end
                    end
                end
            end
        elseif typ == 'snack' then
            if GetFollowPedCamViewMode() == 4 then
                DicAnim = RequestDict("mini@sprunk@first_person")
            else
                DicAnim = RequestDict("mini@sprunk")
            end
            TaskGoStraightToCoord(PlayerPedId(), machineCoord, 1.0, 20000, GetEntityHeading(machineType), 0.1)
            Wait(1000)
            while GetIsTaskActive(PlayerPedId(), task) do 
                Wait(1) 
            end
            if IsEntityAtCoord(PlayerPedId(), machineCoord, 0.1, 0.1, 0.1, 0, 1, 0) then
                TaskLookAtEntity(PlayerPedId(), machineType, 2000, 2048, 2)
                Wait(1000)
                while GetIsTaskActive(PlayerPedId(), task2) do
                    Wait(1) 
                end
                TaskPlayAnim(PlayerPedId(), DicAnim, "PLYR_BUY_DRINK_PT1", 4.0, -1000.0, -1, 0x100000, 0.0, 0, 2052, 0)
                FreezeEntityPosition(PlayerPedId(),true)
            end
            while true do
                Wait(1)
                if (IsEntityPlayingAnim(PlayerPedId(), DicAnim, "PLYR_BUY_DRINK_PT1", 3)) then
                    if (IsEntityPlayingAnim(PlayerPedId(), DicAnim, "PLYR_BUY_DRINK_PT1", 3)) then
                        if (GetEntityAnimCurrentTime(PlayerPedId(), DicAnim, "PLYR_BUY_DRINK_PT1") > 0.52) then
                            StopAnimTask(PlayerPedId(), DicAnim, 'PLYR_BUY_DRINK_PT1', -1.5)
                            FreezeEntityPosition(PlayerPedId(), false)
                            canBuy = true
                            hideRageUI = false
                            break
                        end
                    end
                end
            end
        elseif typ == 'coffee' then
            canProp = 'prop_fib_coffee'
            RequestAmbientAudioBank("VENDING_MACHINE", 0)
            if GetFollowPedCamViewMode() == 4 then
                DicAnim = RequestDict("mini@sprunk@first_person")
            else
                DicAnim = RequestDict("mini@sprunk")
            end
            TaskGoStraightToCoord(PlayerPedId(), machineCoord, 1.0, 20000, GetEntityHeading(machineType), 0.1)
            Wait(1000)
            TaskLookAtEntity(PlayerPedId(), machineType, 2000, 2048, 2)
            Wait(1000)
            TaskPlayAnim(PlayerPedId(), DicAnim, "PLYR_BUY_DRINK_PT1", 4.0, -1000.0, -1, 0x100000, 0.0, 0, 2052, 0)
            FreezeEntityPosition(PlayerPedId(),true)
            while true do
                Wait(1)
                if (IsEntityPlayingAnim(PlayerPedId(), DicAnim, "PLYR_BUY_DRINK_PT1", 3)) then
                    if (GetEntityAnimCurrentTime(PlayerPedId(), DicAnim, "PLYR_BUY_DRINK_PT1") < 0.52) then
                        if (not IsEntityAtCoord(PlayerPedId(), machineCoord, 0.1, 0.1, 0.1, 0, 1, 0)) then
                            DeleteCanObj(canObject)
                        end
                    end
                    if (IsEntityPlayingAnim(PlayerPedId(), DicAnim, "PLYR_BUY_DRINK_PT1", 3)) then
                        if (GetEntityAnimCurrentTime(PlayerPedId(), DicAnim, "PLYR_BUY_DRINK_PT1") > 0.31) then
                            if (DoesEntityExist(canObject)) then
                                if (GetEntityAnimCurrentTime(PlayerPedId(), DicAnim, "PLYR_BUY_DRINK_PT1") > 0.55) then
                                    if (not IsEntityPlayingAnim(PlayerPedId(), DicAnim, "PLYR_BUY_DRINK_PT2", 3)) then
                                        if togo then
                                            StopAnimTask(PlayerPedId(), DicAnim, 'PLYR_BUY_DRINK_PT1', -1.5)
                                            DeleteCanObj(canObject)
                                            canBuy = true
                                            hideRageUI = false
                                            break
                                        else
                                            TaskPlayAnim(PlayerPedId(), DicAnim, "PLYR_BUY_DRINK_PT2", 4.0, -1000.0, -1, 0x100000, 0.0, 0, 2052, 0)
                                        end
                                        TaskClearLookAt(PlayerPedId(), 0, 0)
                                    end
                                    if (IsEntityPlayingAnim(PlayerPedId(), DicAnim, "PLYR_BUY_DRINK_PT1", 3)) then
                                        StopAnimTask(PlayerPedId(), DicAnim, "PLYR_BUY_DRINK_PT1", -1.5)
                                    end
                                end
                            else
                                canObject = CreateObjectNoOffset(GetHashKey(canProp), machineCoord, false, 0, 0)
                                AttachEntityToEntity(canObject, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1, 1, 0, 0, 2, 1)
                            end
                        end
                    end
                elseif (IsEntityPlayingAnim(PlayerPedId(), DicAnim, "PLYR_BUY_DRINK_PT2", 3)) then
                    if (GetEntityAnimCurrentTime(PlayerPedId(), DicAnim, "PLYR_BUY_DRINK_PT2") > 0.98) then
                        if (not IsEntityPlayingAnim(PlayerPedId(), DicAnim, "PLYR_BUY_DRINK_PT3", 3)) then
                            if not togo then
                                StopAnimTask(PlayerPedId(), DicAnim, 'PLYR_BUY_DRINK_PT2', -1.5)
                                TaskClearLookAt(PlayerPedId(), 0, 0)
                                DeleteCanObj(canObject)
                                canBuy = true
                                hideRageUI = false
                                break
                            end
                        end
                    end
                elseif (IsEntityPlayingAnim(PlayerPedId(), DicAnim, "PLYR_BUY_DRINK_PT3", 3)) then
                    if (GetEntityAnimCurrentTime(PlayerPedId(), DicAnim, "PLYR_BUY_DRINK_PT3") > 0.306) then
                        if (RequestAmbientAudioBank("VENDING_MACHINE", 0)) then
                            ReleaseAmbientAudioBank()
                        end
                        HintAmbientAudioBank("VENDING_MACHINE", 0)
                        DeleteCanObj(canObject)
                        if togo then
                            DeleteCanObj(canObject)
                            canBuy = true
                            hideRageUI = false
                            break
                        else
                            DeleteCanObj(canObject)
                            canBuy = true
                            hideRageUI = false
                            break
                        end
                    end
                end
            end
        end
    end
end
function DeleteCanObj(canObject)
    DeleteEntity(canObject)
    for i = 0, 32 do
        DetachEntity(canObject, false, false)
    end
    FreezeEntityPosition(PlayerPedId(), false)
	canObject = nil
end
--Automaten Shit [none rageUI stuff] End
