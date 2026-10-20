-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Data.QuestData.Types);
local Comma_Module = require(ReplicatedStorage.Comma_Module);
local CurrencyData = require(ReplicatedStorage.Data.CurrencyData);

return {
    Type = "EarnEventCurrency",

    Display = function(p1, p2, p3, p4) -- Line: 12, Name: Display
        -- upvalues: CurrencyData (copy), Comma_Module (copy)
        assert(p4, "Quest EarnEventCurrency doesn\'t have an argument.");
        local CurrencyName = CurrencyData[p4[1]].CurrencyName;
        local v5 = Comma_Module.Comma(p3);

        return {
            Title = `Earn {v5} {CurrencyName}`,
            Bar = `{Comma_Module.Comma((math.min(p2, p3)))}/{v5}`,
            Description = `Earn {CurrencyName} from doing tasks related to its event!`
        };
    end,

    Use = function(p6, p7) -- Line: 25, Name: Use
        local table_clone_ret = table.clone(p7);
        table_clone_ret.Type = p6.Type;

        return table_clone_ret;
    end
};