CfG_Sitdown = {}

CfG_Sitdown.Debugmode = false -- General debugging, shows what seats/beds you can sit/lay on and the direction you will be facing, also enables debugging commands.
CfG_Sitdown.DebugPoly = false -- This is not advised unless you have set your PolyZone script set to only render polys nearby
CfG_Sitdown.UseNativeNotifiactions = true
CfG_Sitdown.TeleportToLastPosWhenNoRoute = false

CfG_Sitdown.AlwaysTeleportToSeat = false
CfG_Sitdown.AlwaysTeleportOutOfSeat = false
CfG_Sitdown.MaxInteractionDist = 1.8
CfG_Sitdown.MaxPromptDist = 1.4
CfG_Sitdown.MaxTilt = 20.0

CfG_Sitdown.DefaultKeybinds = {
    GetUp = {
        Keyboard = 'E',
        PadAnalog = 'RRIGHT_INDEX'
    },

    SitDown = {
        SitKeyboard = 'E',
        LayKeyboard = 'L',
        SitPadAnalog = 'LLEFT_INDEX',
        LayPadAnalog = 'LRIGHT_INDEX'
    }
}

CfG_Sitdown.AddChatSuggestions = false

CfG_Sitdown.UsePrompts = true
CfG_Sitdown.ReduceStress = false
CfG_Sitdown.Target = false

CfG_Sitdown.UseTargetingCoords = false

CfG_Sitdown.Targeting = {
    SitIcon = "fas fa-chair",
    LayIcon = "fas fa-bed",
    SitLabel = "Sit Down",
    LayLabel = "Lay Down",
}

CfG_Sitdown.Lang = {
    Notification = {
        OccupiedSit = "Dieser Platz ist bereits besetzt!",
        OccupiedLay = "Sie können sich hier nicht hinlegen!",
        NoAvailable = "Es ist kein Sitzplatz verfügbar!",
        NoFound = "Es wurden keine Sitzplätze gefunden!",
        NoBedFound = "Es wurde kein Sitzplatz gefunden!",
        TooTilted = "Dieser Sitz ist zu schief!",
        CannotReachSeat = "Sie können diesen Sitz nicht erreichen!",
        CannotSitInSeat = "Sie können nicht auf diesem Sitz sitzen!",
        CannotReachBed = "Du kannst dieses Bett/diese Bank nicht erreichen!",
        AlreadyAttemptingToSit = "Du versuchst bereits, dich zu setzen!",
        AlreadyAttemptingToLay = "Du versuchst bereits, dich hinzulegen!"
    },

    ChatSuggestions = {
        Sit = "Sit down on the closest seat",
        Lay = "Lay down on the closest bed/bench"
    },

    KeyMapping = {
        SitDown = "Drücke F um dich zu setzen",
        LayDown = "Drücke L um dich hinzulegen",
        GetUp = "Drücke %s um aufzustehen"
    },

    KeyBindingDesc = {
        Keyboard = {
            SitDown = "Sit - Sit Down On Seat",
            LayDown = "Sit - Lay Down On Bed/Bench",
            GetUp = "Sit - Get Up From Seat/Bed"
        },
        PadAnalog = {
            SitDown = "Sit - Sit Down On Seat - Controller",
            LayDown = "Sit - Lay Down On Bed/Bench - Controller",
            GetUp = "Sit - Get Up From Seat/Bed - Controller"
        }
    }
}

CfG_Sitdown.SitTypes = {
    ['default'] = {
        skipGoStraightTask = false,
        teleportIn = false,
        teleportOut = false,
        timeout = 8,
        scenarios = { 
            [1] = { name = "PROP_HUMAN_SEAT_CHAIR_MP_PLAYER", offset = vector4(0.0, 0.0, 0.0, 0.0) }
        }
        -- animation = { dict = "timetable@jimmy@mics3_ig_15@", name = "idle_a_jimmy", offset = vector4(0.0, 0.0, 0.0, 0.0), flag = 1 }
    },
    ['chair'] = { 
        scenarios = { 
            [1] = { name = "PROP_HUMAN_SEAT_CHAIR_MP_PLAYER" }
        }
    },
    ['chair2'] = { 
        scenarios = { 
            [1] = { name = "PROP_HUMAN_SEAT_CHAIR_MP_PLAYER" },
            [2] = { name = "PROP_HUMAN_SEAT_ARMCHAIR", offset = vector4(0.0, 0.05, 0.0, 0.0) }
        }
    },
    ['chair3'] = { 
        scenarios = { 
            [1] = { name = "PROP_HUMAN_SEAT_CHAIR_MP_PLAYER" },
            [2] = { name = "PROP_HUMAN_SEAT_ARMCHAIR", offset = vector4(0.0, 0.05, 0.0, 0.0) },
            [3] = { name = "PROP_HUMAN_SEAT_DECKCHAIR" } 
        }
    },
    ['barstool'] = { 
        teleportIn = true,
        scenarios = { 
            [1] = { name = "PROP_HUMAN_SEAT_BAR" }
        }
    },
    ['stool'] = { 
        teleportIn = true,
        scenarios = { 
            [1] = { name = "PROP_HUMAN_SEAT_CHAIR_MP_PLAYER" }
        },
    },
    ['deck'] = { 
        scenarios = { 
            [1] = { name = "PROP_HUMAN_SEAT_DECKCHAIR" }
        }
    },
    ['sunlounger'] = { 
        skipGoStraightTask = true,
        timeout = 12,
        scenarios = { 
            [1] = { name = "PROP_HUMAN_SEAT_SUNLOUNGER" }
        }
    },
    ['tattoo'] = {
        animation = { dict = "misstattoo_parlour@shop_ig_4", name = "customer_loop", offset = vector4(0.0, 0.0, -0.75, 0.0) }
    },
    ['strip_watch'] = {
        scenarios = { 
            [1] = { name = "PROP_HUMAN_SEAT_STRIP_WATCH" }
        }
    },
    ['diner_booth'] = {
        teleportIn = true,
        teleportOut = true,
        scenarios = { 
            [1] = { name = "PROP_HUMAN_SEAT_CHAIR_MP_PLAYER" }
        }
    },
    ['laysit'] = {
        animation = { dict = "timetable@jimmy@mics3_ig_15@", name = "idle_a_jimmy", offset = vector4(0.0, 0.0, 0.0, 0.0) }
    },
    ['wall'] = {
        scenarios = { 
            [1] = { name = "WORLD_HUMAN_SEAT_WALL" }
        }
    },
    ['steps'] = {
        scenarios = { 
            [1] = { name = "WORLD_HUMAN_SEAT_STEPS" }
        }
    },
    ['ledge'] = {
        scenarios = { 
            [1] = { name = "WORLD_HUMAN_SEAT_LEDGE" }
        }
    },
    ['director'] = {
        animation = { dict = "misscarsteal4@director_grip", name = "beginning_loop_director", offset = vector4(0.0, 0.0, -1.16, 0.0) },
        teleportOut = true
    },
}

-- The diffrent laying settings, don't touch unless you know what you are doing.
CfG_Sitdown.LayTypes = {
    ['default'] = { -- Default settings, if non has been spesified
        animation = { dict = "misslamar1dead_body", name = "dead_idle" },
        exitAnimType = 0, -- 0 = relative to camera | 1 = to the right | 2 = to the left
        exitAnim = true
    },
    ['bed'] = { 
        animation = { dict = "misslamar1dead_body", name = "dead_idle" }
    },
    ['lay'] = { 
        animation = { dict = "savecouch@", name = "t_sleep_loop_couch", offset = vector4(-0.1, 0.1, -0.5, 270.0) }
    },
    ['layside'] = { 
        animation = { dict = "savecouch@", name = "t_sleep_loop_couch", offset = vector4(-0.1, 0.1, -0.5, 270.0) },
        exitAnimType = 2
    },
    ['layside_reverse'] = { 
        animation = { dict = "savecouch@", name = "t_sleep_loop_couch", offset = vector4(0.1, 0.1, -0.5, 90.0) },
        exitAnimType = 1
    },
    ['busstop'] = { 
        animation = { dict = "savecouch@", name = "t_sleep_loop_couch", offset = vector4(0.0, 0.0, -0.5, 270.0) }
    },
    ['medical'] = { 
        animation = { dict = "anim@gangops@morgue@table@", name = "body_search" }
    },
    ['tattoo'] = { 
        animation = { dict = "amb@world_human_sunbathe@male@front@base", name = "base", offset = vector4(0.0, 0.0, 0.0, 180.0) },
        exitAnim = false
    }
}

CfG_Sitdown.PresetLocations = {
    -- Vanilla Interiors
    coroner = true,
    lscustoms = false,
    mrpd = false,
    pacific_standard = false,
    paleto_bank = false,
    paleto_so = false,
    pdm = false,
    sandy_so = false,
    tattoo_shops = true,
    tequilala = true,
    trevors_trailer = true,
    vanilla_unicorn = false,

    -- Gabz Team
    gabz_catcafe = true,
    gabz_diner = true, -- Pop's Dinner
    gabz_firedept = true, -- El Burro & Davis
    gabz_harmony = true,
    gabz_haters = true,
    gabz_hayes = true,
    gabz_import = true,
    gabz_lamesa_pd = true,
    gabz_lscustoms = true, 
    gabz_mrpd = true,
    gabz_ottos = true,
    gabz_pacific_standard_old = false,
    gabz_paleto_bank = true,
    gabz_paleto_so = true,
    gabz_park_ranger = true,
    gabz_pdm = true,
    gabz_pillbox = true,
    gabz_pizzeria = true,
    gabz_prison = true,
    gabz_records = true, -- Records A Studios
    gabz_sandy_so = true,
    gabz_townhall = true,
    gabz_tuners = true,
    gabz_vanilla_unicorn = true,

    ledge = true,
    steps = true,
    wall = true,
}

local isAktiiiv = false
RegisterCommand('propgun', function()
    if not isAktiiiv then
        print('Aktiv')
        isAktiiiv = true
    else
        print('Aktiv2')
        isAktiiiv = false
    end
end)

CreateThread(function()
    while true do
        Wait(0)
        if isAktiiiv then
            for _, prop in pairs(GetGamePool('CObject')) do
                if IsPlayerFreeAimingAtEntity(PlayerId(), prop) then
                    print('Prop: '..GetEntityModel(prop)..' Coords: '..GetEntityCoords(prop))
                end
            end
        else
            Wait(1000)
        end
    end
end)



local Models = {
    ------------------
    -- Vanila Props --
    ------------------

    -- 1211
    [1127420746] = { sit = { type = 'chair', seats = {[1] = vector4(0.0, 0.05, 0.5, 180.0)} } }, -- vw_prop_vw_offchair_02
    [-1318288271] = { sit = { type = 'chair', seats = {[1] = vector4(0.0, 0.05, 0.05, 180.0)} } }, -- nikki_chair
    [-274707376] = { sit = { type = 'chair2', seats = {[1] = vector4(0.0, 0.05, 0.05, 180.0)} } }, -- v_corp_bk_chair2
    [-523951410] = { sit = { type = 'chair', seats = {[1] = vector4(0.0, 0.05, 0.05, 180.0)} } }, -- v_ret_chair
    [937222680] = { sit = { type = 'chair', seats = {[1] = vector4(0.0, 0.05, 0.05, 180.0)} } }, -- v_res_tre_stool

    [-660611255] = { lay = { type = 'layside', seats = {[1] = vector4(0.0, 0.25, 0.15, 260.0)} } }, -- sgb_barcellona
    [1384445033] = { sit = { type = 'chair', teleportIn = true, seats = {[1] = vector4(1.2, 0.0, -1.05, 90.0), [2] = vector4(-1.2, 0.0, -1.05, 270.0)} } }, -- bunganikkivip
    
    [682082323] = { sit = { type = 'chair', seats = {[1] = vector4(0.0, 0.05, 0.05, 180.0)} } }, -- apa_mp_h_yacht_barstool_01 -- not worky

	-- Chairs --
    [826023884] = { sit = { type = 'chair2', seats = {[1] = vector4(0.0, 0.0, 0.5, 180.0)} } }, -- prop_chair_06
    [1037469683] = { sit = { type = 'chair2', seats = {[1] = vector4(0.0, 0.05, 0.4, 180.0)} } }, -- prop_off_chair_05
    [2040839490] = { sit = { type = 'chair2', seats = {[1] = vector4(0.0, 0.0, 0.0, 180.0)} } }, -- v_ret_gc_chair02
    [867556671] = { sit = { type = 'chair', seats = {[1] = vector4(0.0, 0.0, 0.5, 180.0)} } }, -- v_club_officechair
    [2064599526] = { sit = { type = 'chair2', seats = {[1] = vector4(0.0, 0.05, 0.5, 180.0)} } }, -- prop_chair_04a
    [-741944541] = { sit = { type = 'chair2', seats = {[1] = vector4(0.0, 0.1, 0.5, 180.0)} } }, -- prop_table_03_chr
    [-171943901] = { sit = { type = 'chair2', seats = {[1] = vector4(0.0, 0.1, 0.0, 180.0)} } }, -- v_serv_ct_chair02
    [607684038] = { sit = { type = 'chair2', seats = {[1] = vector4(0.0, 0.0, 0.35, 180.0)} } }, -- v_ret_fh_chair01
    [-109356459] = { sit = { type = 'chair2', seats = {[1] = vector4(0.0, 0.05, 0.5, 180.0)} } }, -- v_corp_offchair
    [146905321] = { sit = { type = 'chair2', seats = {[1] = vector4(0.0, 0.0, 0.5, 180.0)} } }, -- prop_table_03b_chr
    [-1761659350] = { sit = { type = 'chair2', seats = {[1] = vector4(0.0, 0.05, 0.5, 180.0)} } }, -- prop_table_02_chr
    [1404176808] = { sit = { type = 'chair2', seats = {[1] = vector4(0.0, 0.0, 0.5, 180.0)} } }, -- prop_table_04_chr
    [-1521264200] = { sit = { type = 'chair2', seats = {[1] = vector4(0.0, 0.1, 0.0, 180.0)} } }, -- prop_table_01_chr_a
    [-1173315865] = { sit = { type = 'chair2', seats = {[1] = vector4(0.0, 0.0, 0.5, 180.0)} } }, -- p_clb_officechair_s
    [764848282] = { sit = { type = 'chair2', seats = {[1] = vector4(0.0, -0.025, 0.5, 180.0)} } }, -- prop_chair_01b
    [96868307] = { sit = { type = 'chair2', seats = {[1] = vector4(0.0, 0.1, 0.5, 180.0)} } }, -- prop_off_chair_03
    [1918586980] = { sit = { type = 'chair2', seats = {[1] = vector4(0.0, 0.0, 0.5, 180.0)} } }, -- v_res_mbchair
    [-1235256368] = { sit = { type = 'chair2', seats = {[1] = vector4(0.0, 0.0, 0.0, 270.0)} } }, -- prop_table_01_chr_b
    [1071807406] = { sit = { type = 'chair2', seats = {[1] = vector4(0.0, 0.025, 0.06, 180.0)} } }, -- prop_skid_chair_02
    [-1108904010] = { sit = { type = 'chair2', seats = {[1] = vector4(0.0, 0.025, 0.06, 180.0)} } }, -- prop_skid_chair_03
    [291348133] = { sit = { type = 'chair2', seats = {[1] = vector4(0.0, 0.025, 0.06, 180.0)} } }, -- prop_skid_chair_01
    [-1118419705] = { sit = { type = 'chair2', seats = {[1] = vector4(0.0, 0.10, 0.5, 180.0)} } }, -- prop_cs_office_chair
    [538002882] = { sit = { type = 'chair', seats = {[1] = vector4(0.0, 0.0, -0.1, 180.0)} } }, -- ba_prop_battle_club_chair_01
    [-377849416] = { sit = { type = 'chair', seats = {[1] = vector4(0.0, 0.0, 0.5, 180.0)} } }, -- v_ilev_leath_chr
    [47332588] = { sit = { type = 'chair2', seats = {[1] = vector4(0.0, 0.0, 0.5, 180.0)} } }, -- prop_table_05_chr
    [444105316] = { sit = { type = 'chair2', seats = {[1] = vector4(0.0, 0.0, 0.5, 180.0)} } }, -- v_corp_lazychair
    [1268458364] = { sit = { type = 'chair', seats = {[1] = vector4(0.0, 0.0, 0.5, 180.0)} } }, -- prop_off_chair_04
    [-501934650] = { sit = { type = 'chair2', seats = {[1] = vector4(0.0, 0.05, 0.5, 180.0)} } }, -- v_corp_cd_chair
    [536071214] = { sit = { type = 'chair', seats = {[1] = vector4(0.0, 0.075, 0.5, 180.0)} } }, -- prop_off_chair_01
    [589738836] = { sit = { type = 'chair', seats = {[1] = vector4(0.0, 0.0, 0.5, 180.0)} } }, -- v_corp_bk_chair3
    [1281480215] = { sit = { type = 'chair', seats = {[1] = vector4(0.0, 0.05, 0.0, 180.0)} } }, -- prop_chair_08
    [1612971419] = { sit = { type = 'chair', seats = {[1] = vector4(0.0, 0.05, 0.5, 180.0)} } }, -- prop_chair_09
    [1975077032] = { sit = { type = 'chair', seats = {[1] = vector4(0.0, -0.15, 0.5, 180.0)} } }, -- prop_rub_couch03
    [525667351] = { sit = { type = 'chair2', seats = {[1] = vector4(0.0, 0.0, 0.52, 180.0)} } }, -- prop_chair_01a
    [-293380809] = { sit = { type = 'chair2', seats = {[1] = vector4(0.0, -0.1, 0.5, 180.0)} } }, -- hei_prop_yah_seat_02
    [604553643] = { sit = { type = 'chair2', seats = {[1] = vector4(0.0, -0.1, 0.5, 180.0)} } }, -- p_yacht_chair_01_s
    [-157036474] = { sit = { type = 'chair2', seats = {[1] = vector4(0.0, -0.1, 0.5, 180.0)} } }, -- gr_dlc_gr_yacht_props_seat_02
    [28672923] = { sit = { type = 'chair2', seats = {[1] = vector4(0.0, 0.0, 0.7, 180.0)} } }, -- hei_prop_yah_seat_01
    [-294499241] = { sit = { type = 'chair2', seats = {[1] = vector4(0.0, -0.1, 0.5, 180.0)} } }, -- prop_yacht_seat_01
    [-1005619310] = { sit = { type = 'chair2', seats = {[1] = vector4(0.0, 0.0, 0.7, 180.0)} } }, -- prop_yacht_seat_03
    [603897027] = { sit = { type = 'chair2', seats = {[1] = vector4(0.0, 0.0, 0.5, 180.0)} } }, -- v_club_stagechair
    [725259233] = { sit = { type = 'chair2', seats = {[1] = vector4(0.0, 0.0, 0.525, 180.0)} } }, -- prop_chair_02
    [558578166] = { sit = { type = 'chair2', seats = {[1] = vector4(0.0, 0.0, 0.0, 180.0)} } }, -- prop_gc_chair02
    [-2016553006] = { sit = { type = 'chair2', seats = {[1] = vector4(0.0, 0.0, 0.5, 180.0)} } }, -- prop_table_06_chr
    [98421364] = { sit = { type = 'chair2', seats = {[1] = vector4(0.0, 0.0, 0.5, 180.0)} } }, -- v_ilev_p_easychair
    [475561894] = { sit = { type = 'chair', seats = {[1] = vector4(0.0, 0.0, 0.5, 180.0)} } }, -- prop_off_chair_04_s
    [1064877149] = { sit = { type = 'chair', seats = {[1] = vector4(0.0, 0.0, 0.5, 180.0)} } }, -- prop_chair_03
    [2051175944] = { sit = { type = 'chair', seats = {[1] = vector4(0.0, 0.0, 0.5, 180.0)} } }, -- v_res_m_l_chair1
    [1355718178] = { sit = { type = 'chair2', seats = {[1] = vector4(0.0, 0.0, 0.5, 180.0)} } }, -- prop_waiting_seat_01
    [2053667724] = { sit = { type = 'chair2', seats = {[1] = vector4(0.0, 0.0, 0.1, 180.0)} } }, -- v_club_baham_bckt_chr
    [-826852533] = { sit = { type = 'chair2', teleportIn = true, seats = {[1] = vector4(0.0, 0.1, 0.85, 180.0)} } }, -- prop_umpire_01
    [1630899471] = { sit = { type = 'chair2', seats = {[1] = vector4(0.0, 0.0, 0.55, 180.0)} } }, -- v_ret_chair_white
    [-1941377959] = { sit = { type = 'chair2', seats = {[1] = vector4(0.0, 0.1, 0.5, 180.0)} } }, -- prop_chair_04b
    [-1278649385] = { sit = { type = 'chair', seats = {[1] = vector4(0.0, 0.0, -0.1, 180.0)} } }, -- ex_prop_offchair_exec_02
    [-1626066319] = { sit = { type = 'chair', seats = {[1] = vector4(0.0, 0.0, -0.1, 180.0)} } }, -- ex_prop_offchair_exec_01
    [1580642483] = { sit = { type = 'chair', seats = {[1] = vector4(0.0, 0.0, -0.1, 180.0)} } }, -- ex_prop_offchair_exec_03
    [685944827] = { sit = { type = 'chair', seats = {[1] = vector4(0.0, 0.0, 0.5, 180.0)} } }, -- v_res_fa_chair02
    [1262298127] = { sit = { type = 'chair', seats = {[1] = vector4(0.0, 0.075, 0.075, 180.0)} } }, -- prop_wheelchair_01
    [215586331] = { sit = { type = 'chair', seats = {[1] = vector4(0.0, 0.05, 0.3, 180.0)} } }, -- v_ind_ss_chair01
    [-416920619] = { sit = { type = 'chair', seats = {[1] = vector4(0.0, 0.05, 0.0, 180.0)} } }, -- v_ind_ss_chair2
    [-784954167] = { sit = { type = 'chair', seats = {[1] = vector4(0.0, 0.05, 0.0, 180.0)} } }, -- v_ilev_chair02_ped
    [38932324] = { sit = { type = 'chair', seats = {[1] = vector4(0.0, -0.05, 0.5, 180.0)} } }, -- v_res_jarmchair
    [-1251662965] = { sit = { type = 'chair', seats = {[1] = vector4(0.0, -0.08, 0.5, 180.0)} } }, -- v_res_m_armchair
    [1545434534] = { sit = { type = 'chair', seats = {[1] = vector4(0.0, 0.0, 0.5, 180.0)} } }, -- prop_chair_05
    [-1869605644] = { sit = { type = 'chair3', seats = {[1] = vector4(0.0, 0.1, 0.0, 0.0)} } }, -- prop_ld_farm_chair01
    [757888276] = { sit = { type = 'chair', seats = {[1] = vector4(0.0, 0.0, 0.5, 0.0)} } }, -- v_58_soloff_gchair2
    [-1892473334] = { sit = { type = 'chair', seats = {[1] = vector4(0.0, 0.0, 0.5, 0.0)} } }, -- v_58_soloff_gchair
    [1691387372] = { sit = { type = 'chair', seats = {[1] = vector4(0.0, 0.0, 0.5, 180.0)} } }, -- prop_chair_10
    [854385596] = { sit = { type = 'chair', seats = {[1] = vector4(0.0, 0.0, 0.1, 180.0)} } }, -- prop_rock_chair_01
    [1028260687] = { sit = { type = 'chair', seats = {[1] = vector4(-0.035, 0.08, 0.0, 180.0)} } }, -- prop_chateau_chair_01
    [1103738692] = { sit = { type = 'deck', seats = {[1] = vector4(0.0, 0.0, -0.15, 180.0)} } }, -- prop_old_deck_chair
    [1019962318] = { sit = { type = 'chair', seats = {[1] = vector4(0.0, 0.0, 0.3, 180.0)} } }, -- prop_hobo_seat_01
    [451260528] = { sit = { type = 'chair', seats = {[1] = vector4(0.0, 0.0, 0.5, 180.0)} } }, -- v_ilev_m_dinechair
    [575699050] = { sit = { type = 'deck', seats = {[1] = vector4(0.0, 0.2, 0.35, 0.0)} } }, -- prop_rub_carpart_05
    [-853526657] = { sit = { type = 'chair', seats = {[1] = vector4(0.0, 0.05, -0.1, 180.0)} } }, -- imp_prop_impexp_offchair_01a
    [-997157373] = { sit = { type = 'chair', seats = {[1] = vector4(0.0, 0.0, -0.1, 180.0)} } }, -- vw_prop_vw_offchair_03
    [-992735415] = { sit = { type = 'chair', seats = {[1] = vector4(0.0, 0.05, -0.1, 180.0)} } }, -- ba_prop_battle_club_chair_03
    [-829283643] = { sit = { type = 'chair', seats = {[1] = vector4(0.0, -0.075, -0.1, 180.0)} } }, -- ba_prop_battle_club_chair_02
    [438342263] = { sit = { type = 'chair2', seats = {[1] = vector4(0.0, 0.0, 0.29, 180.0)} } }, -- v_res_fa_chair01
    [-1198343923] = { sit = { type = 'chair', seats = {[1] = vector4(0.0, 0.075, 0.5, 180.0)} } }, -- hei_prop_heist_off_chair
    [768067634] = { sit = { type = 'chair', seats = {[1] = vector4(0.0, 0.1, 0.5, 180.0)} } }, -- sf_prop_sf_bench_piano_01a
    [-61947709] = { sit = { type = 'chair', seats = {[1] = vector4(0.0, -0.1, 0.5, 180.0)} } }, -- sf_prop_sf_sofa_chefield_02a
    [1382419899] = { sit = { type = 'deck', seats = {[1] = vector4(0.0, -0.175, 0.225, 180.0)} } }, -- prop_car_seat
    [1480618483] = { sit = { type = 'chair', seats = {[1] = vector4(0.0, 0.0, 0.45, 180.0)} } }, -- prop_off_chair_04b
    [-603563862] = { sit = { type = 'chair', seats = {[1] = vector4(0.0, 0.05, 0.5, 180.0)} } }, -- v_res_fh_dineeamesa
    [174634350] = { sit = { type = 'chair', seats = {[1] = vector4(0.0, 0.05, 0.5, 180.0)} } }, -- v_res_fh_dineeamesb
    [-125562459] = { sit = { type = 'chair', seats = {[1] = vector4(0.0, 0.05, 0.5, 180.0)} } }, -- v_res_fh_dineeamesc
    [-523951410] = { sit = { type = 'chair', seats = {[1] = vector4(0.0, 0.05, 0.5, 180.0)} } }, -- v_ret_chair
    [-590416541] = { sit = { type = 'chair2', seats = {[1] = vector4(0.0, 0.10, 0.5, 180.0)} } }, -- gr_dlc_gr_yacht_props_table_01
    [1872312775] = { sit = { type = 'chair', seats = {[1] = vector4(0.0, 0.0, 0.135, 180.0)} } }, -- prop_ld_toilet_01
    [-1195678770] = { sit = { type = 'chair', seats = {[1] = vector4(0.0, -0.1, 0.80, 0.0)} } }, -- vw_prop_casino_chair_01a
    [-1005355458] = { sit = { type = 'chair', seats = {[1] = vector4(0.0, 0.08, 0.5, 180.0)} } }, -- vw_prop_casino_track_chair_01
    [-296249014] = { sit = { type = 'chair', seats = {[1] = vector4(0.0, 0.05, 0.78, 180.0)} } }, -- prop_chair_pile_01
    [688581443] = { sit = { type = 'chair', seats = {[1] = vector4(0.0, -0.06, 0.03, 180.0)} } }, -- h4_prop_h4_chair_01a
    [-1200941518] = { sit = { type = 'chair', seats = {[1] = vector4(0.0, -0.01, 0.51, 180.0)} } }, -- v_res_trev_framechair
    [803221323] = { sit = { type = 'chair', seats = {[1] = vector4(0.0, 0.05, 0.5, 180.0)} } }, -- v_res_study_chair
    [-1061363766] = { sit = { type = 'chair', seats = {[1] = vector4(0.0, 0.0, 0.5, 180.0)} } }, -- v_res_fh_barcchair
    [-1394425261] = { sit = { type = 'chair2', seats = {[1] = vector4(0.0, 0.0, 0.5, 180.0)} } }, -- v_res_fh_easychair
    [-108069875] = { sit = { type = 'chair2', seats = {[1] = vector4(0.0, -0.25, 0.05, 180.0)} } }, -- v_res_fh_singleseat
    [-5124212] = { sit = { type = 'chair2', seats = {[1] = vector4(0.0, 0.05, 0.48, 180.0)} } }, -- v_res_j_stool
    [-474978775] = { sit = { type = 'chair', seats = {[1] = vector4(0.0, 0.0, 0.5, 180.0)} } }, -- v_res_m_dinechair
    [1789936288] = { sit = { type = 'chair', seats = {[1] = vector4(0.0, 0.05, 0.075, 180.0)} } }, -- v_res_tre_chair
    [810899590] = { sit = { type = 'chair', seats = {[1] = vector4(0.0, 0.05, 0.05, 180.0)} } }, -- v_res_tre_officechair
    [-1254619912] = { sit = { type = 'chair2', seats = {[1] = vector4(0.0, 0.05, 0.5, 180.0)} } }, -- v_med_p_deskchair
    [-802034762] = { sit = { type = 'chair2', seats = {[1] = vector4(0.0, 0.0, 0.475, 180.0)} } }, -- v_med_p_easychair
    [-1786424499] = { sit = { type = 'chair', seats = {[1] = vector4(0.0, -0.05, 0.05, 180.0)} } }, -- v_med_whickerchair1
    [900821510] = { sit = { type = 'director', seats = {[1] = vector4(0.0, 0.0, 0.15, 180.0)} } }, -- prop_direct_chair_01
    [181607490] = { sit = { type = 'director', seats = {[1] = vector4(0.0, 0.0, 0.17, 180.0)} } }, -- prop_direct_chair_02
    [298623376] = { sit = { type = 'chair2', seats = {[1] = vector4(0.0, -0.2, 0.5, 180.0)} } }, -- apa_mp_h_yacht_armchair_01
    [535835408] = { sit = { type = 'chair2', seats = {[1] = vector4(0.0, 0.0, 0.5, 180.0)} } }, -- v_club_barchair
    [1781364495] = { sit = { type = 'chair', seats = {[1] = vector4(0.5, 0.0, 0.5, 180.0)} } }, -- prop_couch_sm_02
    [-405540270] = { sit = { type = 'chair', seats = {[1] = vector4(0.5, -0.1, 0.5, 180.0)} } }, -- prop_couch_sm_05
    [-863683659] = { sit = { type = 'chair', seats = {[1] = vector4(0.5, -0.15, 0.5, 180.0)} } }, -- prop_couch_sm_07
    [266823484] = { sit = { type = 'chair', seats = {[1] = vector4(0.0, -0.15, 0.5, 180.0)} } }, -- prop_couch_sm2_07
    [-606800174] = { sit = { type = 'chair2', seats = {[1] = vector4(0.0, 0.075, 0.525, 180.0)} } }, -- apa_mp_h_din_chair_04
    [6963200] = { sit = { type = 'chair2', seats = {[1] = vector4(0.0, 0.075, 0.525, 180.0)} } }, -- apa_mp_h_din_chair_08
    [987641063] = { sit = { type = 'chair', seats = {[1] = vector4(0.0, 0.25, 0.5, 180.0)} } }, -- apa_mp_h_din_chair_09
    [-1333092650] = { sit = { type = 'chair', seats = {[1] = vector4(0.0, 0.08, 0.5, 180.0)} } }, -- apa_mp_h_din_chair_12
    [1738496974] = { sit = { type = 'chair', seats = {[1] = vector4(0.0, -0.1, 0.5, 180.0)} } }, -- apa_mp_h_stn_chairarm_01
    [2019753297] = { sit = { type = 'chair', seats = {[1] = vector4(0.0, -0.5, 0.5, 180.0)} } }, -- apa_mp_h_stn_chairarm_02
    [1722309084] = { sit = { type = 'chair', seats = {[1] = vector4(0.0, -0.35, 0.5, 180.0)} } }, -- apa_mp_h_stn_chairarm_03
    [-234688365] = { sit = { type = 'chair', seats = {[1] = vector4(0.0, -0.35, 0.5, 180.0)} } }, -- apa_mp_h_stn_chairarm_09
    [-868509571] = { sit = { type = 'chair', seats = {[1] = vector4(0.0, -0.25, 0.5, 180.0)} } }, -- apa_mp_h_stn_chairarm_11
    [-1168018231] = { sit = { type = 'chair', seats = {[1] = vector4(0.0, 0.0, 0.5, 180.0)} } }, -- apa_mp_h_stn_chairarm_12
    [-1482600631] = { sit = { type = 'chair', seats = {[1] = vector4(0.0, -0.5, 0.5, 180.0)} } }, -- apa_mp_h_stn_chairarm_13
    [338307413] = { sit = { type = 'chair', seats = {[1] = vector4(0.0, 0.0, 0.5, 180.0)} } }, -- apa_mp_h_stn_chairarm_23
    [49088219] = { sit = { type = 'chair', seats = {[1] = vector4(0.0, -0.40, 0.5, 180.0)} } }, -- apa_mp_h_stn_chairarm_24
    [-1210781524] = { sit = { type = 'chair', seats = {[1] = vector4(0.0, -0.25, 0.5, 180.0)} } }, -- apa_mp_h_stn_chairarm_25
    [-1785811936] = { sit = { type = 'chair', seats = {[1] = vector4(0.0, -0.7, 0.5, 180.0)} } }, -- apa_mp_h_stn_chairarm_26
    [-67059393] = { sit = { type = 'chair', seats = {[1] = vector4(0.0, -0.08, 0.5, 180.0)} } }, -- apa_mp_h_stn_chairstrip_01
    [1488091809] = { sit = { type = 'chair', seats = {[1] = vector4(0.0, -0.08, 0.5, 180.0)} } }, -- apa_mp_h_stn_chairstrip_02
    [-393569709] = { sit = { type = 'chair', seats = {[1] = vector4(0.0, -0.02, 0.5, 180.0)} } }, -- apa_mp_h_stn_chairstrip_03
    [-999534061] = { sit = { type = 'chair', seats = {[1] = vector4(0.0, -0.05, 0.5, 180.0)} } }, -- apa_mp_h_stn_chairstrip_04
    [-689899780] = { sit = { type = 'chair', seats = {[1] = vector4(0.0, -0.05, 0.5, 180.0)} } }, -- apa_mp_h_stn_chairstrip_05
    [233628951] = { sit = { type = 'chair', seats = {[1] = vector4(0.0, -0.05, 0.5, 180.0)} } }, -- apa_mp_h_stn_chairstrip_06
    [-1608185467] = { sit = { type = 'chair', seats = {[1] = vector4(0.0, -0.05, 0.5, 180.0)} } }, -- apa_mp_h_stn_chairstrip_07
    [1740052654] = { sit = { type = 'chair', seats = {[1] = vector4(0.0, -0.05, 0.5, 180.0)} } }, -- apa_mp_h_stn_chairstrip_08
    [-887404930] = { sit = { type = 'chair', seats = {[1] = vector4(0.0, -0.08, -0.10, 180.0)} } }, -- ba_prop_battle_control_seat
    [-2065455377] = { sit = { type = 'chair', seats = {[1] = vector4(0.0, -0.1, 0.5, 180.0)} } }, -- p_armchair_01_s
    [-721037220] = { sit = { type = 'chair', seats = {[1] = vector4(0.0, 0.05, 0.5, 180.0)} } }, -- p_dinechair_01_s
    [736919402] = { sit = { type = 'chair', seats = {[1] = vector4(0.0, 0.0, 0.6, 180.0)} } }, -- p_ilev_p_easychair_s
    [1196890646] = { sit = { type = 'chair', seats = {[1] = vector4(0.0, -0.1, -0.1, 180.0)} } }, -- p_soloffchair_s
    [-881696544] = { sit = { type = 'chair', seats = {[1] = vector4(0.0, -0.01, -0.125, 180.0)} } }, -- v_ret_gc_chair03
    [-1633198649] = { sit = { type = 'chair', seats = {[1] = vector4(0.0, -0.025, 0.5, 180.0)} } }, -- prop_sol_chair
    [-1289815393] = { sit = { type = 'chair', seats = {[1] = vector4(0.0, 0.05, 0.5, 180.0)} } }, -- v_ilev_fh_dineeamesa

    -- Stools --
    [-1829764702] = { sit = { type = 'barstool', seats = {[1] = vector4(0.0, 0.15, 0.825, 180.0)} } }, -- prop_bar_stool_01
    [-1971298567] = { sit = { type = 'stool', seats = {[1] = vector4(0.0, 0.1, 0.39, 180.0)} } }, -- v_ret_gc_chair01
    [317065662] = { sit = { type = 'stool', seats = {[1] = vector4(0.0, 0.1, 0.35, 180.0)} } }, -- v_club_bahbarstool
    [652816835] = { sit = { type = 'stool', seats = {[1] = vector4(0.0, 0.1, 0.85, 180.0)} } }, -- apa_mp_h_din_stool_04
    [1938265576] = { sit = { type = 'stool', seats = {[1] = vector4(0.0, 0.1, 0.75, 180.0)} } }, -- v_res_kitchnstool
    [1130482396] = { sit = { type = 'barstool', seats = {[1] = vector4(0.0, 0.0, 0.825, 0.0)} } }, -- prop_stool_01
    [-992710074] = { sit = { type = 'chair2', teleportIn = true, seats = {[1] = vector4(0.0, 0.10, 0.70, 180.0)} } }, -- v_med_cor_medstool
    [1798189768] = { sit = { type = 'chair2', teleportIn = true, seats = {[1] = vector4(0.0, 0.10, 0.55, 180.0)} } }, -- v_ret_ta_stool
    [1840174940] = { sit = { type = 'barstool', seats = {[1] = vector4(0.0, 0.0, 0.815, 180.0)} } }, -- ba_prop_int_glam_stool
    [-1120527678] = { sit = { type = 'stool', seats = {[1] = vector4(0.075, 0.0, 0.8, 90.0)} } }, -- ba_prop_int_edgy_stool
    [708083002] = { sit = { type = 'stool', seats = {[1] = vector4(0.0, 0.1, 0.9, 180.0)} } }, -- h4_prop_h4_barstool_01a
    [1079799018] = { sit = { type = 'chair', teleportIn = true, seats = {[1] = vector4(0.1, 0.0, 0.5, 90.0)} } }, -- sf_prop_sf_chair_stool_08a
    [-360727150] = { sit = { type = 'chair', teleportIn = true, seats = {[1] = vector4(0.0, 0.025, 0.80, 180.0)} } }, -- sf_prop_sf_chair_stool_09a
    [-1987538561] = { sit = { type = 'stool', seats = {[1] = vector4(0.0, 0.02, 0.21, 180.0)} } }, -- v_res_d_highchair
    [-1972746906] = { sit = { type = 'stool', seats = {[1] = vector4(0.0, 0.15, 0.9, 180.0)} } }, -- v_res_fh_kitnstool
    [937222680] = { sit = { type = 'stool', seats = {[1] = vector4(0.0, 0.1, 0.08, 180.0)} } }, -- v_res_tre_stool
    [1560277278] = { sit = { type = 'stool', seats = {[1] = vector4(0.0, 0.1, 0.08, 180.0)} } }, -- v_res_tre_stool_leather
    [891849380] = { sit = { type = 'stool', seats = {[1] = vector4(0.0, 0.1, 0.08, 180.0)} } }, -- v_res_tre_stool_scuz
    [1170592309] = { sit = { type = 'stool', seats = {[1] = vector4(0.0, 0.1, 0.6, 180.0)} } }, -- apa_mp_h_yacht_stool_01
    [-677582063] = { sit = { type = 'stool', seats = {[1] = vector4(0.0, 0.1, 0.48, 180.0)} } }, -- apa_mp_h_stn_chairstool_12
    [682082323] = { sit = { type = 'stool', seats = {[1] = vector4(0.0, 0.1, 0.8, 180.0)} } }, -- apa_mp_h_yacht_barstool_01
    [-1190156817] = { sit = { type = 'stool', seats = {[1] = vector4(0.0, 0.2, 0.90, 180.0)} } }, -- v_ilev_fh_kitchenstool
    [196301499] = { sit = { type = 'stool', seats = {[1] = vector4(0.0, 0.15, 0.85, 180.0)} } }, -- ex_mp_h_din_stool_04

    -- Sun Loungers --
    [-573707493] = { sit = { type = 'sunlounger', seats = {[1] = vector4(0.0, -0.23, 0.4, 180.0)} } }, -- p_patio_lounger1_s
    [1160611253]  = { sit = { type = 'sunlounger', seats = {[1] = vector4(0.0, 0.3, 0.5, 180.0)} } }, -- prop_yacht_lounger
    [1699040865] = { sit = { type = 'sunlounger', seats = {[1] = vector4(0.0, 0.25, 0.5, 180.0)} } }, -- prop_patio_lounger_2
    [2017293393] = { sit = { type = 'sunlounger', seats = {[1] = vector4(0.0, 0.18, 0.4, 180.0)} } }, -- prop_patio_lounger_3
    [-1498352975] = { sit = { type = 'sunlounger', seats = {[1] = vector4(0.0, -0.2, 0.4, 180.0)} } }, -- prop_patio_lounger1
    [796317896] = { sit = { type = 'sunlounger', seats = {[1] = vector4(0.0, 0.3, 0.5, 180.0)} } }, -- gr_dlc_gr_yacht_props_lounger
    [900699965] = { sit = { type = 'sunlounger', seats = {[1] = vector4(0.0, 0.3, 0.5, 180.0)} } }, -- hei_prop_yah_lounger
    [-2024837020] = {
        sit = { type = 'chair2', seats = {[1] = vector4(0.0, 0.3, 0.45, 270.0), [2] = vector4(0.0, -0.8, 0.45, 90.0)} },
        lay = { type = 'layside', seats = {[1] = vector4(0.1, -0.25, 0.45, 90.0)} }
    }, -- prop_patio_lounger1b

    -- Benches --
    [1290593659] = {
        sit = { type = 'chair2', seats = {[1] = vector4(-0.8, 0.0, 0.42, 180.0), [2] = vector4(0.0, 0.0, 0.42, 180.0), [3] = vector4(0.8, 0.0, 0.42, 180.0)} },
        lay = { type = 'layside', seats = {[1] = vector4(0.0, 0.0, 0.42, 180.0)} }
    }, -- prop_bench_11
    [-403891623] = { sit = { type = 'chair2', seats = {[1] = vector4(-0.7, 0.125, 0.5, 180.0), [2] = vector4(0.7, 0.125, 0.5, 180.0)} } }, -- prop_bench_08
    [-99500382] = { sit = { type = 'chair2', seats = {[1] = vector4(-0.8, -0.05, 0.3, 180.0), [2] = vector4(0.0, -0.05, 0.3, 180.0), [3] = vector4(0.8, 0.0, 0.3, 180.0)} } }, -- prop_bench_09
    [-628719744] = {
        sit = { type = 'chair2', seats = {[1] = vector4(-0.7, 0.0, 0.5, 180.0), [2] = vector4(0.0, 0.0, 0.5, 180.0), [3] = vector4(0.7, 0.0, 0.5, 180.0)} },
        lay = { type = 'layside', seats = {[1] = vector4(0.0, 0.0, 0.5, 180.0)} }
    }, -- prop_bench_02
    [-1062810675] = { sit = { type = 'chair2', seats = {[1] = vector4(-0.35, 0.05, 0.43, 180.0), [2] = vector4(0.35, 0.05, 0.43, 180.0)} } }, -- prop_bench_03
	[-1631057904] = {
        sit = { type = 'chair2', seats = {[1] = vector4(-0.8, 0.0, 0.45, 180.0), [2] = vector4(0.0, 0.0, 0.45, 180.0), [3] = vector4(0.8, 0.0, 0.45, 180.0)} },
        lay = { type = 'layside', seats = {[1] = vector4(0.0, 0.0, 0.45, 180.0)} }
    }, -- prop_bench_05
    [437354449] = {
        sit = { type = 'chair2', seats = {[1] = vector4(-1.1, -0.05, 0.5, 180.0), [2] = vector4(-0.35, -0.05, 0.5, 180.0), [3] = vector4(0.35, -0.05, 0.5, 180.0), [4] = vector4(1.2, -0.05, 0.5, 180.0)} },
        lay = { type = 'layside', seats = {[1] = vector4(0.0, -0.05, 0.5, 180.0)} }
    }, -- prop_bench_10
    [-71417349] = {
        sit = { type = 'chair2', seats = {[1] = vector4(0.0, -0.1, 0.5, 180.0), [2] = vector4(0.9, -0.1, 0.5, 180.0), [3] = vector4(1.8, -0.1, 0.5, 180.0)} },
        lay = { type = 'layside', teleportIn = true, seats = {[1] = vector4(0.9, -0.1, 0.5, 180.0)} }
    }, -- prop_bench_07
    [1805980844] = {
        sit = { type = 'chair2', seats = {[1] = vector4(-0.75, 0.0, 0.5, 180.0), [2] = vector4(0.0, 0.0, 0.5, 180.0), [3] = vector4(0.75, 0.0, 0.5, 180.0)} },
        lay = { type = 'layside', teleportIn = true, seats = {[1] = vector4(0.0, 0.0, 0.5, 180.0)} }
    }, -- prop_bench_01a
    [-1317098115] = {
        sit = { type = 'chair2', seats = {[1] = vector4(-0.9, 0.0, 0.5, 180.0), [2] = vector4(0.0, 0.0, 0.5, 180.0), [3] = vector4(0.9, 0.0, 0.5, 180.0)} },
        lay = { type = 'layside', teleportIn = true, seats = {[1] = vector4(0.0, 0.0, 0.5, 180.0)} }
    }, -- prop_bench_06
    [2142033519] = { sit = { type = 'chair2', seats = {[1] = vector4(0.0, 0.3, 0.5, 180.0), [2] = vector4(0.75, 0.3, 0.5, 180.0), [3] = vector4(1.5, 0.3, 0.5, 180.0)} } }, -- prop_busstop_02
    [1681727376] = { sit = { type = 'chair2', seats = {[1] = vector4(-0.6, 0.6, 0.5, 180.0), [2] = vector4(0.0, 0.6, 0.5, 180.0), [3] = vector4(0.6, 0.6, 0.5, 180.0)} } }, -- prop_busstop_04
    [1888204845] = {
        sit = { type = 'chair2', seats = {[1] = vector4(0.1, 0.3, 0.5, 180.0), [2] = vector4(0.8, 0.3, 0.5, 180.0)} },
        lay = { type = 'layside', teleportIn = false, seats = {[1] = vector4(0.55, 0.35, 0.5, 180.0)} }
    }, -- prop_busstop_05
    [-1572018818] = {
        sit = { type = 'chair', teleportIn = true, seats = {[1] = vector4(-0.4, -0.6, 0.5, 0.0), [2] = vector4(0.4, -0.6, 0.5, 0.0), [3] = vector4(-0.4, 0.6, 0.5, 180.0), [4] = vector4(0.4, 0.6, 0.5, 180.0)} },
        lay = { type = 'layside', teleportIn = true, seats = {[1] = vector4(0.0, 0.1, 0.85, 180.0)} }
    }, -- prop_picnictable_01
    [-232870343] = { sit = { type = 'chair2', teleportIn = true, seats = {[1] = vector4(-0.5, 0.0, 0.5, 0.0), [2] = vector4(0.5, 0.0, 0.5, 0.0)} } },
    [1916676832] = {
        sit = { type = 'chair2', seats = {[1] = vector4(-0.7, 0.2, 0.5, 180.0), [2] = vector4(0.0, 0.2, 0.5, 180.0), [3] = vector4(0.7, 0.2, 0.5, 180.0)} },
        lay = { type = 'layside', teleportIn = true, seats = {[1] = vector4(0.0, 0.2, 0.5, 180.0)} }
    }, -- prop_ld_bench01
    [-763859088] = { sit = { type = 'chair2', seats = {[1] = vector4(-0.7, -0.1, 0.5, 180.0), [2] = vector4(0.0, -0.1, 0.5, 180.0), [3] = vector4(0.7, -0.1, 0.5, 180.0)} } }, -- prop_bench_04
    [-729914417] = {
        sit = { type = 'chair2', seats = {[1] = vector4(-0.6, 0.05, 0.5, 180.0), [2] = vector4(0.0, 0.05, 0.5, 180.0), [3] = vector4(0.6, 0.05, 0.5, 180.0)} },
        lay = { type = 'layside', seats = {[1] = vector4(0.0, -0.05, 0.5, 180.0)} }
    }, -- Unknown
    [-1507293404] = {
        sit = { type = 'chair2', seats = {[1] = vector4(-0.7, 0.05, 0.5, 180.0), [2] = vector4(0.0, 0.05, 0.5, 180.0), [3] = vector4(0.7, 0.05, 0.5, 180.0)} },
        lay = { type = 'layside', seats = {[1] = vector4(0.0, 0.05, 0.5, 180.0)} }
    }, -- Unknown
    [-128924068] = {
        sit = { type = 'chair2', seats = {[1] = vector4(0.0, -1.08, 0.07, 270.0), [2] = vector4(0.0, -0.375, 0.07, 270.0), [3] = vector4(0.0, 0.375, 0.07, 270.0), [4] = vector4(0.0, 1.08, 0.07, 270.0)} }
    }, -- v_med_hospseating1

    -- Couches / Sofas --
    [-1199485389] = {
        sit = { type = 'chair2', seats = {[1] = vector4(-0.5, -0.1, 0.48, 180.0), [2] = vector4(0.5, -0.1, 0.48, 180.0)} },
        lay = { type = 'layside', teleportIn = true, seats = {[1] = vector4(0.0, -0.20, 0.5, 180.0)} }
    }, -- prop_rub_couch04
    [-2021659595] = {
        sit = { type = 'chair2', seats = {[1] = vector4(-0.6, -0.1, 0.48, 180.0), [2] = vector4(0.5, -0.1, 0.45, 180.0)} },
        lay = { type = 'layside', teleportIn = true, seats = {[1] = vector4(0.10, -0.2, 0.5, 180.0)} }
    }, -- prop_rub_couch02
    [-941390908] = {
        sit = { type = 'chair2', seats = {[1] = vector4(-0.5, -0.1, 0.5, 180.0), [2] = vector4(0.5, -0.1, 0.5, 180.0)} },
        lay = { type = 'layside', teleportIn = true, seats = {[1] = vector4(-0.05, -0.05, 0.5, 180.0)} }
    }, -- v_res_tre_sofa
    [-591349326] = { sit = { type = 'chair2', seats = {[1] = vector4(-0.35, -0.1, 0.6, 180.0), [2] = vector4(0.35, -0.1, 0.6, 180.0)} } }, -- hei_prop_yah_seat_03
    [376180694] = { sit = { type = 'chair2', seats = {[1] = vector4(-0.35, -0.1, 0.6, 180.0), [2] = vector4(0.35, -0.1, 0.6, 180.0)} } }, -- gr_dlc_gr_yacht_props_seat_03
    [-1320300017] = { sit = { type = 'chair2', seats = {[1] = vector4(-0.35, -0.1, 0.6, 180.0), [2] = vector4(0.35, -0.1, 0.6, 180.0)} } }, -- prop_yacht_seat_02
    [1532110050] = { sit = { type = 'chair2', seats = {[1] = vector4(-0.35, -0.1, 0.6, 180.0), [2] = vector4(0.35, -0.1, 0.6, 180.0)} } }, -- p_yacht_sofa_01_s
    [267626795] = {
        sit = { type = 'chair2', seats = {[1] = vector4(-0.9, -0.1, 0.5, 180.0), [2] = vector4(0.0, -0.1, 0.5, 180.0), [3] = vector4(0.9, -0.1, 0.5, 180.0)} },
        lay = { type = 'layside', teleportIn = true, seats = {[1] = vector4(0.0, 0.0, 0.5, 180.0)} }
    }, -- prop_wait_bench_01
    [-70627249] = {
        sit = { type = 'chair2', seats = {[1] = vector4(-0.95, 0.0, 0.5, 180.0), [2] = vector4(0.0, 0.0, 0.5, 180.0), [3] = vector4(0.95, 0.0, 0.5, 180.0)} },
        lay = { type = 'layside', teleportIn = true, seats = {[1] = vector4(0.0, 0.0, 0.5, 180.0)} }
    }, -- prop_fib_3b_bench
    [773405192] = {
        sit = { type = 'chair2', seats = {[1] = vector4(0.1, -0.65, 0.0, 270.0), [2] = vector4(0.1, 0.0, 0.0, 270.0), [3] = vector4(0.1, 0.65, 0.0, 270.0)} },
        lay = { type = 'layside', teleportIn = true, seats = {[1] = vector4(0.1, 0.0, 0.0, 270.0)} }
    }, -- prop_ld_farm_couch02
    [544186037] = {
        sit = { type = 'chair2', seats = {[1] = vector4(-0.1, 0.75, 0.0, 90.0), [2] = vector4(-0.1, 0.0, 0.0, 90.0), [3] = vector4(-0.1, -0.75, 0.0, 90.0)} },
        lay = { type = 'layside', teleportIn = true, seats = {[1] = vector4(-0.15, 0.0, 0.0, 90.0)} }
    }, -- prop_ld_farm_couch01
    [-1841495633] = {
        sit = { type = 'chair2', seats = {[1] = vector4(-0.5, 0.0, 0.45, 180.0), [2] = vector4(0.5, 0.0, 0.5, 180.0)} },
        lay = { type = 'layside', teleportIn = true, seats = {[1] = vector4(0.0, 0.0, 0.5, 180.0)} }
    }, -- prop_rub_couch01
    [-1877459292] = {
        sit = { type = 'chair2', seats = {[1] = vector4(-1.25, -0.6, 0.5, 270.0), [2] = vector4(-0.5, 0.4, 0.5, 180.0), [3] = vector4(0.5, 0.4, 0.5, 180.0), [4] = vector4(1.5, 0.4, 0.5, 180.0)} },
        lay = { type = 'layside', teleportIn = true, seats = {[1] = vector4(-1.5, -0.3, 0.55, 270.0), [2] = vector4(0.1, 0.4, 0.5, 180.0)} }
    }, -- v_ilev_m_sofa
    [1181479993] = {
        sit = { type = 'chair2', seats = {[1] = vector4(-0.45, -0.1, 0.5, 180.0), [2] = vector4(0.45, -0.1, 0.5, 180.0)} }
    }, -- v_res_m_h_sofa
    [-694881216] = {
        sit = { type = 'chair2', seats = {[1] = vector4(-0.4, -0.1, 0.5, 180.0), [2] = vector4(0.4, -0.1, 0.5, 180.0)} },
        lay = { type = 'layside', teleportIn = true, seats = {[1] = vector4(-0.05, -0.1, 0.5, 180.0)} }
    }, -- sf_prop_sf_sofa_chefield_01a
    [1902733481] = {
        sit = { type = 'chair2', seats = {[1] = vector4(-1.4, -0.1, 0.5, 180.0), [2] = vector4(-0.5, -0.1, 0.5, 180.0), [3] = vector4(0.5, -0.1, 0.5, 180.0), [4] = vector4(1.5, -0.1, 0.5, 180.0)} },
        lay = { type = 'layside', teleportIn = true, seats = {[1] = vector4(-1.0, -0.1, 0.5, 180.0), [2] = vector4(1.0, -0.1, 0.5, 180.0)} }
    }, -- sf_prop_sf_sofa_studio_01a
    [-1460572644] = {
        sit = { type = 'chair', seats = {[1] = vector4(-0.35, -0.06, 0.03, 180.0), [2] = vector4(0.35, -0.06, 0.03, 180.0)} }
    }, -- h4_prop_h4_couch_01a
    [-1896300387] = {
        sit = { type = 'chair2', seats = {[1] = vector4(-0.4, -0.15, 0.45, 180.0), [2] = vector4(0.4, -0.15, 0.5, 180.0)} }
    }, -- prop_couch_sm_06
    [-9508935] = {
        sit = { type = 'chair2', seats = {[1] = vector4(-0.45, -0.05, 0.5, 180.0), [2] = vector4(0.45, -0.05, 0.5, 180.0)} },
        lay = { type = 'layside', teleportIn = true, seats = {[1] = vector4(-0.05, -0.05, 0.5, 180.0)} }
    }, -- v_res_tre_sofa_mess_b

    -- Beds --
    [1631638868] = {
        sit = { type = 'chair2', teleportIn = true, seats = {[1] = vector4(-0.3, 0.0, 0.4, 90.0), [2] = vector4(0.20, 0.0, 0.4, 270.0)} },
        lay = { type = 'bed', teleportIn = true, seats = {[1] = vector4(-0.05, 0.0, 0.3, 180.0)} }
    }, -- v_med_bed1
    [2117668672] = {
        sit = { type = 'chair2', teleportIn = true, seats = {[1] = vector4(-0.25, 0.0, 0.4, 90.0), [2] = vector4(0.25, 0.0, 0.4, 270.0)} },
        lay = { type = 'bed', teleportIn = true, seats = {[1] = vector4(0.0, 0.0, 0.5, 180.0)} }
    }, -- v_med_bed2
	[-1091386327] = {
        sit = { type = 'chair2', teleportIn = true, seats = {[1] = vector4(-0.25, 0.0, 0.2, 90.0), [2] = vector4(0.25, 0.0, 0.2, 270.0)} },
        lay = { type = 'bed', teleportIn = true, seats = {[1] = vector4(0.0, 0.0, 0.2, 180.0)} }
    }, -- v_med_emptybed
    [-1182962909] = {
        lay = { type = 'medical', teleportIn = true, seats = {[1] = vector4(0.0, -0.15, 1.0, 0.0)} }
    }, -- v_med_cor_emblmtable
    [-1557777900] = {
        sit = { type = 'chair2', teleportIn = true, seats = {[1] = vector4(0.7, 0.0, 0.65, 270.0), [2] = vector4(0.4, -0.95, 0.65, 180.0)} },
        lay = { type = 'bed', teleportIn = true, seats = {[1] = vector4(0.0, 0.0, 0.5, 180.0)} }
    }, -- v_res_tt_bed
    [314496444] = {
        sit = { type = 'chair2', seats = {[1] = vector4(0.0, -0.375, 0.75, 180.0)} },
        lay = { type = 'bed', teleportIn = true, seats = {[1] = vector4(0.0, 0.0, 0.5, 90.0)} }
    }, -- ex_prop_exec_bed_01
    [-1673752417] = {
        sit = { type = 'chair2', seats = {[1] = vector4(0.0, -0.375, 0.75, 180.0), [2] = vector4(0.0, 0.375, 0.75, 180.0)} },
        lay = { type = 'bed', teleportIn = true, seats = {[1] = vector4(0.0, 0.0, 0.75, 90.0)} }
    }, -- bkr_prop_biker_campbed_01
    [262175156] = {
        sit = { type = 'chair2', seats = {[1] = vector4(0.0, -0.3748, 0.75, 180.0), [2] = vector4(0.0, 0.375, 0.75, 180.0)} },
        lay = { type = 'bed', teleportIn = true, seats = {[1] = vector4(0.0, 0.0, 0.75, 90.0)} }
    }, -- imp_prop_impexp_campbed_01
    [-1818341338] = {
        sit = { type = 'chair2', teleportIn = true, seats = {[1] = vector4(0.0, -0.65, 0.3, 180.0), [2] = vector4(0.0, 0.38, 0.3, 0.0)} },
        lay = { type = 'bed', teleportIn = true, seats = {[1] = vector4(0.2, -0.1, 0.3, 270.0)} }
    }, -- imp_prop_impexp_sofabed_01a
    [1088478360] = {
        sit = { type = 'chair2', seats = {[1] = vector4(-0.5, -0.6, 0.09, 180.0), [2] = vector4(0.5, -0.6, 0.09, 180.0)} },
        lay = { type = 'bed', teleportIn = true, seats = {[1] = vector4(0.0, -0.4, 0.09, 270.0)} }
    }, -- prop_t_sofa_02
    [-1964110779] = {
        sit = { type = 'chair2', seats = {[1] = vector4(-0.5, -0.6, 0.09, 180.0), [2] = vector4(0.5, -0.6, 0.09, 180.0)} },
        lay = { type = 'bed', teleportIn = true, seats = {[1] = vector4(0.0, -0.4, 0.09, 270.0)} }
    }, -- prop_t_sofa
    [-335052794] = {
        lay = { type = 'bed', teleportIn = true, skipSeeCheck = true, seats = {[1] = vector4(0.0, 0.0, 0.5, 90.0)} }
    }, -- v_49_motelmp_bed
    [1715961520] = { lay = { type = 'layside', seats = {[1] = vector4(0.0, 0.05, 0.0, 180.0)} } }, -- prop_beach_lilo_01
    [1677315747] = { sit = { type = 'deck', teleportIn = true, seats = {[1] = vector4(0.0, 0.0, 0.175, 180.0)} } }, -- prop_beach_ring_01

    -- Other
    [1578055800] = {
        sit = { type = 'wall', seats = {[1] = vector4(0.85, -1.30, 0.425, 180.0), [2] = vector4(0.45, 1.35, 0.55, 0.0)} },
        lay = { type = 'bed', teleportIn = true, seats = {[1] = vector4(0.0, 0.0, 0.275, 180.0)} }
    }, -- prop_homeles_shelter_01
    [884467146] = {
        sit = { type = 'wall', seats = {[1] = vector4(0.20, -1.15, 0.45, 100.0), [2] = vector4(1.15, 1.40, 0.74, 270.0)} },
        lay = { type = 'bed', teleportIn = true, teleportOut = true, seats = {[1] = vector4(0.0, 0.20, 0.3, 180.0)} }
    }, -- prop_homeles_shelter_02
}

local PolyZones = {
    ['wall'] = {
		enabled = CfG_Sitdown.PresetLocations.wall,
		center = vector3(100.20, -1388.65, 30.0),
		radius = 10.0,
		polys = {
            ['wall_1'] = {
                sit = { type = 'wall', teleportIn = true, seats = {[1] = vector4(100.20, -1388.65, 29.41, 340.0)} },
                poly = { length = 0.6, width = 1.0, height = 1.0 }
            },
        }
    },

    ['steps'] = {
		enabled = CfG_Sitdown.PresetLocations.steps,
		center = vector3(151.60, -988.22, 28.90),
		radius = 10.0,
		polys = {
            ['steps_1'] = {
                sit = { type = 'steps', teleportIn = true, seats = {[1] = vector4(151.60, -988.22, 28.90, 160.0)} },
                poly = { length = 0.6, width = 1.0, height = 1.0 }
            },

            ['steps_2'] = {
                sit = { type = 'steps', teleportIn = true, seats = {[1] = vector4(154.9092, -989.2885, 28.90, 160.0)} },
                poly = { length = 0.6, width = 1.0, height = 1.0 }
            },
        }
    },

    ['ledge'] = {
		enabled = CfG_Sitdown.PresetLocations.ledge,
		center = vector3(-126.58, -979.24, 295.23),
		radius = 10.0,
		polys = {
            ['ledge_1'] = {
                sit = { type = 'ledge', teleportIn = true, seats = {[1] = vector4(-126.58, -979.24, 295.23, 28.0)} },
                poly = { length = 0.6, width = 1.0, height = 1.0 }
            },
        }
    },
}

function GetModels()
    return Models
end

function GetPolyZones()
    return PolyZones
end



-- Variables --
local Models = GetModels()
local PolyZones = GetPolyZones()

local metadata = {
	isSitting = false,
	isLaying = false,
	entity = 0,
	poly = false,
	type = nil,
	lastPos = nil,
	targetPos = nil,
	teleportOut = false,
	unregister = false,
	frozen = false,
	plyFrozen = false,
	animation = {},
	scenario = false,
	showingPrompt = false,
	attAction = false,
}

local sittingScenarios = {
	"WORLD_HUMAN_SEAT_LEDGE", "WORLD_HUMAN_SEAT_LEDGE_EATING", "WORLD_HUMAN_SEAT_STEPS", "WORLD_HUMAN_SEAT_WALL", "WORLD_HUMAN_SEAT_WALL_EATING", "WORLD_HUMAN_SEAT_WALL_TABLET", 
	"PROP_HUMAN_SEAT_ARMCHAIR", "PROP_HUMAN_SEAT_BAR", "PROP_HUMAN_SEAT_BENCH", "PROP_HUMAN_SEAT_BENCH_FACILITY", "PROP_HUMAN_SEAT_BENCH_DRINK", "PROP_HUMAN_SEAT_BENCH_DRINK_FACILITY", 
	"PROP_HUMAN_SEAT_BENCH_DRINK_BEER", "PROP_HUMAN_SEAT_BENCH_FOOD", "PROP_HUMAN_SEAT_BENCH_FOOD_FACILITY", "PROP_HUMAN_SEAT_BUS_STOP_WAIT", "PROP_HUMAN_SEAT_CHAIR", 
	"PROP_HUMAN_SEAT_CHAIR_DRINK", "PROP_HUMAN_SEAT_CHAIR_DRINK_BEER", "PROP_HUMAN_SEAT_CHAIR_FOOD", "PROP_HUMAN_SEAT_CHAIR_UPRIGHT", "PROP_HUMAN_SEAT_CHAIR_MP_PLAYER", 
	"PROP_HUMAN_SEAT_COMPUTER", "PROP_HUMAN_SEAT_COMPUTER_LOW", "PROP_HUMAN_SEAT_DECKCHAIR", "PROP_HUMAN_SEAT_DECKCHAIR_DRINK", "PROP_HUMAN_SEAT_MUSCLE_BENCH_PRESS", 
	"PROP_HUMAN_SEAT_MUSCLE_BENCH_PRESS_PRISON", "PROP_HUMAN_SEAT_SEWING", "PROP_HUMAN_SEAT_STRIP_WATCH", "PROP_HUMAN_SEAT_SUNLOUNGER"
}

-- Functions --
local function DisplayNativeNotification(msg)
	BeginTextCommandThefeedPost("STRING")
	AddTextComponentSubstringPlayerName(msg)
	EndTextCommandThefeedPostTicker(false, false)
end

local function DisplayNotification(msg)
	if CfG_Sitdown.UseNativeNotifiactions then
		DisplayNativeNotification(msg)
	else
		exports.mythic_notify:SendAlert('error', msg)
	end
end

local function LoadAnimDict(dict)
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Wait(10)
	end
end

local function GetAmountOfSeats(model)
	return #Models[model].sit.seats
end

local function GetNearbyPeds()
	local handle, ped = FindFirstPed()
	local success = false
	local peds = {}
	repeat
		peds[#peds+1] = ped
		success, ped = FindNextPed(handle)
	until not success
	EndFindPed(handle)
	return peds
end

local function GetDifference(num1, num2)
	if num1 > num2 then
		return num1 - num2
	else
		return num2 - num1
	end
end

local function HandleLooseEntity(entity)
	if not IsEntityPositionFrozen(entity) then
		if not NetworkGetEntityIsNetworked(entity) then
			NetworkRegisterEntityAsNetworked(entity)
			metadata.unregister = true
		end
		NetworkRequestControlOfEntity(entity)
		FreezeEntityPosition(entity, true)
		metadata.frozen = true
	end
end

local function UnhandleLooseEntity(entity)
	if metadata.frozen then
		FreezeEntityPosition(entity, false)
		if metadata.unregister then
			NetworkUnregisterNetworkedEntity(entity)
			metadata.unregister = false
		end
		metadata.frozen = false
	end
end

local function HeadingToRotation(heading)
    local rotation = heading
    if rotation > 180.0 then
        rotation = 180.0 - GetDifference(rotation, 180.0)
        rotation = rotation*-1 
    end
    return rotation
end

local function GetOffsetFromCoordsInWorldCoords(position, rotation, offset)
    local rotX, rotY, rotZ = math.rad(rotation.x), math.rad(rotation.y), math.rad(rotation.z)
    local matrix = {}

    matrix[1] = {}
    matrix[1][1] = math.cos(rotZ) * math.cos(rotY) - math.sin(rotZ) * math.sin(rotX) * math.sin(rotY)
    matrix[1][2] = math.cos(rotY) * math.sin(rotZ) + math.cos(rotZ) * math.sin(rotX) * math.sin(rotY)
    matrix[1][3] = -math.cos(rotX) * math.sin(rotY)
    matrix[1][4] = 1
    
    matrix[2] = {}
    matrix[2][1] = -math.cos(rotX) * math.sin(rotZ)
    matrix[2][2] = math.cos(rotZ) * math.cos(rotX)
    matrix[2][3] = math.sin(rotX)
    matrix[2][4] = 1
	
    matrix[3] = {}
    matrix[3][1] = math.cos(rotZ) * math.sin(rotY) + math.cos(rotY) * math.sin(rotZ) * math.sin(rotX)
    matrix[3][2] = math.sin(rotZ) * math.sin(rotY) - math.cos(rotZ) * math.cos(rotY) * math.sin(rotX)
    matrix[3][3] = math.cos(rotX) * math.cos(rotY)
    matrix[3][4] = 1
	
    matrix[4] = {}
    matrix[4][1], matrix[4][2], matrix[4][3] = position.x, position.y, position.z
    matrix[4][4] = 1
    
    local x = offset.x * matrix[1][1] + offset.y * matrix[2][1] + offset.z * matrix[3][1] + matrix[4][1]
    local y = offset.x * matrix[1][2] + offset.y * matrix[2][2] + offset.z * matrix[3][2] + matrix[4][2]
    local z = offset.x * matrix[1][3] + offset.y * matrix[2][3] + offset.z * matrix[3][3] + matrix[4][3]
    
    return vector3(x, y, z)
end

local function IsEntityPlayingAnyLayAnim(entity)
	local checked = {}
	for type, settings in pairs(CfG_Sitdown.LayTypes) do
		local anim = settings.animation
		if not checked[anim.dict] then
			if IsEntityPlayingAnim(entity, anim.dict, anim.name, 3) then
				return true
			else
				checked[anim.dict] = true
			end
		end
	end
	return false
end

local function IsPedSitting(ped)
	local checked = {}
	for index, scenario in pairs(sittingScenarios) do
		if IsPedUsingScenario(ped, scenario) then
			return true
		end
	end
	return false
end

local function IsSeatAvailable(coords, action)
	local playerPed = PlayerPedId()
	for index, ped in pairs(GetNearbyPeds()) do
		if ped ~= playerPed then
			local dist = #(GetEntityCoords(ped)-coords)
			if dist < 1.35 then
				if action == 'sit' then
					if IsEntityPlayingAnyLayAnim(ped) or dist < 0.55 then
						return false
					end
				elseif action == 'lay' then
					if IsEntityPlayingAnyLayAnim(ped) or IsPedSitting(ped) then
						return false
					end
				end
			end
		end
	end
	return true
end

local function SeatSort(a, b)
    return a.dist < b.dist
end

local function SortSeatsByDistance(seatCoords, seats, raycast)
    local sortedSeats = {}
    local coords = GetEntityCoords(PlayerPedId())

	if raycast and CfG_Sitdown.Target and CfG_Sitdown.UseTargetingCoords then
		local flag = -1
		local endCoords, entityHit, entityType = false, nil, nil, nil
		if CfG_Sitdown.Target == 'qtarget' then
			endCoords, entityHit, entityType = exports.qtarget:raycast(flag)
		elseif CfG_Sitdown.Target == 'qb-target' then
			endCoords, entityHit, entityType = exports['qb-target']:RaycastCamera(flag)
		else
			endCoords, entityHit, entityType = false, nil, nil, nil
			print("^3Warning: The targeting soulution used does not have a raycast export! Used player ped location instead. (Please set CfG_Sitdown.UseTargetingCoords to false or add an export)")
		end

		if endCoords and endCoords ~= vector3(0.0, 0.0, 0.0) then
			coords = endCoords
		end
	end

    for k, v in pairs(seats) do
        sortedSeats[k] = {}
		if seatCoords ~= 0 then
			local heading = seatCoords.w
			local rotation = vector3(0.0, 0.0, HeadingToRotation(seatCoords.w))
        	sortedSeats[k].coords = GetOffsetFromCoordsInWorldCoords(seatCoords.xyz, rotation, v)
			heading = heading + v.w
			if heading > 360.0 then
				heading = heading - 360.0
			end
			sortedSeats[k].heading = heading
		else
			sortedSeats[k].coords = v.xyz
			sortedSeats[k].heading = v.w
		end
        sortedSeats[k].dist = #(coords-sortedSeats[k].coords)
    end
    table.sort(sortedSeats, SeatSort)

    return sortedSeats
end

local function GetAvailableSeat(seatCoords, seats, raycast)
	local coords = nil
	local heading = nil
	local sortedSeats = SortSeatsByDistance(seatCoords, seats, raycast)

	for index, data in pairs(sortedSeats) do
		if IsSeatAvailable(data.coords, 'sit') then
			coords = data.coords
			heading = data.heading
			break
		end
	end

	return coords, heading
end

local function LeaveSeat(clearTask, clearTaskImmediately, waitIfAttached)
	metadata.isSitting = false
	metadata.isLaying = false
	metadata.scenario = false

	if metadata.plyFrozen then
		SetEntityCollision(PlayerPedId(), true, false)
		FreezeEntityPosition(PlayerPedId(), false)
		metadata.plyFrozen = false
	end

	if metadata.entity ~= 0 then 
		UnhandleLooseEntity(metadata.entity)
		metadata.entity = 0
	end

	if clearTask or clearTaskImmediately then
		if waitIfAttached then
			-- Wait until the person is no longer attached to another ped (aka. getting escorted or carried).
			CreateThread(function()
				while true do
					if not IsEntityAttachedToAnyPed(PlayerPedId()) then
						break
					end
					Wait(200)
				end
				ClearPedTasksImmediately(PlayerPedId())
			end)
		elseif clearTask then
			ClearPedTasks(PlayerPedId())
		else
			ClearPedTasksImmediately(PlayerPedId())
		end
	end
end

local function StopSitting()
	if metadata.lastPos and (CfG_Sitdown.AlwaysTeleportOutOfSeat or CfG_Sitdown.TeleportToLastPosWhenNoRoute or CfG_Sitdown.SitTypes[metadata.type].teleportOut or metadata.teleportOut) then
		ClearPedTasksImmediately(PlayerPedId())
		SetEntityCoords(PlayerPedId(), vector3(metadata.lastPos.x, metadata.lastPos.y, metadata.lastPos.z-0.95))
	end
	LeaveSeat(true, false, false)
end

local function GetScenario(type)
	local scenarios = CfG_Sitdown.SitTypes[type].scenarios
	if not scenarios then return false, vector4(0.0, 0.0, 0.0, 0.0) end

	local index = 1
	if #scenarios > 1 then
		index = math.floor(math.random(100, #scenarios*100)/100 + 0.5)
	end

	return scenarios[index].name, scenarios[index].offset or CfG_Sitdown.SitTypes['default'].scenarios[1].offset
end

local function IsPlayerDoingAnyAction()
	if IsPedUsingScenario(PlayerPedId(), metadata.scenario) or metadata.isSitting or metadata.isLaying then
		return true
	else
		return false
	end
end

local function CanPlayerReachSeat(destination, entity)
	local ped = PlayerPedId()
	local coords = GetEntityCoords(ped)
	local start = vector3(coords.x, coords.y, coords.z+0.25)
	local rayHandle = StartShapeTestLosProbe(start, destination, -1, ped, 0)
	while true do
		Wait(0)
		local result, hit, endCoords, surfaceNormal, entityHit = GetShapeTestResult(rayHandle)
		if result ~= 1 then
			if GetEntityType(entityHit) ~= 1 then
				local dist = #(endCoords-destination)
				if (dist < 0.5 or endCoords.x == 0.0) or entityHit == entity then
					return true
				else
					return false
				end
			else
				rayHandle = StartShapeTestLosProbe(GetEntityCoords(entityHit), destination, -1, entityHit, 0)
			end
		end
	end
end

-- Checks if the seat is "sitable"
local function CanPlayerSitInSeat(coords, heading, entity)
	local rotation = HeadingToRotation(heading)
	local start = GetOffsetFromCoordsInWorldCoords(coords, vector3(0.0, 0.0, rotation), vector3(0.0, 0.30, 0.0))
	local destination = vector3(start.x, start.y, start.z+0.30)
	local rayHandle = StartShapeTestLosProbe(start, destination, -1, entity, 4)
	while true do
		Wait(0)
		local result, hit, endCoords, surfaceNormal, entityHit = GetShapeTestResult(rayHandle)
		if result ~= 1 then
			if hit == 0 then
				return true
			else
				return false
			end
		end
	end
end

local function SitOnSeat(data)
	metadata.attAction = true
	metadata.entity = data.entity
	metadata.poly = data.poly
	metadata.type = data.sit.type

    local seat = data.sit
	local settings = CfG_Sitdown.SitTypes[seat.type]
	local seatLocation = 0.0

	if not settings then
		print("^3Warning: No settings were set for type^2", seat.type, "^3 in CfG_Sitdown.SitTypes, the default settings were used instead!")
		seat.type = 'default'
		settings = CfG_Sitdown.SitTypes['default']
	end

	if data.entity ~= nil and data.entity ~= 0 then  
		local rot = GetEntityRotation(data.entity)
		local xRot = rot.x
		local yRot = rot.y

		if xRot < 0.0 then xRot = xRot*-1 end
		if yRot < 0.0 then yRot = yRot*-1 end

		local tilt = xRot + yRot
		if tilt > CfG_Sitdown.MaxTilt then
			DisplayNotification(CfG_Sitdown.Lang.Notification.TooTilted)
			metadata.attAction = false
			return
		end

		local seatCoords = GetEntityCoords(data.entity)
		seatLocation = vector4(seatCoords.x, seatCoords.y, seatCoords.z, GetEntityHeading(data.entity))
	end

	local coords, heading = GetAvailableSeat(seatLocation, seat.seats, data.raycast)
    if coords == nil then
		local model = GetEntityModel(data.entity)
        if model ~= 0 and GetAmountOfSeats(model) ~= 1 then
			DisplayNotification(CfG_Sitdown.Lang.Notification.NoAvailable)
        else
            DisplayNotification(CfG_Sitdown.Lang.Notification.OccupiedSit)
        end
		metadata.attAction = false
        return
    end

    if heading == nil then
        DisplayNotification(CfG_Sitdown.Lang.Notification.NoAvailable)
		print('^1Error: Heading was nil!')
		metadata.attAction = false
        return
    end

	local skipReachCheck = seat.skipSeeCheck or false
	if not skipReachCheck and not CanPlayerReachSeat(coords, data.entity) then
		DisplayNotification(CfG_Sitdown.Lang.Notification.CannotReachSeat)
		metadata.attAction = false
		return
	end

	if data.entity ~= 0 and not CanPlayerSitInSeat(coords, heading, data.entity) then
		DisplayNotification(CfG_Sitdown.Lang.Notification.CannotSitInSeat)
		metadata.attAction = false
		return
	end

	-- Scenario offsets
	local offset = vector4(0.0, 0.0, 0.0, 0.0)
	metadata.scenario, offset = GetScenario(seat.type)
	heading = heading + offset.w
	if heading > 360.0 then
		heading = heading - 360.0
	end
	local rotation = HeadingToRotation(heading)
	coords = GetOffsetFromCoordsInWorldCoords(coords, vector3(0.0, 0.0, rotation), offset.xyz)

	local playerPed = PlayerPedId()
	local lastPos = GetEntityCoords(playerPed)

	metadata.teleportOut = false
	metadata.lastPos = nil
	if CfG_Sitdown.AlwaysTeleportOutOfSeat or settings.teleportOut or seat.teleportOut then
		metadata.teleportOut = true
		metadata.lastPos = lastPos
	end

	-- If we are already sitting then leave the current seat first, however if we are attempting to sit on the current seat then stop sitting.
	if metadata.isSitting or metadata.isLaying then
		if #(coords-lastPos) < 0.2 then
			StopSitting()
			metadata.attAction = false
			return
		else
			if metadata.teleportOut then
				LeaveSeat(false, true, false)
			else
				LeaveSeat(true, false, false)
				Wait(2000)
			end
			metadata.entity = data.entity
		end
	end

	metadata.isLaying = false
	metadata.animation = {}

	ClearPedTasks(playerPed)
	if data.entity ~= 0 then
		HandleLooseEntity(data.entity)
	end

	local timeout = settings.timeout or CfG_Sitdown.SitTypes['default'].timeout
	local skipGoStraightTask = settings.skipGoStraightTask
	local prevDist = #(coords.xy - GetEntityCoords(playerPed).xy)
	local dist = prevDist
	local teleport = CfG_Sitdown.AlwaysTeleportToSeat or seat.teleportIn or settings.teleportIn
	local breakCounter = 0
	local tick = 0

	if not teleport and not skipGoStraightTask then
		local rotation = HeadingToRotation(heading)
		local gotoCoords = GetOffsetFromCoordsInWorldCoords(coords, vector3(0.0, 0.0, rotation), vector3(0.0, 0.695, 0.0))
		TaskGoStraightToCoord(playerPed, gotoCoords, 1, timeout*500, heading, 0.15)

		while true do
			Wait(500)
			if not metadata.attAction then
				return
			end

			local playerCoords = GetEntityCoords(playerPed)
			dist = #(gotoCoords.xy - playerCoords.xy)
			tick = tick + 1

			if dist < prevDist then 
				lastPos = playerCoords 
				prevDist = dist
			end 

			local diff = GetDifference(dist, prevDist)
			local taskStatus = GetScriptTaskStatus(playerPed, "SCRIPT_TASK_GO_STRAIGHT_TO_COORD") 

			if taskStatus == 0 or taskStatus == 7 then
				break
			elseif tick > timeout then
				break
			elseif dist > prevDist+0.1 and dist > 0.85 then
				breakCounter = breakCounter + 1
			elseif diff <= 0.085 and dist < CfG_Sitdown.MaxInteractionDist and dist > 0.05 and tick > 1 then
				breakCounter = breakCounter + 1
			else
				breakCounter = breakCounter - 1
				if breakCounter < 0 then
					breakCounter = 0
				end
			end

			if breakCounter > 2 and seat.type ~= "sunlounger" then
				break
			end
		end
		teleport = dist > 0.5 or false
		tick = 0
	end

	if metadata.scenario then
		metadata.targetPos = coords
		TaskStartScenarioAtPosition(playerPed, metadata.scenario, coords.x, coords.y, coords.z, heading, -1, false, teleport)

		while true do
			Wait(500)
			local playerCoords = GetEntityCoords(playerPed)
			dist = #(coords.xy - playerCoords.xy)
			tick = tick + 1

			local taskStatus = GetScriptTaskStatus(playerPed, "SCRIPT_TASK_START_SCENARIO_AT_POSITION")
			if taskStatus == 0 or taskStatus == 7 then
				break
			elseif IsPedUsingScenario(playerPed, metadata.scenario) and dist < 0.40 then
				metadata.isSitting = true
				break
			elseif tick > timeout then
				break
			elseif not IsPedUsingScenario(playerPed, metadata.scenario) then
				break
			end
		end
	else
		local animation = settings.animation
		if animation.offset then
			coords = coords+animation.offset.xyz
			heading = heading+animation.offset.w
		end
		metadata.targetPos = coords

		SetEntityCollision(playerPed, false, false)
		FreezeEntityPosition(playerPed, true)
		SetEntityCoords(playerPed, coords)
		SetEntityHeading(playerPed, heading)

		LoadAnimDict(animation.dict)
		TaskPlayAnim(playerPed, animation.dict, animation.name, 2.0, 2.0, -1, animation.flag or 1, 0, false, false, false)
		RemoveAnimDict(animation.dict)
		metadata.plyFrozen = true
		metadata.isSitting = true
		metadata.animation = animation
	end

	if metadata.isSitting then
		Wait(350)
		TriggerEvent('sit:helpTextThread', 'isSitting')
		TriggerEvent('sit:checkThread', 'isSitting')
	elseif dist <= 2.0 then
		TaskStartScenarioAtPosition(playerPed, metadata.scenario, coords.x, coords.y, coords.z, heading, -1, false, true)
		metadata.lastPos = lastPos
		metadata.isSitting = true

		Wait(350)
		TriggerEvent('sit:helpTextThread', 'isSitting')
		TriggerEvent('sit:checkThread', 'isSitting')
	else
		LeaveSeat(true, false, false)
	end
	metadata.attAction = false
end

local function SitOnClosestSeat()
	if metadata.attAction then
		DisplayNotification(CfG_Sitdown.Lang.Notification.AlreadyAttemptingToSit)
		return
	end
	
	local coords = GetEntityCoords(PlayerPedId())
    local chair = {
		entity = 0,
		dist = CfG_Sitdown.MaxInteractionDist
	}

    for model, data in pairs(Models) do
		if data.sit then
			local newChair = GetClosestObjectOfType(coords.x, coords.y, coords.z, CfG_Sitdown.MaxInteractionDist, model, false, true, true)
			if newChair ~= 0 then
				local dist = #(GetEntityCoords(newChair) - coords)
				if dist < chair.dist then
					chair.entity = newChair
					chair.dist = dist
				end
			end
		end
    end

	for group, data in pairs(PolyZones) do
		if data.enabled then
			if not data.radius or (#(data.center.xy - coords.xy) < data.radius) then
				for name, info in pairs(data.polys) do
					if info.sit then
						for indexName, seat in pairs(info.sit.seats) do
							local dist = #(seat.xyz - coords) 
							if dist < chair.dist then
								chair.name = name
								chair.group = group
								chair.dist = dist
							end
						end
					end
				end
			end
		end
	end

	if chair.name ~= nil then
		local seat = PolyZones[chair.group].polys[chair.name]
		SitOnSeat({entity = 0, poly = chair.name, sit = seat.sit, raycast = false})
	elseif chair.entity ~= 0 then
		SitOnSeat({entity = chair.entity, poly = false, sit = Models[GetEntityModel(chair.entity)].sit, raycast = false})
	else
		DisplayNotification(CfG_Sitdown.Lang.Notification.NoFound)
	end
end

local function LayDownOnBed(data)
	metadata.attAction = true
	metadata.isSitting = false
	metadata.plyFrozen = true
	metadata.scenario = false
	metadata.teleportOut = false
	metadata.entity = data.entity
	metadata.poly = data.poly
	metadata.type = data.bed.type
	
    local bed = data.bed
	local bedLocation = nil

	if data.entity then 
		local rot = GetEntityRotation(data.entity)
		local xRot = rot.x
		local yRot = rot.y

		if xRot < 0.0 then xRot = xRot*-1 end
		if yRot < 0.0 then yRot = yRot*-1 end

		local tilt = xRot + yRot
		if tilt > CfG_Sitdown.MaxTilt then
			DisplayNotification(CfG_Sitdown.Lang.Notification.TooTilted)
			metadata.attAction = false
			return
		end

		local bedCoords = GetEntityCoords(data.entity)
		bedLocation = vector4(bedCoords.x, bedCoords.y, bedCoords.z, GetEntityHeading(data.entity))
	else
		bedLocation = 0
	end

	local coords, heading = GetAvailableSeat(bedLocation, bed.seats, data.raycast)
    if coords == nil then
		local model = GetEntityModel(data.entity)
        if CfG_Sitdown.SitTypes[bed.type] and GetAmountOfSeats(model) ~= 1 then
			DisplayNotification(CfG_Sitdown.Lang.Notification.NoAvailable)
        else
            DisplayNotification(CfG_Sitdown.Lang.Notification.OccupiedSit)
        end
		metadata.attAction = false
        return
    end

    if heading == nil then
        DisplayNotification(CfG_Sitdown.Lang.Notification.NoAvailable)
		print('^1Error: Heading was nil!', heading)
		metadata.attAction = false
        return
    end

	if not IsSeatAvailable(coords, 'lay') then
		DisplayNotification(CfG_Sitdown.Lang.Notification.OccupiedLay)
		metadata.attAction = false
		return
	end

	local skipReachCheck = bed.skipSeeCheck or false
	if not skipReachCheck and not CanPlayerReachSeat(coords, data.entity) then
		DisplayNotification(CfG_Sitdown.Lang.Notification.CannotReachBed)
		metadata.attAction = false
		return
	end

	local playerPed = PlayerPedId()
	if CfG_Sitdown.AlwaysTeleportOutOfSeat or CfG_Sitdown.LayTypes[bed.type].teleportOut or bed.teleportOut then
		metadata.teleportOut = true
		metadata.lastPos = GetEntityCoords(playerPed)
	end

	local animation = nil
	if CfG_Sitdown.LayTypes[bed.type] then
		animation = CfG_Sitdown.LayTypes[bed.type].animation
	else
		print("^3Warning: No animation settings were set for type^2", bed.type, "^3 in CfG_Sitdown.LayTypes, the default animation settings were used instead!")
		animation = CfG_Sitdown.LayTypes['default'].animation
	end

	metadata.animation = animation
	if animation.offset then
		coords = GetOffsetFromCoordsInWorldCoords(coords, vector3(0.0, 0.0, HeadingToRotation(heading)), animation.offset.xyz)
		heading = heading+animation.offset.w
		if heading > 360 then 
			heading = heading - 360 
		end
	end

	LoadAnimDict(animation.dict)
	ClearPedTasksImmediately(playerPed)
	SetEntityCollision(playerPed, false, false)
	FreezeEntityPosition(playerPed, true)
	SetEntityCoords(playerPed, coords)
	SetEntityHeading(playerPed, heading)

	TaskPlayAnim(playerPed, animation.dict, animation.name, 2.0, 2.0, -1, animation.flag or 1, 0, false, false, false)
	RemoveAnimDict(animation.dict)

	Wait(350)
	metadata.isLaying = true
	metadata.attAction = false
	metadata.targetPos = coords
	TriggerEvent('sit:helpTextThread', 'isLaying')
	TriggerEvent('sit:checkThread', 'isLaying')
end

local function LayDownOnClosestBed()
	if metadata.attAction then
		DisplayNotification(CfG_Sitdown.Lang.Notification.AlreadyAttemptingToLay)
		return
	end

	local coords = GetEntityCoords(PlayerPedId())
    local bed = {
		entity = 0,
		dist = CfG_Sitdown.MaxInteractionDist
	}

	for model, data in pairs(Models) do
		if data.lay then
			local newBed = GetClosestObjectOfType(coords.x, coords.y, coords.z, CfG_Sitdown.MaxInteractionDist, model, false, true, true)
			if newBed ~= 0 then
				local dist = #(GetEntityCoords(newBed) - coords)
				if dist < bed.dist then
					bed.entity = newBed
					bed.dist = dist
				end
			end
		end
    end

	for group, data in pairs(PolyZones) do
		if data.enabled then
			if not data.radius or (#(data.center.xy - coords.xy) < data.radius) then
				for name, info in pairs(data.polys) do
					if info.lay then
						local dist = #(info.lay.seats[1].xyz - coords) 
						if dist < bed.dist then
							bed.name = name
							bed.group = group
							bed.dist = dist
						end
					end
				end
			end
		end
	end

	if bed.name ~= nil then
		local seat = PolyZones[bed.group].polys[bed.name]
		LayDownOnBed({entity = 0, poly = bed.name, bed = seat.lay, raycast = false})
	elseif bed.entity ~= 0 then
		LayDownOnBed({entity = bed.entity, poly = false, bed = Models[GetEntityModel(bed.entity)].lay, raycast = false})
	else
		DisplayNotification(CfG_Sitdown.Lang.Notification.NoBedFound)
	end
end

local function GetUpFromBed()
	local clearTask = true
	local exitAnim = CfG_Sitdown.LayTypes[metadata.type].exitAnim or CfG_Sitdown.LayTypes['default'].exitAnim
	metadata.isLaying = false

	if metadata.teleportOut then
		ClearPedTasksImmediately(PlayerPedId())
		SetEntityCoords(PlayerPedId(), vector3(metadata.lastPos.x, metadata.lastPos.y, metadata.lastPos.z-0.95))
		clearTask = false
	elseif exitAnim then
		local exitAnimType = CfG_Sitdown.LayTypes[metadata.type].exitAnimType or CfG_Sitdown.LayTypes['default'].exitAnimType
		local direction = nil

		if exitAnimType == 0 then
			if GetGameplayCamRelativeHeading() < 0 then
				direction = "m_getout_l"
			else
				direction = "m_getout_r"
			end
		elseif exitAnimType == 1 then
			direction = "m_getout_l"
		elseif exitAnimType == 2 then
			direction = "m_getout_r"
		else
			print('^1Error: exitAnimType:', exitAnimType, 'was not an expcted type, please correct this, setting type to 1 for this instance ("m_getout_r").')
			direction = "m_getout_r"
		end

		LoadAnimDict("savem_default@")
		TaskPlayAnim(PlayerPedId(), "savem_default@", direction, 1.0, 1.0, 3000, 0, 0, false, false, false)
		RemoveAnimDict("savem_default@")
		Wait(1400)
		clearTask = false
	end
	metadata.animation = {}
	LeaveSeat(clearTask, false, false)
end

local function StopCurrentAction()
	if IsPedUsingScenario(PlayerPedId(), metadata.scenario) or metadata.isSitting then
		StopSitting()
	elseif metadata.isLaying then
		GetUpFromBed()
	elseif metadata.attAction then
		metadata.attAction = false
		LeaveSeat(true, false, false)
	end
end

local function SetupBeds()
	local models = {}
    local index = 0
    for model, data in pairs(Models) do
		if data.lay then
			index = index + 1
			models[index] = model
		end
    end

	exports[CfG_Sitdown.Target]:AddTargetModel(models, {
		options = {
			{
				icon = CfG_Sitdown.Targeting.LayIcon,
				label = CfG_Sitdown.Targeting.LayLabel,
				action = function(entity)
					if not metadata.attAction then
						if metadata.isLaying then
							GetUpFromBed()
						else
							local model = GetEntityModel(entity)
							LayDownOnBed({entity = entity, poly = false, bed = Models[model].lay, raycast = true})
						end
					else
						DisplayNotification(CfG_Sitdown.Lang.Notification.AlreadyAttemptingToLay)
					end
				end
			},
		},
		distance = CfG_Sitdown.MaxInteractionDist
	})
end

local function SetupSeats()
	local models = {}
	local index = 0
    for model, data in pairs(Models) do
		if data.sit then
			index = index + 1
			models[index] = model
		end
    end

	exports[CfG_Sitdown.Target]:AddTargetModel(models, {
		options = {
			{
				icon = CfG_Sitdown.Targeting.SitIcon,
				label = CfG_Sitdown.Targeting.SitLabel,
				action = function(entity)
					if not metadata.attAction then
						if metadata.isSitting or metadata.isLaying then
							if entity == metadata.entity then
								SitOnSeat({entity = entity, poly = false, sit = Models[GetEntityModel(entity)].sit, raycast = true})
							else
								StopSitting()
							end
						else
							SitOnSeat({entity = entity, poly = false, sit = Models[GetEntityModel(entity)].sit, raycast = true})
						end
					else
						DisplayNotification(CfG_Sitdown.Lang.Notification.AlreadyAttemptingToSit)
					end
				end
			},
		},
		distance = CfG_Sitdown.MaxInteractionDist
	})
end

local function SetupPolyZones()
	if CfG_Sitdown.Target then
		for group, data in pairs(PolyZones) do
			if data.enabled then
				for name, info in pairs(data.polys) do
					-- Remove the zone if it already exists. (targeting script does the checking)
					exports[CfG_Sitdown.Target]:RemoveZone(name)

					if info.poly == nil then
						print("^1Error: PolyZone '"..name.."' could not be generated! (lacks poly specifications)")
					elseif info.lay == nil and info.sit == nil then
						print("^1Error: PolyZone '"..name.."' could not be generated! (no action assinged)")
					else
						local type = 'sit'
						local options = {}

						if info.lay then
							type = 'lay'
							options[#options+1] = {
								icon = CfG_Sitdown.Targeting.LayIcon,
								label = CfG_Sitdown.Targeting.LayLabel,
								action = function()
									if not metadata.attAction then
										if metadata.isLaying then
											GetUpFromBed()
										else
											LayDownOnBed({entity = 0, poly = name, bed = info.lay, raycast = true})
										end
									else
										DisplayNotification(CfG_Sitdown.Lang.Notification.AlreadyAttemptingToLay)
									end
								end
							}
						end

						if info.sit then 
							type = 'sit'
							options[#options+1] = {
								icon = CfG_Sitdown.Targeting.SitIcon,
								label = CfG_Sitdown.Targeting.SitLabel,
								action = function()
									if not metadata.attAction then
										if metadata.isSitting or metadata.isLaying then
											if name == metadata.poly then
												SitOnSeat({entity = 0, poly = name, sit = info.sit, raycast = true})
											else
												StopSitting()
											end
										else
											SitOnSeat({entity = 0, poly = name, sit = info.sit, raycast = true})
										end
									else
										DisplayNotification(CfG_Sitdown.Lang.Notification.AlreadyAttemptingToSit)
									end
								end
							}
						end

						local minZ = info.poly.minZ or (info.poly.center and info.poly.center.z-(info.poly.height/2)) or info[type].seats[1].z-(info.poly.height/2)
						local maxZ = info.poly.maxZ or (info.poly.center and info.poly.center.z+(info.poly.height/2)) or info[type].seats[1].z+(info.poly.height/2)
						local heading = info.poly.heading or info[type].seats[1].w
						local center = info.poly.center or info[type].seats[1].xyz

						if info.poly.type == "circle" then
							local radius = info.poly.radius
							if radius == nil then
								print("^3Warning: PolyZone '"..name.."' did not have a specified radius! Radius was automatically set to 1.5!")
								radius = 1.5
							end

							exports[CfG_Sitdown.Target]:AddCircleZone(name, center, radius, {
								name = name,
								heading = heading,
								debugPoly = CfG_Sitdown.DebugPoly,
								minZ = minZ,
								maxZ = maxZ,
								useZ = true
							}, {
								options = options,
								distance = CfG_Sitdown.MaxInteractionDist
							})
						else
							exports[CfG_Sitdown.Target]:AddBoxZone(name, center, info.poly.length, info.poly.width, {
								name = name,
								heading = heading,
								debugPoly = CfG_Sitdown.DebugPoly,
								minZ = minZ,
								maxZ = maxZ
							}, {
								options = options,
								distance = CfG_Sitdown.MaxInteractionDist
							})
						end
					end
				end
				print("^2Info: PolyZone group '"..group.."' was generated.")
			else
				print("^3Info: PolyZone group '"..group.."' is disabled.")
			end
		end
	end
end

local function SetupLocalization()
	AddTextEntry("sit_getup_keyboard", string.format(CfG_Sitdown.Lang.KeyMapping.GetUp, "~INPUT_BA1F4C6D~"))
    AddTextEntry("sit_getup_controller", string.format(CfG_Sitdown.Lang.KeyMapping.GetUp, "~INPUT_6ED7AA10~"))

	if CfG_Sitdown.UsePrompts then
		AddTextEntry("sit_on_keyboard", string.format(CfG_Sitdown.Lang.KeyMapping.SitDown, "~INPUT_93A2CC75~"))
		AddTextEntry("sit_down_controller", string.format(CfG_Sitdown.Lang.KeyMapping.SitDown, "~INPUT_53FA0B5E~"))
		AddTextEntry("lay_on_keyboard", string.format(CfG_Sitdown.Lang.KeyMapping.LayDown, "~INPUT_C15C4337~"))
		AddTextEntry("lay_down_controller", string.format(CfG_Sitdown.Lang.KeyMapping.LayDown, "~INPUT_49E4480F~"))
		AddTextEntry("both_on_keyboard", string.format(CfG_Sitdown.Lang.KeyMapping.SitDown, "~INPUT_93A2CC75~").."\n"..string.format(CfG_Sitdown.Lang.KeyMapping.LayDown, "~INPUT_C15C4337~"))
		AddTextEntry("both_down_controller", string.format(CfG_Sitdown.Lang.KeyMapping.SitDown, "~INPUT_53FA0B5E~").."\n"..string.format(CfG_Sitdown.Lang.KeyMapping.LayDown, "~INPUT_49E4480F~"))
	end
end

-- Prompt System
local function StartPromptSystem()
	-- Commands
	RegisterCommand("siton2", function(source, args, rawCommand)
		if metadata.showingPrompt then
			ExecuteCommand("sit")
		end
	end, false)
	RegisterCommand("sitdown", function(source, args, rawCommand)
		if metadata.showingPrompt then
			ExecuteCommand("sit")
		end
	end, false)
	
	RegisterCommand("layon", function(source, args, rawCommand)
		if metadata.showingPrompt then
			ExecuteCommand("lay")
		end
	end, false)
	RegisterCommand("laydown", function(source, args, rawCommand)
		if metadata.showingPrompt then
			ExecuteCommand("lay")
		end
	end, false)

	-- Keymapping
	RegisterKeyMapping('siton2', CfG_Sitdown.Lang.KeyBindingDesc.Keyboard.SitDown, 'keyboard', 'F')
	--RegisterKeyMapping('sitdown', CfG_Sitdown.Lang.KeyBindingDesc.PadAnalog.SitDown, 'PAD_ANALOGBUTTON', CfG_Sitdown.DefaultKeybinds.SitDown.SitPadAnalog)
	RegisterKeyMapping('layon', CfG_Sitdown.Lang.KeyBindingDesc.Keyboard.LayDown, 'keyboard', 'L')
	--RegisterKeyMapping('laydown', CfG_Sitdown.Lang.KeyBindingDesc.PadAnalog.LayDown, 'PAD_ANALOGBUTTON', CfG_Sitdown.DefaultKeybinds.SitDown.LayPadAnalog)

	-- A nested function!
	local function GetEntities()
		local handle, entity = FindFirstObject()
		local success = nil
		local objects = {}
		repeat
			objects[#objects+1] = entity
			success, entity = FindNextObject(handle)
		until not success
		EndFindObject(handle)
		return objects
	end
	
	-- Another nested function!
	local function ShowPromptText(type)
		metadata.showingPrompt = true
		local textHash = "sit_on_keyboard"

		if IsUsingKeyboard(1) then
			textHash = type.."_on_keyboard"
		else
			textHash = type.."_down_controller"
		end

		for i = 1, 25 do
			DisplayHelpTextThisFrame(textHash)
			Wait(0)
		end
	end

	-- Prompt Thread
	CreateThread(function()
		while true do
			local closest = { distance = CfG_Sitdown.MaxPromptDist, type = nil, coords = nil, entity = 0 }
			local playerPed = PlayerPedId()
			local playerCoords = GetEntityCoords(playerPed)
			local wait = 500

			if not metadata.isSitting and not metadata.isLaying and not metadata.attAction then
				local entites = GetEntities()
				for index, entity in pairs(entites) do
					local model = GetEntityModel(entity)
					if Models[model] then
						local coords = GetEntityCoords(entity)
						local dist = #(coords - playerCoords)
						if dist < closest.distance then
							closest.distance = dist
							closest.type = (Models[model].sit and Models[model].lay and "both") or (Models[model].sit and "sit") or (Models[model].lay and "lay") or nil
							closest.coords = coords
							closest.entity = entity
						end
					end
				end

				for group, data in pairs(PolyZones) do
					if data.enabled then
						if not data.radius or (#(data.center.xy - playerCoords.xy) < data.radius) then
							for name, information in pairs(data.polys) do
								for typeset, info in pairs(information) do
									if typeset == "sit" or typeset == "lay" then
										for index, coords in pairs(info.seats) do
											local dist = #(playerCoords-coords.xyz)
											if dist < closest.distance then
												closest.distance = dist
												closest.type = (information.sit and information.lay and "both") or (information.sit and "sit") or (information.lay and "lay") or nil
												closest.coords = coords.xyz
												closest.entity = 0
											end
										end
									end
								end
							end
						end
					end
				end

				if closest.distance < CfG_Sitdown.MaxPromptDist and CanPlayerReachSeat(closest.coords, closest.entity) then
					ShowPromptText(closest.type)
					wait = 0
				else
					metadata.showingPrompt = false
				end
			else
				wait = 1000
			end

			Wait(wait)
		end
	end)
end


-- Commands --
RegisterCommand("sit", function(source, args, rawCommand)
	if not IsPauseMenuActive() then
		if IsPlayerDoingAnyAction() then
			if not CfG_Sitdown.UsePrompts then
				StopCurrentAction()
			end
		else
			SitOnClosestSeat()
		end
	end
end, false)

RegisterCommand("lay", function(source, args, rawCommand)
	if not IsPauseMenuActive() then
		if IsPlayerDoingAnyAction() then
			if not CfG_Sitdown.UsePrompts then
				StopCurrentAction()
			end
		else
			LayDownOnClosestBed()
		end
	end
end, false)


-- KeyMapping --
RegisterKeyMapping('getup', CfG_Sitdown.Lang.KeyBindingDesc.Keyboard.GetUp, 'keyboard', CfG_Sitdown.DefaultKeybinds.GetUp.Keyboard)
RegisterCommand('getup', function()
	if not IsPauseMenuActive() then
		StopCurrentAction()
	end
end, false)

RegisterKeyMapping('standup', CfG_Sitdown.Lang.KeyBindingDesc.PadAnalog.GetUp, 'PAD_ANALOGBUTTON', CfG_Sitdown.DefaultKeybinds.GetUp.PadAnalog)
RegisterCommand('standup', function()
	if not IsPauseMenuActive() then
		StopCurrentAction()
	end
end, false)


-- Events/Threads --
AddEventHandler('sit:helpTextThread', function(type)
	CreateThread(function()
		while metadata[type] do
			if IsUsingKeyboard(1) then
				DisplayHelpTextThisFrame("sit_getup_keyboard")
			else
				DisplayHelpTextThisFrame("sit_getup_controller")
			end
			Wait(0)
		end
	end)
end)

AddEventHandler('sit:checkThread', function(type)
	CreateThread(function()
		while true do
			Wait(500)
			if not metadata[type] then
				break
			end

			-- Reduce strees
			if CfG_Sitdown.ReduceStress then
				--TriggerEvent("status:reduceStress", 0.15) -- keep in mind this is per 500 ms (500 ms = half a second).
			end

			-- Distance and animation check
			local playerPed = PlayerPedId()
			local playerPos = GetEntityCoords(playerPed)
			local distance = #(playerPos.xy - metadata.targetPos.xy)
			local distZ = playerPos.z - metadata.targetPos.z - 1.25
			if distZ > 0.0 then
				distance = distance + distZ
			end

			if distance > 0.5 or (metadata.scenario and not IsPedUsingScenario(playerPed, metadata.scenario) or (metadata.animation and metadata.animation.dict and not IsEntityPlayingAnim(playerPed, metadata.animation.dict, metadata.animation.name, 3))) or IsEntityDead(playerPed) then
				local clearTask = true
				if IsEntityDead(playerPed) then
					clearTask = false
				end

				LeaveSeat(clearTask, false, true)
				break
			end
		end
	end)
end)


-- Initialization --
CreateThread(function()
	-- Set up localization
	SetupLocalization()

	-- Chat command suggestions
	if CfG_Sitdown.AddChatSuggestions then
    	TriggerEvent('chat:addSuggestion', '/sit', CfG_Sitdown.Lang.ChatSuggestions.Sit)
		TriggerEvent('chat:addSuggestion', '/lay', CfG_Sitdown.Lang.ChatSuggestions.Lay)
	end

	-- Prompts
	if CfG_Sitdown.UsePrompts then
		StartPromptSystem()
	end

	-- Targeting
	if CfG_Sitdown.Target then
		SetupBeds()
		SetupSeats()
		SetupPolyZones()
	end
end)


-- Debugging --
-- This is some of the code I used when I was debugging/adding new models and polys.
if CfG_Sitdown.Debugmode then
	local debugging = true
	local function DrawText3D(coords, text, rgb)
		SetTextColour(rgb.r, rgb.g, rgb.b, 255)
		SetTextScale(0.0, 0.35)
		SetTextFont(4)
		SetTextDropshadow(0, 0, 0, 0, 55)
		SetTextDropShadow()
		SetTextOutline()
		SetTextCentre(true)
		SetTextProportional(1)
		SetTextEdge(2, 0, 0, 0, 150)

		-- Diplay the text
		BeginTextCommandDisplayText("STRING")
		AddTextComponentSubstringPlayerName(text)
		SetDrawOrigin(coords, 0)
		EndTextCommandDisplayText(0.0, 0.0)
		ClearDrawOrigin()
		DrawRect(coords.x, coords.y, 1.0, 1.0, 230, 230, 230, 255)
	end
	
	local function GetDebugEntities(playerPed)
		local playerCoords = GetEntityCoords(playerPed)
		local handle, entity = FindFirstObject()
		local success = nil
		local objects = {}
		repeat
			local pos = GetEntityCoords(entity)
			local distance = #(playerCoords- pos)
			if distance < 8.0 then
				objects[#objects+1] = {pos = pos, entity = entity}
			end
	
			success, entity = FindNextObject(handle)
		until not success
		EndFindObject(handle)
		return objects
	end

	local function DebugIsSeatAvailable(coords, action)
		local playerPed = PlayerPedId()
		for index, ped in pairs(GetNearbyPeds()) do
			local dist = #(GetEntityCoords(ped)-coords)
			if dist < 1.35 then
				if action == 'sit' then
					if IsEntityPlayingAnyLayAnim(ped) or dist < 0.55 then
						return false
					end
				elseif action == 'lay' then
					if IsEntityPlayingAnyLayAnim(ped) or IsPedSitting(ped) then
						return false
					end
				end
			end
		end
		return true
	end

	-- A debug thread, the messiest shit I've ever made.
	local function StartDebuging()
		local toDisplay = {}
		local colors = {
			['occupied'] = {r=200, g=0, b=0},
			['sit'] = {r=255, g=255, b=255},
			['lay'] = {r=150, g=150, b=150},
			['sit_line'] = {r=255, g=0, b=0, a=200},
			['lay_line'] = {r=0, g=102, b=204, a=255}
		}

		CreateThread(function()
			while debugging do 
				local globalIndex = 0
				local playerPed = PlayerPedId()
				local playerCoords = GetEntityCoords(playerPed)
				toDisplay = {}

				local entites = GetDebugEntities(playerPed)
				for k, info in pairs(entites) do
					local model = GetEntityModel(info.entity)
					local information = Models[model]
					if information then
						for typeset, data in pairs(information) do
							for seatIndex, seat in pairs(data.seats) do
								local subName = typeset..": "..model
								if #data.seats > 1 then
									subName = subName.." ("..seatIndex..")"
								end
								local heading = GetEntityHeading(info.entity)
								local coords = nil
								if typeset == "lay" then
									coords = GetOffsetFromCoordsInWorldCoords(info.pos, vector3(0.0, 0.0, HeadingToRotation(heading)), vector3(seat.x, seat.y, seat.z+0.25))
								else
									coords = GetOffsetFromCoordsInWorldCoords(info.pos, vector3(0.0, 0.0, HeadingToRotation(heading)), seat.xyz)
								end
								local newHeading = heading + seat.w
								if newHeading > 360 then
									newHeading = newHeading - 360 
								end
	
								local textColor = colors[typeset]
								if not DebugIsSeatAvailable(coords.xyz, typeset) then
									textColor = colors['occupied']
								end
								globalIndex = globalIndex + 1 
								toDisplay[globalIndex] = { vector4(coords.xyz, newHeading), subName, textColor, colors[typeset.."_line"]}
							end
						end
					end
				end

				for group, data in pairs(PolyZones) do
					if data.enabled then
						if not data.radius or (#(data.center.xy - playerCoords.xy) < data.radius) then
							for name, information in pairs(data.polys) do
								for typeset, info in pairs(information) do
									if typeset == "sit" or typeset == "lay" then
										for index, coords in pairs(info.seats) do
											if #(playerCoords-coords.xyz) < 8.0 then
												local subName = typeset..": "..name
												if #info.seats > 1 then
													subName = subName.." ("..index..")"
												end
												local location = coords
												if typeset == "lay" then
													location = GetOffsetFromCoordsInWorldCoords(coords, vector3(0.0, 0.0, 0.0), vector3(0.0, 0.0, 0.25))
												end

												local textColor = colors[typeset]
												if not DebugIsSeatAvailable(location.xyz, typeset) then
													textColor = colors['occupied']
												end
												globalIndex = globalIndex + 1 
												toDisplay[globalIndex] = {vector4(location.xyz, coords.w), subName, textColor, colors[typeset.."_line"]}
											end
										end
									end
								end
							end
						end
					end
				end
				Wait(1000)
			end
		end)

		CreateThread(function()
			while debugging do 
				for index, data in pairs(toDisplay) do
					DrawText3D(data[1].xyz, data[2], data[3])
				end
				Wait(0)
			end
		end)

		CreateThread(function()
			while debugging do 
				for index, data in pairs(toDisplay) do
					if data[1].w ~= nil then
						DrawLine(data[1].xyz, GetOffsetFromCoordsInWorldCoords(data[1].xyz, vector3(0.0, 0.0, HeadingToRotation(data[1].w)), vector3(0.0, 0.50, 0.0)), data[4].r, data[4].g, data[4].b, data[4].a)
						DrawLine(data[1].xyz, GetOffsetFromCoordsInWorldCoords(data[1].xyz, vector3(0.0, 0.0, HeadingToRotation(data[1].w)), vector3(0.0, 0.00, 0.20)), data[4].r, data[4].g, data[4].b, data[4].a)
					end
				end
				Wait(0)
			end
		end)
	end

	RegisterKeyMapping('sit:debug', 'sit Debuging', 'keyboard', 'G')
	RegisterCommand('sit:debug', function(source, args, rawCommand)
		debugging = not debugging
		if debugging then
			StartDebuging()
		end
	end, false)

	local function GetAverage(table)
		local sum = 0
		for key, value in pairs(table) do
			sum = sum + value
		end
		return sum / #table
	end

	-- Not a true "center", as it calculates the average of all the points, but it's good enough for our purpose.
	RegisterCommand('sit:getcenter', function(source, args, rawCommand)
		local group = args[1] 
		if PolyZones[group] then
			local xPoints = {}
			local yPoints = {}
			local zPoints = {}
	
			local index = 0
			for k, v in pairs(PolyZones[group].polys) do
				index = index + 1
				xPoints[index] = (v.poly.center and v.poly.center.x) or (v.sit and v.sit.seats[1].x) or (v.lay and v.lay.seats[1].x)
				yPoints[index] = (v.poly.center and v.poly.center.y) or (v.sit and v.sit.seats[1].y) or (v.lay and v.lay.seats[1].y)
				zPoints[index] = (v.poly.center and v.poly.center.z) or (v.sit and v.sit.seats[1].z) or (v.lay and v.lay.seats[1].z)
			end
	
			local average = vector3(GetAverage(xPoints), GetAverage(yPoints), GetAverage(zPoints))
			print('average "center":', average)
		else
			print(group, 'is not a valid poly group!')
		end
	end, false)

	RegisterCommand('sit:getfarthestdist', function(source, args, rawCommand)
		local group = args[1] 
		if PolyZones[group] and PolyZones[group].center then
			local center = PolyZones[group].center
			local farthest = {
				dist = 0,
				name = 'error'
			}
	
			for name, data in pairs(PolyZones[group].polys) do
				local pos = data.poly.center or (data.sit and data.sit.seats[1].xyz) or (data.lay and data.lay.seats[1].xyz)
				local distance = #(center-pos)
				if distance > farthest.dist then
					farthest.dist = distance
					farthest.name = name
				end
			end
	
			print(farthest.name, farthest.dist)
		else
			print(group, 'is not a valid poly group!')
		end
	end, false)

	-- Load poly groups (only on your client)
	RegisterCommand('sit:loadGroup', function(source, args, rawCommand)
		local group = args[1] 
		if PolyZones[group] and PolyZones[group].center then
			PolyZones[group].enabled = true
			SetupPolyZones()
		else
			print(group, 'is not a valid poly group!')
		end
	end, false)

	-- Unload poly groups (only on your client)
	RegisterCommand('sit:unloadGroup', function(source, args, rawCommand)
		local group = args[1] 
		if PolyZones[group] and PolyZones[group].center then
			PolyZones[group].enabled = false
			for name, info in pairs(PolyZones[group].polys) do
				exports[CfG_Sitdown.Target]:RemoveZone(name)
			end
		else
			print(group, 'is not a valid poly group!')
		end
	end, false)

	StartDebuging()
end
