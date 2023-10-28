Config_Fraksperre = {}

Config_Fraksperre.time = 4320 --WIE LANGE DIE FRAKSPERRE ANHALTEN SOLL! IN MINUTEN
Config_Fraksperre.CommandName = "removefraksperre"
Config_Fraksperre.CommandAllowedGroups = {
    "papapl",
    "stvpl",
    "manager",
    "frakleitung",
}

Config_Fraksperre.unemployed = "unemployed"

Config_Fraksperre.Notify = function(player, msg)
    TriggerCientEvent("prime_notify", "info", "Information", msg, 5000)
end
