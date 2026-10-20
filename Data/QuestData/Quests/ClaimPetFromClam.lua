-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Data.QuestData.Types);

return {
    Type = "ClaimPetFromClam",

    Display = function(p1, p2, p3) -- Line: 11, Name: Display
        return {
            Description = "Feed Sam the Clam pets and claim the ones he makes!",
            Title = `Claim {p3} of anything from Shelldon the Clam`,
            Bar = `{p2}/{p3}`
        };
    end,

    Use = function(p4, p5) -- Line: 19, Name: Use
        local table_clone_ret = table.clone(p5);
        table_clone_ret.Type = p4.Type;

        return table_clone_ret;
    end
};