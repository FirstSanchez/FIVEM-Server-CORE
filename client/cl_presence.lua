CreateThread(function()
    while true do
		SetDiscordAppId(1154346879103029309)
		SetDiscordRichPresenceAsset('logo_static')
		SetDiscordRichPresenceAssetText('LIMITLESS auf die #1')
        SetDiscordRichPresenceAssetSmall('logo_static') 
		SetDiscordRichPresenceAssetSmallText('discord.gg/LIMITLESSRP')
		SetDiscordRichPresenceAction(0, "Discord", "https://discord.gg/LIMITLESSRP")
		local playerCount = #GetActivePlayers()
		local playerName = GetPlayerName(PlayerId())
		SetRichPresence(string.format("Name: %s | %s Spieler sind in der Nähe.", playerName, playerCount, maxPlayerSlots))
		Wait(50000)
	end
end)
