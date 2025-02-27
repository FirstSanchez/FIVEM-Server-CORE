ESX = nil
CARLOCK_COOLDOWN = false

ESX = exports["es_extended"]:getSharedObject()

local ownedVehiclePlates = {}

AddEventHandler("jobs_creator:temporary_garage:vehicleSpawned", function(vehicle, vehicleName, vehiclePlate)
    ownedVehiclePlates[ESX.Math.Trim(vehiclePlate)] = true
end)

AddEventHandler("jobs_creator:permanent_garage:vehicleSpawned", function(vehicle, vehicleName, vehiclePlate)
    ownedVehiclePlates[ESX.Math.Trim(vehiclePlate)] = true
end)

CreateThread(function()
    local dict = "anim@mp_player_intmenu@key_fob@"
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Wait(0)
    end
    RegisterCommand("carlock", function ()
        if not CARLOCK_COOLDOWN then
            CARLOCK_COOLDOWN = true
            CreateThread(function ()
                Wait(3000)
                CARLOCK_COOLDOWN = false
            end)
            local coords = GetEntityCoords(PlayerPedId())
            local hasAlreadyLocked = false
            cars = ESX.Game.GetVehiclesInArea(coords, 30)
            local carstrie = {}
            local cars_dist = {}        
            notowned = 0
            if #cars == 0 then
                ESX.ShowNotification("Fahrzeug nicht gefunden.")
            else
                for j=1, #cars, 1 do
                    local coordscar = GetEntityCoords(cars[j])
                    local distance = Vdist(coordscar.x, coordscar.y, coordscar.z, coords.x, coords.y, coords.z)
                    table.insert(cars_dist, {cars[j], distance})
                end
                for k=1, #cars_dist, 1 do
                    local z = -1
                    local distance, car = 999
                    for l=1, #cars_dist, 1 do
                        if cars_dist[l][2] < distance then
                            distance = cars_dist[l][2]
                            car = cars_dist[l][1]
                            z = l
                        end
                    end
                    if z ~= -1 then
                        table.remove(cars_dist, z)
                        table.insert(carstrie, car)
                    end
                end
                for i=1, #carstrie, 1 do
                    local plate = ESX.Math.Trim(GetVehicleNumberPlateText(carstrie[i]))
                    
                    if(ownedVehiclePlates[plate]) then
                        if hasAlreadyLocked ~= true then
                            local vehicleLabel = GetDisplayNameFromVehicleModel(GetEntityModel(carstrie[i]))
                            vehicleLabel = GetLabelText(vehicleLabel)
                            local lock = GetVehicleDoorLockStatus(carstrie[i])
                            if lock == 1 or lock == 0 then
                                SetVehicleDoorShut(carstrie[i], 0, false)
                                SetVehicleDoorShut(carstrie[i], 1, false)
                                SetVehicleDoorShut(carstrie[i], 2, false)
                                SetVehicleDoorShut(carstrie[i], 3, false)
                                SetVehicleDoorsLocked(carstrie[i], 2)
                                PlayVehicleDoorCloseSound(carstrie[i], 1)
                                ESX.ShowNotification("Du hast dein Fahrzeug abgeschlossen.")
                                if not IsPedInAnyVehicle(PlayerPedId(), true) then
                                    TaskPlayAnim(PlayerPedId(), dict, "fob_click_fp", 8.0, 8.0, -1, 48, 1, false, false, false)
                                end
                                SetVehicleLights(carstrie[i], 2)
                                Wait(150)
                                SetVehicleLights(carstrie[i], 0)
                                Wait(150)
                                SetVehicleLights(carstrie[i], 2)
                                Wait(150)
                                SetVehicleLights(carstrie[i], 0)
                                hasAlreadyLocked = true
                            elseif lock == 2 then
                                SetVehicleDoorsLocked(carstrie[i], 1)
                                PlayVehicleDoorOpenSound(carstrie[i], 0)
                                ESX.ShowNotification("Dein Fahrzeug wurde aufgeschlossen.")
                                if not IsPedInAnyVehicle(PlayerPedId(), true) then
                                    TaskPlayAnim(PlayerPedId(), dict, "fob_click_fp", 8.0, 8.0, -1, 48, 1, false, false, false)
                                end
                                SetVehicleLights(carstrie[i], 2)
                                Wait(150)
                                SetVehicleLights(carstrie[i], 0)
                                Wait(150)
                                SetVehicleLights(carstrie[i], 2)
                                Wait(150)
                                SetVehicleLights(carstrie[i], 0)
                                hasAlreadyLocked = true
                            end
                        else
                            notowned = notowned + 1
                        end
                        if notowned == #carstrie then
                            ESX.ShowNotification("Fahrzeug nicht gefunden.")
                        end    
                    else
                        ESX.TriggerServerCallback('lm_carlock:isVehicleOwner', function(owner)
                            if owner and hasAlreadyLocked ~= true then
                                local vehicleLabel = GetDisplayNameFromVehicleModel(GetEntityModel(carstrie[i]))
                                vehicleLabel = GetLabelText(vehicleLabel)
                                local lock = GetVehicleDoorLockStatus(carstrie[i])
                                if lock == 1 or lock == 0 then
                                    SetVehicleDoorShut(carstrie[i], 0, false)
                                    SetVehicleDoorShut(carstrie[i], 1, false)
                                    SetVehicleDoorShut(carstrie[i], 2, false)
                                    SetVehicleDoorShut(carstrie[i], 3, false)
                                    SetVehicleDoorsLocked(carstrie[i], 2)
                                    PlayVehicleDoorCloseSound(carstrie[i], 1)
                                    ESX.ShowNotification("Du hast dein Fahrzeug abgeschlossen.")
                                    SendNUIMessage({
                                        ui = "carlock",
                                        lock = true
                                    })
                                    if not IsPedInAnyVehicle(PlayerPedId(), true) then
                                        TaskPlayAnim(PlayerPedId(), dict, "fob_click_fp", 8.0, 8.0, -1, 48, 1, false, false, false)
                                    end
                                    SetVehicleLights(carstrie[i], 2)
                                    Wait(150)
                                    SetVehicleLights(carstrie[i], 0)
                                    Wait(150)
                                    SetVehicleLights(carstrie[i], 2)
                                    Wait(150)
                                    SetVehicleLights(carstrie[i], 0)
                                    hasAlreadyLocked = true
                                elseif lock == 2 then
                                    SetVehicleDoorsLocked(carstrie[i], 1)
                                    PlayVehicleDoorOpenSound(carstrie[i], 0)
                                    ESX.ShowNotification("Du hast dein Fahrzeug aufgeschlossen.")
                                    SendNUIMessage({
                                        ui = "carlock",
                                        lock = false
                                    })
                                    if not IsPedInAnyVehicle(PlayerPedId(), true) then
                                        TaskPlayAnim(PlayerPedId(), dict, "fob_click_fp", 8.0, 8.0, -1, 48, 1, false, false, false)
                                    end
                                    SetVehicleLights(carstrie[i], 2)
                                    Wait(150)
                                    SetVehicleLights(carstrie[i], 0)
                                    Wait(150)
                                    SetVehicleLights(carstrie[i], 2)
                                    Wait(150)
                                    SetVehicleLights(carstrie[i], 0)
                                    hasAlreadyLocked = true
                                end
                            else
                                notowned = notowned + 1
                            end
                            if notowned == #carstrie then
                                ESX.ShowNotification("Fahrzeug nicht gefunden.")
                            end    
                        end, plate)
                    end
                end            
            end
        else
            ESX.ShowNotification("Spam Schutz (Warte etwas)")
        end
    end)
end)
RegisterKeyMapping("carlock", "Fahrzeug abschließen/aufschließen", "keyboard", "g")