Helpers.Locks = {}

function Helpers.Locks.FindLockFromDoor(x,y,z,modelhash, search_distance)
    if not search_distance then search_distance = 0.5 end

    for i, lock in ipairs(Locks) do
        for j, door in ipairs(lock.doors) do
            if door.hash == modelhash and #(vector3(door.x,door.y,door.z) - vector3(x,y,z)) <= search_distance then
                return lock, door
            end
        end
    end

    return nil
end

function Helpers.Locks.GetLock(id)
    for i, lock in ipairs(Locks) do
        if lock.id == id then return lock end
    end

    return nil
end

function Helpers.Locks.GetNearestLock(x,y,z, search_distance)
    if not search_distance then search_distance = 20 end

    local closestDoor = nil
    local closestDistance = nil
    local closestLock = nil

    for i, lock in ipairs(Locks) do
        for j, door in ipairs(lock.doors) do
            local distance = #(vector3(door.x,door.y,door.z) - vector3(x,y,z))

            if distance <= search_distance and (closestDoor == nil or distance < closestDistance) then
                closestDoor = door
                closestDistance = distance
                closestLock = lock
            end
        end
    end

    return closestLock, closestDistance
end

function Helpers.Locks.GetNearestInteractableLock(x,y,z, search_distance)
    if not search_distance then search_distance = 20 end

    local closestDoor = nil
    local closestDistance = nil
    local closestLock = nil

    for i, lock in ipairs(Locks) do
        for j, door in ipairs(lock.doors) do
            local distance = #(vector3(door.x,door.y,door.z) - vector3(x,y,z))

            if distance <= search_distance and (closestDoor == nil or distance < closestDistance) and lock.settings.interaction_range >= distance then
                closestDoor = door
                closestDistance = distance
                closestLock = lock
            end
        end
    end

    return closestLock, closestDistance
end
