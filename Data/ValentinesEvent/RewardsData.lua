-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Types = require(ReplicatedStorage.Modules.GiveServiceCommon).Types;

return {
    Rewards = {
        {
            ImageId = "rbxassetid://128917754594343",
            ItemName = "Heart Bench",
            Price = 30,
            Items = { Types.Cosmetic:Use("Heart Bench", 1) }
        },
        {
            ImageId = "rbxassetid://140635830048990",
            ItemName = "Pink Rose",
            Price = 200,
            Items = { Types.Seed:Use("Pink Rose", 1) }
        },
        {
            ImageId = "rbxassetid://97219704562929",
            ItemName = "Valentine Arch",
            Price = 700,
            Items = { Types.Cosmetic:Use("Valentine Arch", 1) }
        },
        {
            ImageId = "rbxassetid://103412834589201",
            ItemName = "Pink Panda",
            Price = 2000,
            Items = { Types.Pet:Use("Pink Panda", 1) }
        },
        {
            ImageId = "rbxassetid://100539117208884",
            ItemName = "Red Rose Fox",
            Price = 10000,
            Items = { Types.Pet:Use("Red Rose Fox", 1) }
        }
    }
};