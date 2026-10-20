-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Data.QuestData.Types);
local ItemImageFinder = require(ReplicatedStorage.Modules.ItemImageFinder);

return {
    Type = "Egg",

    Display = function(p1, p2) -- Line: 15, Name: Display
        return `+{p2.Data.Amount} {p2.Data.Type}`;
    end,

    DisplayIcon = function(p3, p4) -- Line: 20, Name: DisplayIcon
        -- upvalues: ItemImageFinder (copy)
        return ItemImageFinder(p4.Data.Type, "Egg");
    end,

    Give = function(p5, p6, p7) -- Line: 24, Name: Give
        local ServerScriptService = game:GetService("ServerScriptService");

        return require(ServerScriptService.Modules.PetsServices.PetEggToolService):GiveEgg(p6, p7.Data.Type, p7.Data.Amount);
    end,

    Use = function(p8, p9) -- Line: 32, Name: Use
        return {
            Type = p8.Type,
            Data = p9
        };
    end
};