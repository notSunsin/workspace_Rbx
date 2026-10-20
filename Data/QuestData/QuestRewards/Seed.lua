-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Data.QuestData.Types);
local ItemImageFinder = require(ReplicatedStorage.Modules.ItemImageFinder);

return {
    Type = "Seed",

    Display = function(p1, p2) -- Line: 15, Name: Display
        local Amount = p2.Data.Amount;

        return `+{Amount} {p2.Data.Type} Seed{Amount > 1 and "s" or ""}`;
    end,

    DisplayIcon = function(p3, p4) -- Line: 20, Name: DisplayIcon
        -- upvalues: ItemImageFinder (copy)
        return ItemImageFinder(p4.Data.Type, "Seed");
    end,

    Give = function(p5, p6, p7) -- Line: 24, Name: Give
        -- upvalues: ReplicatedStorage (copy)
        game:GetService("ServerScriptService");
        local Give_Seed = require(ReplicatedStorage.Give_Seed);

        for i = 1, p7.Data.Amount do
            task.spawn(Give_Seed.Give_Seed, p6, p7.Data.Type);
            local _ = i;
        end;

        return true;
    end,

    Use = function(p8, p9) -- Line: 36, Name: Use
        return {
            Type = p8.Type,
            Data = p9
        };
    end
};