function notification(source, title, text, time, type)
    TriggerClientEvent('mdev-islandroyale:client:DefaultNotify', source, text)
end

function revivePlayer(source)
    TriggerClientEvent('esx_ambulancejob:revive', source)
end
