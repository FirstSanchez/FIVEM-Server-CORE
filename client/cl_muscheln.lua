local isCurrentlyCollecting, isCurrentlySelling = false, false

function ShootRaycast(from, to)
    local raycast = StartExpensiveSynchronousShapeTestLosProbe(from.x, from.y, from.z, to.x, to.y, to.z, 1, PlayerPedId()
    , 4)
    return raycast
end

RegisterCommand("muschelnsammeln", function()
    if (not isCurrentlyCollecting and not IsPedInAnyVehicle(PlayerPedId(), false)) then
        local playerPed = PlayerPedId()

        if (not IsPedDeadOrDying(playerPed, true) and not IsPedRagdoll(playerPed) and not IsNuiFocused()) then
            local playerCoords = GetEntityCoords(playerPed)

            local success, height = GetGroundZFor_3dCoord(playerCoords.x, playerCoords.y, playerCoords.z, false)

            if (success) then
                local raycast = ShootRaycast(playerCoords, vector3(playerCoords.x, playerCoords.y, (height - 1.0)))
                local _, hit, endCoords, surfaceNormal, materialHash, entityHit = GetShapeTestResultIncludingMaterial(
                    raycast)

                if (materialHash == 1288448767) then
                    isCurrentlyCollecting = true

                    PlayAnimation("anim@mp_snowball", "pickup_snowball")
                    TriggerEvent("jobs_creator:startProgressBar", 5000, "Sammle...")
                    SetTimeout(5000, function()
                        isCurrentlyCollecting = false
                        ClearPedTasks(PlayerPedId())

                        ESX.TriggerServerCallback("corbo_muscheln:sammeln", function()
                        end)
                    end)
                end
            end
        end
    end
end)
RegisterKeyMapping("muschelnsammeln", "Damit kannst du Muscheln sammeln", "keyboard", "E")

function PlayAnimation(dict, anim)
    RequestAnimDict(dict)

    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Wait(0)
    end

    TaskPlayAnim(PlayerPedId(), dict, anim, 2.0, 2.0, -1, 43, 1.0, false, false, false)
end

CreateThread(function()
    RequestModel("a_m_m_prolhost_01")

    while (not HasModelLoaded("a_m_m_prolhost_01")) do
        RequestModel("a_m_m_prolhost_01")
        Wait(0)
    end

    local npc = CreatePed(2, "a_m_m_prolhost_01", Confing_Muscheln.SellPos.x, Confing_Muscheln.SellPos.y, Confing_Muscheln.SellPos.z, Confing_Muscheln.SellPos.w, false
        ,
        false)
    FreezeEntityPosition(npc, true)
    SetEntityInvincible(npc, true)
    SetBlockingOfNonTemporaryEvents(npc, true)
    SetEntityCoords(npc, Confing_Muscheln.SellPos.x, Confing_Muscheln.SellPos.y, Confing_Muscheln.SellPos.z, true, false, false, false)
end)

RegisterCommand("selljewerly", function()
    if (not isCurrentlyCollecting and not isCurrentlySelling) then
        local playerPed = PlayerPedId()

        if (not IsPedDeadOrDying(playerPed, true) and not IsPedRagdoll(playerPed) and not IsNuiFocused()) then
            local playerCoords = GetEntityCoords(playerPed)

            if (#(playerCoords - vector3(Confing_Muscheln.SellPos.x, Confing_Muscheln.SellPos.y, Confing_Muscheln.SellPos.z)) < 1.5) then
                ESX.TriggerServerCallback("corbo_muscheln:cansell", function(cansell)
                    if (cansell) then
                        FreezeEntityPosition(playerPed, true)
                        TriggerEvent("jobs_creator:startProgressBar", 30000, "Verkaufe...")
                        isCurrentlySelling = true
                        SetTimeout(30000, function()
                            FreezeEntityPosition(playerPed, false)
                            isCurrentlySelling = false
                            ESX.TriggerServerCallback("corbo_muscheln:sell", function(money, pearls, diamonds)
                                if (pearls > 0 or diamonds > 0) then
                                    if (pearls > 0 and diamonds > 0) then
                                        TriggerEvent("prime_notify", "success", "Juwelen Ankauf", "Du hast " ..
                                            money ..
                                            "€ für " .. pearls .. " Perlen und " .. diamonds .. " Diamanten bekommen")
                                    end
                                    if (pearls > 0 and diamonds <= 0) then
                                        TriggerEvent("prime_notify", "success", "Juwelen Ankauf", "Du hast " ..
                                            money .. "€ für " .. pearls .. " Perlen bekommen")
                                    end
                                    if (diamonds > 0 and pearls <= 0) then
                                        TriggerEvent("prime_notify", "success", "Juwelen Ankauf", "Du hast " ..
                                            money .. "€ für " .. diamonds .. " Diamanten bekommen")
                                    end
                                else
                                    TriggerEvent("prime_notify", "error", "Juwelen Ankauf",
                                        "Du hast nichts zum verkaufen")
                                end
                            end)
                        end)
                    else
                        TriggerEvent("prime_notify", "error", "Juwelen Ankauf", "Du hast nichts zum verkaufen")
                    end
                end)
            end
        end
    end
end)
RegisterKeyMapping("selljewerly", "Damit kannst du Juwelen verkaufen", "keyboard", "E")
