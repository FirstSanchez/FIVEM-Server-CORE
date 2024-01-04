ESX = nil

PlayerData = {}
PlayerData.Inventory = {}
PlayerData.WeaponList = {}

Money = 0
BlackMoney = 0
Bank = 0

playerName = GetPlayerName(PlayerId())

TotalBills = {}

ESXLoaded = false

CreateThread(function()
	while ESX == nil do
		ESX = exports['es_extended']:getSharedObject()
		Wait(10)
	end

	while ESX.GetPlayerData().job == nil do
		Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
    PlayerData.Inventory = ESX.GetPlayerData().inventory
    PlayerData.weaponList = ESX.GetWeaponList()

    for k, v in pairs(PlayerData.accounts) do
        if v.name == 'money' then
            Money = v.money
        elseif v.name == 'black_money' then
            BlackMoney = v.money
        elseif v.name == 'bank' then
            Bank = v.money
        end
    end

    ESXLoaded = true
end)

RegisterNetEvent('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
    playerName = GetPlayerName(PlayerId())
end)

RegisterNetEvent('esx:setJob', function(job)
    PlayerData.job = job
end)

RegisterNetEvent('esx:setLevel')
AddEventHandler('esx:setLevel', function(level)
	PlayerData.level = level
end)

RegisterNetEvent('esx:setAccountMoney', function(account)
    if account.name == 'money' then
        Money = account.money
    elseif account.name == 'black_money' then
        BlackMoney = account.money
    elseif account.name == 'bank' then
        Bank = account.money
    end
end)

AddEventHandler('esx:onPlayerDeath', function(data)
    RageUI.CloseAll()
end)

RegisterNetEvent('kek:oger')
AddEventHandler('kek:oger', function()
    RageUI.CloseAll()
    CancelOnscreenKeyboard()
end)

function Notify(title, message, type)
    TriggerEvent('cataleya_hud:sendNotify', title, message, type, 5000)
end
