local nativeHash = GetHashKey("ADD_TEXT_ENTRY")

function SetData()
	Citizen.InvokeNative(nativeHash, 'FE_THDR_GTAO', "~b~ESX | ~s~Hosted By ~y~avoro.eu")
end

CreateThread(function() 
	Wait(1000)
	AddTextEntry("PM_PANE_LEAVE", "~b~Verbindung trennen😭")
	AddTextEntry("PM_PANE_QUIT", "~b~Schließe ~o~FiveM 🐌")
	SetData()
	while true do
		Wait(100)
		if IsPauseMenuActive() then
			SetData()
		else
			Wait(200)
		end
	end
end)
