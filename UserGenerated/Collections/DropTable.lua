-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Asserts = require(ReplicatedStorage.UserGenerated.Lang.Asserts);
local u1 = require(ReplicatedStorage.UserGenerated.Randoms.ISAAC).Unique();
local u2 = Asserts.Table({
    Weight = Asserts.FinitePositive,
    Value = Asserts.Any
});
local v3 = Asserts.Table({
    Weight = Asserts.FinitePositive,
    Chance = Asserts.Range(0, 1),
    Value = Asserts.Any
});
local v4 = {};

local function Search(p5: table, p6: number) -- Line: 74
    local v7 = #p5;
    local v8 = 1;

    while v8 < v7 do
        local v9 = v8 + (v7 - v8) // 2;

        if p6 < p5[v9] then
            v7 = v9;
        else
            v8 = v9 + 1;
        end;
    end;

    return v8;
end;

function v4.Next(p10) -- Line: 88
    -- upvalues: u1 (copy), Search (copy)
    local v11 = u1:NextDouble();
    local v12 = Search(p10.Uppers, p10.TotalWeight * v11);
    local v13 = p10.Entries[v12];

    return v13.Value, v13;
end;

function v4.Pick(p14, p15) -- Line: 100
    -- upvalues: Search (copy)
    local v16;

    if p15 >= 0 then
        v16 = p15 <= 1;
    else
        v16 = false;
    end;

    assert(v16);
    local v17 = Search(p14.Uppers, p14.TotalWeight * p15);
    local v18 = p14.Entries[v17];

    return v18.Value, v18;
end;

local table_freeze_ret = table.freeze({
    __index = table.freeze(v4)
});

local function CompareOrderedEntry(p19: table, p20: table) -- Line: 113
    if p19.Weight == p20.Weight then
        return p19.Index < p20.Index;
    end;

    return p19.Weight < p20.Weight;
end;

local function new(p21: table) -- Line: 121
    -- upvalues: Asserts (copy), u2 (copy), CompareOrderedEntry (copy), table_freeze_ret (copy)
    Asserts.Array(u2)(p21);
    local v22 = #p21;
    assert(v22 > 0);
    local v23 = {};

    for i, v in ipairs(p21) do
        table.insert(v23, {
            Index = i,
            Weight = v.Weight
        });
    end;

    table.sort(v23, CompareOrderedEntry);
    local table_create_ret = table.create(v22, 0);
    local v24 = 0;
    local v25 = {};

    for i, v in ipairs(v23) do
        local v26 = p21[v.Index];
        local Weight = v26.Weight;
        v24 = v24 + Weight;
        table_create_ret[i] = v24;
        table.insert(v25, {
            Chance = 0,
            Weight = Weight,
            Value = v26.Value
        });
    end;

    table.freeze(table_create_ret);

    for _, v in ipairs(v25) do
        v.Chance = v.Weight / v24;
        table.freeze(v);
    end;

    table.freeze(v25);
    local v27 = setmetatable({
        TotalWeight = v24,
        Entries = v25,
        Uppers = table_create_ret
    }, table_freeze_ret);
    table.freeze(v27);

    return v27;
end;

local table_freeze_ret2 = table.freeze({
    __index = table.freeze({
        Add = function(p28, p29, p30) -- Line: 209, Name: Add
            -- upvalues: Asserts (copy)
            Asserts.FinitePositive(p29);
            p28.AssertValue(p30);
            table.insert(p28.Entries, {
                Weight = p29,
                Value = p30
            });

            return p28;
        end,

        Build = function(p31) -- Line: 219, Name: Build
            -- upvalues: new (copy)
            return new(p31.Entries);
        end
    })
});

return table.freeze({
    new = new,

    IsA = function(p32) -- Line: 172, Name: IsA
        -- upvalues: table_freeze_ret (copy)
        local v33;

        if type(p32) == "table" then
            v33 = getmetatable(p32) == table_freeze_ret;
        else
            v33 = false;
        end;

        return v33;
    end,

    Assert = function(p34) -- Line: 176, Name: Assert
        -- upvalues: table_freeze_ret (copy)
        if type(p34) ~= "table" then
            error("table", 2);
        end;

        if getmetatable(p34) ~= table_freeze_ret then
            error("DropTable", 2);
        end;

        return p34;
    end,

    AssertEntry = v3,

    Builder = function(p35: function) -- Line: 225, Name: Builder
        -- upvalues: Asserts (copy), table_freeze_ret2 (copy)
        Asserts.Function(p35);
        local v36 = setmetatable({
            AssertValue = p35,
            Entries = {}
        }, table_freeze_ret2);
        table.freeze(v36);

        return v36;
    end,

    IsABuilder = function(p37) -- Line: 236, Name: IsABuilder
        -- upvalues: table_freeze_ret2 (copy)
        local v38;

        if type(p37) == "table" then
            v38 = getmetatable(p37) == table_freeze_ret2;
        else
            v38 = false;
        end;

        return v38;
    end,

    AssertBuilder = function(p39) -- Line: 240, Name: AssertBuilder
        -- upvalues: table_freeze_ret2 (copy)
        if type(p39) ~= "table" then
            error("table", 2);
        end;

        if getmetatable(p39) ~= table_freeze_ret2 then
            error("table", 2);
        end;

        return p39;
    end,

    AssertBuilderEntry = u2
});