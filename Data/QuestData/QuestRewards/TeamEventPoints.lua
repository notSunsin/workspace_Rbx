-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Data.QuestData.Types);
require(ReplicatedStorage.Comma_Module);
require(ReplicatedStorage.Modules.NumberUtil);
require(ReplicatedStorage.Modules.TeamEventHelper);

return {
    Type = "TeamEventPoints",

    Display = function(p1, p2) -- Line: 16, Name: Display
        return `+{p2.Data.Amount} Team Event Points`;
    end,

    Give = function(p3, p4, p5) -- Line: 22, Name: Give
        local ServerScriptService = game:GetService("ServerScriptService");
        require(ServerScriptService.Modules.TeamEventServices.TeamEventService):AddPoints(p5.Data.EventName, p4, p5.Data.Amount, false);

        return true;
    end,

    Use = function(p6, p7) -- Line: 31, Name: Use
        return {
            Type = p6.Type,
            Data = p7
        };
    end
};