fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'Milo | M Development'
description 'M Development | Island royale script'
version '1.0.0'

client_scripts { 
	'framework/client-framework.lua',
	'client-utils.lua',
    'client/client.lua'
}

shared_scripts {
    'config.lua'
}

server_scripts { 
    -- If you don't have OxMySQL and you're using other mysql system uncomment the line below
--  '@mysql-async/lib/MySQL.lua',
	'@oxmysql/lib/MySQL.lua',
	'framework/server-framework.lua',
	'server-utils.lua',
    'server/server.lua'
}

dependencies {
    'ox_inventory'
}