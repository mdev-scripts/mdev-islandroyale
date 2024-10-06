--[[
                                                                                                                 
  __  __   ____                 _                                  _   
 |  \/  | |  _ \  _____   _____| | ___  _ __  _ __ ___   ___ _ __ | |_ 
 | |\/| | | | | |/ _ \ \ / / _ \ |/ _ \| '_ \| '_ ` _ \ / _ \ '_ \| __|
 | |  | | | |_| |  __/\ V /  __/ | (_) | |_) | | | | | |  __/ | | | |_ 
 |_|  |_| |____/ \___| \_/ \___|_|\___/| .__/|_| |_| |_|\___|_| |_|\__|
                                       |_|    

                     https://m-development.tebex.io/
                  https://m-development-1.gitbook.io/docs
                                                                                                           
]]

Config = {}
Config.Framework = 'ESX'                                               -- Choose the framework you are using esx/qbcore
Config.AdminGroup = {"mod", "admin", "management", "beheer"}           -- Allowed groups for admin commands
Config.EventCoords = vector4(4427.5718, -4497.6235, 4.2085, 187.3014)  -- Coords were you should be spawned (lobby) after using /join-royale command
Config.RespawnCoords = vector4(162.7198, -1006.0343, 29.4122, 17.5011) -- Coords were you will be wapred to after dying

Config.SpawnCoords = {                                                 -- possible spawncoords for you players that are in the event
  {4733.4214, -4607.1396, 11.0036, 264.1593},
  {5194.6309, -4617.9492, 7.3885, 253.0921},
  {5060.2534, -4846.6118, 18.7544, 12.1768},
  {5346.6768, -5216.3271, 31.1856, 208.5037},
  {5546.5708, -5371.6743, 25.3942, 226.5594},
  {5246.8711, -5415.6768, 65.2653, 89.9686},
  {5346.0898, -5628.0059, 61.9837, 205.6969},
  {5365.8950, -5846.1333, 25.7095, 188.9473},
  {5596.1289, -5659.2480, 12.8397, 289.0010}
}

Config.RandomItems = {                                                   -- random items that the players will recieve whem the event is started
  {item = "gps", amount = "1", chance = "100"},
  {item = "bread", amount = "5", chance = "100"},
  {item = "water", amount = "5", chance = "100"},
  {item = "bandage", amount = "3", chance = "50"},
}                                                                        -- add more items to your liking on the same way | {item = "example", amount = "example", chance = "example"}, 

Config.RandomWeapons = {                                                 -- random weapons that the players will recieve whem the event is started
  {weapon = "weapon_heavypistol", ammo = "pistol_ammo", amount = "100"}, 
  {weapon = "weapon_pistol", ammo = "pistol_ammo", amount = "100"}, 
  {weapon = "weapon_minismg", ammo = "smg_ammo", amount = "135"}, 
  {weapon = "weapon_microsmg", ammo = "smg_ammo", amount = "120"}, 
  {weapon = "weapon_assaultsmg", ammo = "smg_ammo", amount = "150"}, 
  {weapon = "weapon_assaultrifle", ammo = "rifle_ammo", amount = "150"}
}                                                                        -- add more weapons to you liking on the same way | {weapon = "example", ammo = "example", amount = "example"}, 
