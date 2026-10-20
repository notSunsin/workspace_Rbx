-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Data.QuestData.Types);
require(ReplicatedStorage.Comma_Module);

return {
    Type = "CompositeAll",

    Display = function(p1, p2) -- Line: 13, Name: Display
        -- upvalues: ReplicatedStorage (copy)
        game:GetService("ServerScriptService");
        local QuestRewards = require(ReplicatedStorage.Data.QuestData.QuestRewards);
        local v3 = nil;

        for _, v in p2.Data.SubRewards do
            local v4 = QuestRewards[v.Type];

            if v3 == nil then
                v3 = v4:Display(v);
            else
                v3 = v3 .. ", " .. v4:Display(v);
            end;
        end;

        return v3;
    end,

    DisplayIcon = function(p5, p6) -- Line: 31, Name: DisplayIcon
        -- upvalues: ReplicatedStorage (copy)
        game:GetService("ServerScriptService");
        local QuestRewards = require(ReplicatedStorage.Data.QuestData.QuestRewards);
        local v7 = os.time() % #p6.Data.SubRewards + 1;
        local v8 = p6.Data.SubRewards[v7];

        return QuestRewards[v8.Type]:DisplayIcon(v8);
    end,

    Give = function(p9, p10, p11) -- Line: 45, Name: Give
        -- upvalues: ReplicatedStorage (copy)
        game:GetService("ServerScriptService");
        local QuestRewards = require(ReplicatedStorage.Data.QuestData.QuestRewards);

        for _, v in p11.Data.SubRewards do
            QuestRewards[v.Type]:Give(p10, v);
        end;

        return true;
    end,

    Use = function(p12, p13) -- Line: 58, Name: Use
        return {
            Type = p12.Type,
            Data = p13
        };
    end
};