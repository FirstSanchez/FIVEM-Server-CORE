-- optimizations
local tonumber = tonumber
local CreateThread = CreateThread
local Wait = Wait
local TriggerEvent = TriggerEvent
local RegisterCommand = RegisterCommand
local PlayerPedId = PlayerPedId
local IsPedInAnyVehicle = IsPedInAnyVehicle
local GetPedInVehicleSeat = GetPedInVehicleSeat
local GetVehiclePedIsIn = GetVehiclePedIsIn
local SetPedIntoVehicle = SetPedIntoVehicle
-- end optimizations

local disabled = false

CreateThread(function()
    while true do
        local ped = PlayerPedId()
        local restrictSwitching = false
        
        if IsPedInAnyVehicle(ped, false) and not disabled then
            if GetPedInVehicleSeat(GetVehiclePedIsIn(ped, false), 0) == ped then
                restrictSwitching = true
            end
        end
        
        SetPedConfigFlag(ped, 184, restrictSwitching)
        Wait(150)
    end
end)

local function switchSeat(_, args)
    local seatIndex = tonumber(args[1]) - 1
    
    if seatIndex < -1 or seatIndex >= 4 then
        SetNotificationTextEntry('STRING')
        AddTextComponentString("~r~Seat ~b~" .. (seatIndex + 1) .. "~r~ is not recognized")
        DrawNotification(true, true)
    else
        local ped = PlayerPedId()
        local veh = GetVehiclePedIsIn(ped, false)
        
        if veh ~= nil and veh > 0 then
            CreateThread(function()
                disabled = true
                SetPedIntoVehicle(PlayerPedId(), veh, seatIndex)
                Wait(50)
                disabled = false
            end)
        end
    end
end

local function shuffleSeat()
    CreateThread(function()
        disabled = true
        Wait(3000)
        disabled = false
    end)
end

RegisterCommand("seat", switchSeat)
RegisterCommand("shuff", shuffleSeat)
RegisterCommand("shuffle", shuffleSeat)

TriggerEvent('chat:addSuggestion', '/shuff', "Switch to the driver's seat")
TriggerEvent('chat:addSuggestion', '/shuffle', "Switch to the driver's seat")
TriggerEvent('chat:addSuggestion', '/seat', 'Switch seats in the current vehicle',
  { { name = 'seat', help = "Switch seats in the current vehicle. 0 = driver, 1 = passenger, 2-3 = back seats" } })

AddEventHandler('onClientResourceStop', function(name)
    if name == 'seat-switcher' then
        SetPedConfigFlag(PlayerPedId(), 184, false)
    end
end)

CreateThread(function()
    ClearPlayerWantedLevel(PlayerId())
    SetMaxWantedLevel(0)

    for i = 1, 15 do
        EnableDispatchService(i, false)
    end

    local scenarios = {
        'WORLD_VEHICLE_ATTRACTOR',
        'WORLD_VEHICLE_AMBULANCE',
        'WORLD_VEHICLE_BICYCLE_BMX',
        'WORLD_VEHICLE_BICYCLE_BMX_BALLAS',
        'WORLD_VEHICLE_BICYCLE_BMX_FAMILY',
        'WORLD_VEHICLE_BICYCLE_BMX_HARMONY',
        'WORLD_VEHICLE_BICYCLE_BMX_VAGOS',
        'WORLD_VEHICLE_BICYCLE_MOUNTAIN',
        'WORLD_VEHICLE_BICYCLE_ROAD',
        'WORLD_VEHICLE_BIKE_OFF_ROAD_RACE',
        'WORLD_VEHICLE_BIKER',
        'WORLD_VEHICLE_BOAT_IDLE',
        'WORLD_VEHICLE_BOAT_IDLE_ALAMO',
        'WORLD_VEHICLE_BOAT_IDLE_MARQUIS',
        'WORLD_VEHICLE_BOAT_IDLE_MARQUIS',
        'WORLD_VEHICLE_BROKEN_DOWN',
        'WORLD_VEHICLE_BUSINESSMEN',
        'WORLD_VEHICLE_HELI_LIFEGUARD',
        'WORLD_VEHICLE_CLUCKIN_BELL_TRAILER',
        'WORLD_VEHICLE_CONSTRUCTION_SOLO',
        'WORLD_VEHICLE_CONSTRUCTION_PASSENGERS',
        'WORLD_VEHICLE_DRIVE_PASSENGERS',
        'WORLD_VEHICLE_DRIVE_PASSENGERS_LIMITED',
        'WORLD_VEHICLE_DRIVE_SOLO',
        'WORLD_VEHICLE_FIRE_TRUCK',
        'WORLD_VEHICLE_EMPTY',
        'WORLD_VEHICLE_MARIACHI',
        'WORLD_VEHICLE_MECHANIC',
        'WORLD_VEHICLE_MILITARY_PLANES_BIG',
        'WORLD_VEHICLE_MILITARY_PLANES_SMALL',
        'WORLD_VEHICLE_PARK_PARALLEL',
        'WORLD_VEHICLE_PARK_PERPENDICULAR_NOSE_IN',
        'WORLD_VEHICLE_PASSENGER_EXIT',
        'WORLD_VEHICLE_POLICE_BIKE',
        'WORLD_VEHICLE_POLICE_CAR',
        'WORLD_VEHICLE_POLICE',
        'WORLD_VEHICLE_POLICE_NEXT_TO_CAR',
        'WORLD_VEHICLE_QUARRY',
        'WORLD_VEHICLE_SALTON',
        'WORLD_VEHICLE_SALTON_DIRT_BIKE',
        'WORLD_VEHICLE_SECURITY_CAR',
        'WORLD_VEHICLE_STREETRACE',
        'WORLD_VEHICLE_TOURBUS',
        'WORLD_VEHICLE_TOURIST',
        'WORLD_VEHICLE_TANDL',
        'WORLD_VEHICLE_TRACTOR',
        'WORLD_VEHICLE_TRACTOR_BEACH',
        'WORLD_VEHICLE_TRUCK_LOGS',
        'WORLD_VEHICLE_TRUCKS_TRAILERS',
        'WORLD_VEHICLE_DISTANT_EMPTY_GROUND',
        'WORLD_HUMAN_PAPARAZZI'
    }
    
    for i, v in pairs(scenarios) do
        SetScenarioTypeEnabled(v, false)
    end
end)