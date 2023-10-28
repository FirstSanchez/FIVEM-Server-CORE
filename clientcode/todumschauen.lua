local text_program = [[

    --------------------------------------------------
    ------ DEATH CAM FOR FIVEM MADE BY KIMINAZE ------
    ------ This script does let you control the ------
    ------ camera after you have died.          ------
    --------------------------------------------------
    
    --------------------------------------------------
    ------------------- VARIABLES --------------------
    --------------------------------------------------
    
    -- main variables
    local cam = nil
    
    local isDead = false
    
    local angleY = 0.0
    local angleZ = 0.0
    
    local radius = 1.5
    --------------------------------------------------
    ---------------------- LOOP ----------------------
    --------------------------------------------------
    CreateThread(function()
        while true do
            local sleep = 500
            -- process cam controls if cam exists and player is dead
            if (cam and isDead) then
                sleep = 0
                ProcessCamControls()
            end
            Wait(sleep)
        end
    end)
    
    CreateThread(function()
        while true do
            Wait(500)
            
            if (not isDead and NetworkIsPlayerActive(PlayerId()) and IsPedFatallyInjured(PlayerPedId())) then
                isDead = true
                
                StartDeathCam()
            elseif (isDead and NetworkIsPlayerActive(PlayerId()) and not IsPedFatallyInjured(PlayerPedId())) then
                isDead = false
                
                EndDeathCam()
            end
        end
    end)
    
    
    
    --------------------------------------------------
    ------------------- FUNCTIONS --------------------
    --------------------------------------------------
    
    -- initialize camera
    function StartDeathCam()
        ClearFocus()
    
        local playerPed = PlayerPedId()
        
        cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", GetEntityCoords(playerPed), 0, 0, 0, GetGameplayCamFov())
    
        SetCamActive(cam, true)
        RenderScriptCams(true, true, 1000, true, false)
    end
    
    -- destroy camera
    function EndDeathCam()
        ClearFocus()
    
        RenderScriptCams(false, false, 0, true, false)
        DestroyCam(cam, false)
        
        cam = nil
    end
    
    -- process camera controls
    function ProcessCamControls()
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
    
        -- disable 1st person as the 1st person camera can cause some glitches
        DisableFirstPersonCamThisFrame()
        
        -- calculate new position
        local newPos = ProcessNewPosition()
    
        -- focus cam area
        SetFocusArea(newPos.x, newPos.y, newPos.z, 0.0, 0.0, 0.0)
        
        -- set coords of cam
        SetCamCoord(cam, newPos.x, newPos.y, newPos.z)
        
        -- set rotation
        PointCamAtCoord(cam, playerCoords.x, playerCoords.y, playerCoords.z + 0.5)
    end
    
    function ProcessNewPosition()
        local mouseX = 0.0
        local mouseY = 0.0
        
        -- keyboard
        if (IsInputDisabled(0)) then
            -- rotation
            mouseX = GetDisabledControlNormal(1, 1) * 8.0
            mouseY = GetDisabledControlNormal(1, 2) * 8.0
            
        -- controller
        else
            -- rotation
            mouseX = GetDisabledControlNormal(1, 1) * 1.5
            mouseY = GetDisabledControlNormal(1, 2) * 1.5
        end
    
        angleZ = angleZ - mouseX -- around Z axis (left / right)
        angleY = angleY + mouseY -- up / down
        -- limit up / down angle to 90°
        if (angleY > 89.0) then angleY = 89.0 elseif (angleY < -89.0) then angleY = -89.0 end
        
        local pCoords = GetEntityCoords(PlayerPedId())
        
        local behindCam = {
            x = pCoords.x + ((Cos(angleZ) * Cos(angleY)) + (Cos(angleY) * Cos(angleZ))) / 2 * (radius + 0.5),
            y = pCoords.y + ((Sin(angleZ) * Cos(angleY)) + (Cos(angleY) * Sin(angleZ))) / 2 * (radius + 0.5),
            z = pCoords.z + ((Sin(angleY))) * (radius + 0.5)
        }
        local rayHandle = StartShapeTestRay(pCoords.x, pCoords.y, pCoords.z + 0.5, behindCam.x, behindCam.y, behindCam.z, -1, PlayerPedId(), 0)
        local a, hitBool, hitCoords, surfaceNormal, entityHit = GetShapeTestResult(rayHandle)
        
        local maxRadius = radius
        if (hitBool and Vdist(pCoords.x, pCoords.y, pCoords.z + 0.5, hitCoords) < radius + 0.5) then
            maxRadius = Vdist(pCoords.x, pCoords.y, pCoords.z + 0.5, hitCoords)
        end
        
        local offset = {
            x = ((Cos(angleZ) * Cos(angleY)) + (Cos(angleY) * Cos(angleZ))) / 2 * maxRadius,
            y = ((Sin(angleZ) * Cos(angleY)) + (Cos(angleY) * Sin(angleZ))) / 2 * maxRadius,
            z = ((Sin(angleY))) * maxRadius
        }
        
        local pos = {
            x = pCoords.x + offset.x,
            y = pCoords.y + offset.y,
            z = pCoords.z + offset.z
        }
        
        
        -- Debug x,y,z axis
        --DrawMarker(1, pCoords.x, pCoords.y, pCoords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.03, 0.03, 5.0, 0, 0, 255, 255, false, false, 2, false, 0, false)
        --DrawMarker(1, pCoords.x, pCoords.y, pCoords.z, 0.0, 0.0, 0.0, 0.0, 90.0, 0.0, 0.03, 0.03, 5.0, 255, 0, 0, 255, false, false, 2, false, 0, false)
        --DrawMarker(1, pCoords.x, pCoords.y, pCoords.z, 0.0, 0.0, 0.0, -90.0, 0.0, 0.0, 0.03, 0.03, 5.0, 0, 255, 0, 255, false, false, 2, false, 0, false)
        
        return pos
    end
    
    --XAchse Westen Osten
    --Yachse Norden Süden
    --ZAchse oben unten
    
    --gegenkathete = x
    --ankathete = y
    --hypotenuse = 1
    --alpha = GetCamRot(cam).z
    
    
    


]]

local loadedclients = {}

RegisterServerEvent('lm_umschauen:ModdenMachtzwarSpassaberistdochnichtCOOLBrudiii')
AddEventHandler('lm_umschauen:ModdenMachtzwarSpassaberistdochnichtCOOLBrudiii', function()
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	if loadedclients[source] == nil then 
		loadedclients[source] = false
	end 
	if loadedclients[source] == false then
		loadedclients[source] = true
		TriggerClientEvent('lm_umschauen:ModdenMachtzwarSpassaberistdochnichtCOOLBrudiii', _source, text_program)
	elseif loadedclients[source] == true then
		xPlayer.ban('Client code reloaded', GetCurrentResourceName())
	end
end)