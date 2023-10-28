local weaponsByName = {}
local weaponsByHash = {}

CreateThread(function()
    for index, weapon in pairs(ESX.GetConfig().Weapons) do
        weaponsByName[weapon.name] = index
        weaponsByHash[joaat(weapon.name)] = weapon
    end
end)

RegisterNetEvent('esx:addInventoryItem', function(item, count)
    -- print('you received item: ', item)
    -- print('count', count)
    Wait(6000)
    local isItem, foundItem = false, nil
    local isWeapon, foundWeapon = false, nil

    for k, v in pairs(ESX.GetPlayerData().inventory) do
        if v.name == item then
            foundItem = v
            isItem = true
            break
        end
    end

    for k, v in pairs(weaponsByName) do
        local weapon = ESX.GetConfig().Weapons[v]
        if string.upper(weapon.label) == string.upper(item) then
            foundWeapon = weapon
            isWeapon = true
            break
        end
    end

    if (isItem) then
        ESX.TriggerServerCallback("corbo_restricteditems:gotItem", function()
        end, foundItem.name)
        return
    end

    if (isWeapon) then
        ESX.TriggerServerCallback("corbo_restricteditems:gotWeapon", function()
        end, foundWeapon.name)
        return
    end
end)


-- interiorfix

RegisterCommand('interiorid', function()
    local interior = GetInteriorFromEntity(PlayerPedId())
    print(interior)
    print(GetInteriorInfo(interior))
end)

RegisterCommand('lipl', function(s, args)
	RequestIpl(args[1])
	print('requested')
end)

-- RegisterCommand('disableint', function(_, args)
    -- local interior = tonumber(args[1])
    -- print(tobool(args[2]))
    -- DisableInterior(interior, tobool(args[2]))
-- end)


-- RegisterCommand('tpint', function(_, args)
    -- local interior = tonumber(args[1])
    -- SetEntityCoords(PlayerPedId(), GetInteriorInfo(interior))
-- end)

RegisterCommand('intdist', function(_, args)
    local interior = tonumber(args[1])
    print(#(GetEntityCoords(PlayerPedId()) - GetInteriorInfo(interior)))
end)

local ped = PlayerPedId()
local coords = GetEntityCoords(ped)
local currentInterior = GetInteriorFromEntity(ped)
for name, interior in pairs(Ints.Interiors) do
    local interiorCoords = GetInteriorInfo(interior.id)
    if #(interiorCoords - coords) > interior.loadRange then
        if currentInterior ~= interior.id then
            interior.disabled = true
			DisableInterior(interior.id, true)
        end
    else
        interior.disabled = false
    end
end

RegisterCommand('loadallinteriors', function()
	for name, interior in pairs(Ints.Interiors) do
		DisableInterior(interior.id, false)
		RefreshInterior(interior.id)
	end
	print('done')
end)

CreateThread(function()
    while true do
		local sleep = 100
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
        local currentInterior = GetInteriorFromEntity(ped)
		
        for name, interior in pairs(Ints.Interiors) do
            local interiorCoords = GetInteriorInfo(interior.id)
			
            if #(interiorCoords - coords) > interior.loadRange then
                if not interior.disabled and currentInterior ~= interior.id then
                    interior.disabled = true
                    DisableInterior(interior.id, true)
                end
            elseif interior.disabled then
                interior.disabled = false
                DisableInterior(interior.id, false)
				--RefreshInterior(interior.id)
            end
        end
        Wait(sleep)--Wait(100)
    end
end)