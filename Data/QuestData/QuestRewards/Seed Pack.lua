-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Data.QuestData.Types);
local ItemImageFinder = require(ReplicatedStorage.Modules.ItemImageFinder);

return {
    Type = "Seed Pack",

    Display = function(p1, p2) -- Line: 15, Name: Display
        local Amount = p2.Data.Amount;
        local v3 = `Seed Pack{Amount > 1 and "s" or ""}`;

        if p2.Data.Type and p2.Data.Type ~= "Normal" then
            return `+{Amount} {p2.Data.Type} {v3}`;
        end;

        return `+{Amount} {v3}`;
    end,

    DisplayIcon = function(p4, p5) -- Line: 23, Name: DisplayIcon
        -- upvalues: ItemImageFinder (copy)
        return ItemImageFinder(p5.Data.Type or "Normal", "Seed Pack");
    end,

    Give = function(p6, p7, p8) -- Line: 27, Name: Give
        local ServerScriptService = game:GetService("ServerScriptService");
        require(ServerScriptService.Modules.SeedPackService):Give(p7, p8.Data.Type or "Normal", p8.Data.Amount);

        return true;
    end,

    Use = function(p9, p10) -- Line: 34, Name: Use
        return {
            Type = p9.Type,
            Data = p10
        };
    end
};