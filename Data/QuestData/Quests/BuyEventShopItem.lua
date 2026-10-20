-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Data.QuestData.Types);
local Pluralize = require(ReplicatedStorage.Modules.Pluralize);

return {
    Type = "BuyEventShopItem",
    RequireAll = true,

    Display = function(p1, p2, p3, p4) -- Line: 12, Name: Display
        -- upvalues: Pluralize (copy)
        assert(p4, "Quest BuyEventShopItem doesn\'t have arguments.");
        local v5 = p4[2] or p4[1];
        local v6 = {
            Description = "Found in the event shop — stock rotates, so check back!"
        };

        if p3 > 1 then
            v5 = Pluralize(v5);
        end;

        v6.Title = `Buy {p3} {v5} from the event shop`;
        v6.Bar = `{p2}/{p3}`;

        return v6;
    end,

    Use = function(p7, p8) -- Line: 22, Name: Use
        assert(p8.Arguments, "BuyEventShopItem quests need arguments { ShopIndex, ItemName }.");
        local table_clone_ret = table.clone(p8);
        table_clone_ret.Type = p7.Type;

        return table_clone_ret;
    end
};