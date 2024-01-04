ESX = exports["es_extended"]:getSharedObject()

CreateThread(function()
    while true do
	    local ped = PlayerPedId()
        Wait(0)
        if not IsEntityDead( ped ) then
            entitycoords = GetEntityCoords(ped)
            for i,k in pairs(Config_aufzug.Elevators) do
                coords = k.pos
                dist = #(entitycoords-coords)
                if dist < 5 then
                    DrawMarker(20, k.pos, 0, 0, 0, 0, 0, 90.0, 1.0, 1.0, 1.0, 144, 224, 255, 155, 0, 0, 2, 0, 0, 0, 0)
                    if dist < 2 then
                        ESX.ShowHelpNotification('Drücke E um den Aufzug zu öffnen')
                        if IsControlJustReleased(1, 51) then
                            local floors = {}
                            for i, k in pairs(k.floors) do
                                if i == 0 then
                                    table.insert(floors, {label = "Erdgeschoss", value = k})
                                else
                                    table.insert(floors, {label = i .. " Stock", value = k})
                                end
                            end
                            Aufzug(floors)
                        end
                    end
                end
            end

                for ia,k in pairs(Config_aufzug.Elevators) do
                    for ib, k in pairs(k.floors) do
                        dist = #(entitycoords-k)
                        if dist < 5 then
                            local floors1 = {}
                            for i,k in pairs(Config_aufzug.Elevators[ia].floors) do
                                if i == 0 then
                                    table.insert(floors1, {label = "Erdgeschoss", value = k})
                                else
                                    table.insert(floors1, {label = i .. " Stock", value = k})
                                end
                            end
                            DrawMarker(20, k, 0, 0, 0, 0, 0, 90.0, 1.0, 1.0, 1.0, 144, 224, 255, 155, 0, 0, 2, 0, 0, 0, 0)
                            if dist < 2 then
                                ESX.ShowHelpNotification('Drücke E um den Aufzug zu öffnen')
                                if IsControlJustReleased(1, 51) then
                                    Aufzug(floors1)
                                end
                            end
                        end
                end
            end
        end
    end
end)

function Aufzug(elements)
    ESX.UI.Menu.CloseAll()
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'elevator_actions', {
        title    = 'Aufzug',
        align    = 'top-left',
        elements = elements
    }, function(data, menu)
        coords = data.current.value
        SetEntityCoords(GetPlayerPed(-1), vec3(coords.x,coords.y, coords.z), false, false, false, true)
        menu.close()
    end, function(data, menu) -- on cancel
        menu.close()
    end)
end