Helpers.Raycast = {}

function RotationToDirection(rot)  
    if (rot == nil) then 
      rot = GetGameplayCamRot(2);  
    end   
  
    local  rotZ = rot.z  * ( 3.141593 / 180.0 )   
    local  rotX = rot.x  * ( 3.141593 / 180.0 )   
    local  c = math.cos(rotX);   
    local  multXY = math.abs(c)   
    local  res = vector3( ( math.sin(rotZ) * -1 )*multXY, math.cos(rotZ)*multXY, math.sin(rotX) ) 
  
    return res 
end  
  

function Helpers.Raycast.Shoot(distance, flags)
    local cameraCoords = GetGameplayCamCoord();
    local direction = RotationToDirection(GetGameplayCamRot(0));
    local destination = vector3(
                cameraCoords.x + direction.x * distance,
                cameraCoords.y + direction.y * distance,
                cameraCoords.z + direction.z * distance
    );

    return GetShapeTestResult(
        StartShapeTestRay(
            cameraCoords.x,
            cameraCoords.y,
            cameraCoords.z,
            destination.x,
            destination.y,
            destination.z,
            flags,
            -1,
            1
        )
    );
end

-- returns HIT_ENTITY, RAY_HIT, RAY_POS, RAY_NORM, RAY_ENT
function Helpers.Raycast.Execute()
    local position = GetEntityCoords(PlayerPedId())

    local ret, hit, pos, norm, ent = Helpers.Raycast.Shoot(50, 16) -- Raycast for Entity
    local hit_entity = true

    if hit ~= 1 then 
        hit_entity = false
        ret, hit, pos, norm, ent = Helpers.Raycast.Shoot(50, 1)
    end

    if hit == 1 then 
        DrawLine(position.x, position.y, position.z, pos.x, pos.y, pos.z, 255,255,255,255)
        DrawSphere(pos.x, pos.y, pos.z, 0.05, 255, 255, 255, 0.4)
    end
    
    return hit_entity, ret, hit, pos, norm, ent 
end