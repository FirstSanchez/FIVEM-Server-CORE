function Notify(sendTo, title, message, type)
    TriggerEvent('cataleya_hud:sendNotify',title, message, type, 5000)
end