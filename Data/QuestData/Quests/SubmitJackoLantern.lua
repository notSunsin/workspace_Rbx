-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Data.QuestData.Types);
require(ReplicatedStorage.Data.SeedData);

return {
    Type = "SubmitJackoLantern",

    Display = function(p1, p2, p3) -- Line: 12, Name: Display
        return {
            Description = "Sell plants, food, or pets to the Jack-o-Lantern!",
            Title = `Offer {p3}x`,
            Bar = `{p2}/{p3}`
        };
    end,

    Use = function(p4, p5) -- Line: 20, Name: Use
        local table_clone_ret = table.clone(p5);
        table_clone_ret.Type = p4.Type;

        return table_clone_ret;
    end
};