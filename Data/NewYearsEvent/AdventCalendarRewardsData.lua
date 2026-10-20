-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local GiveServiceCommon = require(ReplicatedStorage.Modules.GiveServiceCommon);
require(ReplicatedStorage.Data.NewYearsEvent.AdventCalendarConfigData);
local Types = GiveServiceCommon.Types;
local v1 = {
    FinalReward = {
        ImageId = "rbxassetid://112676240905133",
        ItemName = "Colorpop Crop Seed",
        Items = { Types.Seed:Use("Colorpop Crop", 1) }
    },
    Rewards = {
        {
            ImageId = "rbxassetid://103343401422538",
            ItemName = "Dragon\'s Firework x3",
            Items = { Types.Gear:Use("Dragon\'s Firework", 3) }
        },
        {
            ImageId = "rbxassetid://135452393147569",
            ItemName = "New Year\'s Egg x1",
            Items = { Types.Egg:Use("New Year\'s Egg", 1) }
        },
        {
            ImageId = "rbxassetid://103343401422538",
            ItemName = "Dragon\'s Firework x10",
            Items = { Types.Gear:Use("Dragon\'s Firework", 10) }
        },
        {
            ImageId = "rbxassetid://135452393147569",
            ItemName = "New Year\'s Egg x3",
            Items = { Types.Egg:Use("New Year\'s Egg", 3) }
        },
        {
            ImageId = "rbxassetid://103343401422538",
            ItemName = "Dragon\'s Firework x20",
            Items = { Types.Gear:Use("Dragon\'s Firework", 20) }
        },
        {
            ImageId = "rbxassetid://135452393147569",
            ItemName = "New Year\'s Egg x5",
            Items = { Types.Egg:Use("New Year\'s Egg", 5) }
        }
    }
};

for i = 1, #v1.Rewards do
    local v2;

    if v1.Rewards[i] then
        v2 = i;
    else
        warn((`Reward data not found for day {i}`));
        v2 = i;
    end;
end;

return v1;