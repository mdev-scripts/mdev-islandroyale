Core = nil

if Config['Framework']:upper() == 'ESX' then

    Core = exports['es_extended']:getSharedObject()

    RESCB = Core.RegisterServerCallback
    GETPFI = Core.GetPlayerFromId
    RUI = Core.RegisterUsableItem

    function GetPlayersFunction()
        return Core.GetPlayers()
    end

    function AddMoneyFunction(source, amount)
        local xPlayer = GETPFI(source)
        xPlayer.addAccountMoney('money', amount)
    end

    function GetPlayerJobFunction(source)
        local xPlayer = GETPFI(source)
        PlayerJob = xPlayer.job.name
        return PlayerJob
    end

    function GetItemCount(source, item)
        local xPlayer = GETPFI(source)
        return xPlayer.getInventoryItem(item).count
    end

    function AddItem(source, item, count)
        local xPlayer = GETPFI(source)
        xPlayer.addInventoryItem(item, count)
    end

    function RemoveItem(source, item, amount)
        local xPlayer = GETPFI(source)
        xPlayer.removeInventoryItem(item, amount)
    end

    function GetIdentifierFunction(source)
        local xPlayer = GETPFI(source)
        return xPlayer.identifier
    end

elseif Config['Framework']:upper() == 'QBCORE' then

    Core = exports['qb-core']:GetCoreObject()
    
    RESCB = Core.Functions.CreateCallback
    GETPFI = Core.Functions.GetPlayer
    RUI = Core.Functions.CreateUseableItem

    function GetPlayersFunction()
        return Core.Functions.GetPlayers()
    end

    function AddMoneyFunction(source, amount)
        local xPlayer = GETPFI(source)
        xPlayer.Functions.AddMoney('cash', amount)
    end

    function GetPlayerJobFunction(source)
        local xPlayer = GETPFI(source)
        PlayerJob = xPlayer.PlayerData.job.name
        return PlayerJob
    end

    function GetItemCount(source, item)
        local xPlayer = GETPFI(source)

        local items = xPlayer.Functions.GetItemByName(item)
        local item_count = 0
        if items ~= nil then
            item_count = items.amount
        else
            item_count = 0
        end
        return item_count
    end

    function AddItem(source, item, count)
        local xPlayer = GETPFI(source)
        xPlayer.Functions.AddItem(item, count)
    end

    function RemoveItem(source, item, amount)
        local xPlayer = GETPFI(source)
        xPlayer.Functions.RemoveItem(item, amount)
    end

    function GetIdentifierFunction(source)
        local xPlayer = GETPFI(source)
        return xPlayer.PlayerData.citizenid
    end
    
end