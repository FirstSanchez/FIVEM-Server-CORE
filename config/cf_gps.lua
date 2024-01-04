CFG_Tracker = {}

CFG_Tracker = {
    Refresh = 30000, -- in ms
    NeedsItem = true, -- if the player needs the item
    Item = 'tracker', -- item name
    Jobs = {
        ['police'] = {
            color = 38,
            sprite = 60
        },
        ['ambulance'] = {
            color = 1,
            sprite = 61
        },
        ['mechanic'] = {
            color = 5,
            sprite = 446
        },
    }
}
