
function GetJobs(cb) 
    ESX.TriggerServerCallback('ax_locks:get_jobs', function (raw_jobs)
        local jobs = {}

        for i, raw_job in pairs(raw_jobs) do
            local job = {}
            local grades = {}

            job.name = raw_job.name

            for j, raw_grade in pairs(raw_job.grades) do
                local grade = {}
                grade.grade = raw_grade.grade
                grade.label = raw_grade.label
                
                table.insert(grades, grade)
            end

            table.sort(grades, function(a,b) 
                return a.grade < b.grade
            end)

            job.grades = grades
            table.insert(jobs, job)
        end

        table.sort(jobs, function(a,b) 
            return a.name < b.name
        end)

        cb(jobs)
    end)
end


local current_lock = {
    settings = {
        locked_on_start = true,
        interaction_range = 2.5,
        interaction_in_car = false,
        force_lock = false
    },
    
    permissions = {
        jobs = {},
        keys = {}
    },

    break_in = {
        notify = {},
        hackable = false,
        hackable_options = {
            time = 45,
            letters = 5
        },
        pickable = false,
        pickable_options = {
            pins = 5
        }
    },
}

function GetJobPermissions(name)
    for i, job in ipairs(current_lock.permissions.jobs) do
        if job.name == name then
            return job
        end
    end

    return nil
end

function RemoveJobPermissions(name)
    local index = nil

    for i, job in ipairs(current_lock.permissions.jobs) do
        if job.name == name then
            index = i
            break
        end
    end

    if index ~= nil then
        table.remove(current_lock.permissions.jobs, index)
    end
end

function SetJobPermissions(name, min_grade)
    local index = nil

    for i, job in ipairs(current_lock.permissions.jobs) do
        if job.name == name then
            index = i
            break
        end
    end

    if index ~= nil then
        current_lock.permissions.jobs[index].min_grade = min_grade
    else
        table.insert(current_lock.permissions.jobs, {
            name = name,
            min_grade = min_grade
        })
    end
end


--
-- Sub Menus
--

function JobMenu()
    GetJobs(function(jobs)
        local elements = {}

        for i, job in ipairs(jobs) do
            local job_perm = GetJobPermissions(job.name)
            local label = job.name ..' (Kein Zugriff)'

            if job_perm ~= nil then
                label = job.name ..' ('..job_perm.min_grade..')'
            end

            local grade_elements = {
                {label = "Zugriff entfernen", name="remove"}
            }

            for j, grade in ipairs(job.grades) do
                table.insert(grade_elements,  {
                    label = grade.label,
                    grade = grade.grade
                })
            end

            table.insert(elements, {
                label = label,
                name = job.name,
                grade_elements = grade_elements
            })
        end

        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'set_job_jobs', {
            title = 'Job-Permissions',
            align = 'top-left',
            elements = elements,
        },function(data, menu) 


            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'set_job_grade_'..data.current.name, {
                title = 'Rank setzen ('..data.current.name..')',
                align = 'top-left',
                elements = data.current.grade_elements
            }, function(data2, menu2) 
                menu2.close()

                if data2.current.name == 'remove' then
                    RemoveJobPermissions(data.current.name)
                else
                    SetJobPermissions(data.current.name, data2.current.grade)
                end
              
                for k,v in pairs(menu.data.elements) do
                    if v.name == data.current.name then
                        menu.setElement(k,'label',data.current.name ..' ('..(data2.current.grade == nil and 'Kein Zugriff' or data2.current.grade)..')')
                        menu.refresh()
                    end
                end
            end, function(data2, menu2) menu2.close() end)
        end,function(data, menu)
            menu.close()
        end)
    end)
end

function NotifyMenu()
    GetJobs(function(jobs)
        local elements = {}

        for i, job in ipairs(jobs) do
            
            table.insert(elements, {
                label = job.name.. ': '..tostring(Helpers.Table.Exists(current_lock.break_in.notify,job.name)),
                name = job.name,
                grade_elements = grade_elements
            })
        end

        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'set_job_jobs', {
            title = 'Benachrichtigen',
            align = 'top-left',
            elements = elements,
        },function(data, menu) 
            local index = Helpers.Table.FindIndex(current_lock.break_in.notify, data.current.name)
            local value = index == nil

            if index ~= nil then
                table.remove(current_lock.break_in.notify, index)
            else
                table.insert(current_lock.break_in.notify, data.current.name)
            end

            for k,v in pairs(menu.data.elements) do
                if v.name == data.current.name then
                    menu.setElement(k,'label',string.format("%s: %s",data.current.name,tostring(value)))
                    menu.refresh()
                end
            end
        end,function(data, menu)
            menu.close()
        end)
    end)
end


function KeyMenu()
    local elements = {}

    for item_name, label in pairs(CfgLock.AuthorizedItems) do
        table.insert(elements, {
            prefix = label,
            label = label .. ': '..tostring(Helpers.Table.Exists(current_lock.permissions.keys, item_name)),
            name = 'key',
            value = item_name,
        })
    end

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'key_menu', {
        title = "Schlüssel",
        align = "top-left",
        elements = elements,
    }, function(data, menu)
        if data.current.name == 'key' then
            local index = Helpers.Table.FindIndex(current_lock.permissions.keys, data.current.value)
            local value = index == nil

            if index ~= nil then
                table.remove(current_lock.permissions.keys, index)
            else
                table.insert(current_lock.permissions.keys, data.current.value)
            end

            for k,v in pairs(menu.data.elements) do
                if v.value == data.current.value then
                    menu.setElement(k,'label',string.format("%s: %s",data.current.prefix,tostring(value)))
                    menu.refresh()
                end
            end
        end
    end, function(data, menu) menu.close() end)
end


function HackableMenu()
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'hackable_menu', {
        title = "Hackerlaptop",
        align = 'top-left',
        elements = {
            {
                name="enabled",
                prefix = 'Aktiviert',
                label = "Aktiviert: "..tostring(current_lock.break_in.hackable),
            },
            {
                name="time",
                label = "Zeit",
                type = 'slider',
                min = 30,
                max = 60,
                value = current_lock.break_in.hackable_options.time,
            },
            {
                name="letters",
                label = 'Zeichen',
                type = 'slider',
                min = 2,
                max = 10,
                value = current_lock.break_in.hackable_options.letters,
            },
        }
    },function(data, menu)
        if data.current.name == 'enabled' then
            current_lock.break_in.hackable = not current_lock.break_in.hackable

            for k,v in pairs(menu.data.elements) do
                if v.name == data.current.name then
                    menu.setElement(k,'label',string.format("%s: %s",data.current.prefix,tostring(current_lock.break_in.hackable)))
                    menu.refresh()
                end
            end

        end
      end
    ,function(data, menu) menu.close() end
    ,function(data, menu) 
        if data.current.name == 'time' then 
            current_lock.break_in.hackable_options.time = data.current.value
        elseif data.current.name == 'letters' then 
            current_lock.break_in.hackable_options.letters = data.current.value
        end
    end)
end

function PickableMenu()
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'pickable_menu', {
        title = "Dietrich",
        align = 'top-left',
        elements = {
            {
                name="enabled",
                prefix = 'Aktiviert',
                label = "Aktiviert: "..tostring(current_lock.break_in.pickable),
            },
            {
                name="pins",
                label = "Pins",
                type = 'slider',
                min = 1,
                max = 10,
                value = current_lock.break_in.pickable_options.pins,
            }
        }
    },function(data, menu)
        if data.current.name == 'enabled' then
            current_lock.break_in.pickable = not current_lock.break_in.pickable

            for k,v in pairs(menu.data.elements) do
                if v.name == data.current.name then
                    menu.setElement(k,'label',string.format("%s: %s",data.current.prefix,tostring(current_lock.break_in.pickable)))
                    menu.refresh()
                end
            end

        end
      end
    ,function(data, menu) menu.close() end
    ,function(data, menu) 
        if data.current.name == 'pins' then 
            current_lock.break_in.hackable_options.pins = data.current.value
        end
    end)
end




--
-- Main Menu
--
function EditMenu(lock, finished)
    CreateMenu(nil, nil, finished, true, Helpers.Table.Clone(lock))
end

function CreateMenu(selectedDoors, multi_mode, finished, edit_mode, lock)
    local doors = {}

    if not edit_mode then
        if #selectedDoors <= 0 then
            return
        end
    
        for i, door in ipairs(selectedDoors) do
            local coords = GetEntityCoords(door)
            local modelhash = GetEntityModel(door)
    
            table.insert(doors, {
                hash = modelhash,
                x = coords.x,
                y = coords.y,
                z = coords.z
            })
        end
    
        current_lock = {
            doors = {},
    
            settings = {
                locked_on_start = true,
                interaction_range = 2.5,
                interaction_in_car = false,
                force_lock = false
            },
            
            permissions = {
                jobs = {},
                keys = {}
            },
    
            break_in = {
                notify = {},
                hackable = false,
                hackable_options = {
                    time = 45,
                    letters = 5
                },
                pickable = false,
                pickable_options = {
                    pins = 5
                }
            },
        }
    else
        current_lock = lock
    end

    ESX.UI.Menu.Open('default', GetCurrentResourceName(),
                         'create_menu', {
            title = edit_mode and "Schloss bearbeiten" or "Schloss erstellen",
            align = 'top-left',
            elements = {
                {label = "-- EINSTELLUNGEN --", name="seperator"},
                {prefix = "Beim Start abgeschlossen", label = "Beim Start abgeschlossen: "..tostring(current_lock.settings.locked_on_start), name="locked_on_start"},
                {prefix = "Interaktions-Distanz",     label = "Interaktions-Distanz: "..tostring(current_lock.settings.interaction_range), name="interaction_range"},
                {prefix = "Interagieren im Auto",     label = "Interagieren im Auto: "..tostring(current_lock.settings.interaction_in_car), name="interaction_in_car"},
                {prefix = "Schließen erzwingen",     label = "Schließen erzwingen: "..tostring(current_lock.settings.force_lock), name="force_lock"},
                {label = "-- AUFBRECHEN --", name="seperator"},
                {prefix = "Hackerlaptop", label = "Hackerlaptop ", name="hackable"},
                {prefix = "Dietrich",     label = "Dietrich ",     name="pickable"},
                {label = "Benachrichtigen", name="notify"},
                {label = "-- RECHTE --", name="seperator"},
                {label = "Jobs", name="jobs"},
                {label = "Schlüssel", name="keys"},
                {label = "-- FINISH --", name="seperator"},
                {label = edit_mode and "Schloss bearbeiten" or "Schloss erstellen", name="finish"},
            }
        }, function(data, menu)
            if data.current.name == 'seperator' then return end
            
            if data.current.name == 'finish' then 
                table.sort( current_lock.break_in.notify, function(a,b) 
                    return a < b
                end)

                table.sort(current_lock.permissions.keys, function(a,b) 
                    return a < b
                end)

                table.sort(current_lock.permissions.jobs, function(a,b) 
                    return a.name < b.name
                end)

                if edit_mode then
                    TriggerServerEvent("ax_locks:edit-lock", current_lock)
                else
                    local locks = {}
--                    print(json.encode(selectedDoors))
                    if multi_mode then
                        for i, door in ipairs(doors) do
                            local lock = Helpers.Table.Clone(current_lock)
                            lock.doors = {Helpers.Table.Clone(door)}
                            table.insert(locks, lock)
                        end
                    else
                        local lock = Helpers.Table.Clone(current_lock)
                        lock.doors = doors 
                        table.insert(locks, lock)
                    end
    
                    TriggerServerEvent("ax_locks:create-locks", locks)
                end
                menu.close()
                return finished(true)
            end

            if data.current.name == 'jobs' then
                JobMenu()
            elseif data.current.name == 'keys' then
                KeyMenu()
            elseif data.current.name == 'hackable' then
                HackableMenu()
            elseif data.current.name == 'pickable' then
                PickableMenu()
            elseif data.current.name == 'notify' then
                NotifyMenu()
            else
                local _v = current_lock.settings[data.current.name]
                if _v == nil then return end

                if (type(_v) == "boolean") then
                    _v = not _v
                else
                    if _v >= 20.0 then
                        _v = 2.5
                    elseif _v == 2.5 then
                        _v = 5.0
                    elseif _v == 5.0 then
                        _v = 10.0
                    elseif _v == 10.0 then
                        _v = 20.0
                    end
                end
    
                for k,v in pairs(menu.data.elements) do
                    if v.name == data.current.name then
                        menu.setElement(k,'label',string.format("%s: %s",data.current.prefix,tostring(_v)))
                        current_lock.settings[data.current.name] = _v
                        menu.refresh()
                    end
                end
            end
        end, function(data, menu)
            menu.close()
            finished(false)
        end)
end