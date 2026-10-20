-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Data.QuestData.Types);

return {
    Type = "AgePetWithTrait",

    Display = function(p1, p2, p3, p4) -- Line: 10, Name: Display
        assert(p4, "AgePetWithTrait quest requires trait argument");
        local v5 = p4[1];

        return {
            Title = `Level up a "{v5}" type pet`,
            Bar = `{p2}/{p3}`,
            Description = `Level up pets that are "{v5}" type!.`
        };
    end,

    Use = function(p6, p7) -- Line: 21, Name: Use
        local table_clone_ret = table.clone(p7);
        table_clone_ret.Type = p6.Type;

        return table_clone_ret;
    end
};