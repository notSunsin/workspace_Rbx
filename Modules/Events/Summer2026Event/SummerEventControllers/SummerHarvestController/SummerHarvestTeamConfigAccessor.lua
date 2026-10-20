-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ReplicatedFirst = game:GetService("ReplicatedFirst");
local GameConfigController = require(ReplicatedStorage.Modules.GameConfigController);
local GlobalUpdateTime = ReplicatedFirst:WaitForChild("GlobalUpdateTime");

local function GetLive() -- Line: 21
    -- upvalues: GameConfigController (copy)
    local Config = GameConfigController:GetConfig("SummerHarvestTeamConfig");

    return type(Config) ~= "table" and {} or Config;
end;

local function ResolveStartTime(p1: table) -- Line: 26
    -- upvalues: GlobalUpdateTime (copy)
    local v2 = tonumber(p1.EventStartTime);

    if v2 and v2 > 0 then
        return v2;
    end;

    return GlobalUpdateTime.Value;
end;

local function CurrentSeasonEndTime(p3: table) -- Line: 34
    -- upvalues: GlobalUpdateTime (copy)
    local v4 = tonumber(p3.EventEndTime);

    if v4 and v4 > 0 then
        return v4;
    end;

    local v5 = tonumber(p3.TotalDays) or 7;
    local v6 = tonumber(p3.DayLength) or 86400;
    local v7 = tonumber(p3.EventStartTime);

    if not v7 or v7 <= 0 then
        v7 = GlobalUpdateTime.Value;
    end;

    return v7 + v5 * v6;
end;

local function GetActiveNext(p8: table) -- Line: 65
    -- upvalues: GlobalUpdateTime (copy)
    local NextSeason = p8.NextSeason;

    if type(NextSeason) ~= "table" then
        return nil;
    end;

    local v9 = tonumber(NextSeason.StartTime);

    if v9 and v9 > 0 then
        if v9 <= workspace:GetServerTimeNow() then
            return NextSeason;
        end;

        return nil;
    end;

    local v10 = tonumber(p8.EventStartTime);

    if not v10 or v10 <= 0 then
        return nil;
    end;

    local ServerTimeNow = workspace:GetServerTimeNow();
    local v11 = tonumber(p8.EventEndTime);

    if not v11 or v11 <= 0 then
        local v12 = tonumber(p8.TotalDays) or 7;
        local v13 = tonumber(p8.DayLength) or 86400;
        local v14 = tonumber(p8.EventStartTime);

        if not v14 or v14 <= 0 then
            v14 = GlobalUpdateTime.Value;
        end;

        v11 = v14 + v12 * v13;
    end;

    if v11 <= ServerTimeNow then
        return NextSeason;
    end;

    local Value = GlobalUpdateTime.Value;

    if v10 + 3600 <= Value and Value <= ServerTimeNow then
        return NextSeason;
    end;

    return nil;
end;

local function NextSeasonStartTime(p15: table) -- Line: 97
    -- upvalues: GlobalUpdateTime (copy)
    return tonumber(p15.StartTime) or GlobalUpdateTime.Value;
end;

return setmetatable({
    GetDailyPointGoal = function(p16: number) -- Line: 105, Name: GetDailyPointGoal
        -- upvalues: GameConfigController (copy), GetActiveNext (copy)
        local Config = GameConfigController:GetConfig("SummerHarvestTeamConfig");
        local v17 = type(Config) ~= "table" and {} or Config;
        local v18 = GetActiveNext(v17);
        local v19 = v18 and v18.DailyPointGoals or v17.DailyPointGoals;

        if type(v19) == "table" then
            local v20 = tonumber(v19[p16]);

            if v20 then
                return v20;
            end;

            local v21 = 1;
            local v22 = nil;

            while v19[v21] ~= nil do
                v22 = tonumber(v19[v21]);
                v21 = v21 + 1;
            end;

            if v22 then
                return v22;
            end;
        end;

        return 500;
    end,

    IsNextSeasonActive = function() -- Line: 129, Name: IsNextSeasonActive
        -- upvalues: GetActiveNext (copy), GameConfigController (copy)
        local Config = GameConfigController:GetConfig("SummerHarvestTeamConfig");

        return GetActiveNext(type(Config) ~= "table" and {} or Config) ~= nil;
    end,

    GetNextSeasonActivationTime = function() -- Line: 137, Name: GetNextSeasonActivationTime
        -- upvalues: GameConfigController (copy), GetActiveNext (copy), GlobalUpdateTime (copy)
        local Config = GameConfigController:GetConfig("SummerHarvestTeamConfig");
        local v23 = type(Config) ~= "table" and {} or Config;
        local NextSeason = v23.NextSeason;

        if type(NextSeason) ~= "table" or GetActiveNext(v23) ~= nil then
            return nil;
        end;

        local v24 = tonumber(NextSeason.StartTime);

        if v24 and v24 > 0 then
            return v24;
        end;

        local v25 = tonumber(v23.EventStartTime);

        if not v25 or v25 <= 0 then
            return nil;
        end;

        local v26 = tonumber(v23.EventEndTime);

        if not v26 or v26 <= 0 then
            local v27 = tonumber(v23.TotalDays) or 7;
            local v28 = tonumber(v23.DayLength) or 86400;
            local v29 = tonumber(v23.EventStartTime);

            if not v29 or v29 <= 0 then
                v29 = GlobalUpdateTime.Value;
            end;

            v26 = v29 + v27 * v28;
        end;

        local Value = GlobalUpdateTime.Value;

        if v25 + 3600 <= Value then
            if Value >= v26 then
                Value = v26;
            end;
        else
            Value = v26;
        end;

        return Value;
    end,

    GetPreviousSeasonConfig = function() -- Line: 168, Name: GetPreviousSeasonConfig
        -- upvalues: GameConfigController (copy), GetActiveNext (copy), GlobalUpdateTime (copy)
        local Config = GameConfigController:GetConfig("SummerHarvestTeamConfig");
        local v30 = type(Config) ~= "table" and {} or Config;

        if not GetActiveNext(v30) then
            local PreviousSeason = v30.PreviousSeason;

            if type(PreviousSeason) == "table" then
                return PreviousSeason;
            end;

            return nil;
        end;

        local v31 = {
            Season = tonumber(v30.EventSeason) or 1
        };
        local v32 = tonumber(v30.EventEndTime);

        if not v32 or v32 <= 0 then
            local v33 = tonumber(v30.TotalDays) or 7;
            local v34 = tonumber(v30.DayLength) or 86400;
            local v35 = tonumber(v30.EventStartTime);

            if not v35 or v35 <= 0 then
                v35 = GlobalUpdateTime.Value;
            end;

            v32 = v35 + v33 * v34;
        end;

        v31.EndTime = v32;
        v31.TotalDays = tonumber(v30.TotalDays);
        v31.DailyRewards = v30.DailyRewards;
        v31.GrandPrize = v30.GrandPrize;
        v31.DailyPointGoals = v30.DailyPointGoals;
        v31.DaysRequiredForGrandPrize = v30.DaysRequiredForGrandPrize;

        return v31;
    end
}, {
    __index = function(p36: any, p37: string) -- Line: 190, Name: __index
        -- upvalues: GameConfigController (copy), GetActiveNext (copy), GlobalUpdateTime (copy)
        local Config = GameConfigController:GetConfig("SummerHarvestTeamConfig");
        local v38 = type(Config) ~= "table" and {} or Config;
        local v39 = GetActiveNext(v38);

        if p37 == "EventSeason" then
            if v39 then
                return tonumber(v39.Season) or (tonumber(v38.EventSeason) or 1) + 1;
            end;

            return v38.EventSeason;
        end;

        if p37 == "EventStartTime" then
            if v39 then
                return tonumber(v39.StartTime) or GlobalUpdateTime.Value;
            end;

            local v40 = tonumber(v38.EventStartTime);

            if v40 and v40 > 0 then
                return v40;
            end;

            return GlobalUpdateTime.Value;
        end;

        if p37 ~= "EventEndTime" then
            if v39 and v39[p37] ~= nil then
                return v39[p37];
            end;

            return v38[p37];
        end;

        if v39 then
            local v41 = tonumber(v39.EndTime);

            if v41 and v41 > 0 then
                return v41;
            end;

            local v42 = tonumber(v39.TotalDays) or (tonumber(v38.TotalDays) or 7);
            local v43 = tonumber(v39.DayLength) or (tonumber(v38.DayLength) or 86400);

            return (tonumber(v39.StartTime) or GlobalUpdateTime.Value) + v42 * v43;
        end;

        local v44 = tonumber(v38.EventEndTime);

        if v44 and v44 > 0 then
            return v44;
        end;

        local v45 = tonumber(v38.TotalDays) or 7;
        local v46 = tonumber(v38.DayLength) or 86400;
        local v47 = tonumber(v38.EventStartTime);

        if not v47 or v47 <= 0 then
            v47 = GlobalUpdateTime.Value;
        end;

        return v47 + v45 * v46;
    end
});