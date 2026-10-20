-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local GiveServiceCommon = require(ReplicatedStorage.Modules.GiveServiceCommon);
local AdventCalendarConfigData = require(ReplicatedStorage.Data.NewYearsEvent.AdventCalendarConfigData);
local Types = GiveServiceCommon.Types;
local v1 = {
    FinalReward = Types.Seed:Use("Gingerbread Blossom", 1),
    Rewards = {
        { Types.Gear:Use("Dragon\'s Firework", 3) },
        {
            Types.Seed:Use("Carrot", 50),
            Types.Seed:Use("Buttercup", 40),
            Types.Seed:Use("Daffodil", 30),
            Types.Seed:Use("Bamboo", 20),
            Types.Seed:Use("Mushroom", 10)
        },
        { Types.Gear:Use("Dragon\'s Firework", 10) },
        { Types.SeedPack:Use("Santa\'s Surprise Present", 5), Types.SeedPack:Use("Rare Present", 1) },
        { Types.Gear:Use("Dragon\'s Firework", 20) },
        { Types.Crate:Use("Christmas Crate", 4), Types.SeedPack:Use("Christmas Present", 4) }
    }
};

if #v1.Rewards < AdventCalendarConfigData.DAY_COUNT then
    warn("Number of rewards is less than the number of days!");
end;

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