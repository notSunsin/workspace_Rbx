-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ServerScriptService = game:GetService("ServerScriptService");
local RunService = game:GetService("RunService");
local SeedData = require(ReplicatedStorage.Data.SeedData);
require(ReplicatedStorage.Data.Events.LunarGlowEvent.LunarGlowConfig.LunarGlowTypes);
local u1 = nil;

if RunService:IsServer() then
    u1 = require(ServerScriptService.Modules.GameConfigService);
elseif RunService:IsClient() then
    u1 = require(ReplicatedStorage.Modules.GameConfigController);
end;

local Config = u1:GetConfig("LunarGlowConfig");
workspace:GetAttributeChangedSignal("LunarGlowConfig"):Connect(function() -- Line: 17
    -- upvalues: Config (ref), u1 (ref)
    Config = u1:GetConfig("LunarGlowConfig");
end);
local u2 = {
    Common = 1,
    Uncommon = 2,
    Rare = 3,
    Legendary = 4,
    Mythical = 5,
    Divine = 6,
    Prismatic = 7
};
local u3 = {
    Normal = 0,
    Gold = 2,
    Rainbow = 3
};
local u15 = {
    GetFruitExperienceValue = function(p4: table, p5: userdata) -- Line: 40, Name: GetFruitExperienceValue
        -- upvalues: SeedData (copy), u2 (copy), u3 (copy)
        local Item_String = p5:FindFirstChild("Item_String");

        if not Item_String then
            return warn("LunarGlowUtils:GetFruitExperienceValue | Cannot find Item Name!");
        end;

        local v6 = SeedData[Item_String.Value];

        if not v6 then
            warn((`LunarGlowUtils:GetFruitExperienceValue | Unable to find seed {Item_String}!`));

            return 1;
        end;

        local v7 = u2[v6.SeedRarity];

        if not v7 then
            warn((`LunarGlowUtils:GetFruitExperienceValue | Unable to find rarity {v6.SeedRarity}!`));

            return 1;
        end;

        local Variant = p5:FindFirstChild("Variant");

        if not Variant then
            return warn("LunarGlowUtils:GetFruitExperienceValue | Unable to find Variant!");
        end;

        local v8 = u3[Variant.Value];

        if not v8 then
            warn("LunarGlowUtils:GetFruitExperienceValue | Variant Value Cannot be found!");
            v8 = 1;
        end;

        local v9 = v7 + v8;

        if p5:GetAttribute("Bloodlit") then
            v9 = v9 * 1.5;
        end;

        return math.ceil(v9);
    end,

    IsQuestFinished = function(p10, p11) -- Line: 74, Name: IsQuestFinished
        -- upvalues: Config (ref)
        return #p11.ClaimedRewardIndices >= #Config.REWARDS;
    end,

    ReturnRewardData = function(p12) -- Line: 78, Name: ReturnRewardData
        -- upvalues: Config (ref)
        return Config.REWARDS;
    end,

    GetNextQuestReward = function(p13, p14) -- Line: 82, Name: GetNextQuestReward
        -- upvalues: Config (ref)
        for i, v in Config.REWARDS do
            if not table.find(p14.ClaimedRewardIndices, i) and p14.Experience < v.RequiredExperience then
                return v, i;
            end;
        end;
    end
};

function u15.GetXPForNextReward(p16, p17) -- Line: 94
    -- upvalues: u15 (copy), Config (ref)
    local NextQuestReward, v18 = u15:GetNextQuestReward(p17);

    if v18 == 1 then
        return NextQuestReward.RequiredExperience;
    end;

    return NextQuestReward.RequiredExperience - Config.REWARDS[v18 - 1].RequiredExperience;
end;

function u15.GetUnclaimedQuestRewards(p19, p20) -- Line: 104
    -- upvalues: Config (ref)
    local v21 = {};

    for i, v in Config.REWARDS do
        if not table.find(p20.ClaimedRewardIndices, i) and p20.Experience >= v.RequiredExperience then
            v21[i] = v;
        end;
    end;

    return v21;
end;

return u15;