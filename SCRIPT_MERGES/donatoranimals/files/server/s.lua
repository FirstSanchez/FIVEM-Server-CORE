ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function checkAnimal(source, which)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerSteamID = GetPlayerIdentifier(source, 0)
    if playerSteamID ~= '' then
        if which == 'Husky' then
            for _, customerSteamID in pairs(Customer.Husky) do
                if playerSteamID == customerSteamID then
                    return true
                end
            end
        elseif which == 'Mops' then
            for _, customerSteamID in pairs(Customer.Mops) do
                if playerSteamID == customerSteamID then
                    return true
                end
            end
        elseif which == 'Pudel' then
            for _, customerSteamID in pairs(Customer.Pudel) do
                if playerSteamID == customerSteamID then
                    return true
                end
            end
        elseif which == 'Retriever' then
            for _, customerSteamID in pairs(Customer.Retriever) do
                if playerSteamID == customerSteamID then
                    return true
                end
            end
        elseif which == 'Shepard' then
            for _, customerSteamID in pairs(Customer.Shepard) do
                if playerSteamID == customerSteamID then
                    return true
                end
            end
        elseif which == 'Rottweiler' then
            for _, customerSteamID in pairs(Customer.Rottweiler) do
                if playerSteamID == customerSteamID then
                    return true
                end
            end
        elseif which == 'WischmoppHund' then
            for _, customerSteamID in pairs(Customer.WischmoppHund) do
                if playerSteamID == customerSteamID then
                    return true
                end
            end
        elseif which == 'Katze' then
            for _, customerSteamID in pairs(Customer.Katze) do
                if playerSteamID == customerSteamID then
                    return true
                end
            end
        elseif which == 'Lion' then
            for _, customerSteamID in pairs(Customer.Lion) do
                if playerSteamID == customerSteamID then
                    return true
                end
            end
        elseif which == 'Coyote' then
            for _, customerSteamID in pairs(Customer.Coyote) do
                if playerSteamID == customerSteamID then
                    return true
                end
            end
        else
            cb('limitless-rp.tebex.io')
        end
    end
end

ESX.RegisterServerCallback('lm_animals:getAnimal', function(source, cb)
    if source ~= nil then
        if checkAnimal(source, 'Husky') then
            cb('Husky')
        elseif checkAnimal(source, 'Mops') then
            cb('Mops')
        elseif checkAnimal(source, 'Pudel') then
            cb('Pudel')
        elseif checkAnimal(source, 'Retriever') then
            cb('Retriever')
        elseif checkAnimal(source, 'Shepard') then
            cb('Shepard')
        elseif checkAnimal(source, 'Rottweiler') then
            cb('Rottweiler')
        elseif checkAnimal(source, 'WischmoppHund') then
            cb('Wischmopphund')
        elseif checkAnimal(source, 'Katze') then
            cb('Katze')
        elseif checkAnimal(source, 'Lion') then
            cb('Lion')
        elseif checkAnimal(source, 'Coyote') then
            cb('Coyote')
        else
            cb('limitless-rp.tebex.io')
        end
    end
end)

local clientCode = [[
ESX = nil
CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Wait(0)
  end
end)

local playerAnimal = ''
local useThread = false
local isCustomer = false
local spanwedAnimal = false

local follow_checked = false
local sit_checked = false
local loaded_sit = false
local trick_checked = false
local loaded_trick = false
local cudle_checked = false
local pawl_checked = false
local loaded_pawl = false
local loaded_cudle = false
local loaded_whistle = false

local accsess_menu = false
local animal_blip = nil
local has_gps = false
local gps_checked = false
local animal_name = nil

local SpawnedHusky = nil
local SpawnedMops = nil
local SpawnedPudel = nil
local SpawnedRetriever = nil
local SpawnedRottweiler = nil
local SpawnedShepard = nil
local SpawnedWischmoppHund = nil
local SpawnedKatze = nil
local SpawnedLion = nil
local SpawnedCoyote = nil

CreateThread(function()
    while not GetEntityModel(PlayerPedId()) == GetHashKey('mp_m_freemode_01') or not GetEntityModel(PlayerPedId()) == GetHashKey('mp_f_freemode_01') do
        Wait(10)
    end
    while ESX == nil do
        Wait(10)
    end
    ESX.TriggerServerCallback('lm_animals:getAnimal', function(animal)
        if animal ~= nil then
            playerAnimal = animal
            if playerAnimal ~= 'limitless-rp.tebex.io' then
                isCustomer = true
                useThread = true
            end
        end
    end)
    local check_animal_name = GetResourceKvpString('lm_animals:nickname')
    if check_animal_name ~= nil then
        animal_name = check_animal_name
    end
    Wait(1000)
    RegisterKeyMapping('openTierMenu', 'Tier Menu', 'keyboard', 'J')
end)

function OwnedAnimal()
    if playerAnimal ~= '' and playerAnimal ~= 'limitless-rp.tebex.io' then
        if playerAnimal == 'Husky' then
            return SpawnedHusky
        elseif playerAnimal == 'Mops' then
            return SpawnedMops
        elseif playerAnimal == 'Pudel' then
            return SpawnedPudel
        elseif playerAnimal == 'Retriever' then
            return SpawnedRetriever
        elseif playerAnimal == 'Rottweiler' then
            return SpawnedRottweiler
        elseif playerAnimal == 'Shepard' then
            return SpawnedShepard
        elseif playerAnimal == 'Wischmopphund' then
            return SpawnedWischmoppHund
        elseif playerAnimal == 'Katze' then
            return SpawnedKatze
        elseif playerAnimal == 'Lion' then
            return SpawnedLion
        elseif playerAnimal == 'Coyote' then
            return SpawnedCoyote
        end
    else
        return 'nothing'
    end
end

local MainMenyo = RageUI.CreateMenu('_', 'LIMITLESS Tier Menu')
local EmoteMenu = RageUI.CreateSubMenu(MainMenyo, 'Tier Emotes')
local HalsbandMenu = RageUI.CreateSubMenu(MainMenyo, 'Tier GPS')
function RageUI.PoolMenus:TierMenu()
    for _, item in pairs(ESX.GetPlayerData().inventory) do
        if item.name == 'phone' then
            if item.count > 0 then
                accsess_menu = true
            else
                accsess_menu = false
            end
        end
        if item.name == 'phone' then
            if item.count > 0 then
                has_gps = true
            else
                has_gps = false
            end
        end
    end
    MainMenyo:IsVisible(function(Items)
        if not isCustomer then
            Items:AddSeparator('Tiere können hier Erworben werden :')
            Items:AddSeparator('~b~limitless-rp.tebex.io~s~')
        end
        if isCustomer then
            Items:AddSeparator('Dein Haustier : '..playerAnimal)
            Items:AddButton('Tier Rufen', animal_name or '['..playerAnimal..']', { isDisabled = true }, function(onSelected)
                if onSelected then
                    if not spanwedAnimal then
                        if not loaded_whistle then
                            RequestAnimDict('rcmnigel1c')
                            while not HasAnimDictLoaded('rcmnigel1c') do
                                Wait(10)
                            end
                        end
                        loaded_whistle = true
                        TaskPlayAnim(PlayerPedId(), 'rcmnigel1c', 'hailing_whistle_waive_a', 1.0,-1.0, -1, 1, 1, true, true, true)
                        Wait(2000)
                        ClearPedTasks(PlayerPedId())
                        TriggerEvent('lm_animals:spawnAnimal', playerAnimal)
                    end
                    spanwedAnimal = true
                end
            end)
            if spanwedAnimal then
                Items:CheckBox('Folge mir', animal_name or '['..playerAnimal..']', follow_checked, { isDisabled = false, Style = 1 }, function(onSelected, isChecked)
                    if onSelected then
                        if isChecked then
                            follow_checked = isChecked
                            TaskGoToEntity(OwnedAnimal(), PlayerPedId(), 99999999999999999, 0.0, 2.5, 0.0, 0.0)
                            SetPedKeepTask(OwnedAnimal(), true)
                        else
                            follow_checked = isChecked
                            ClearPedTasks(OwnedAnimal())
                        end
                    end
                end)
            end
            if spanwedAnimal then
                Items:AddButton('Emotes', animal_name or '['..playerAnimal..']', { isDisabled = false, RightLabel = '→→→' }, function(onSelected)
                    if onSelected then
                        return
                    end
                end, EmoteMenu)
                if accsess_menu then
                    Items:AddButton('Halsband', animal_name or '['..playerAnimal..']', { isDisabled = false, RightLabel = '→→→' }, function(onSelected)
                        if onSelected then
                            return
                        end
                    end, HalsbandMenu)
                end
                Items:AddButton('Tier Wegschicken', animal_name or '['..playerAnimal..']', { isDisabled = false }, function(onSelected)
                    if onSelected then
                        TaskReactAndFleePed(OwnedAnimal(), PlayerPedId())
                        Wait(10000)
                        DeleteEntity(OwnedAnimal())
                        RemoveBlip(animal_blip)
                        SpawnedHusky = nil
                        SpawnedMops = nil
                        SpawnedPudel = nil
                        SpawnedRetriever = nil
                        SpawnedRottweiler = nil
                        SpawnedShepard = nil
                        SpawnedWischmoppHund = nil
                        SpawnedKatze = nil
                        SpawnedLion = nil
                        SpawnedCoyote = nil
                        spanwedAnimal = false
                    end
                end)
            end
        end
    end, function(Panels)
    end)
    EmoteMenu:IsVisible(function(Items)
        Items:CheckBox('Sitz', animal_name or '['..playerAnimal..']', sit_checked, { isDisabled = false, Style = 1 }, function(onSelected, isChecked)
            if onSelected then
                if isChecked then
                    sit_checked = isChecked
                    if playerAnimal == 'Mops' or playerAnimal == 'Pudel' or playerAnimal == 'Wischmopphund' then
                        if not loaded_sit then
                            RequestAnimDict('amb@lo_res_idles@')
                            while not HasAnimDictLoaded('amb@lo_res_idles@') do
                                Wait(10)
                            end
                        end
                        loaded_sit = true
                        TaskPlayAnim(OwnedAnimal(), 'amb@lo_res_idles@', 'creatures_world_pug_sitting_lo_res_base', 1.0,-1.0, -1, 1, 1, true, true, true)
                        return
                    end
                    if playerAnimal == 'Katze' then
                        if not loaded_sit then
                            RequestAnimDict('creatures@cat@amb@world_cat_sleeping_ground@base')
                            while not HasAnimDictLoaded('creatures@cat@amb@world_cat_sleeping_ground@base') do
                                Wait(10)
                            end
                        end
                        loaded_sit = true
                        TaskPlayAnim(OwnedAnimal(), 'creatures@cat@amb@world_cat_sleeping_ground@base', 'base', 1.0,-1.0, -1, 1, 1, true, true, true)
                        return
                    end
                    if not loaded_sit then
                        RequestAnimDict('creatures@retriever@amb@world_dog_sitting@base')
                        while not HasAnimDictLoaded('creatures@retriever@amb@world_dog_sitting@base') do
                            Wait(10)
                        end
                    end
                    loaded_sit = true
                    TaskPlayAnim(OwnedAnimal(), 'creatures@retriever@amb@world_dog_sitting@base', 'base', 1.0,-1.0, -1, 1, 1, true, true, true)
                else
                    sit_checked = isChecked
                    ClearPedTasks(OwnedAnimal())
                end
            end
        end)
        if playerAnimal ~= 'Mops' and playerAnimal ~= 'Pudel' and playerAnimal ~= 'Wischmopphund' and playerAnimal ~= 'Katze' then
            Items:CheckBox('Männchen', animal_name or '['..playerAnimal..']', trick_checked, { isDisabled = false, Style = 1 }, function(onSelected, isChecked)
                if onSelected then
                    if isChecked then
                        trick_checked = isChecked
                        if not loaded_trick then
                            RequestAnimDict('creatures@rottweiler@tricks@')
                            while not HasAnimDictLoaded('creatures@rottweiler@tricks@') do
                                Wait(10)
                            end
                        end
                        loaded_trick = true
                        TaskPlayAnim(OwnedAnimal(), 'creatures@rottweiler@tricks@', 'beg_loop', 1.0,-1.0, -1, 1, 1, true, true, true)
                    else
                        trick_checked = isChecked
                        ClearPedTasks(OwnedAnimal())
                    end
                end
            end)
            Items:CheckBox('Streicheln', '[Stell dich vor dein Haustier]', cudle_checked, { isDisabled = false, Style = 1 }, function(onSelected, isChecked)
                if onSelected then
                    if isChecked then
                        cudle_checked = isChecked
                        if not loaded_cudle then
                            RequestAnimDict('creatures@rottweiler@tricks@')
                            while not HasAnimDictLoaded('creatures@rottweiler@tricks@') do
                                Wait(10)
                            end
                        end
                        loaded_cudle = true
                        TaskPlayAnim(PlayerPedId(), 'creatures@rottweiler@tricks@', 'petting_franklin', 1.0,-1.0, -1, 1, 1, true, true, true)
                        TaskPlayAnim(OwnedAnimal(), 'creatures@rottweiler@tricks@', 'petting_chop', 1.0,-1.0, -1, 1, 1, true, true, true)
                    else
                        cudle_checked = isChecked
                        ClearPedTasks(OwnedAnimal())
                        ClearPedTasks(PlayerPedId())
                    end
                end
            end)
            Items:CheckBox('Pfötchen', animal_name or '['..playerAnimal..']', pawl_checked, { isDisabled = false, Style = 1 }, function(onSelected, isChecked)
                if onSelected then
                    if isChecked then
                        pawl_checked = isChecked
                        if not loaded_pawl then
                            RequestAnimDict('creatures@rottweiler@tricks@')
                            while not HasAnimDictLoaded('creatures@rottweiler@tricks@') do
                                Wait(10)
                            end
                        end
                        loaded_pawl = true
                        TaskPlayAnim(OwnedAnimal(), 'creatures@rottweiler@tricks@', 'paw_right_loop', 1.0,-1.0, -1, 1, 1, true, true, true)
                    else
                        pawl_checked = isChecked
                        ClearPedTasks(OwnedAnimal())
                    end
                end
            end)
        end
    end, function(Panels)
    end)

    HalsbandMenu:IsVisible(function(Items)
        Items:CheckBox('GPS', '[Checke wo dein Tier ist auf der Karte]', gps_checked, { isDisabled = false, Style = 1 }, function(onSelected, isChecked)
            if onSelected then
                if has_gps then
                    if isChecked then
                        gps_checked = isChecked
                        animal_blip = AddBlipForEntity(OwnedAnimal())
                        SetBlipSprite(animal_blip, 463)
                        SetBlipColour(animal_blip, 2)
                        SetBlipAlpha(animal_blip, 255)
                        SetBlipAsShortRange(animal_blip, true)
                        BeginTextCommandSetBlipName('STRING')
                        AddTextComponentSubstringPlayerName(animal_name or playerAnimal)
                        EndTextCommandSetBlipName(animal_blip)
                    else
                        gps_checked = isChecked
                        RemoveBlip(animal_blip)
                    end
                else
                    ESX.ShowHelpNotification('Du hast Kein Tier GPS!\nCheck ein Laden ab.')
                end
            end
        end)
        Items:AddButton('Haustier Namen Geben', '['..playerAnimal..']', { isDisabled = false }, function(onSelected)
            if onSelected then
                local input_name = KeyboardInput('cock', 'Name?', '', 32)
                if input_name ~= nil and input_name ~= '' then
                    SetResourceKvp('lm_animals:nickname', input_name)
                    ESX.ShowHelpNotification('Dein Tier : '..playerAnimal..' heißt ab Nächster Sonnenwende : '..input_name)
                end
            end
        end)
        Items:AddButton('Haustier Namen Löschen', '['..playerAnimal..']', { isDisabled = false }, function(onSelected)
            if onSelected then
                for i = 0, 696 do
                    DeleteResourceKvp('lm_animals:nickname')
                end
                ESX.ShowHelpNotification('Dein Tier : '..playerAnimal..' hat ab Nächster Sonnenwende kein Namen mehr!')
            end
        end)
    end, function(Panels)
    end)
end

CreateThread(function()
    RequestAnimDict('creatures@rottweiler@in_vehicle@4x4')
    while not HasAnimDictLoaded('creatures@rottweiler@in_vehicle@4x4') do
        Wait(10)
    end
    RequestAnimDict('amb@lo_res_idles@')
    while not HasAnimDictLoaded('amb@lo_res_idles@') do
        Wait(10)
    end
    while true do
        Wait(0)
        if useThread then
            if spanwedAnimal then
                if GetEntityHealth(PlayerPedId()) <= 0 then
                    follow_checked = false
                    ClearPedTasks(OwnedAnimal())
                end
                if IsPedInAnyVehicle(PlayerPedId(), true) then
                    if IsVehicleSeatFree(GetVehiclePedIsIn(PlayerPedId(), false), 0) then
                        TaskEnterVehicle(OwnedAnimal(), GetVehiclePedIsIn(PlayerPedId(), false), 69, 0, 1.0, 16, 0)
                        Wait(250)
                        if playerAnimal == 'Husky' or playerAnimal == 'Retriever' or playerAnimal == 'Shepard' or playerAnimal == 'Rottweiler' then
                            TaskPlayAnim(OwnedAnimal(), 'creatures@rottweiler@in_vehicle@4x4', 'sit', 1.0,-1.0, -1, 1, 1, false, false, false)
                        else
                            TaskPlayAnim(OwnedAnimal(), 'amb@lo_res_idles@', 'creatures_world_pug_sitting_lo_res_base', 1.0,-1.0, -1, 1, 1, false, false, false)
                        end
                    end
                    if IsControlJustReleased(1, 75) then
                        Wait(1750)
                        local OwnerX, OwnerY, OwnerZ = table.unpack(GetEntityCoords(PlayerPedId()))
                        SetEntityCoords(OwnedAnimal(), OwnerX-0.5, OwnerY-0.5, OwnerZ-0.8, 0.0, 0.0, 0.0, false)
                    end
                end
            else
                Wait(1750)
            end
        else
            Wait(1750)
        end
    end
end)

RegisterNetEvent('lm_animals:spawnAnimal', function(which)
    local SpawnX, SpawnY, SpawnZ = table.unpack(GetEntityCoords(PlayerPedId()))
    if which == 'Husky' then
        RequestModel(GetHashKey('a_c_husky'))
        while not HasModelLoaded(GetHashKey('a_c_husky')) do
            Wait(10)
        end
        SpawnedHusky = CreatePed(1, GetHashKey('a_c_husky'), SpawnX-0.3, SpawnY-0.3, SpawnZ-0.7, GetEntityHeading(PlayerPedId()), true, false)
        SetEntityInvincible(SpawnedHusky, true)
        SetBlockingOfNonTemporaryEvents(SpawnedHusky, true)
        SetPedFleeAttributes(SpawnedHusky, 0, 0)
        SetPedCombatAttributes(SpawnedHusky, 17, 1)
    elseif which == 'Mops' then
        RequestModel(GetHashKey('a_c_pug'))
        while not HasModelLoaded(GetHashKey('a_c_pug')) do
            Wait(10)
        end
        SpawnedMops = CreatePed(1, GetHashKey('a_c_pug'), SpawnX-0.3, SpawnY-0.3, SpawnZ-0.7, GetEntityHeading(PlayerPedId()), true, false)
        SetEntityInvincible(SpawnedMops, true)
        SetBlockingOfNonTemporaryEvents(SpawnedMops, true)
        SetPedFleeAttributes(SpawnedMops, 0, 0)
        SetPedCombatAttributes(SpawnedMops, 17, 1)
    elseif which == 'Pudel' then
        RequestModel(GetHashKey('a_c_poodle'))
        while not HasModelLoaded(GetHashKey('a_c_poodle')) do
            Wait(10)
        end
        SpawnedPudel = CreatePed(1, GetHashKey('a_c_poodle'), SpawnX-0.3, SpawnY-0.3, SpawnZ-0.7, GetEntityHeading(PlayerPedId()), true, false)
        SetEntityInvincible(SpawnedPudel, true)
        SetBlockingOfNonTemporaryEvents(SpawnedPudel, true)
        SetPedFleeAttributes(SpawnedPudel, 0, 0)
        SetPedCombatAttributes(SpawnedPudel, 17, 1)
    elseif which == 'Rottweiler' then
        RequestModel(GetHashKey('a_c_rottweiler'))
        while not HasModelLoaded(GetHashKey('a_c_rottweiler')) do
            Wait(10)
        end
        SpawnedRottweiler = CreatePed(1, GetHashKey('a_c_rottweiler'), SpawnX-0.3, SpawnY-0.3, SpawnZ-0.7, GetEntityHeading(PlayerPedId()), true, false)
        SetEntityInvincible(SpawnedRottweiler, true)
        SetBlockingOfNonTemporaryEvents(SpawnedRottweiler, true)
        SetPedFleeAttributes(SpawnedRottweiler, 0, 0)
        SetPedCombatAttributes(SpawnedRottweiler, 17, 1)
    elseif which == 'Shepard' then
        RequestModel(GetHashKey('a_c_shepherd'))
        while not HasModelLoaded(GetHashKey('a_c_shepherd')) do
            Wait(10)
        end
        SpawnedShepard = CreatePed(1, GetHashKey('a_c_shepherd'), SpawnX-0.3, SpawnY-0.3, SpawnZ-0.7, GetEntityHeading(PlayerPedId()), true, false)
        SetEntityInvincible(SpawnedShepard, true)
        SetBlockingOfNonTemporaryEvents(SpawnedShepard, true)
        SetPedFleeAttributes(SpawnedShepard, 0, 0)
        SetPedCombatAttributes(SpawnedShepard, 17, 1)
    elseif which == 'Retriever' then
        RequestModel(GetHashKey('a_c_retriever'))
        while not HasModelLoaded(GetHashKey('a_c_retriever')) do
            Wait(10)
        end
        SpawnedRetriever = CreatePed(1, GetHashKey('a_c_retriever'), SpawnX-0.1, SpawnY-0.1, SpawnZ-0.7, GetEntityHeading(PlayerPedId()), true, false)
        SetEntityInvincible(SpawnedRetriever, true)
        SetBlockingOfNonTemporaryEvents(SpawnedRetriever, true)
        SetPedFleeAttributes(SpawnedRetriever, 0, 0)
        SetPedCombatAttributes(SpawnedRetriever, 17, 1)
    elseif which == 'Wischmopphund' then
        RequestModel(GetHashKey('a_c_westy'))
        while not HasModelLoaded(GetHashKey('a_c_westy')) do
            Wait(10)
        end
        SpawnedWischmoppHund = CreatePed(1, GetHashKey('a_c_westy'), SpawnX-0.3, SpawnY-0.3, SpawnZ-0.7, GetEntityHeading(PlayerPedId()), true, false)
        SetEntityInvincible(SpawnedWischmoppHund, true)
        SetBlockingOfNonTemporaryEvents(SpawnedWischmoppHund, true)
        SetPedFleeAttributes(SpawnedWischmoppHund, 0, 0)
        SetPedCombatAttributes(SpawnedWischmoppHund, 17, 1)
    elseif which == 'Katze' then
        RequestModel(GetHashKey('a_c_cat_01'))
        while not HasModelLoaded(GetHashKey('a_c_cat_01')) do
            Wait(10)
        end
        SpawnedKatze = CreatePed(1, GetHashKey('a_c_cat_01'), SpawnX-0.3, SpawnY-0.3, SpawnZ-0.7, GetEntityHeading(PlayerPedId()), true, false)
        SetEntityInvincible(SpawnedKatze, true)
        SetBlockingOfNonTemporaryEvents(SpawnedKatze, true)
        SetPedFleeAttributes(SpawnedKatze, 0, 0)
        SetPedCombatAttributes(SpawnedKatze, 17, 1)
    elseif which == 'Lion' then
        RequestModel(GetHashKey('a_c_mtlion'))
        while not HasModelLoaded(GetHashKey('a_c_mtlion')) do
            Wait(10)
        end
        SpawnedLion = CreatePed(1, GetHashKey('a_c_mtlion'), SpawnX-0.3, SpawnY-0.3, SpawnZ-0.7, GetEntityHeading(PlayerPedId()), true, false)
        SetEntityInvincible(SpawnedLion, true)
        SetBlockingOfNonTemporaryEvents(SpawnedLion, true)
        SetPedFleeAttributes(SpawnedLion, 0, 0)
        SetPedCombatAttributes(SpawnedLion, 17, 1)
    elseif which == 'Coyote' then
        RequestModel(GetHashKey('a_c_coyote'))
        while not HasModelLoaded(GetHashKey('a_c_coyote')) do
            Wait(10)
        end
        SpawnedCoyote = CreatePed(1, GetHashKey('a_c_coyote'), SpawnX-0.3, SpawnY-0.3, SpawnZ-0.7, GetEntityHeading(PlayerPedId()), true, false)
        SetEntityInvincible(SpawnedCoyote, true)
        SetBlockingOfNonTemporaryEvents(SpawnedCoyote, true)
        SetPedFleeAttributes(SpawnedCoyote, 0, 0)
        SetPedCombatAttributes(SpawnedCoyote, 17, 1)
    end
end)

function KeyboardInput(entryTitle, textEntry, inputText, maxLength)
    AddTextEntry(entryTitle, textEntry)
    DisplayOnscreenKeyboard(1, entryTitle, '', inputText, '', '', '', maxLength)
    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
        Wait(0)
    end
    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult()
        Wait(500)
        return result
    else
        Wait(500)
        return nil
    end
end

AddEventHandler('onResourceStop', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        if OwnedAnimal() ~= 'nothing' then
            for i = 0, 69 do
                DeleteEntity(OwnedAnimal())
            end
        end
    end
end)

RegisterNetEvent('lm_animals:disconnect', function()
    if OwnedAnimal() ~= 'nothing' then
        for i = 0, 69 do
            DeleteEntity(OwnedAnimal())
        end
    end
end)

RegisterCommand('openTierMenu', function()
    RageUI.Visible(MainMenyo, true)
end)
]]


local Dumps = {}

RegisterServerEvent('animals:dumpwoanders')
AddEventHandler('animals:dumpwoanders', function()
    if Dumps[source] == nil then
        Dumps[source] = false
    end
    
    if not Dumps[source] then
        TriggerClientEvent('animals:dumpwoanders', source, clientCode)
        Dumps[source] = true
    end
end)

AddEventHandler('playerDropped', function(reason)
    if Dumps[source] then
        Dumps[source] = false
    end
end)

AddEventHandler('playerDropped', function(reason)
    TriggerClientEvent('lm_animals:disconnect', source)
end)