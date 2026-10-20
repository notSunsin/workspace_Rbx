-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local EventRotationUtils = require(ReplicatedStorage.Modules.EventRotation.EventRotationUtils);
local UpdateService = require(ReplicatedStorage.Modules.UpdateService);
require(script.Types);
local u1 = {};
local u2 = {
    Seasons = u1
};

for _, child in script.Seasons:GetChildren() do
    if child:IsA("ModuleScript") then
        local v3 = tonumber(child.Name);

        if v3 then
            local success, result = pcall(require, child);

            if success and type(result) == "table" then
                u1[v3] = result;
                local v4 = {};

                for i, v in result.Sets do
                    local v5 = i;

                    for i2, v2 in v.Quests do
                        if v4[v2.Id] then
                            warn((`{v2.Id} (index {i2}) has duplicated id in quest set {v5} for season {v3}`));
                        else
                            v4[v2.Id] = true;
                        end;
                    end;
                end;
            else
                warn((`Failed to require {child:GetFullName()}: {result}`));
            end;
        end;
    end;
end;

local function UpdateBlockedAchievements() -- Line: 47
    -- upvalues: u1 (copy), UpdateService (copy)
    for _, v in u1 do
        for i, v2 in v.Sets do
            if UpdateService:IsHiddenAfterUpdate(i) then
                v2.IsBlocked = true;
            end;
        end;
    end;
end;

local function ActivateAchievementSet(p6: number, p7: string, p8: boolean) -- Line: 59
    -- upvalues: u2 (copy)
    local v9 = u2.Seasons[p6];

    if not v9 then
        warn((`No AchievementData: {p6}`));

        return;
    end;

    if not v9.Sets[p7] then
        warn((`No AchievementData: {p6} {p7}`));

        return;
    end;

    v9.Sets[p7].IsBlocked = p8;

    if p8 then
        return;
    end;

    local v10 = 0;

    for _, v in v9.Sets do
        if v.Order and v10 < v.Order then
            v10 = v.Order;
        end;
    end;

    v9.Sets[p7].Order = v10 + 1;
end;

local function ToggleEventAchievements(p11: string, p12: string) -- Line: 82
    -- upvalues: u2 (copy), EventRotationUtils (copy), ActivateAchievementSet (copy)
    local v13 = u2.Seasons[3];

    if not v13 then
        warn((`No AchievementData: {3}`));

        return;
    end;

    local EventInSetIndex = EventRotationUtils:GetEventInSetIndex(p11, p12);

    for i, v in v13.Sets do
        if v.EventRotationID then
            local EventInSetIndex2 = EventRotationUtils:GetEventInSetIndex(v.EventRotationID, p12);

            if EventInSetIndex2 and (EventInSetIndex and EventInSetIndex2 <= EventInSetIndex) then
                ActivateAchievementSet(3, i, false);
            else
                local v14 = u2.Seasons[3];

                if v14 then
                    if v14.Sets[i] then
                        v14.Sets[i].IsBlocked = true;
                    else
                        warn((`No AchievementData: {3} {i}`));
                    end;
                else
                    warn((`No AchievementData: {3}`));
                end;
            end;
        end;
    end;
end;

if RunService:IsServer() then
    local EventRotationService = require(game.ServerScriptService.Modules.EventRotation.EventRotationService);
    EventRotationService.EventUpdated:Connect(ToggleEventAchievements);
    local LoadedEvent = EventRotationService:GetLoadedEvent();

    if LoadedEvent then
        ToggleEventAchievements(LoadedEvent.EventID, LoadedEvent.EventSet);
    end;
elseif RunService:IsClient() then
    local EventRotationController = require(ReplicatedStorage.Modules.EventRotation.EventRotationController);
    EventRotationController.EventUpdated:Connect(ToggleEventAchievements);
    local LoadedEvent = EventRotationController:GetLoadedEvent();

    if LoadedEvent then
        ToggleEventAchievements(LoadedEvent.EventID, LoadedEvent.EventSet);
    end;
end;

UpdateService.OnUpdated:Connect(function() -- Line: 123
    -- upvalues: UpdateBlockedAchievements (copy)
    UpdateBlockedAchievements();
end);

if UpdateService:IsUpdateDone() then
    UpdateBlockedAchievements();
end;

return u2;