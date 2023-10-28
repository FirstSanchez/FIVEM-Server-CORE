fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'FirstSanchez#0'
description 'The Core of Limitless make with Love 💖'
version '2.0.0'

-- //////////////////////////////
server_scripts {'@mysql-async/lib/MySQL.lua'}
shared_script '@es_extended/imports.lua'
-- EXPORTS Weil muss sein^^
export 'GetPlayers'
export 'GeneratePlate'
-- EXPORTS Weil muss sein^^

-- Loadingscreen
loadscreen 'loadingscreen/index.html'
loadscreen_cursor 'yes'
loadscreen_manual_shutdown 'yes'
files  {
    'loadingscreen/index.html',
    'loadingscreen/assets/**/*',
    'loadingscreen/assets/**/**/*',
}
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
files {'fraksperren.json'}
-- Fraksperre

-- Tatto
files {'AllTattoos.json'}
-- Tatto

-- sanchez_cityhall
client_scripts{
    'SCRIPT_MERGES/sanchez_cityhall/client.lua',
    'SCRIPT_MERGES/sanchez_cityhall/config.lua',
    'SCRIPT_MERGES/elevator/config.lua',
    'SCRIPT_MERGES/elevator/client.lua',
    'SCRIPT_MERGES/vendingmachine/client/RageUI.lua',
    'SCRIPT_MERGES/vendingmachine/client/main.lua',
    'SCRIPT_MERGES/vendingmachine/client/machine/main.lua',
    'SCRIPT_MERGES/donatoranimals/files/client/RageUI.lua',
    'SCRIPT_MERGES/donatoranimals/files/client/c.lua',
}
server_scripts{
    'SCRIPT_MERGES/sanchez_cityhall/config.lua',
    'SCRIPT_MERGES/sanchez_cityhall/server.lua',
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
    'SCRIPT_MERGES/donatoranimals/customer.lua',
    'SCRIPT_MERGES/donatoranimals/files/server/s.lua',
}
-- sanchez_cityhall

-- Audio PACK MUUUCH
data_file 'WEAPONINFO_FILE_PATCH' 'weapons.meta'
data_file 'AUDIO_WAVEPACK' 'audio/sfx/resident'
data_file 'AUDIO_WAVEPACK' 'audio/sfx/weapons_player'
files  {
'audio/sfx/resident/ambience.awc',
'audio/sfx/resident/animals_footsteps.awc',
'audio/sfx/resident/collision.awc',
'audio/sfx/resident/collisions.awc',
'audio/sfx/resident/doors.awc',
'audio/sfx/resident/explosions.awc',
'audio/sfx/resident/feet_materials.awc',
'audio/sfx/resident/feet_resident.awc',
'audio/sfx/resident/frontend.awc',
'audio/sfx/resident/low_latency.awc',
'audio/sfx/resident/melee.awc',
'audio/sfx/resident/movement.awc',
'audio/sfx/resident/player_switch.awc',
'audio/sfx/resident/vehicles.awc',
'audio/sfx/resident/weapons.awc',
'audio/sfx/resident/weather.awc',
'audio/sfx/weapons_player/lmg_combat.awc',
'audio/sfx/weapons_player/lmg_mg_player.awc',
'audio/sfx/weapons_player/mgn_sml_am83_vera.awc',
'audio/sfx/weapons_player/mgn_sml_am83_verb.awc',
'audio/sfx/weapons_player/mgn_sml_sc__l.awc',
'audio/sfx/weapons_player/ptl_50cal.awc',
'audio/sfx/weapons_player/ptl_50cal.oac',
'audio/sfx/weapons_player/ptl_combat.awc',
'audio/sfx/weapons_player/ptl_pistol.awc',
'audio/sfx/weapons_player/ptl_px4.awc',
'audio/sfx/weapons_player/ptl_rubber.awc',
'audio/sfx/weapons_player/sht_bullpup.awc',
'audio/sfx/weapons_player/sht_pump.awc',
'audio/sfx/weapons_player/smg_micro.awc',
'audio/sfx/weapons_player/smg_smg.awc',
'audio/sfx/weapons_player/snp_heavy.awc',
'audio/sfx/weapons_player/snp_rifle.awc',
'audio/sfx/weapons_player/spl_grenade_player.awc',
'audio/sfx/weapons_player/spl_minigun_player.awc',
'audio/sfx/weapons_player/spl_prog_ar_player.awc',
'audio/sfx/weapons_player/spl_railgun.awc',
'audio/sfx/weapons_player/spl_rpg_player.awc',
'audio/sfx/weapons_player/spl_tank_player.awc',
}
-- Audio PACK MUUUCH

-- //////////////////////////////






shared_scripts {
    'config/*.lua',
    'config.lua',
    -- Locks
    'config/cf_locks.lua',

}

client_scripts {
	'@es_extended/locale.lua',
    'client/*.lua',
    'en.lua',
    'config.lua',
    -- LOCKS
    'client/locks/main.lua',
    'client/locks/globals.lua',
    'client/locks/editor/menus.lua',
    'client/locks/editor/main.lua',
    'client/locks/helpers/Table.lua',
    'client/locks/helpers/Scaleforms.lua',
    'client/locks/helpers/Raycast.lua',
    'client/locks/helpers/Locks.lua',
    'client/locks/helpers/Bounding.lua',
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
    -- Locks
    'server/locks/main.lua',
    'server/locks/globals.lua',
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
}