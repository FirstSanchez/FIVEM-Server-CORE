--[[
    Sanchez-Base
    Ein umfangreiches FiveM-Ressourcenpaket
]]
fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'FirstSanchez#0'
description 'The Core of HotLife make with Love 💖'
version '2.0.0'

-- //////////////////////////////
server_scripts {'@mysql-async/lib/MySQL.lua'}
shared_script '@es_extended/imports.lua'
-- EXPORTS Weil muss sein^^
export 'GetPlayers'
export 'GeneratePlate'
-- EXPORTS Weil muss sein^^

-- Loadingscreen
files {
    'loadingscreen/**/',
}
loadscreen 'loadingscreen/index.html'
loadscreen_cursor 'yes'
loadscreen_manual_shutdown "yes"
-- Loadingscreen

-- Wafffensync
data_file "WEAPONINFO_FILE_PATCH" "weapons/*.meta"
files {
    'weapons/*.meta'
}
-- Wafffensync

-- PLZ COMMAND
file 'postals.json'
postal_file 'postals.json'
-- PLZ COMMAND

-- Fraksperre
-- files {'fraksperren.json'}
-- Fraksperre

-- Tatto
files {'AllTattoos.json'}
-- Tatto


-- SCRIPT_MERGES
client_scripts {
    'SCRIPT_MERGES/vendingmachine/client/RageUI.lua',
    'SCRIPT_MERGES/vendingmachine/client/main.lua',
    'SCRIPT_MERGES/vendingmachine/client/machine/main.lua',
    'SCRIPT_MERGES/trigger/client.lua',
    -- IPL MERGE
    "SCRIPT_MERGES/client/ipls/lib/common.lua",
	"SCRIPT_MERGES/client/ipls/lib/observers/interiorIdObserver.lua",
	"SCRIPT_MERGES/client/ipls/lib/observers/officeSafeDoorHandler.lua",
	"SCRIPT_MERGES/client/ipls/client.lua",
	-- GTA V
	"SCRIPT_MERGES/client/ipls/gtav/base.lua",
	"SCRIPT_MERGES/client/ipls/gtav/ammunations.lua",
	"SCRIPT_MERGES/client/ipls/gtav/bahama.lua",
	"SCRIPT_MERGES/client/ipls/gtav/floyd.lua",
	"SCRIPT_MERGES/client/ipls/gtav/franklin.lua",
	"SCRIPT_MERGES/client/ipls/gtav/franklin_aunt.lua",
	"SCRIPT_MERGES/client/ipls/gtav/graffitis.lua",
	"SCRIPT_MERGES/client/ipls/gtav/pillbox_hospital.lua",
	"SCRIPT_MERGES/client/ipls/gtav/lester_factory.lua",
	"SCRIPT_MERGES/client/ipls/gtav/michael.lua",
	"SCRIPT_MERGES/client/ipls/gtav/north_yankton.lua",
	"SCRIPT_MERGES/client/ipls/gtav/red_carpet.lua",
	"SCRIPT_MERGES/client/ipls/gtav/simeon.lua",
	"SCRIPT_MERGES/client/ipls/gtav/stripclub.lua",
	"SCRIPT_MERGES/client/ipls/gtav/trevors_trailer.lua",
	"SCRIPT_MERGES/client/ipls/gtav/ufo.lua",
	"SCRIPT_MERGES/client/ipls/gtav/zancudo_gates.lua",
	-- GTA Online
	"SCRIPT_MERGES/client/ipls/gta_online/apartment_hi_1.lua",
	"SCRIPT_MERGES/client/ipls/gta_online/apartment_hi_2.lua",
	"SCRIPT_MERGES/client/ipls/gta_online/house_hi_1.lua",
	"SCRIPT_MERGES/client/ipls/gta_online/house_hi_2.lua",
	"SCRIPT_MERGES/client/ipls/gta_online/house_hi_3.lua",
	"SCRIPT_MERGES/client/ipls/gta_online/house_hi_4.lua",
	"SCRIPT_MERGES/client/ipls/gta_online/house_hi_5.lua",
	"SCRIPT_MERGES/client/ipls/gta_online/house_hi_6.lua",
	"SCRIPT_MERGES/client/ipls/gta_online/house_hi_7.lua",
	"SCRIPT_MERGES/client/ipls/gta_online/house_hi_8.lua",
	"SCRIPT_MERGES/client/ipls/gta_online/house_mid_1.lua",
	"SCRIPT_MERGES/client/ipls/gta_online/house_low_1.lua",
	-- DLC High Life
	"SCRIPT_MERGES/client/ipls/dlc_high_life/apartment1.lua",
	"SCRIPT_MERGES/client/ipls/dlc_high_life/apartment2.lua",
	"SCRIPT_MERGES/client/ipls/dlc_high_life/apartment3.lua",
	"SCRIPT_MERGES/client/ipls/dlc_high_life/apartment4.lua",
	"SCRIPT_MERGES/client/ipls/dlc_high_life/apartment5.lua",
	"SCRIPT_MERGES/client/ipls/dlc_high_life/apartment6.lua",
	-- DLC Heists
	"SCRIPT_MERGES/client/ipls/dlc_heists/carrier.lua",
	"SCRIPT_MERGES/client/ipls/dlc_heists/yacht.lua",
	-- DLC Executives & Other Criminals
	"SCRIPT_MERGES/client/ipls/dlc_executive/apartment1.lua",
	"SCRIPT_MERGES/client/ipls/dlc_executive/apartment2.lua",
	"SCRIPT_MERGES/client/ipls/dlc_executive/apartment3.lua",
	-- DLC Finance & Felony
	"SCRIPT_MERGES/client/ipls/dlc_finance/office1.lua",
	"SCRIPT_MERGES/client/ipls/dlc_finance/office2.lua",
	"SCRIPT_MERGES/client/ipls/dlc_finance/office3.lua",
	"SCRIPT_MERGES/client/ipls/dlc_finance/office4.lua",
	"SCRIPT_MERGES/client/ipls/dlc_finance/organization.lua",
	-- DLC Bikers
	"SCRIPT_MERGES/client/ipls/dlc_bikers/cocaine.lua",
	"SCRIPT_MERGES/client/ipls/dlc_bikers/counterfeit_cash.lua",
	"SCRIPT_MERGES/client/ipls/dlc_bikers/document_forgery.lua",
	"SCRIPT_MERGES/client/ipls/dlc_bikers/meth.lua",
	"SCRIPT_MERGES/client/ipls/dlc_bikers/weed.lua",
	"SCRIPT_MERGES/client/ipls/dlc_bikers/clubhouse1.lua",
	"SCRIPT_MERGES/client/ipls/dlc_bikers/clubhouse2.lua",
	"SCRIPT_MERGES/client/ipls/dlc_bikers/gang.lua",
	-- DLC Import/Export
	"SCRIPT_MERGES/client/ipls/dlc_import/garage1.lua",
	"SCRIPT_MERGES/client/ipls/dlc_import/garage2.lua",
	"SCRIPT_MERGES/client/ipls/dlc_import/garage3.lua",
	"SCRIPT_MERGES/client/ipls/dlc_import/garage4.lua",
	"SCRIPT_MERGES/client/ipls/dlc_import/vehicle_warehouse.lua",
	-- DLC Gunrunning
	"SCRIPT_MERGES/client/ipls/dlc_gunrunning/bunkers.lua",
	"SCRIPT_MERGES/client/ipls/dlc_gunrunning/yacht.lua",
	-- DLC Smuggler's Run
	"SCRIPT_MERGES/client/ipls/dlc_smuggler/hangar.lua",
	-- DLC Doomsday Heist
	"SCRIPT_MERGES/client/ipls/dlc_doomsday/facility.lua",
	-- DLC After Hours
	"SCRIPT_MERGES/client/ipls/dlc_afterhours/nightclubs.lua",
	-- DLC Diamond Casino (Requires forced build 2060 or higher)
	"SCRIPT_MERGES/client/ipls/dlc_casino/casino.lua",
	"SCRIPT_MERGES/client/ipls/dlc_casino/penthouse.lua"
}

server_scripts {
    'SCRIPT_MERGES/TEBEX/lua/server.lua',
    'SCRIPT_MERGES/TEBEX/lua/client/apiclient.lua',
    'SCRIPT_MERGES/TEBEX/lua/models/config.lua',
    'SCRIPT_MERGES/TEBEX/lua/commands/secret.lua',
    'SCRIPT_MERGES/TEBEX/lua/commands/info.lua',
    'SCRIPT_MERGES/TEBEX/lua/commands/forcecheck.lua',
    'SCRIPT_MERGES/TEBEX/lua/models/information.lua',
    'SCRIPT_MERGES/TEBEX/lua/models/commandrunner.lua',
    'SCRIPT_MERGES/TEBEX/lua/models/buycommand.lua',
    'SCRIPT_MERGES/TEBEX/lua/startup.lua',
    'SCRIPT_MERGES/vendingmachine/server/main.lua',
    'SCRIPT_MERGES/vendingmachine/server/machine/main.lua',
    'SCRIPT_MERGES/trigger/server.lua',
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