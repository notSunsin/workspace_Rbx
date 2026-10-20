-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CommaFormatNumber = require(ReplicatedStorage.Modules.CommaFormatNumber);
require(ReplicatedStorage.Modules.GiveServiceCommon.RewardDataTypes);
local u1 = { "Seed Pack", "Chest", "Gear Box", "Gift Box", "Present", "Gift" };

local function endswith(p2, p3) -- Line: 20
    return #p3 == 0 and true or p2:sub(-#p3) == p3;
end;

return {
    Use = function(p4: table, p5: string, p6: number?) -- Line: 26, Name: Use
        local v7 = require(game.ReplicatedStorage.Data.SeedPackData).Packs[p5];
        local v8 = `Seed Pack Item "{p5}" is an invalid entry. Please fix`;
        assert(v7, v8);

        return {
            Type = "Seed Pack",
            Value = p5,
            Quantity = p6 or 1
        };
    end,

    Format = function(p9, p10) -- Line: 34, Name: Format
        -- upvalues: u1 (copy), CommaFormatNumber (copy)
        local v11 = p10.Quantity or 1;
        local Value = p10.Value;
        local v12 = false;

        for _, v in u1 do
            if #v == 0 and true or p10.Value:sub(-#v) == v then
                v12 = true;
                break;
            end;
        end;

        if not v12 then
            Value = Value .. " Seed Pack";
        end;

        return `{CommaFormatNumber(v11)}x {Value}`;
    end,

    GetImage = function(p13, p14) -- Line: 54, Name: GetImage
        -- upvalues: ReplicatedStorage (copy)
        return require(ReplicatedStorage.Modules.ItemImageFinder)(p14.Value, "Seed Pack");
    end,

    GetRarity = function(p15, p16) -- Line: 59, Name: GetRarity
        return "Common";
    end
};