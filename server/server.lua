local eventActive = false
local eventStarted = false
local eventPlayers = {}

local function savePlayerInventory(xPlayer)
    local identifier = xPlayer.identifier
    local inventory = xPlayer.getInventory()

    local encodedInventory = json.encode(inventory)
    MySQL.Async.execute(
        "INSERT INTO mdev_islandroyale (player_identifier, inventory) VALUES (@identifier, @inventory)",
        {
            ['@identifier'] = identifier,
            ['@inventory'] = encodedInventory
        }
    )
end

local function restorePlayerInventory(xPlayer)
    local identifier = xPlayer.identifier

    MySQL.Async.fetchAll(
        "SELECT inventory FROM mdev_islandroyale WHERE player_identifier = @identifier ORDER BY saved_at DESC LIMIT 1",
        { ['@identifier'] = identifier },
        function(result)
            if result[1] then
                local savedInventory = json.decode(result[1].inventory)

                for _, item in pairs(xPlayer.getInventory()) do
                    if item.count > 0 then
                        xPlayer.removeInventoryItem(item.name, item.count)
                    end
                end

                for _, item in pairs(savedInventory) do
                    if item.count > 0 then
                        xPlayer.addInventoryItem(item.name, item.count)
                    end
                end

                MySQL.Async.execute(
                    "DELETE FROM mdev_islandroyale WHERE player_identifier = @identifier",
                    { ['@identifier'] = identifier }
                )
            end
        end
    )
end

local function givePlayerLoadout(player)
    local randomWeaponConfig = Config.RandomWeapons[math.random(1, #Config.RandomWeapons)]
    player.addInventoryItem(randomWeaponConfig.weapon, 1)
    player.addInventoryItem(randomWeaponConfig.ammo, tonumber(randomWeaponConfig.amount))

    for _, itemConfig in pairs(Config.RandomItems) do
        local chance = tonumber(itemConfig.chance)
        if math.random(0, 100) <= chance then
            local amount = tonumber(itemConfig.amount)
            player.addInventoryItem(itemConfig.item, amount)
        end
    end
end

local function isPlayerStaffmember(playerGroup, groupList)
    for _, group in ipairs(groupList) do
        if group == playerGroup then
            return true
        end
    end
    return false
end


RegisterCommand('create-royale', function(source, args, rawCommand)
    local xPlayer = GETPFI(source)

        if not isPlayerStaffmember(xPlayer.getGroup(), Config.AdminGroup) then
            notification(source, "Systeem", "You are not an staffmember!", 5000, "error")
            return
        end

        if not eventActive then
            eventActive = true
            eventStarted = false
            notification(source, "Island Royale", "The island royale lobby is created!", 5000, "success")
            notification(-1, "Island Royale", "There is an island royale ongoing, use /join-royale to participate.", 5000, "info")
        else
            notification(source, "Island Royale", "There is already an island royale lobby!", 5000, "error")
        end
end, false)

RegisterCommand('join-royale', function(source, args, rawCommand)
    if eventActive and not eventStarted then
        local xPlayer = GETPFI(source)
        local playerId = source

        if not eventPlayers[playerId] then
            eventPlayers[playerId] = true

            savePlayerInventory(xPlayer)

            for _, item in pairs(xPlayer.getInventory()) do
                if item.count > 0 then
                    xPlayer.removeInventoryItem(item.name, item.count)
                end
            end

            TriggerClientEvent('mdev-islandroyale:joinEvent', source, Config.EventCoords)
            notification(source, "Island Royale", "You have joined the island royale lobby", 5000, "success")

            local players = GetPlayersFunction()
            for _, playerId in ipairs(players) do
                local player = GETPFI(playerId)
                if player and isPlayerStaffmember(player.getGroup(), Config.AdminGroup) then
                    notification(playerId, "Island Royale", xPlayer.getName() .. " has entered the island royale lobby.", 5000, "info")
                end
            end
        else
            notification(source, "Island Royale", "You are already in the island royale lobby", 5000, "error")
        end
    else
        notification(source, "Island Royale", "There is currently no island royale lobby or the lobby already started.", 5000, "error")
    end
end, false)

RegisterCommand('start-royale', function(source, args, rawCommand)
    local xPlayer = GETPFI(source)

    if not isPlayerStaffmember(xPlayer.getGroup(), Config.AdminGroup) then
        notification(source, "Systeem", "You are not an staffmember!", 5000, "error")
        return
    end

    if eventActive and not eventStarted then
        eventStarted = true

        notification(source, "Island Royale", "You have started the island royale lobby!", 5000, "success")

        for playerId, _ in pairs(eventPlayers) do
            local player = GETPFI(playerId)
            if player then
                givePlayerLoadout(player)

                TriggerClientEvent('mdev-islandroyale:startEvent', player.source, Config.SpawnCoords)
                notification(player.source, "Island Royale", "The island royale has been started!", 5000, "info")
            end
        end
    else
        notification(source, "Island Royale", "The island royale lobby already started or there is no active lobby.", 5000, "error")
    end
end, false)

RegisterCommand('stop-royale', function(source, args, rawCommand)
    local xPlayer = GETPFI(source)

    if not isPlayerStaffmember(xPlayer.getGroup(), Config.AdminGroup) then
        notification(source, "Systeem", "You are not an staffmember!", 5000, "error")
        return
    end

        if eventActive then
            eventActive = false
            eventStarted = false 

            for playerId, _ in pairs(eventPlayers) do
                local player = GETPFI(playerId)
                if player then
                    TriggerClientEvent('mdev-islandroyale:stopEvent', player.source, Config.RespawnCoords)

                    restorePlayerInventory(player)

                end
            end
            eventPlayers = {}

            notification(source, "Island Royale", "The Island royale has ended, thank you for participating.", 5000, "info")
        else
            notification(source, "Island Royale", "There is no island royale to stop...", 5000, "error")
        end
end, false)

RegisterNetEvent('mdev-islandroyale:playerDiedInEvent')
AddEventHandler('mdev-islandroyale:playerDiedInEvent', function()
    local xPlayer = GETPFI(source)
    local playerId = source

    if eventPlayers[playerId] then
        eventPlayers[playerId] = nil
        notification(playerId, "Island Royale", "You have died and your removed from the island royale", 5000, "info")

        TriggerClientEvent('mdev-islandroyale:stopEvent', playerId, Config.RespawnCoords)
        revivePlayer(source)

        restorePlayerInventory(xPlayer)

    end
end)

RegisterServerEvent('mdev-islandroyale:checkroyalestatus')
AddEventHandler('mdev-islandroyale:checkroyalestatus', function(targetId)
    local source = source
    local xPlayer = GETPFI(targetId)
    local playeridentifier = xPlayer.identifier
    if xPlayer then
        MySQL.Async.fetchScalar('SELECT COUNT(1) FROM mdev_islandroyale WHERE player_identifier = @playeridentifier', {
            ['@playeridentifier'] = playeridentifier
        }, function(count)
            if count > 0 then
                Citizen.Wait(2000)
                restorePlayerInventory(xPlayer)
            end
        end)
    end
end)