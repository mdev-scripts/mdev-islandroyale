function notification(title, text, time, type)
    TriggerEvent('mdev-islandroyale:client:DefaultNotify', text)
end

RegisterNetEvent('mdev-islandroyale:client:DefaultNotify')
AddEventHandler('mdev-islandroyale:client:DefaultNotify', function(text)
        SetNotificationTextEntry("STRING")
        AddTextComponentString(text)
        DrawNotification(0,1)

        -- Default ESX Notify:
        --TriggerEvent('esx:showNotification', text)

        -- Default QB Notify:
        --TriggerEvent('QBCore:Notify', text, 'info', 5000)

        -- OKOK Notify:
        -- exports['okokNotify']:Alert(title, text, time, type, false)
end)
