Core = nil

if Config['Framework']:upper() == 'ESX' then
    
    Core = exports['es_extended']:getSharedObject()
    TSCB = Core.TriggerServerCallback

    function GPDA()
        return Core.GetPlayerData()
    end

    function GPDJ() 
        return Core.GetPlayerData().job
    end

elseif Config['Framework']:upper() == 'QBCORE' then

    Core = exports['qb-core']:GetCoreObject()
    TSCB = Core.Functions.TriggerCallback

    function GPDA()
        return Core.Functions.GetPlayerData()
    end

    function GPDJ() 
        return Core.Functions.GetPlayerData().job
    end

end