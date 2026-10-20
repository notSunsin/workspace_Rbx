-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Data.QuestData.Types);
local ItemImageFinder = require(ReplicatedStorage.Modules.ItemImageFinder);
local SeedShopData = require(ReplicatedStorage.Data.SeedShopData);

return {
    Type = "RandomSeed",

    Display = function(p1, p2) -- Line: 16, Name: Display
        local Amount = p2.Data.Amount;

        return `+{Amount} Random Seed Shop Seeds {Amount > 1 and "s" or ""}`;
    end,

    DisplayIcon = function(p3, p4) -- Line: 21, Name: DisplayIcon
        -- upvalues: ItemImageFinder (copy)
        return ItemImageFinder(p4.Data.Type or "", "RandomSeed");
    end,

    Give = function(p5, p6, p7) -- Line: 25, Name: Give
        -- upvalues: ReplicatedStorage (copy), SeedShopData (copy)
        game:GetService("ServerScriptService");
        local Give_Seed = require(ReplicatedStorage.Give_Seed);
        local Random_new_ret = Random.new();
        local v8 = {};

        for i, v in SeedShopData do
            if not v.SpecialCurrencyType then
                table.insert(v8, i);
            end;
        end;

        for i = 1, p7.Data.Amount do
            local v9 = v8[Random_new_ret:NextInteger(1, #v8)];
            task.spawn(Give_Seed.Give_Seed, p6, v9);
            local _ = i;
        end;

        return true;
    end,

    Use = function(p10, p11) -- Line: 48, Name: Use
        return {
            Type = p10.Type,
            Data = p11
        };
    end
};