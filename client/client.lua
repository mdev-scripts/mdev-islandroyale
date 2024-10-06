RegisterNetEvent('mdev-islandroyale:joinEvent')
AddEventHandler('mdev-islandroyale:joinEvent', function(coords)
    local playerPed = PlayerPedId()
    SetEntityCoords(playerPed, coords.x, coords.y, coords.z)
    SetEntityHeading(playerPed, coords.w)
end)

RegisterNetEvent('mdev-islandroyale:stopEvent')
AddEventHandler('mdev-islandroyale:stopEvent', function(coords)
    local playerPed = PlayerPedId()
    SetEntityCoords(playerPed, coords.x, coords.y, coords.z)
    SetEntityHeading(playerPed, coords.w)
    RemoveAllPedWeapons(playerPed, true)
end)

RegisterNetEvent('mdev-islandroyale:startEvent')
AddEventHandler('mdev-islandroyale:startEvent', function(spawnCoords)
    local playerPed = PlayerPedId()
    local randomSpawn = math.random(1, #spawnCoords)
    SetEntityCoords(playerPed, spawnCoords[randomSpawn][1], spawnCoords[randomSpawn][2], spawnCoords[randomSpawn][3])
    SetEntityHeading(playerPed, spawnCoords[randomSpawn][4])
end)

if Config['Framework']:upper() == 'ESX' then

    RegisterNetEvent('esx:onPlayerDeath')
    AddEventHandler('esx:onPlayerDeath', function()
        TriggerServerEvent('mdev-islandroyale:playerDiedInEvent')
    end)

    RegisterNetEvent('esx:playerLoaded')
    AddEventHandler('esx:playerLoaded', function(source)
        local playerPed = PlayerPedId()
        local playerId = GetPlayerServerId(PlayerId())
        TriggerServerEvent('mdev-islandroyale:checkroyalestatus', playerId)
    end)

elseif Config['Framework']:upper() == 'QBCORE' then

    RegisterNetEvent('qb-core:playerDied')
    AddEventHandler('qb-core:playerDied', function()
        TriggerServerEvent('mdev-islandroyale:playerDiedInEvent')
    end)

    RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
    AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
        local playerPed = PlayerPedId()
        local playerId = GetPlayerServerId(PlayerId())
        TriggerServerEvent('mdev-islandroyale:checkroyalestatus', playerId)
    end)
else
    print('Ongeldige Framework geselecteerd!')
end