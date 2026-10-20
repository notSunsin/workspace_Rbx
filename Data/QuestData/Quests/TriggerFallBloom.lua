-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Data.QuestData.Types);

return {
    Type = "TriggerFallBloom",

    Display = function(p1, p2, p3, p4) -- Line: 10, Name: Display
        return {
            Description = "The Heartseed welcomes your contributions",
            Title = `Trigger a Fall Bloom {p3} time{p3 > 1 and "s" or ""}`,
            Bar = `{p2}/{p3}`
        };
    end,

    Use = function(p5, p6) -- Line: 18, Name: Use
        local table_clone_ret = table.clone(p6);
        table_clone_ret.Type = p5.Type;

        return table_clone_ret;
    end
};