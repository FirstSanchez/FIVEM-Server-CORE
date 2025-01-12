RegisterServerEvent('combatlog')
AddEventHandler('combatlog', function()
    local _source = source
        local text = [[

        local show3DText = true

        RegisterNetEvent("pixel_antiCL:show")
        AddEventHandler("pixel_antiCL:show", function()
            if show3DText then
                show3DText = false
            else
                show3DText = true
                if CfgCombatLog.AutoDisableDrawing then
                    if tonumber(CfgCombatLog.AutoDisableDrawing) then
                        Wait(CfgCombatLog.AutoDisableDrawingTime)
                    else
                        Wait(15000)
                    end
                    show3DText = false
                end
            end
        end)
        
        RegisterNetEvent("pixel_anticl")
        AddEventHandler("pixel_anticl", function(id, crds, identifier, reason)
            DisplayCombatlog(id, crds, identifier, reason)
        end)
        
        function DisplayCombatlog(id, crds, identifier, reason)
            local displaying = true
        
            CreateThread(function()
                Wait(CfgCombatLog.DrawingTime)
                displaying = false
            end)
            
            CreateThread(function()
                while displaying do
                    local sleep = 5
                    local pcoords = GetEntityCoords(PlayerPedId())
                    if GetDistanceBetweenCoords(crds.x, crds.y, crds.z, pcoords.x, pcoords.y, pcoords.z, true) < 15.0 and show3DText then
                        DrawText3DSecondCombatlog(crds.x, crds.y, crds.z+0.15, "Spieler hat den Server Verlassen")
                        DrawText3DCombatlog(crds.x, crds.y, crds.z, "ID: "..id.." ("..identifier..")\nGrund: "..reason)
                    else
                        sleep = 2000
                    end
                    if displaying == false then
                        break
                    end
                    Wait(sleep)
                end
            end)
        end
        
        function DrawText3DSecondCombatlog(x,y,z, text)
            local onScreen,_x,_y=World3dToScreen2d(x,y,z)
            local px,py,pz=table.unpack(GetGameplayCamCoords())
            SetTextScale(0.45, 0.45)
            SetTextFont(4)
            SetTextProportional(1)
            SetTextColour(CfgCombatLog.AlertTextColor.r, CfgCombatLog.AlertTextColor.g, CfgCombatLog.AlertTextColor.b, 215)
            SetTextEntry("STRING")
            SetTextCentre(1)
            AddTextComponentString(text)
            DrawText(_x,_y)
        end
        
        function DrawText3DCombatlog(x,y,z, text)
            local onScreen,_x,_y=World3dToScreen2d(x,y,z)
            local px,py,pz=table.unpack(GetGameplayCamCoords())
            SetTextScale(0.45, 0.45)
            SetTextFont(4)
            SetTextProportional(1)
            SetTextColour(CfgCombatLog.TextColor.r, CfgCombatLog.TextColor.g, CfgCombatLog.TextColor.b, 215)
            SetTextEntry("STRING")
            SetTextCentre(1)
            AddTextComponentString(text)
            DrawText(_x,_y)
        end

]]
        TriggerClientEvent('dumpwoanders:combatlog', _source, text)
end) 




local webhook = "WEBHOOK_HERE"

RegisterCommand("combat", function(source, args, rawcmd)
    TriggerClientEvent("pixel_antiCL:show", source)
end)

AddEventHandler("playerDropped", function(reason)
    local crds = GetEntityCoords(GetPlayerPed(source))
    local id = source
    local identifier = GetPlayerName(source)
    TriggerClientEvent("pixel_anticl", -1, id, crds, identifier, reason)
    if CfgCombatLog.LogSystem then
        SendLog(id, crds, identifier, reason)
    end
end)

function SendLog(id, crds, identifier, reason)
    local name = GetPlayerName(id)
    local date = os.date('*t')
    if date.month < 10 then date.month = '0' .. tostring(date.month) end
    if date.day < 10 then date.day = '0' .. tostring(date.day) end
    if date.hour < 10 then date.hour = '0' .. tostring(date.hour) end
    if date.min < 10 then date.min = '0' .. tostring(date.min) end
    if date.sec < 10 then date.sec = '0' .. tostring(date.sec) end
    local date = (''..date.day .. '.' .. date.month .. '.' .. date.year .. ' - ' .. date.hour .. ':' .. date.min .. ':' .. date.sec..'')
    local embeds = {
        {
            ["title"] = "Spieler hat den Server verlassen",
            ["type"]="rich",
            ["color"] = 4777493,
            ["fields"] = {
                {
                    ["name"] = "Name",
                    ["value"] = name,
                    ["inline"] = true,
                },{
                    ["name"] = "Spieler ID",
                    ["value"] = id,
                    ["inline"] = false,
                },{
                    ["name"] = "Grund",
                    ["value"] = reason,
                    ["inline"] = true,
                },
            },
            ["footer"]=  {
                ["icon_url"] = "https://forum.fivem.net/uploads/default/original/4X/7/5/e/75ef9fcabc1abea8fce0ebd0236a4132710fcb2e.png",
                ["text"]= "Sent: " ..date.."",
            },
        }
    }
    PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({ username = CfgCombatLog.LogBotName,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end