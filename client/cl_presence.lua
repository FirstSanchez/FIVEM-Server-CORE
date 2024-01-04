CreateThread(function()
    while true do
		SetDiscordAppId(1030865287605669888)
		SetDiscordRichPresenceAsset('logo')
		SetDiscordRichPresenceAssetText('HotLife auf die #1')
        SetDiscordRichPresenceAssetSmall('logo') 
		SetDiscordRichPresenceAssetSmallText('discord.gg/hotlife')
		SetDiscordRichPresenceAction(0, "Discord", "https://discord.gg/HotLife")
		local playerCount = #GetActivePlayers()
		local playerName = GetPlayerName(PlayerId())
		SetRichPresence(string.format("Name: %s | %s Spieler sind in der Nähe.", playerName, playerCount, maxPlayerSlots))
		Wait(50000)
	end
end)
