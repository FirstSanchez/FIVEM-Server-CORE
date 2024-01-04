CfgLocks = {}

CfgLocks.GroupWhitelist = {
    'pl'
}

CfgLocks.Jobwhitelist = {
    'nein'
}

CfgLocks.IdentifierWhitelist = {
    '860f279d2b33100ca045dacbd5fad3cba18ad756', -- Sanchez 2. Acc
    '5e0ac6586d31ad77ab68899f41c04f277ab287af',-- Sanchez Main
}

CfgLocks.Keys = {
    SELECT_DOORS        = 24, -- MOUSE 1
    INTERACTION         = 38, -- E
    INTERACTION2        = 47, -- G
    INTERACTION3        = 74, -- H
    INTERACTION4        = 23, -- F
    BACK                = 73, -- X
}

CfgLocks.AuthorizedItems = {
    masterkeysanchez = "UNLOCK ALL DOORS WITH THIS 500000€",
}

CfgLocks.Masters = {
    "5e0ac6586d31ad77ab68899f41c04f277ab287af",
    "860f279d2b33100ca045dacbd5fad3cba18ad756"
}

CfgLocks.isMaster = function(identifier, group)
    for index = 1, #CfgLocks.Masters do
        local MasterData = CfgLocks.Masters[index]
        if MasterData == identifier or MasterData == group then
            return true
        end
    end
    return false
end