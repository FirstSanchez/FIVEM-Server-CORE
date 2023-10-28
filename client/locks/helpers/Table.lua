Helpers.Table = {}

function Helpers.Table.Exists(tbl, val)
    for i,v in ipairs(tbl) do
        if v == val then return true end
    end

    return false
end

function Helpers.Table.FindIndex(tbl, val, index)
    for i,v in ipairs(tbl) do
        if v == val then return i end
    end

    return nil
end



function Helpers.Table.Clone(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[Helpers.Table.Clone(orig_key)] = Helpers.Table.Clone(orig_value)
        end
        setmetatable(copy, Helpers.Table.Clone(getmetatable(orig)))
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end