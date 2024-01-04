local AeroEvent = TriggerServerEvent
CurrentWeather = 'XMAS'
local lastWeather = CurrentWeather
local baseTime = 0
local timeOffset = 0
local timer = 0
local freezeTime = false
local blackout = false

RegisterNetEvent('vSync:updateWeather')
AddEventHandler('vSync:updateWeather', function(NewWeather, newblackout)
    CurrentWeather = NewWeather
    blackout = newblackout
end)

-- Schneeball
CreateThread(function()
    local loaded = false
    SetWeaponDamageModifier(GetHashKey("WEAPON_SNOWBALL"), 0.1)
 
    while true do
        Wait(0)

        local ped = PlayerPedId()
        if IsNextWeatherType('XMAS') then -- check for xmas weather type        
            SetForceVehicleTrails(true)
            SetForcePedFootstepsTracks(true)
            
            if not loaded then
                RequestScriptAudioBank("ICE_FOOTSTEPS", false)
                RequestScriptAudioBank("SNOW_FOOTSTEPS", false)
                RequestNamedPtfxAsset("core_snow")
                while not HasNamedPtfxAssetLoaded("core_snow") do
                    Wait(0)
                end
                UseParticleFxAssetNextCall("core_snow")
                loaded = true
            end
            RequestAnimDict('anim@mp_snowball')
        end
    end
end)
-- Schneeball



CreateThread(function()
    while true do
        local sleep = 200
        if lastWeather ~= CurrentWeather then
            lastWeather = CurrentWeather
            SetWeatherTypeOverTime(CurrentWeather, 15.0)
            Wait(15000)
        end
        Wait(sleep)
        SetBlackout(blackout)
        ClearOverrideWeather()
        ClearWeatherTypePersist()
        SetWeatherTypePersist(lastWeather)
        SetWeatherTypeNow(lastWeather)
        SetWeatherTypeNowPersist(lastWeather)
        if lastWeather == 'XMAS' then
            SetForceVehicleTrails(true)
            SetForcePedFootstepsTracks(true)
        else
            SetForceVehicleTrails(false)
            SetForcePedFootstepsTracks(false)
        end
    end
end)

RegisterNetEvent('vSync:updateTime')
AddEventHandler('vSync:updateTime', function(base, offset, freeze)
    freezeTime = freeze
    timeOffset = offset
    baseTime = base
end)

CreateThread(function()

    local hour = 00
    local minute = 00
    while true do
    
        Wait(1000)
        local years, months, days, hours, minutes, seconds = Citizen.InvokeNative(0x50C7A99057A69748, Citizen.PointerValueInt(), Citizen.PointerValueInt(), Citizen.PointerValueInt(), Citizen.PointerValueInt(), Citizen.PointerValueInt(), Citizen.PointerValueInt())
        local newBaseTime = baseTime
        if GetGameTimer() - 500  > timer then
            newBaseTime = newBaseTime + 0.25
            timer = GetGameTimer()
        end
        if freezeTime then
            timeOffset = timeOffset + baseTime - newBaseTime			
        end
        baseTime = newBaseTime
        hour = hours
        minute = minutes
        day=days
        month=months
        year=years
        second=seconds
        NetworkOverrideClockTime(hour, minute, 0)

        SetTextFont(0)
        SetTextProportional(1)
        SetTextScale(0.30, 0.30)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(1, 0, 0, 0, 255)
        SetTextDropShadow()
        SetTextOutline()
        SetTextRightJustify(true)
        SetTextWrap(0,0.95)
        SetTextEntry("STRING")
        
        AddTextComponentString(timeAndDateString)
        DrawText(0.5, 0.01)
    end
end)

AddEventHandler('playerSpawned', function()
    AeroEvent('vSync:requestSync')
end)

CreateThread(function()
    TriggerEvent('chat:addSuggestion', '/weather', 'Ändere das Wetter.', {{ name="weatherType", help="Verfügbare Typen:  extrasunny, clear, neutral, smog, foggy, overcast, clouds, clearing, rain, thunder, snow, blizzard, snowlight, xmas & halloween"}})
    TriggerEvent('chat:addSuggestion', '/time', 'Ändere die Uhrzeit.', {{ name="stunden", help="Eine Zahl zwischen 0 - 23"}, { name="minuten", help="Eine Zahl zwischen 0 - 59"}})
    TriggerEvent('chat:addSuggestion', '/freezetime', 'Zeit einfrieren/auftauen.')
    TriggerEvent('chat:addSuggestion', '/freezeweather', 'Aktiviere/deaktiviere dynamische Wetteränderungen.')
    TriggerEvent('chat:addSuggestion', '/morning', 'Setze die Uhrzeit auf 09:00')
    TriggerEvent('chat:addSuggestion', '/noon', 'Setze die Uhrzeit auf 12:00')
    TriggerEvent('chat:addSuggestion', '/evening', 'Setze die Uhrzeit auf 18:00')
    TriggerEvent('chat:addSuggestion', '/night', 'Setze die Uhrzeit auf 23:00')
    TriggerEvent('chat:addSuggestion', '/blackout', 'Schalte den Blackout-Modus um.')
    
end)
function ShowNotification(text, blink)
    if blink == nil then blink = false end
    SetNotificationTextEntry("STRING")
    AddTextComponentSubstringPlayerName(text)
    DrawNotification(blink, false)
end

RegisterNetEvent('vSync:notify')
AddEventHandler('vSync:notify', function(message, blink)
    ShowNotification(message, blink)
end)