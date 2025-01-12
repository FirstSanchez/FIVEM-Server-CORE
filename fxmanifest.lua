--[[
    Sanchez-Base
    Ein umfangreiches FiveM-Ressourcenpaket
]]

-- Metadata
fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'FirstSanchez#0'
description 'The Core of ESX made with Love 💖'
version '2.0.0'

-- Dependencies
server_scripts {
    '@mysql-async/lib/MySQL.lua',
    '@oxmysql/lib/MySQL.lua'
}
shared_script '@es_extended/imports.lua'

-- Exports
exports {
    'GetPlayers',
    'GeneratePlate'
}

-- Files & Data
files {
    -- Loadingscreen
    'loadingscreen/**/',
    -- Weapons
    'weapons/*.meta',
    -- Data Files
    'postals.json',
    'AllTattoos.json'
}

-- Data File Definitions
data_file 'WEAPONINFO_FILE_PATCH' 'weapons/*.meta'
postal_file 'postals.json'

-- Loadingscreen Configuration
loadscreen 'loadingscreen/index.html'
loadscreen_cursor 'yes'
loadscreen_manual_shutdown 'yes'

-- Shared Scripts
shared_scripts {
    -- Configurations
    'config/*.lua',
    'config.lua',
    -- SCRIPT_MERGES
    'SCRIPT_MERGES/door/config.lua',
    'SCRIPT_MERGES/trigger/config.lua'
}

-- Client Scripts
client_scripts {
    -- Core
    '@es_extended/locale.lua',
    'client/*.lua',
    'en.lua',
    'config.lua',
    
    -- Tattoo System
    'config/cf_tattoos.lua',
    'client/tattoos/jaymenu.lua',
    'client/tattoos/client.lua',
    
    -- ESX Integration
    'esx/skin/config.lua',
    'esx/skin/cl_main.lua',
    'esx/skinchanger/config.lua',
    'esx/skinchanger/cl_main.lua',
    
    -- SCRIPT_MERGES
    -- Vending Machine
    'SCRIPT_MERGES/vendingmachine/client/RageUI.lua',
    'SCRIPT_MERGES/vendingmachine/client/main.lua',
    'SCRIPT_MERGES/vendingmachine/client/machine/main.lua',
    'SCRIPT_MERGES/trigger/client.lua',
    
    -- IPL System
    -- Base
    'SCRIPT_MERGES/client/ipls/lib/common.lua',
    'SCRIPT_MERGES/client/ipls/lib/observers/interiorIdObserver.lua',
    'SCRIPT_MERGES/client/ipls/lib/observers/officeSafeDoorHandler.lua',
    'SCRIPT_MERGES/client/ipls/client.lua',
    
    -- GTA V IPLs
    'SCRIPT_MERGES/client/ipls/gtav/*.lua',
    
    -- GTA Online IPLs
    'SCRIPT_MERGES/client/ipls/gta_online/*.lua',
    
    -- DLC IPLs
    'SCRIPT_MERGES/client/ipls/dlc_high_life/*.lua',
    'SCRIPT_MERGES/client/ipls/dlc_heists/*.lua',
    'SCRIPT_MERGES/client/ipls/dlc_executive/*.lua',
    'SCRIPT_MERGES/client/ipls/dlc_finance/*.lua',
    'SCRIPT_MERGES/client/ipls/dlc_bikers/*.lua',
    'SCRIPT_MERGES/client/ipls/dlc_import/*.lua',
    'SCRIPT_MERGES/client/ipls/dlc_gunrunning/*.lua',
    'SCRIPT_MERGES/client/ipls/dlc_smuggler/*.lua',
    'SCRIPT_MERGES/client/ipls/dlc_doomsday/*.lua',
    'SCRIPT_MERGES/client/ipls/dlc_afterhours/*.lua',
    'SCRIPT_MERGES/client/ipls/dlc_casino/*.lua'
}

-- Server Scripts
server_scripts {
    -- Core
    '@es_extended/locale.lua',
    'server/*.lua',
    'clientcode/*.lua',
    'config.lua',
    'en.lua',
    'webhooks.lua',
    
    -- Tattoo System
    'server/sv_tattoos.lua',
    
    -- ESX Integration
    'esx/skin/config.lua',
    'esx/skin/sv_main.lua',
    
    -- Inventory Systems
    'server/addoninventory/addoninventory.lua',
    'server/addoninventory/sv_main.lua',
    'server/esx_addoninventory/classes/addoninventory.lua',
    'server/datastore/datastore.lua',
    'server/datastore/sv_main.lua',
    
    -- SCRIPT_MERGES
    -- TEBEX Integration
    'SCRIPT_MERGES/TEBEX/lua/server.lua',
    'SCRIPT_MERGES/TEBEX/lua/client/apiclient.lua',
    'SCRIPT_MERGES/TEBEX/lua/models/*.lua',
    'SCRIPT_MERGES/TEBEX/lua/commands/*.lua',
    'SCRIPT_MERGES/TEBEX/lua/startup.lua',
    
    -- Vending Machine
    'SCRIPT_MERGES/vendingmachine/server/main.lua',
    'SCRIPT_MERGES/vendingmachine/server/machine/main.lua',
    'SCRIPT_MERGES/trigger/server.lua'
}

-- Security
escrow_ignore {
    'config/*.lua',
    'config.lua'
}
shared_script {
    'SCRIPT_MERGES/door/config.lua',
    'SCRIPT_MERGES/trigger/config.lua',
}
-- SCRIPT_MERGES

-- //////////////////////////////




shared_scripts {
    'config/*.lua',
    'config.lua',
}

client_scripts {
	'@es_extended/locale.lua',
    'client/*.lua',
    'en.lua',
    'config.lua',
    -- Tatto
	'config/cf_tattoos.lua',
	'client/tattoos/jaymenu.lua', 
	'client/tattoos/client.lua',
    -- ESX
	'esx/skin/config.lua',
	'esx/skin/cl_main.lua',
	'esx/skinchanger/config.lua',
	'esx/skinchanger/cl_main.lua',
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'@es_extended/locale.lua',
    'server/*.lua',
    'clientcode/*.lua',
    'config.lua',
    'en.lua',
    -- Tattoo
    'server/sv_tattoos.lua', 
    -- ESX
    'esx/skin/config.lua',
    'esx/skin/sv_main.lua',
    -- AddonInventory
	'server/addoninventory/addoninventory.lua',
    'server/addoninventory/sv_main.lua',
    'server/esx_addoninventory/classes/addoninventory.lua',
    -- Datastore
	'server/datastore/datastore.lua',
    'server/datastore/sv_main.lua',
    -- Webhhoks
    'webhooks.lua',
}

escrow_ignore 'config/*.lua'
escrow_ignore 'config.lua'