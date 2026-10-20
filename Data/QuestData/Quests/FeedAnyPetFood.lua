-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Data.QuestData.Types);
require(ReplicatedStorage.Modules.TimeHelper);

return {
    Type = "FeedAnyPetFood",

    Display = function(p1, p2, p3, p4) -- Line: 11, Name: Display
        assert(p4);

        return p4[1] and {
            Title = `Feed any pet {p3}x {p4[1]}`,
            Bar = `{p2}/{p3}`,
            Description = `Cook up {p4[1]} for your pet`
        } or {
            Description = "Cook up a treat for your pet!",
            Title = `Feed any pet {p3} time{p3 > 1 and "s" or ""}`,
            Bar = `{p2}/{p3}`
        };
    end,

    Use = function(p5, p6) -- Line: 29, Name: Use
        local table_clone_ret = table.clone(p6);
        table_clone_ret.Type = p5.Type;

        return table_clone_ret;
    end
};