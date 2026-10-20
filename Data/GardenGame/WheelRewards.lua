-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Types = require(ReplicatedStorage.Modules.GiveServiceCommon).Types;

return {
    {
        Weight = 30,
        ImageId = "rbxassetid://130489605814946",
        Reward = Types.Crate:Use("Carnival Crate", 1)
    },
    {
        Weight = 15,
        ImageId = "rbxassetid://130489605814946",
        Reward = Types.Crate:Use("Carnival Crate", 3)
    },
    {
        Weight = 4,
        ImageId = "rbxassetid://130489605814946",
        Reward = Types.Crate:Use("Carnival Crate", 10)
    },
    {
        Weight = 1,
        ImageId = "rbxassetid://72188256382500",
        Reward = Types.Seed:Use("Kernel Curl", 1)
    },
    {
        Weight = 30,
        ImageId = "rbxassetid://91270408981945",
        Reward = Types.Egg:Use("Carnival Egg", 1)
    },
    {
        Weight = 15,
        ImageId = "rbxassetid://91270408981945",
        Reward = Types.Egg:Use("Carnival Egg", 3)
    },
    {
        Weight = 4,
        ImageId = "rbxassetid://91270408981945",
        Reward = Types.Egg:Use("Carnival Egg", 10)
    },
    {
        Weight = 1,
        ImageId = "rbxassetid://91270408981945",
        Reward = Types.Egg:Use("Carnival Egg", 50)
    }
};