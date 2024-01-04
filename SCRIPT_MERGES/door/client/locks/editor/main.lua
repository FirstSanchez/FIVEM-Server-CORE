ESX = nil

CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Wait(0)
    end
end)

CreateThread(function()
    -- STATES
    local E_EDITOR_STATES = {
        NOT_STARTED             = 0, -- INITIAL STATE MAIN LOOP FOR EDITOR IS NOT STARTED IN THIS STATE!
        OVERVIEW                = 1, -- SEE ALL EXITING DOORS AND SEE CONTROLS

        -- SUB_STATES: 0 -> DEFAULT, 1 -> SELECT DOOR, 2 -> DESELECT DOOR, 3 -> SELECT MODE
        -- EXTRA_BOOL: TRUE -> CAN GO INTO NEXT STEP
        CREATE_SELECTION        = 2, -- SELECTING DOORS FOR CREATING NEW LOCK

        CREATE_SETTINGS         = 3, -- SETUP DOOR (SETTINGS LIKE PERMISSIONS ETC) IN A NUI (STOPPING RAYCAST)

        -- SUB_STATES: 0 -> DEFAULT, 1 --> CAN PASTE, 2 --> CONFIRM_DELETE
        INFO                    = 4, -- HOVERING OVER EXITING DOORS TO GET INFORMATIONS

        EDIT                    = 5, -- EDIT SETTINGS LIKE PERMISSIONS ETC IN A NUI (STOPPING RAYCAST)
    }

    editor = {}

    local state = E_EDITOR_STATES.NOT_STARTED
    local sub_state = 0
    local extra_bool = false

    local current_state = nil
    local current_sub_state = nil
    local current_extra_bool = nil

    local controls_scaleform = nil
    local active_controls = {}

    function refresh_controls(sub_state, extra_bool) 
        active_controls = {}
        if sub_state == nil then sub_state = 0 end

        if state ==  E_EDITOR_STATES.OVERVIEW then
            active_controls = {
                { text = "Beenden", codes = {CfgLocks.Keys.BACK}},
                { text = "Neues Schloss", codes = {CfgLocks.Keys.INTERACTION}},
            }
        elseif state ==  E_EDITOR_STATES.CREATE_SELECTION then
            table.insert(active_controls, { text = "Zurück", codes = {CfgLocks.Keys.BACK}})
            
            if sub_state ~= 3 and extra_bool then
                table.insert(active_controls, { text = "Weiter", codes = {CfgLocks.Keys.INTERACTION}})
            end

            if sub_state == 1 or sub_state == 2 then
                table.insert(active_controls, {
                    text = (sub_state == 1 and "Tür hinzufügen" or "Tür entfernen"), codes = {CfgLocks.Keys.SELECT_DOORS}
                })
            elseif sub_state == 3 then
                table.insert(active_controls, {
                    text = "Einzel", codes = {CfgLocks.Keys.INTERACTION2}
                })
                table.insert(active_controls, {
                    text = "Mehrfach", codes = {CfgLocks.Keys.INTERACTION3}
                })
            end
        elseif state ==  E_EDITOR_STATES.INFO then
            table.insert(active_controls, { text = (sub_state == 2 and "Abbrechen" or "Beenden"), codes = {CfgLocks.Keys.BACK}})

            if sub_state ~= 2 then
                table.insert(active_controls, {
                    text = "Löschen", codes = {CfgLocks.Keys.INTERACTION4}
                })
                
                if sub_state == 1 then
                    table.insert(active_controls, {
                        text = "Einfügen", codes = {CfgLocks.Keys.INTERACTION3}
                    })
                end
            
                table.insert(active_controls, {
                    text = "Kopieren", codes = {CfgLocks.Keys.INTERACTION2}
                })

                table.insert(active_controls, {
                    text = "Bearbeiten", codes = {CfgLocks.Keys.INTERACTION}
                })
            else
                table.insert(active_controls, {
                    text = "Bestätigen", codes = {CfgLocks.Keys.INTERACTION}
                })
            end
        end

        PushScaleformMovieFunction(controls_scaleform, 'CLEAR_ALL')
        PopScaleformMovieFunctionVoid()
        PushScaleformMovieFunction(controls_scaleform,'SET_CLEAR_SPACE')
        PushScaleformMovieFunctionParameterInt(200)
        PopScaleformMovieFunctionVoid()

        for i,c in ipairs(active_controls) do
            PushScaleformMovieFunction(controls_scaleform, "SET_DATA_SLOT")
            PushScaleformMovieFunctionParameterInt(i)
            for j,key in ipairs(c.codes) do
                ScaleformMovieMethodAddParamPlayerNameString(GetControlInstructionalButton(0, key, true))
            end
            BeginTextCommandScaleformString("STRING")
            AddTextComponentScaleform(c.text)
            EndTextCommandScaleformString()
            PopScaleformMovieFunctionVoid()
        end

        PushScaleformMovieFunction(controls_scaleform, 'DRAW_INSTRUCTIONAL_BUTTONS')
        PopScaleformMovieFunctionVoid()
    end

    function refresh_help_text(sub_state, extra_bool) 
        help_text = ""

        if state ==  E_EDITOR_STATES.OVERVIEW then
            help_text = "Ziele auf die markierten Türen für mehr Informationen oder erstelle neue Schlösser"
        elseif state ==  E_EDITOR_STATES.CREATE_SELECTION then
            if sub_state ~= 3 then
                help_text = "Ziele auf Türen um sie für das neue Schloss zu markieren.\n~b~Blaue Türen~s~ haben bereits ein Schloss und können nicht markiert werden!"
            else
                help_text = "Wähle einen Modus aus.\n\nMehrfach: Jede Markierte Tür bekommt ihr eigenes Schloss!\n\nEinzel: Alle Markierten Türen bekommen EIN gemeinsames Schloss!"
            end

        elseif state ==  E_EDITOR_STATES.INFO then
            help_text = "Beachte die Möglichen Aktionen unten Rechts."
            if sub_state == 2 then 
                help_text = "Möchtest du dieses Schloss wirklich löschen?"
            end
        end
    end

    function RenderLocks()
        local playerPed = GetPlayerPed(-1)
        local playerCoords = GetEntityCoords(playerPed)
        for doorHash, data in pairs(DoorSystemGetActive()) do
        local entityHandle = data[2]

        local entityCoords = GetEntityCoords(entityHandle)

        local distance = #(playerCoords - entityCoords) 

        if distance <= 50 then
            Helpers.Bounding.DrawEntityBoundingBox(entityHandle, 0,   0, 255, 50)
        end

        if distance < 10 then
                SetEntityNoCollisionEntity(entityHandle, playerPed, true)
        end
        end
    end

    --
    -- STATES
    --

    -- vars
    local selected_doors = {}
    local copied_lock = nil

    -- OVERVIEW
    function state_overview()
        RenderLocks()

        -- todo check if aiming on existing door
        local HIT_ENTITY, RAY_RES, RAY_HIT, RAY_POS, RAY_NORM, RAY_ENT = Helpers.Raycast.Execute()

        if HIT_ENTITY then 
            local coords = GetEntityCoords(RAY_ENT)
            local modelhash = GetEntityModel(RAY_ENT)
            if Helpers.Locks.FindLockFromDoor(coords.x, coords.y, coords.z, modelhash) ~= nil then
                state = E_EDITOR_STATES.INFO
            end
        end

        -- keybinds
        if IsDisabledControlJustReleased(0, CfgLocks.Keys.INTERACTION) then
            state = E_EDITOR_STATES.CREATE_SELECTION
            selected_doors = {} -- reset selection
        elseif IsDisabledControlJustReleased(0, CfgLocks.Keys.BACK) then
            editor.stop()
        end
    end

    -- CREATE_SELECTION
    function state_create_select()
        RenderLocks()



        local hovered_ent = nil

        if sub_state ~= 3 then
            local HIT_ENTITY, RAY_RES, RAY_HIT, RAY_POS, RAY_NORM, RAY_ENT = Helpers.Raycast.Execute()

            -- todo check if aiming on door
            if HIT_ENTITY then
                local coords = GetEntityCoords(RAY_ENT)
                local modelhash = GetEntityModel(RAY_ENT)
        
                local lock = Helpers.Locks.FindLockFromDoor(coords.x, coords.y, coords.z, modelhash)
        
                if lock == nil then
                    hovered_ent = RAY_ENT

                    if Helpers.Table.Exists(selected_doors, RAY_ENT) then
                        Helpers.Bounding.DrawEntityBoundingBox(RAY_ENT, 255,   0, 0, 50)
                        sub_state = 2
                    else
                        Helpers.Bounding.DrawEntityBoundingBox(RAY_ENT,  255, 255, 0, 50)
                        sub_state = 1
                    end
                else
                    sub_state = 0
                end
            else
                sub_state = 0
            end

            extra_bool = #selected_doors > 0
        end

        for i, selectedDoor in ipairs(selected_doors) do
            if selectedDoor ~= hovered_ent then
                Helpers.Bounding.DrawEntityBoundingBox(selectedDoor,  255, 255, 0, 25)
            end
        end

        if IsDisabledControlJustReleased(0, CfgLocks.Keys.SELECT_DOORS) then
            local selectedIndex = Helpers.Table.FindIndex(selected_doors, hovered_ent)

            if selectedIndex ~= nil then
                table.remove(selected_doors, selectedIndex) 
            else
                table.insert(selected_doors, hovered_ent) 
            end
        elseif IsDisabledControlJustReleased(0, CfgLocks.Keys.INTERACTION) and extra_bool == true then
            sub_state = 3
        elseif IsDisabledControlJustReleased(0, CfgLocks.Keys.INTERACTION2) and sub_state == 3 then
            state = E_EDITOR_STATES.CREATE_SETTINGS
            CreateMenu(selected_doors, false, function(finished) 
                if finished then
                    state = E_EDITOR_STATES.OVERVIEW
                else
                    state = E_EDITOR_STATES.CREATE_SELECTION
                end
            end)
        elseif IsDisabledControlJustReleased(0, CfgLocks.Keys.INTERACTION3) and sub_state == 3 then
            state = E_EDITOR_STATES.CREATE_SETTINGS
            CreateMenu(selected_doors, true, function(finished)
                if finished then
                    state = E_EDITOR_STATES.OVERVIEW
                else
                    state = E_EDITOR_STATES.CREATE_SELECTION
                end
            end)
        elseif IsDisabledControlJustReleased(0, CfgLocks.Keys.BACK) then
            if sub_state == 3 then
                sub_state = 0
            else 
                state = E_EDITOR_STATES.OVERVIEW
            end
        end
    
    end


    -- CREATE_SETTINGS
    function state_create_setup()
    -- nothing todo here a menu will handle setup
    end


    -- INFO

    local current_lines = 0
    function render_line_of_text(msg,r,g,b,a)
        current_lines = current_lines + 1

        if msg == nil then 
            return
        end

        if r == nil then 
            r,g,b,a = 255,255,255,255
        end

        SetTextFont(4)
        SetTextScale(0.0, 0.35)
        SetTextColour(r,g,b,a)
        SetTextOutline()
        SetTextEntry("STRING")
        AddTextComponentString(msg)
        DrawText(0.005, 0.100 + 0.017 * current_lines)
    end

    function state_info()
        RenderLocks()

    -- change state if not aiming on a door anymore
        local HIT_ENTITY, RAY_RES, RAY_HIT, RAY_POS, RAY_NORM, RAY_ENT = Helpers.Raycast.Execute()
        local lock = nil
        local door = nil

        if HIT_ENTITY then
            local coords = GetEntityCoords(RAY_ENT)
            local modelhash = GetEntityModel(RAY_ENT)
            lock, door = Helpers.Locks.FindLockFromDoor(coords.x, coords.y, coords.z, modelhash)
        end

        if lock == nil then 
            state = E_EDITOR_STATES.OVERVIEW
            return
        end

        if sub_state == 0 and copied_lock ~= nil then sub_state = 1 end

        --
        -- Render lock information
        --
        if lock ~= nil then

            current_lines = 0
            render_line_of_text(string.format("Lock ID: %s", lock.id))
            render_line_of_text(string.format("Door ID: %s", door.id))
            local state
            if lock.state == 0 then 
                state = "UNLOCKED"
            elseif lock.state == 1 then
                state = "LOCKED (NORMAL)"
            elseif lock.state == 4 then
                state = "LOCKED (FORCED)"
            else 
                state = string.format("UNKNOWN (%s)", lock.state)
            end
            render_line_of_text(string.format("State: %s", state))
            render_line_of_text()
            render_line_of_text("--Settings--")
            for name, value in pairs(lock.settings) do
                render_line_of_text(string.format("%s: %s",name, value))
            end
            render_line_of_text()
            render_line_of_text("--Pickable Options--")
            render_line_of_text(string.format("Enabled: %s", lock.break_in.pickable))
            if lock.break_in.pickable then 
                for name, value in pairs(lock.break_in.pickable_options) do
                    render_line_of_text(string.format("%s: %s",name, value))
                end
            end
            render_line_of_text()
            render_line_of_text("--Hackable Options--")
            render_line_of_text(string.format("Enabled: %s", lock.break_in.hackable))
            if lock.break_in.hackable then 
                for name, value in pairs(lock.break_in.hackable_options) do
                    render_line_of_text(string.format("%s: %s",name, value))
                end
            end
            render_line_of_text()
            render_line_of_text("--BreakIn Notifications--")
            if lock.break_in.notify == nil or #lock.break_in.notify == 0 then
                render_line_of_text("Disabled")
            else
                for i, job in ipairs(lock.break_in.notify) do
                    render_line_of_text(string.format("> %s",job))
                end
            end
            render_line_of_text()
            render_line_of_text("--Jobs--")
            if lock.permissions.jobs == nil or #lock.permissions.jobs == 0 then
                render_line_of_text("Disabled")
            else
                for i, job in ipairs(lock.permissions.jobs) do
                    render_line_of_text(string.format("> %s (%s)",job.name, job.min_grade))
                end
            end
            render_line_of_text()
            render_line_of_text("--Keys--")
            if lock.permissions.keys == nil or #lock.permissions.keys == 0 then
                render_line_of_text("Disabled")
            else
                for i, key in ipairs(lock.permissions.keys) do
                    render_line_of_text(string.format("> %s",key))
                end
            end
        
        end


        if IsDisabledControlJustReleased(0, CfgLocks.Keys.BACK) then
            if sub_state == 2 then
                sub_state = 0 
            else
                editor.stop()
            end
        end

        if IsDisabledControlJustReleased(0, CfgLocks.Keys.INTERACTION4) then
            sub_state = 2
        end

        if lock ~= nil and IsDisabledControlJustReleased(0,  CfgLocks.Keys.INTERACTION2) then
            sub_state = 1
            copied_lock = Helpers.Table.Clone(lock)
        end

        if IsDisabledControlJustReleased(0,  CfgLocks.Keys.INTERACTION3) and sub_state == 1 and copied_lock ~= nil and lock ~= nil then
            copy = Helpers.Table.Clone(copied_lock)
            current_lock = Helpers.Table.Clone(lock)

            current_lock.settings = copy.settings 
            current_lock.break_in = copy.break_in
            current_lock.permissions = copy.permissions
            TriggerServerEvent("ax_locks:edit-lock", current_lock)
        end
        

        if lock ~= nil and IsDisabledControlJustReleased(0, CfgLocks.Keys.INTERACTION) then 
            if sub_state == 0 then
                state = E_EDITOR_STATES.EDIT
                EditMenu(lock, function(finished)
                    state = E_EDITOR_STATES.OVERVIEW
                end)
            elseif sub_state == 2 then 
                TriggerServerEvent('ax_locks:delete', lock.id)
            end
        end
    end


    -- EDIT
    function state_edit()
        -- nothing todo here a menu will handle edits
    end

    --
    -- MAIN LOOP
    --
    function main_loop()
        -- do state independent stuff first

        -- Refresh controls if state changes
        if state ~= current_state or sub_state ~= current_sub_state or extra_bool ~= current_extra_bool then
            if state ~= current_state then
                sub_state = 0 -- reset sub state on state change
                extra_bool = false -- reset extra bool on state change
            end
            refresh_controls(sub_state, extra_bool)
            refresh_help_text(sub_state, extra_bool)
            current_state = state
            current_sub_state = sub_state
            current_extra_bool = extra_bool
        end

        -- Render controls
        if #active_controls > 0 then
            DrawScaleformMovieFullscreen(controls_scaleform,255,255,255,0,0)
        end

        -- Render Help Text
        if help_text ~= "" then 
            AddTextEntry("axlocks_help", help_text);
            DisplayHelpTextThisFrame("axlocks_help", false);
        end

        -- Disable Control Actions
        DisableControlAction(0, CfgLocks.Keys.SELECT_DOORS, true)
        DisableControlAction(0, CfgLocks.Keys.INTERACTION, true)
        DisableControlAction(0, CfgLocks.Keys.INTERACTION2, true)
        DisableControlAction(0, CfgLocks.Keys.INTERACTION3, true)
        DisableControlAction(0, CfgLocks.Keys.INTERACTION4, true)
        DisableControlAction(0, CfgLocks.Keys.BACK, true)

        -- Call state method
        if state ==  E_EDITOR_STATES.OVERVIEW then
            state_overview()
        elseif state ==  E_EDITOR_STATES.CREATE_SELECTION then
            state_create_select()
        elseif state ==  E_EDITOR_STATES.CREATE_SETTINGS then
            state_create_setup()
        elseif state ==  E_EDITOR_STATES.INFO then
            state_info()
        elseif state ==  E_EDITOR_STATES.EDIT then
            state_edit()
        end
    end

    -- STOP EDITOR
    function editor.stop() 
        state = E_EDITOR_STATES.NOT_STARTED
        current_state = nil

        -- CLEAN UP
        Helpers.Scaleforms.UnloadMovie(controls_scaleform)
        controls_scaleform = nil
    end

    -- START MAIN LOOP + SWITCH INTO OVERVIEW STATE
    function editor.start() 
        state = E_EDITOR_STATES.OVERVIEW
        
        -- SETUP CONTROLS SCALEFORM
        controls_scaleform = Helpers.Scaleforms.LoadMovie('INSTRUCTIONAL_BUTTONS') 

        CreateThread(function()
            while state ~= E_EDITOR_STATES.NOT_STARTED do
               Wait(0)

                main_loop()
            end
        end) 
    end
end)