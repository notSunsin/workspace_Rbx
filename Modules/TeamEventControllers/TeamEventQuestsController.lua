-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
local DataService = require(ReplicatedStorage.Modules.DataService);
local QuestsController = require(ReplicatedStorage.Modules.QuestsController);
local TeamEventHelper = require(ReplicatedStorage.Modules.TeamEventHelper);
require(ReplicatedStorage.Data.QuestData.Types);
local u5 = {
    GetQuests = function(p1, p2) -- Line: 13, Name: GetQuests
        -- upvalues: DataService (copy), TeamEventHelper (copy), QuestsController (copy)
        local Data = DataService:GetData();

        if not Data then
            return nil;
        end;

        local v3 = p2 or TeamEventHelper.CurrentEvent;
        local v4 = Data.TeamEventData[v3];

        if not v4 then
            warn((`No player event data found: {v3}`));

            return nil;
        end;

        local QuestContainerId = v4.QuestContainerId;

        if QuestContainerId then
            return QuestsController:GetContainerFromId(QuestContainerId) or nil;
        end;

        warn("Missing quest container id:", v4);

        return nil;
    end
};

function u5.GetQuestsCompletedCount(p6, p7) -- Line: 39
    -- upvalues: u5 (copy)
    local Quests = u5:GetQuests(p7);

    if not Quests then
        return 0, 0;
    end;

    local v8 = 0;
    local v9 = 0;

    for _, v in Quests.Quests do
        if v.Completed then
            v8 = v8 + 1;
        end;

        v9 = v9 + 1;
    end;

    return v8, v9;
end;

return u5;