local knockedOut = false
local wait = 15
local count = 60
CreateThread(function()
	while true do
		Wait(1)
        local myPed = GetPlayerPed(-1)
        if IsPedInMeleeCombat(myPed) then
            if (HasPedBeenDamagedByWeapon(myPed, GetHashKey("WEAPON_UNARMED"), 0) )then
                if GetEntityHealth(myPed) < 145 then
                    SetPlayerInvincible(PlayerId(), false)
					SetPedToRagdoll(myPed, 1000, 1000, 0, 0, 0, 0)
					ShakeGameplayCam('LARGE_EXPLOSION_SHAKE', 2.5)
                    wait = 15
					knockedOut = true
					SetEntityHealth(myPed, 140)
				end
			end
		end

		if knockedOut == true then		
			SetPlayerInvincible(PlayerId(), false)
			DisablePlayerFiring(PlayerId(), true)
			SetPedToRagdoll(myPed, 1000, 1000, 0, 0, 0, 0)
			ResetPedRagdollTimer(myPed)
			SetTimecycleModifier("REDMIST")
			ShakeGameplayCam("VIBRATE_SHAKE", 1.0)

			if wait >= 0 then
				count = count - 1
                if count == 0 then
                    
					count = 120
					wait = wait - 1
                    if GetEntityHealth(myPed) <= 50 then
						SetEntityHealth(myPed, GetEntityHealth(myPed)+2)
					end
				end
            else
                
				SetTimecycleModifier("")
                SetTransitionTimecycleModifier("")		
				SetPlayerInvincible(PlayerId(), false)
				knockedOut = false
			end
		end
	end
end)
