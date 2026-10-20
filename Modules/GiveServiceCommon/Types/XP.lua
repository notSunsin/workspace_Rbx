-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CommaFormatNumber = require(ReplicatedStorage.Modules.CommaFormatNumber);
require(ReplicatedStorage.Modules.GiveServiceCommon.RewardDataTypes);

return {
    Use = function(p1: table, p2: number) -- Line: 10, Name: Use
        return {
            Type = "XP",
            Value = p2
        };
    end,

    Format = function(p3, p4) -- Line: 14, Name: Format
        -- upvalues: CommaFormatNumber (copy)
        return `{CommaFormatNumber(p4.Value)}x XP`;
    end,

    GetImage = function(p5, p6) -- Line: 21, Name: GetImage
        return "rbxassetid://0";
    end,

    GetRarity = function(p7, p8) -- Line: 25, Name: GetRarity
        return "Common";
    end
};