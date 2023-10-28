Config_Blacklist = {}

Config_Blacklist.Weapons = {
    ["WEAPON_COMBATPISTOL"] = { "police", "army", "swat", "doj", "fib" },
    ["WEAPON_SPECIALCARBINE"] = { "police", "army", "swat", "doj", "fib" },
    ["WEAPON_NIGHTSTICK"] = { "police", "army", "swat", "doj", "fib" },
    ["WEAPON_STUNGUN"] = { "police", "army", "swat", "security", "doj", "fib" },
    ["WEAPON_SMG"] = { "police", "army", "swat", "doj", "fib" },
    ["WEAPON_COMBATPDW"] = { "police", "army", "swat", "doj", "fib" }, 
    ["WEAPON_PUMPSHOTGUN"] = { "police", "army", "swat", "doj", "fib" }, 
}

Config_Blacklist.Items = {
    ["clip2"] = { "police", "army", "swat", "doj", "fib" },
    ["kevlar2"] = { "police", "army", "swat", "doj", "fib" },
    ["medikit"] = { "ambulance", "army", "off_ambulance" }
}












-- interiorfix
-- Command: /interiorid
Ints = {
    Interiors = {
    SharedObjectEvent = 'esx:getSharedObject',
        ['mrpd'] = {
            id = 768001,
            loadRange = 80,
        },
        ['pillboxmd'] = {
            id = 129794,
            loadRange = 40,
        },
        ['7156'] = {
            id = 150530,
            loadRange = 30,
        },
        ['6070'] = {
            id = 150786,
            loadRange = 30,
        },
        ['prison'] = {
            id = 128258,
            loadRange = 30,
        },
        ['pizzeria'] = {
            id = 151298,
            loadRange = 30,
        },
        ['sheriff'] = {
            id = 152322,
            loadRange = 30,
        },
        ['malibu'] = {
            id = 299266,
            loadRange = 90,
        },
        ['malibuoben'] = {
            id = 299522,
            loadRange = 90,
        },
        ['hexeinreise'] = {
            id = 121858,
            loadRange = 30,
        },
        ['7112'] = {
            id = 127234,
            loadRange = 30,
        },
        ['71121'] = {
            id = 123906,
            loadRange = 30,
        },
        ['mechanic7204'] = {
            id = 126978,
            loadRange = 40,
        },
        ['hexlsia'] = {
            id = 121090,
            loadRange = 70,
        },
        ['pdm'] = {
            id = 123650,
            loadRange = 80,
        },
        ['5025gmbh'] = {
            id = 126978,
            loadRange = 50,
        },
        ['fib2'] = {
            id = 121858,
            loadRange = 50,
        },
        -- ['weinberg'] = {
        --     id = 121346,
        --     loadRange = 80,
        -- },
        ['tbar'] = {
            id = 233729,
            loadRange = 20,
        },
        ['senju'] = {
            id = 123394,
            loadRange = 50,
        },
        ['hotel'] = {
            id = 300290,
            loadRange = 70,
        },
        ['shisha'] = {
            id = 121858,
            loadRange = 90,
        },
        ['bennypdm'] = {
            id = 121602,
            loadRange = 80,
        },
        ['einszwei'] = {
            id = 120834,
            loadRange = 90,
        },
        ['bowling'] = {
            id = 514049,
            loadRange = 50,
        },
        ['cardealer'] = {
            id = 7170,
            loadRange = 40,
        },
        ['taxi'] = {
            id = 535297,
            loadRange = 70,
        },
        ['ammunation_main'] = {
            id = 137729,
            loadRange = 60,
        },
        ['stripclub'] = {
            id = 197121,
            loadRange = 40,
        },
        ['lsmd'] = {
            id = 525569,
            loadRange = 75,
        },
        ['shop1'] = {
            id = 196865,
            loadRange = 30,
        },
        ['cloth1'] = {
            id = 198145,
            loadRange = 40,
        },
        ['cloth2'] = { -- PD
            id = 137217,
            loadRange = 40,
        },
        ['bennys'] = {
            id = 196609,
            loadRange = 50,
        },
        ['polizeivpd'] = {
            id = 512513,
            loadRange = 80,
        },
        ['polizeivpd2'] = {
            id = 512769,
            loadRange = 80,
        },
        ['morgue'] = {
            id = 60418,
            loadRange = 50,
        },
        ['bank1'] = { -- Meetingpoint
            id = 137985,
            loadRange = 40,
        },
        ['casino_penthouse'] = {
            id = 274689,
            loadRange = 50,
        },
        ['mpapartment1'] = { -- Unter Meetingpoint
            id = 149761,
            loadRange = 15,
        },
        ['mpapartment2'] = { -- Unter Meetingpoint
            id = 148225,
            loadRange = 20,
        },
        ['house1'] = {
            id = 207361,
            loadRange = 20,
        },
        ['house2'] = {
            id = 207105,
            loadRange = 20,
        },
        ['apartment1'] = {
            id = 146689,
            loadRange = 20,
        },
        ['apartment2'] = {
            id = 145665,
            loadRange = 20,
        },
        ['storage1'] = {
            id = 235777,
            loadRange = 15,
        },
        ['motel'] = {
            id = 149505,
            loadRange = 10,
        },
        ['document_forgery'] = {
            id = 246785,
            loadRange = 15,
        },
        ['finbank'] = {
            id = 119042,
            loadRange = 200, -- muss so
        },
        ['motorclub1'] = {
            id = 246273,
            loadRange = 20,
        },
        ['motorclub2'] = {
            id = 246529,
            loadRange = 20,
        },
        ['minioffice'] = {
            id = 164865,
            loadRange = 40,
        },
        ['paradiseclub'] = {
            id = 271617,
            loadRange = 50,
        },
        ['yacht1'] = {
            id = 214785,
            loadRange = 40,
        },
        ['yacht2'] = {
            id = 282369,
            loadRange = 40,
        },
        ['yacht3'] = {
            id = 212225,
            loadRange = 40,
        },
        ['yacht4'] = {
            id = 209153,
            loadRange = 40,
        },
        ['yacht5'] = {
            id = 227073,
            loadRange = 40,
        },
        ['casino'] = {
            id = 297986,
            loadRange = 35,
        },
        ['casino_destroyed'] = {
            id = 278017,
            loadRange = 75,
        },
        ['club_2'] = {
            id = 281089,
            loadRange = 35,
        },
        ['madrazo_ranch'] = {
            id = 205825,
            loadRange = 15,
        },
        ['serverfarm'] = {
            id = 270337,
            loadRange = 20,
        },
        ['franklin'] = {
            id = 206849,
            loadRange = 40,
        },
        ['kfc'] = {
            id = 150530,
            loadRange = 80,
        },
        ['recording_studio'] = {
            id = 286977,
            loadRange = 30,
        },
        ['pub'] = {
            id = 235009,
            loadRange = 15,
        },
        ['airport'] = {
            id = 521729,
            loadRange = 150,
        },
        ['carmeet'] = {
            id = 285697,
            loadRange = 250,
        },
        ['bahamas'] = {
            id = 303874,
            loadRange = 40,
        },
        ['bahamasmain'] = {
            id = 304130,
            loadRange = 40,
        },
        ['lifeinvader'] = {
            id = 3330,
            loadRange = 100,
        },
        ['arena'] = { 
            id = 78338,
            loadRange = 30,
        },
        ['mainbank'] = { -- Staatsbank
            id = 139265,
            loadRange = 275,
        },
        ['tunergarages'] = { -- NOS
            id = 285953,
            loadRange = 20,
        },
        ['michael'] = { 
            id = 166657,
            loadRange = 30,
        },
        ['random_shop1'] = { 
            id = 167937,
            loadRange = 50,
        },
        ['random_shop2'] = { 
            id = 198401,
            loadRange = 40,
        },
        ['random_shop3'] = { 
            id = 171521,
            loadRange = 40,
        },
        ['random_shop4'] = { 
            id = 171009,
            loadRange = 40,
        },
        ['random_shop5'] = { 
            id = 198657,
            loadRange = 40,
        },
        ['random_shop6'] = { 
            id = 154113,
            loadRange = 40,
        },
        ['random_shop7'] = { 
            id = 168449,
            loadRange = 40,
        },
        ['random_shop8'] = { 
            id = 166657,
            loadRange = 40,
        },
        ['random_shop9'] = { 
            id = 165633,
            loadRange = 40,
        },
        ['random_shop10'] = { 
            id = 165377,
            loadRange = 40,
        },
        ['random_shop11'] = { 
            id = 235265,
            loadRange = 40,
        },
        ['random_shop12'] = { 
            id = 140801,
            loadRange = 40,
        },
        ['random_shop13'] = { 
            id = 141057,
            loadRange = 40,
        },
        ['random_shop14'] = { 
            id = 139777,
            loadRange = 40,
        },
        ['sherriff'] = { 
            id = 527873,
            loadRange = 70,
        },
        ['bayview'] = { 
            id = 721409,
            loadRange = 50,
        },
		['aztecasshop'] = {
			id = 200705,
			loadRange = 50,
		},
		['muelljob'] = {
			id = 114690,
			loadRange = 30,
		},		
		['fibunten'] = {
			id = 58882,
			loadRange = 40,
		},			
		['fiboben'] = {
			id = 135937,
			loadRange = 40,
		},			
		['fibdach'] = {
			id = 136449,
			loadRange = 20,
		},			
		['fibtreppenhaus'] = {
			id = 136705,
			loadRange = 20,
		},			
		['juwe'] = {
			id = 82690,
			loadRange = 30,
		},				
		['klamotten01'] = {
			id = 171265,
			loadRange = 40,
		},																				
		['bankpaleto'] = {
			id = 179969,
			loadRange = 40,
		},									
		['ammunationpaleto'] = {
			id = 180481,
			loadRange = 35,
		},									
		['kleidungsladenpaleto'] = {
			id = 179713,
			loadRange = 30,
		},									
		['frisuerpaleto'] = {
			id = 180225,
			loadRange = 30,
		},									
		['tattoopaleto'] = {
			id = 180737,
			loadRange = 30,
		},																		
		['cocainelab'] = {
			id = 247553,
			loadRange = 20,
		},	
        ['doj'] = {
			id = 309506,
			loadRange = 60,
		},										
		['geldwaesche'] = {
			id = 247809,
			loadRange = 30,
		},										
		['methlab'] = {
			id = 247041,
			loadRange = 20,
		},										
		['weedlab'] = {
			id = 247297,
			loadRange = 20,
		},										
		-- ['bunker1'] = {
			-- id = 258561,
			-- loadRange = 50,
		-- },											
		['yachtrandom'] = {
			id = 259073,
			loadRange = 40,
		},											
		['yachtrandom2'] = {
			id = 259329,
			loadRange = 40,
		},											
		['yachtrandom3'] = {
			id = 258817,
			loadRange = 40,
		},											
		['yachtrandom4'] = {
			id = 259841,
			loadRange = 40,
		},											
		['yachtrandom5'] = {
			id = 259585,
			loadRange = 40,
		},											
		['yachtraub1'] = {
			id = 174337,
			loadRange = 80,
		},											
		['yachtraub2'] = {
			id = 174593,
			loadRange = 80,
		},											
		['yachtraub3'] = {
			id = 174081,
			loadRange = 80,
		},											
		['yachtraub4'] = {
			id = 173569,
			loadRange = 80,
		},											
		['yachtraub5'] = {
			id = 173825,
			loadRange = 80,
		},																															
		['lesterfac'] = {
			id = 92674,
			loadRange = 20,
		},											
		['mrblack'] = {
			id = 153601,
			loadRange = 30,
		},																															
		['firestationgrove'] = {
			id = 198913,
			loadRange = 40,
		},												
		['hafenhalle1'] = {
			id = 156161,
			loadRange = 30,
		},																								
		['schmelze'] = {
			id = 250625,
			loadRange = 50,
		},													
		['schweinezucht'] = {
			id = 248321,
			loadRange = 80,
		},																																																																																				
		['bunker2'] = {
			id = 260353,
			loadRange = 100,
		},														
		['miene'] = {
			id = 202241,
			loadRange = 40,
		},																												
		['raumbuero1'] = {
			id = 255233,
			loadRange = 30,
		},																
		['garage02'] = {
			id = 254465,
			loadRange = 30,
		},																
		['garage03'] = {
			id = 254209,
			loadRange = 30,
		},																																																																														
		['apptzimmer3'] = {
			id = 146177,
			loadRange = 30,
		},																															
		['garage06'] = {
			id = 256769,
			loadRange = 30,
		},																
		['raumbosssec'] = {
			id = 257281,
			loadRange = 30,
		},																
		['appt001'] = {
			id = 145921,
			loadRange = 30,
		},																
		['appt002'] = {
			id = 255489,
			loadRange = 30,
		},																																	
		['wohnwagen'] = {
			id = 2562,
			loadRange = 30,
		},																	
		['humanlabs'] = {
			id = 184321,
			loadRange = 250,
		},																																																																																																																																																								
		['bunker3'] = {
			id = 269313,
			loadRange = 20,
		},																																				
		['iaabase'] = {
			id = 270081,
			loadRange = 150,
		}																																																																																													
    }
}