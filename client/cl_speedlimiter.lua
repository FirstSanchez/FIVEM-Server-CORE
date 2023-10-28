local speedlimiter = true
local speedlimit = 310
local emergencyclassSpeedlimit = 330

CreateThread(function()
    while true do
        local ped = PlayerPedId()

        if IsPedInAnyVehicle(ped, false) then
            local vehicle = GetVehiclePedIsIn(ped, false)
            local class = GetVehicleClass(vehicle)
            local speed = GetEntitySpeed(vehicle)

            if class == 18 then
                if math.floor(speed * 3.6) >= emergencyclassSpeedlimit then
                    cruise = speed
                    SetEntityMaxSpeed(vehicle, cruise)
                end
            else 
                if class ~= (14 or 15 or 16 or 21) then
                    if math.floor(speed * 3.6) >= speedlimit then
                        cruise = speed
                        SetEntityMaxSpeed(vehicle, cruise)
                    end
                end
            end
        else 
            Wait(1000)
        end
        Wait(1)
    end
end)