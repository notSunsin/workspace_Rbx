-- Decompiled with Potassium's decompiler.

local None = require(script.Parent.Parent.None);
local isDataStructure = require(script.Parent.Parent.utils.isDataStructure);
local slice = require(script.Parent.slice);
local get = require(script.Parent.get);
local remove = require(script.Parent:FindFirstChild("remove"));
local set = require(script.Parent.set);

local function toString(p1) -- Line: 12
    return table.concat(p1, ", ");
end;

local function updateInDeeply(p2: any, p3: table, p4: number, p5: function, p6: any) -- Line: 16
    -- upvalues: None (copy), isDataStructure (copy), slice (copy), get (copy), updateInDeeply (copy), remove (copy), set (copy)
    local v7 = p2 == None;

    if p4 == #p3 + 1 then
        if not v7 then
            p6 = p2;
        end;

        local v8 = p5(p6);

        if v8 == p6 then
            return p2;
        end;

        return v8;
    end;

    if not (v7 or isDataStructure(p2)) then
        local v9 = error;
        local v10 = slice(p3, 1, p4 - 1);
        v9("Cannot update within non-data-structure value in path [" .. table.concat(v10, ", ") .. "]: " .. tostring(p2));
    end;

    local v11 = p3[p4];
    local v12;

    if v7 then
        v12 = None;
    else
        v12 = get(p2, v11, None);
    end;

    local v13 = updateInDeeply(v12, p3, p4 + 1, p5, p6);

    if v13 == v12 then
        return p2;
    end;

    if v13 == None then
        return remove(p2, v11);
    end;

    return set(v7 and {} or p2, v11, v13);
end;

return function(p14: table, p15: table, p16: function, p17: any) -- Line: 49
    -- upvalues: updateInDeeply (copy), None (copy)
    local v18 = updateInDeeply(p14, p15, 1, p16, p17);

    if v18 == None then
        return p17;
    end;

    return v18;
end;