function Notify(sendTo, title, message, type)
    TriggerClientEvent('esx:showNotification', sendTo, message)
end