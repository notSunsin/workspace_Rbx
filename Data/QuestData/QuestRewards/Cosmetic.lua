-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Data.QuestData.Types);
local ItemImageFinder = require(ReplicatedStorage.Modules.ItemImageFinder);

return {
    Type = "Cosmetic",

    Display = function(p1, p2) -- Line: 14, Name: Display
        return `+{p2.Data.Amount} {p2.Data.Type}`;
    end,

    DisplayIcon = function(p3, p4) -- Line: 19, Name: DisplayIcon
        -- upvalues: ItemImageFinder (copy)
        return ItemImageFinder(p4.Data.Type, "Cosmetic");
    end,

    Give = function(p5, p6, p7) -- Line: 23, Name: Give
        local ServerScriptService = game:GetService("ServerScriptService");
        local CosmeticService = require(ServerScriptService.Modules.CosmeticsServices.CosmeticService);

        for i = 1, p7.Data.Amount do
            CosmeticService:CreateCosmetic(p6, p7.Data.Type);
            local _ = i;
        end;

        return true;
    end,

    Use = function(p8, p9) -- Line: 35, Name: Use
        return {
            Type = p8.Type,
            Data = p9
        };
    end
};