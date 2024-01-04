Config_Fraksperre = {}

Config_Fraksperre.time = 4320 --WIE LANGE DIE FRAKSPERRE ANHALTEN SOLL! IN MINUTEN
Config_Fraksperre.CommandName = "removefraksperre"
Config_Fraksperre.CommandAllowedGroups = {
    "pl",
    "management",
    "frakv",
    "supleitung",
}

Config_Fraksperre.unemployed = "unemployed"

Config_Fraksperre.Notify = function(player, msg)
    TriggerCientEvent("cataleya_hud:sendNotify", "info", "Information", msg, 5000)
end
