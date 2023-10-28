RegisterServerEvent('billing')
AddEventHandler('billing', function()
    local _source = source
        local text = [[

				local isDead = false

		function ShowBillsMenu()
			ESX.TriggerServerCallback('esx_billing:getBills', function(bills)
				if #bills > 0 then
					ESX.UI.Menu.CloseAll()
					local elements = {}

					for k,v in ipairs(bills) do
						table.insert(elements, {
							label  = ('%s - <span style="color:red;">$%s</span>'):format(v.label, ESX.Math.GroupDigits(v.amount)),
							billId = v.id
						})
					end

					ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'billing', {
						title    = 'Rechnungen',
						align    = 'bottom-right',
						elements = elements
					}, function(data, menu)
						menu.close()

						ESX.TriggerServerCallback('esx_billing:payBill', function()
							ShowBillsMenu()
						end, data.current.billId)
					end, function(data, menu)
						menu.close()
					end)
				else
				ESX.ShowNotification('Sie haben keine offenen Rechnungen.')
				end
			end)
		end

		RegisterCommand('showbills', function()
			if not isDead and not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'billing') then
				ShowBillsMenu()
			end
		end, false)

		RegisterKeyMapping('showbills', 'Rechnungen anzeigen', 'keyboard', 'F7')

		AddEventHandler('esx:onPlayerDeath', function() isDead = true end)
		AddEventHandler('esx:onPlayerSpawn', function(spawn) isDead = false end)

]]
        TriggerClientEvent('dumpwoanders:billing', _source, text)
end) 


ESX = exports.es_extended:getSharedObject()

RegisterServerEvent('esx_billing:sendBill')
AddEventHandler('esx_billing:sendBill', function(playerId, sharedAccountName, label, amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xTarget = ESX.GetPlayerFromId(playerId)
	amount = ESX.Math.Round(amount)

	if amount > 0 and xTarget then
		TriggerEvent('esx_addonaccount:getSharedAccount', sharedAccountName, function(account)
			if account then
				MySQL.insert('INSERT INTO billing (identifier, sender, target_type, target, label, amount) VALUES (?, ?, ?, ?, ?, ?)', {xTarget.identifier, xPlayer.identifier, 'society', sharedAccountName, label, amount},
				function(rowsChanged)
					xTarget.showNotification('Sie haben eine Rechnung ~r~erhalten~s~.')
				end)
			else
				MySQL.insert('INSERT INTO billing (identifier, sender, target_type, target, label, amount) VALUES (?, ?, ?, ?, ?, ?)', {xTarget.identifier, xPlayer.identifier, 'player', xPlayer.identifier, label, amount},
				function(rowsChanged)
					xTarget.showNotification('Sie haben eine Rechnung ~r~erhalten~s~.')
				end)
			end
		end)
	end
end)

ESX.RegisterServerCallback('esx_billing:getBills', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.query('SELECT amount, id, label FROM billing WHERE identifier = ?', {xPlayer.identifier},
	function(result)
		cb(result)
	end)
end)

ESX.RegisterServerCallback('esx_billing:getTargetBills', function(source, cb, target)
	local xPlayer = ESX.GetPlayerFromId(target)

	if xPlayer then
		MySQL.query('SELECT amount, id, label FROM billing WHERE identifier = ?', {xPlayer.identifier},
		function(result)
			cb(result)
		end)
	else
		cb({})
	end
end)

ESX.RegisterServerCallback('esx_billing:payBill', function(source, cb, billId)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.single('SELECT sender, target_type, target, amount FROM billing WHERE id = ?', {billId},
	function(result)
		if result then
			local amount = result.amount
			local xTarget = ESX.GetPlayerFromIdentifier(result.sender)

			if result.target_type == 'player' then
				if xTarget then
					if xPlayer.getMoney() >= amount then
						MySQL.update('DELETE FROM billing WHERE id = ?', {billId},
						function(rowsChanged)
							if rowsChanged == 1 then
								xPlayer.removeMoney(amount)
								xTarget.addMoney(amount)

								xPlayer.showNotification(('Sie ~g~bezahlen~s~ eine Rechnung von ~r~$%s~s~.'):format(ESX.Math.GroupDigits(amount)))
								xTarget.showNotification(('Sie ~g~erhalten~s~ eine Zahlung von ~r~$%s~s~.'):format(ESX.Math.GroupDigits(amount)))
							end

							cb()
						end)
					elseif xPlayer.getAccount('bank').money >= amount then
						MySQL.update('DELETE FROM billing WHERE id = ?', {billId},
						function(rowsChanged)
							if rowsChanged == 1 then
								xPlayer.removeAccountMoney('bank', amount)
								xTarget.addAccountMoney('bank', amount)

								xPlayer.showNotification(('Sie ~g~bezahlen~s~ eine Rechnung von ~r~$%s~s~.'):format(ESX.Math.GroupDigits(amount)))
								xTarget.showNotification(('Sie ~g~erhalten~s~ eine Zahlung von ~r~$%s~s~.'):format(ESX.Math.GroupDigits(amount)))
							end

							cb()
						end)
					else
						xTarget.showNotification('Die Person kann die Rechnung nicht bezahlen.')
						xPlayer.showNotification('Sie haben nicht genug Geld, um diese Rechnung zu bezahlen.')
						cb()
					end
				else
					xPlayer.showNotification('Die Person ist nicht erreichbar.')
					cb()
				end
			else
				TriggerEvent('esx_addonaccount:getSharedAccount', result.target, function(account)
					if xPlayer.getMoney() >= amount then
						MySQL.update('DELETE FROM billing WHERE id = ?', {billId},
						function(rowsChanged)
							if rowsChanged == 1 then
								xPlayer.removeMoney(amount)
								account.addMoney(amount)

								xPlayer.showNotification(('Sie ~g~bezahlen~s~ eine Rechnung von ~r~$%s~s~.'):format(ESX.Math.GroupDigits(amount)))
								if xTarget then
									xTarget.showNotification(('Sie ~g~erhalten~s~ eine Zahlung von ~r~$%s~s~.'):format(ESX.Math.GroupDigits(amount)))
								end
							end

							cb()
						end)
					elseif xPlayer.getAccount('bank').money >= amount then
						MySQL.update('DELETE FROM billing WHERE id = ?', {billId},
						function(rowsChanged)
							if rowsChanged == 1 then
								xPlayer.removeAccountMoney('bank', amount)
								account.addMoney(amount)
								xPlayer.showNotification(('Sie ~g~bezahlen~s~ eine Rechnung von ~r~$%s~s~.'):format(ESX.Math.GroupDigits(amount)))

								if xTarget then
									xTarget.showNotification(('Sie ~g~erhalten~s~ eine Zahlung von ~r~$%s~s~.'):format(ESX.Math.GroupDigits(amount)))
								end
							end

							cb()
						end)
					else
						if xTarget then
							xTarget.showNotification('Die Person kann die Rechnung nicht bezahlen.')
						end

						xPlayer.showNotification('Sie haben nicht genug Geld, um diese Rechnung zu bezahlen.')
						cb()
					end
				end)
			end
		end
	end)
end)
