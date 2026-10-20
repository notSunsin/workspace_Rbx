-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Data.QuestData.Types);

return {
    Type = "HitPeopleWithShovel",

    Display = function(p1, p2, p3) -- Line: 11, Name: Display
        return {
            Description = "Smack other pirates while the Chest Conquest is on!",
            Title = `Hit {p3} player{p3 > 1 and "s" or ""} with your shovel during the Chest Conquest`,
            Bar = `{p2}/{p3}`
        };
    end,

    Use = function(p4, p5) -- Line: 19, Name: Use
        local table_clone_ret = table.clone(p5);
        table_clone_ret.Type = p4.Type;

        return table_clone_ret;
    end
};