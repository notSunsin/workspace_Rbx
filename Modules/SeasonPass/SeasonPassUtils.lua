-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local SeasonPassStaticData = require(ReplicatedStorage.Data.SeasonPass.SeasonPassStaticData);
local SeedData = require(ReplicatedStorage.Data.SeedData);
local GameConfigController = require(ReplicatedStorage.Modules.GameConfigController);
local ConfigRegistry = require(ReplicatedStorage.Data.ConfigRegistry);
local Config = GameConfigController:GetConfig("SeasonPassTimerData");
local v1 = {
    ["Season 7"] = {
        StartTime = 0,
        EndTime = game.ReplicatedFirst.GlobalUpdateTime.Value
    }
};
local v2 = {
    StartTime = game.ReplicatedFirst.GlobalUpdateTime.Value
};
local v3;

if Config["Season 8"] then
    v3 = Config["Season 8"].EndTime;
else
    v3 = ConfigRegistry.SeasonPassTimerData["Season 8"].EndTime;
end;

v2.EndTime = v3;
v1["Season 8"] = v2;

local function GetCurrentSeason() -- Line: 127
    -- upvalues: GameConfigController (copy), ConfigRegistry (copy)
    local Config2 = GameConfigController:GetConfig("SeasonPassTimerData");
    local ServerTimeNow = workspace:GetServerTimeNow();

    for i, v in Config2 do
        if v.StartTime <= ServerTimeNow and ServerTimeNow < v.EndTime then
            return i;
        end;
    end;

    for i, v in ConfigRegistry.SeasonPassTimerData do
        if v.StartTime <= ServerTimeNow and ServerTimeNow < v.EndTime then
            return i;
        end;
    end;

    return nil;
end;

return {
    CalculateLevel = function(p4: number) -- Line: 32, Name: CalculateLevel
        -- upvalues: SeasonPassStaticData (copy)
        local math_sqrt_ret = math.sqrt(p4 / SeasonPassStaticData.XP_CONSTANT);

        return math.floor(math_sqrt_ret);
    end,

    CalculateXPForLevel = function(p5: number) -- Line: 27, Name: CalculateXPForLevel
        -- upvalues: SeasonPassStaticData (copy)
        return SeasonPassStaticData.XP_CONSTANT * p5 ^ 2;
    end,

    GetXPEarnedCurrentLevel = function(p6: number) -- Line: 54, Name: GetXPEarnedCurrentLevel
        -- upvalues: SeasonPassStaticData (copy)
        local math_sqrt_ret = math.sqrt(p6 / SeasonPassStaticData.XP_CONSTANT);
        local math_floor_ret = math.floor(math_sqrt_ret);

        return p6 - SeasonPassStaticData.XP_CONSTANT * math_floor_ret ^ 2;
    end,

    GetTotalXPForNextLevel = function(p7: number) -- Line: 40, Name: GetTotalXPForNextLevel
        -- upvalues: SeasonPassStaticData (copy)
        local math_sqrt_ret = math.sqrt(p7 / SeasonPassStaticData.XP_CONSTANT);
        local math_floor_ret = math.floor(math_sqrt_ret);

        return SeasonPassStaticData.XP_CONSTANT * (math_floor_ret + 1) ^ 2 - SeasonPassStaticData.XP_CONSTANT * math_floor_ret ^ 2;
    end,

    GetXPFractionOfCurrentLevel = function(p8: number) -- Line: 73, Name: GetXPFractionOfCurrentLevel
        -- upvalues: SeasonPassStaticData (copy)
        local math_sqrt_ret = math.sqrt(p8 / SeasonPassStaticData.XP_CONSTANT);
        local math_floor_ret = math.floor(math_sqrt_ret);
        local v9 = p8 - SeasonPassStaticData.XP_CONSTANT * math_floor_ret ^ 2;
        local math_sqrt_ret2 = math.sqrt(p8 / SeasonPassStaticData.XP_CONSTANT);
        local math_floor_ret2 = math.floor(math_sqrt_ret2);

        return v9 / (SeasonPassStaticData.XP_CONSTANT * (math_floor_ret2 + 1) ^ 2 - SeasonPassStaticData.XP_CONSTANT * math_floor_ret2 ^ 2);
    end,

    CalculateInfClaimCount = function(p10: number, p11: number) -- Line: 82, Name: CalculateInfClaimCount
        -- upvalues: SeasonPassStaticData (copy)
        return math.floor((p10 - SeasonPassStaticData.XP_CONSTANT * SeasonPassStaticData.MAX_LEVEL ^ 2 - p11 * SeasonPassStaticData.INF_REWARD_XP) / SeasonPassStaticData.INF_REWARD_XP);
    end,

    GetXPToReachNextLevel = function(p12: number) -- Line: 64, Name: GetXPToReachNextLevel
        -- upvalues: SeasonPassStaticData (copy)
        local math_sqrt_ret = math.sqrt(p12 / SeasonPassStaticData.XP_CONSTANT);
        local math_floor_ret = math.floor(math_sqrt_ret);
        local v13 = p12 - SeasonPassStaticData.XP_CONSTANT * math_floor_ret ^ 2;
        local math_sqrt_ret2 = math.sqrt(p12 / SeasonPassStaticData.XP_CONSTANT);
        local math_floor_ret2 = math.floor(math_sqrt_ret2);

        return SeasonPassStaticData.XP_CONSTANT * (math_floor_ret2 + 1) ^ 2 - SeasonPassStaticData.XP_CONSTANT * math_floor_ret2 ^ 2 - v13;
    end,

    GetXPReductions = function(p14: table) -- Line: 178, Name: GetXPReductions
        -- upvalues: SeasonPassStaticData (copy), SeedData (copy)
        local HarvestThresholdByRarity = SeasonPassStaticData.HarvestThresholdByRarity;
        local v15 = {};

        for i, v in p14 do
            local v16;

            if SeedData[i] then
                v16 = SeedData[i].SeedRarity or nil;
            else
                v16 = nil;
            end;

            if v16 then
                local v17 = HarvestThresholdByRarity[v16];

                if v17 then
                    local v18 = v // v17;

                    if v18 ~= 0 then
                        v15[i] = v18 * 0.15;
                    end;
                end;
            end;
        end;

        return v15;
    end,

    GetRarityXPReward = function(p19: string) -- Line: 97, Name: GetRarityXPReward
        -- upvalues: SeedData (copy), SeasonPassStaticData (copy)
        if SeedData[p19] then
            return SeasonPassStaticData.Rarity[SeedData[p19].SeedRarity];
        end;

        warn((`SeasonPassUtils | No SeedData for {p19}`));

        return 0;
    end,

    GetMutationXPReward = function(p20: number) -- Line: 90, Name: GetMutationXPReward
        -- upvalues: SeasonPassStaticData (copy)
        local MUTATION_COUNT_CAP = SeasonPassStaticData.MUTATION_COUNT_CAP;
        local math_min_ret = math.min(p20, MUTATION_COUNT_CAP);
        local math_clamp_ret = math.clamp(math_min_ret, 1, MUTATION_COUNT_CAP);

        return SeasonPassStaticData.MutationCount[math_clamp_ret];
    end,

    ToggleButton = function(p21: userdata, p22: boolean, p23: string?) -- Line: 108, Name: ToggleButton
        -- upvalues: SeasonPassStaticData (copy)
        local UIStroke = p21:FindFirstChild("UIStroke");
        local UIStroke2 = p21:FindFirstChild("TextLabel"):FindFirstChild("UIStroke");
        local v24 = p23 or "Green";
        p21.Interactable = p22;
        local v25;

        if p22 then
            v25 = SeasonPassStaticData.ButtonColors[v24].Background;
        else
            v25 = SeasonPassStaticData.ButtonColors.Gray.Background;
        end;

        p21.BackgroundColor3 = v25;
        local v26;

        if p22 then
            v26 = SeasonPassStaticData.ButtonColors[v24].ButtonStroke;
        else
            v26 = SeasonPassStaticData.ButtonColors.Gray.ButtonStroke;
        end;

        UIStroke.Color = v26;
        local v27;

        if p22 then
            v27 = SeasonPassStaticData.ButtonColors[v24].TextStroke;
        else
            v27 = SeasonPassStaticData.ButtonColors.Gray.TextStroke;
        end;

        UIStroke2.Color = v27;
    end,

    GetCurrentSeason = GetCurrentSeason,

    GetResetTime = function() -- Line: 156, Name: GetResetTime
        -- upvalues: GetCurrentSeason (copy), GameConfigController (copy)
        local v28 = GetCurrentSeason();

        if not v28 then
            return 0;
        end;

        local v29 = GameConfigController:GetConfig("SeasonPassTimerData")[v28];

        if v29 then
            return v29.EndTime;
        end;

        warn((`No schedule found: {v28}`));

        return 0;
    end
};