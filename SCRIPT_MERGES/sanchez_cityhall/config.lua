Config = {}

Config.General = {
    
    position = { -- -545.1060, -204.1982, 38.2152, 212.6393
        coords = vector3(-545.2240, -204.2595, 39.2152), -- The position of the NPC and the marker (x, y, z) /// If you want to use the NPC and the marker, you need to set enable to true
        interactionRadius = 1.5, -- The radius in which the player can interact with the NPC
        interactKey = 38, -- E key
        interactText = "Drücke um auf das Bürgeramt zuzugreifen",  -- Text shown when the player is in the interaction radius

        marker = {
            enable = true, -- If false, the marker will be disabled
            type = 0,  -- Marker type (https://docs.fivem.net/docs/game-references/markers/)
            scale = vector3(0.5, 0.5, 0.5), 
            color = vector3(114, 224, 255),  -- RGB SYSTEM (0-255)
            alpha = 255, -- Opacity
        },
    }, 

    blip = {
        enable = true, -- If false, the blip will be disabled
        sprite = 419, -- Blip sprite (https://docs.fivem.net/docs/game-references/blips/)
        color = 3, -- Blip color
        scale = 0.8, -- Blip scale
        name = "Stadthalle", -- Blip name
    },

    npc = {
        enable = false, -- If false, the NPC will be disabled
        model = "a_m_m_bevhills_01", 
        heading = 0.0,
        pos = vector3(-545.1060, -204.1982, 38.2152),
    },

}

Config.Namechange = {

    price = 50000, -- The price for a namechange
    
    item = {
        needItem = false, -- If true, the player will need the item to change his name
        itemName = "item_namechange", -- The name of the item
        itemLabel = "Namechange", -- The label of the item (shown in the inventory)
    },
    
}

Config.SocialMoney = {

    enable = false, -- If false, the social money option will be disabled   (DONT TOUCH)

    allowedJobs = { -- If empty, all jobs will be allowed /// If not empty, only the jobs in the table will be allowed /// "unemployed" will allow unemployed players
        "unemployed",
        "police",
        "ambulance",
    },

    money = {    
        payment = 50, -- The amount of money the player will receive 
        paymentSchedule = 30, -- In minutes
        automaticMode = true, -- If true, the payment will be automatic transferred to the player's bank account /// If false, the player will need to withdraw the money
    },

}


Config.Marriage = {

    general = {
        allowSameGender = false, -- Gleiches Geschlecht Marry KEKW
    },

    cost = {
        marriagePrice = 10000, -- The price for a marriage
        marriageDivorcePrice = 500, -- The price for a divorce
    },
    
    item = {
        needItem = false, -- If true, the player will need the item to marry
        itemName = "wedding_ring",
        itemLabel = "Wedding Ring"
    },

    notify = {
        notifyAll = true, -- this will notify all players in the server
        notifyAllmsg = "Der Spieler %s ist jetzt verheiratet mit %s", -- %s = name of the player
    },
    


}

Config.Leaderboard = {

    enable = true, -- If false, the leaderboard will be disabled

    leaderboard = {
        limit = 5, -- The amount of players shown in the leaderboard
        sortBy = "bank", -- The value to sort by (bank, money, black_money) || Just for "Richest Players"
    },

}

-- Change trigger events to your own framework or script

function clientNotify(message)
    TriggerEvent("prime_notify", "info", title, message)
end

function serverNotify(source, message)
    TriggerClientEvent("esx:showNotification", source, message)
end