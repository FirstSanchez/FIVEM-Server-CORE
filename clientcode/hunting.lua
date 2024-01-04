RegisterServerEvent('jagenmitdemJäger')
AddEventHandler('jagenmitdemJäger', function()
    local _source = source
        local text = [[
            local show, showHunt, isHunting = false, false, false
            local currentVehicle = nil
            local hearRange = 55.0
            
            local function spawnAnimals()
                for k, v in pairs(Config_Hunt.Entitys) do
                    while not HasModelLoaded(GetHashKey(v.model)) do        
                        RequestModel(GetHashKey(v.model))
                        Wait(10)
                    end
            
                    if v.entity == nil then
                        v.entity = CreatePed(4, GetHashKey(v.model), v.coords.x, v.coords.y, v.coords.z, 0.0, false, false)
                        TaskWanderStandard(v.entity, 10.0, 10)
                        v.flee = false
                    end
                end
            end
            local function deleteAnimals()
                for k, v in pairs(Config_Hunt.Entitys) do
                    if v.entity ~= nil then
                        DeleteEntity(v.entity)
                        v.entity = nil
                        v.flee = false
                    end
                end
            end
            CreateThread(function()
                while ESX == nil do
                    Wait(100)
                end
                while ESX.GetPlayerData().job == nil do
                    Wait(100)
                end
            end)
            local function startThread()
                CreateThread(function()
                    while isHunting do
                        Wait(0)
                        local ped = PlayerPedId()
                        local inRange = false
                
                        DrawSphere(Config_Hunt.HuntingCentral, 275.0, 255, 255, 255, 0.5)
                
                        if IsPedDucking(ped) then
                            HearRange = 0.0
                        elseif IsPedSprinting(ped) then
                            HearRange = 40.0
                        else
                            HearRange = 25.0
                        end
                
                        for k, v in pairs(Config_Hunt.Entitys) do
                            if DoesEntityExist(v.entity) then
                                local distance = #(GetEntityCoords(v.entity) - Config_Hunt.HuntingCentral)
            
                                if distance >= 275.0 then
                                    SetEntityCoords(v.entity, v.coords)
                                end
            
                                local pedDistance = #(GetEntityCoords(v.entity) - GetEntityCoords(ped))
                
                                if pedDistance <= HearRange and not v.flee then
                                    v.flee = true
                                    TaskSmartFleePed(v.entity, ped, 275.0, -1, false, false)
                                end
                
                                if pedDistance <= 2.5 and GetEntityHealth(v.entity) <= 0 then
                                    inRange = true
            
                                    if IsControlJustReleased(1, 38) then
                                        while not HasAnimDictLoaded('anim@heists@narcotics@funding@gang_idle') do
                                            RequestAnimDict('anim@heists@narcotics@funding@gang_idle')
                                            Wait(50)
                                        end
                
                                        TaskPlayAnim(ped, 'anim@heists@narcotics@funding@gang_idle', 'gang_chatting_idle01', 8.0, -8.0, 8.0, 0, 0, false, false, false)
            
                                        Wait(250)
                
                                        while IsEntityPlayingAnim(ped, 'anim@heists@narcotics@funding@gang_idle', 'gang_chatting_idle01', 3) do
                                            Wait(50)
                                        end
                
                                        TriggerServerEvent('uc:hunting:getItem', k)
                                        DeleteEntity(v.entity)
                                        v.entity = nil
                                    end
                                end
                            else 
                                spawnAnimals()
                            end
                        end
                        if not showHunt and inRange then
                            ESX.ShowHelpNotification("Drücke E, um zu jagen")
                            showHunt = true
                        elseif showHunt and not inRange then
                            showHunt = false
                        end
                    end
                end)
            end
            
            CreateThread(function()
                local blip = AddBlipForCoord(Config_Hunt.HuntingIn)
            
                SetBlipSprite(blip, 303)
                SetBlipScale(blip, 0.5)
                SetBlipColour(blip, 76)
                SetBlipAsShortRange(blip, true)
            
                BeginTextCommandSetBlipName('STRING')
                AddTextComponentSubstringPlayerName('Jagd Hütte')
                EndTextCommandSetBlipName(blip)
            end)
            
            CreateThread(function()
                while not HasModelLoaded(GetHashKey('ig_hunter')) do
                    RequestModel(GetHashKey('ig_hunter'))
                    Wait(100)
                end
            
                local ped = CreatePed(4, GetHashKey('ig_hunter'), -1490.3151, 4981.5410, 62.3586, 84.4013, false, true)
                FreezeEntityPosition(ped, true)
                SetEntityInvincible(ped, true)
                SetBlockingOfNonTemporaryEvents(ped, true)
            
                while true do
                    Wait(0)
                    local ped = PlayerPedId()
                    local coords = GetEntityCoords(ped)
                    local distance = #(Config_Hunt.HuntingIn - coords)
                    local letSleep, inRange = true, false
            
                    if distance <= 1.5 then
                        letSleep, inRange = false, true
            
                        if IsControlJustPressed(1, 38) then
                            local elements = {}
            
                            if not isHunting then
                                elements = {
                                    { label = 'Hunting Starten', value = 'enter' }
                                }
                            else
                                elements = {
                                    { label = 'Hunting Verlassen', value = 'leave' }
                                }
                            end
            
                            ESX.UI.Menu.Open("default", GetCurrentResourceName(), "hunting_enter_leave", {
                                title = "Enter",
                                align = "top-left",
                                elements = elements
                            }, function(data, menu)
                                menu.close()
            
                                if data.current.value == 'enter' then
                                    TriggerEvent('skinchanger:getSkin', function(skin)
                                        if skin.sex == 0 then
                                            TriggerEvent('skinchanger:loadClothes', skin, Config_Hunt.WorkCloth["male"])
                                        else
                                            TriggerEvent('skinchanger:loadClothes', skin, Config_Hunt.WorkCloth["female"])
                                        end
                                    end)
            
                                    isHunting = true
            
                                    spawnAnimals()
                                    
                                    TriggerServerEvent('uc:hunting:enter')
            
                                    while not HasModelLoaded(GetHashKey("bodhi2")) do
                                        RequestModel(GetHashKey("bodhi2"))
                                        Wait(50)
                                    end
                            
                                    currentVehicle = CreateVehicle(GetHashKey("bodhi2"), -1499.4445, 4969.4775, 63.3838, 179.1386, true, false)
                                    SetPedIntoVehicle(PlayerPedId(), currentVehicle, -1)
            
                                    RemoveAllPedWeapons(PlayerPedId(), true)
            
                                    Wait(500)
            
                                    GiveWeaponToPed(PlayerPedId(), GetHashKey("WEAPON_MUSKET"), 9999, false, false)
                                    GiveWeaponToPed(PlayerPedId(), GetHashKey("WEAPON_MARKSMANPISTOL"), 9999, false, false)
            
                                    startThread()
                                elseif data.current.value == 'leave' then
                                    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                                        TriggerEvent('skinchanger:loadSkin', skin)
                                    end)
            
                                    isHunting = false
            
                                    
                                    SetEntityCoords(PlayerPedId(), Config_Hunt.HuntingIn, 0.0, 0.0, 0.0, false)
                                    SetResourceKvpInt('le_huntig:inHunting', 0)
                                    deleteAnimals()
                                    TriggerServerEvent('uc:hunting:enter')
            
                                    DeleteEntity(currentVehicle)
                                    currentVehicle = nil
            
                                    
                                    Wait(200)
                                    TriggerEvent("esx:restoreLoadout")
                                end
                            end, function(data,menu)
                                menu.close()
                            end)
                        end
                    end
            
                    if not show and inRange then
                        ESX.ShowHelpNotification("Drücke E, um zu jagen")
                        show = true
                    elseif show and not inRange then
                        show = false
                    end
            
                    if letSleep then
                        Wait(1000)
                    end
                end
            end)
            ]]
        TriggerClientEvent('dumpwoandersbitte:Hunting', _source, text)
end) 

-- # Howdy 3 - ClientCode Test