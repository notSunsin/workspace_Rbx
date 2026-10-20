-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CommaFormatNumber = require(ReplicatedStorage.Modules.CommaFormatNumber);
require(ReplicatedStorage.Modules.GiveServiceCommon.RewardDataTypes);
local v1 = {};

local function endswith(p2, p3) -- Line: 12
    return #p3 == 0 and true or p2:sub(-#p3) == p3;
end;

function v1.Use(p4: table, p5: string, p6: number?, p7: string?) -- Line: 16
    local v8 = require(game.ReplicatedStorage.Data.SeedData)[p5];
    local v9 = `Seed Item "{p5}" is an invalid entry. Please fix`;
    assert(v8, v9);

    return {
        Type = "Seed",
        Value = p5,
        Quantity = p6 or 1,
        Variant = p7
    };
end;

function v1.Format(p10, p11) -- Line: 23
    -- upvalues: CommaFormatNumber (copy)
    local v12 = p11.Quantity or 1;
    local Value = p11.Value;

    if p11.Variant then
        Value = p11.Variant .. " " .. Value;
    end;

    if Value:sub(-4) ~= "Seed" then
        Value = Value .. " Seed";
    end;

    return `{CommaFormatNumber(v12)}x {Value}`;
end;

function v1.GetImage(p13, p14) -- Line: 38
    -- upvalues: ReplicatedStorage (copy)
    return require(ReplicatedStorage.Modules.ItemImageFinder)(p14.Value, "Seed");
end;

function v1.GetRarity(p15, p16) -- Line: 43
    -- upvalues: ReplicatedStorage (copy)
    local v17 = require(ReplicatedStorage.Data.SeedData)[p16.Value];

    return not v17 and "Common" or v17.SeedRarity;
end;

return v1;