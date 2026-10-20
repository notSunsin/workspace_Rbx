-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CollectionService = game:GetService("CollectionService");
require(script.NPCLevelTypes);
require(game.ReplicatedStorage.Modules.GiveServiceCommon);
local GameTimeUtils = require(ReplicatedStorage.Modules.GameTimeUtils);
local u1 = {};
local u2 = {
    Giant = {
        Alias = "Giant",
        FeedCooldown = 0,
        LevelBrackets = { 0, 20, 50, 90, 140, 200, 270 },
        LevelNotifs = { "Level 1?? how did you go DOWN??", "Wow cool level 2...", "Level 3 isnt bad", "Oh nice, Level 4, getting there", "Level 5?? Now that\'s a friend", "LEVEL 6!!! You\'ve done it!", "MAX Friendship!!!" },
        TabUnlocks = {
            [10] = { "Friendship" }
        }
    },
    Jack = {
        Alias = "Jack",
        FeedCooldown = 0,
        LevelBrackets = { 0, 25, 75, 175, 300, 450 },
        LevelNotifs = { "Level 1: Beanstalk cooldown is 15 minutes", "Level 2: Beanstalk cooldown reduced to 14 minutes", "Level 3: Beanstalk cooldown reduced to 13 minutes", "Level 4: Beanstalk cooldown reduced to 12 minutes", "Max Level: Beanstalk cooldown reduced to 10 minutes" }
    },
    Eloise = {
        Alias = "Gear",
        FeedCooldown = 86400,
        BirthdayDay = 4,
        BirthdayMonth = 3,
        OnlyFeedBirthday = true,
        LevelBrackets = { 0, 10, 20, 30, 40, 50 },
        BirthdayRewards = { {
                Type = "Gear",
                Value = "Grandmaster Sprinkler",
                Quantity = 1
            }, {
                Type = "Gear",
                Value = "Levelup Lollipop",
                Quantity = 3
            } }
    },
    Sam = {
        Alias = "Seed",
        FeedCooldown = 86400,
        BirthdayDay = 2,
        BirthdayMonth = 7,
        LevelBrackets = { 0, 15, 40, 70, 100 },
        TabUnlocks = { { "Tier 2" } },
        BirthdayRewards = {
            {
                Type = "SEEDROLL",
                Value = "Divine",
                Quantity = NumberRange.new(2, 3)
            },
            {
                Type = "SEEDROLL",
                Value = "Prismatic",
                Quantity = NumberRange.new(2, 3)
            }
        }
    },
    Raphael = {
        Alias = "Pet",
        FeedCooldown = 86400,
        BirthdayDay = 30,
        BirthdayMonth = 10,
        LevelBrackets = { 0, 15, 30, 40, 70, 100 },
        TabUnlocks = {
            [30] = { "Tier 2" }
        },
        Rewards = {
            [15] = {
                Type = "Cosmetic",
                Value = "Pet Incubator",
                Quantity = 1
            }
        },
        BirthdayRewards = { {
                Type = "Egg",
                Value = "Bug Egg",
                Quantity = 1
            }, {
                Type = "Egg",
                Value = "Legendary Egg",
                Quantity = 1
            }, {
                Type = "Egg",
                Value = "Mythical Egg",
                Quantity = 1
            } }
    },
    Isaac = {
        Alias = "Cosmetic",
        FeedCooldown = 86400,
        BirthdayDay = 1,
        BirthdayMonth = 12,
        OnlyFeedBirthday = true,
        LevelBrackets = { 0, 10, 20, 30, 40, 50 },
        TabUnlocks = { { "Friendship" } },
        BirthdayRewards = { {
                Type = "Crate",
                Value = "Sign Crate",
                Quantity = 1
            }, {
                Type = "Crate",
                Value = "Farmers Gnome Crate",
                Quantity = 1
            }, {
                Type = "Crate",
                Value = "Classic Gnome Crate",
                Quantity = 1
            }, {
                Type = "Crate",
                Value = "Statue Crate",
                Quantity = 1
            }, {
                Type = "Crate",
                Value = "Beach Crate",
                Quantity = 1
            } }
    }
};
u1.NPCEntires = u2;
u1.AliasMap = {};
local u3 = {};

for i, v in u2 do
    u1.AliasMap[v.Alias] = i;
end;

function u1.GetLevelFromPoints(p4: table, p5: any, p6: number) -- Line: 172
    -- upvalues: u2 (copy)
    local v7 = u2[p5];

    if not v7 then
        warn((`Invalid NPC name: {p5}`));

        return 1;
    end;

    local v8 = 1;

    for i, v in v7.LevelBrackets do
        if v > p6 then
            break;
        end;

        v8 = i;
    end;

    return v8;
end;

function u1.GetMaxPoints(p9, p10) -- Line: 191
    -- upvalues: u2 (copy)
    local v11 = u2[p10];

    if v11 then
        return v11.LevelBrackets[#v11.LevelBrackets];
    end;

    warn((`Invalid NPC name: {p10}`));

    return 0;
end;

function u1.GetLevelPoints(p12: table, p13: any, p14: number) -- Line: 202
    -- upvalues: u2 (copy)
    local v15 = u2[p13];

    if v15 then
        return v15.LevelBrackets[p14] or 0;
    end;

    warn((`Invalid NPC name: {p13}`));

    return 0;
end;

function u1.GetUnlockableShopTabs(p16: table, p17: any, p18: number) -- Line: 213
    -- upvalues: u2 (copy)
    local v19 = u2[p17];

    if not v19 then
        warn((`Invalid NPC name: {p17}`));

        return {};
    end;

    if not v19.TabUnlocks then
        return {};
    end;

    local v20 = {};

    for i, v in v19.TabUnlocks do
        if i <= p18 then
            for _, v2 in v do
                table.insert(v20, v2);
            end;
        end;
    end;

    return v20;
end;

function u1.GetNPCRewards(p21, p22) -- Line: 236
    -- upvalues: u2 (copy)
    local v23 = u2[p22];

    if v23 then
        return not v23.Rewards and {} or v23.Rewards;
    end;

    warn((`Invalid NPC name: {p22}`));

    return {};
end;

function u1.GetLevelNotifFromPoints(p24: table, p25: any, p26: number) -- Line: 250
    -- upvalues: u2 (copy), u1 (copy)
    local v27 = u2[p25];

    if v27 then
        local LevelFromPoints = u1:GetLevelFromPoints(p25, p26);

        return v27.LevelNotifs and v27.LevelNotifs[LevelFromPoints] or `Level {LevelFromPoints}!`;
    end;

    warn((`Invalid NPC name: {p25}`));

    return "...";
end;

function u1.IsNPCBirthday(p28: table, p29: any, p30: number?) -- Line: 262
    -- upvalues: u2 (copy), GameTimeUtils (copy)
    local v31 = u2[p29];

    if not v31 then
        warn((`Invalid NPC name: {p29}`));

        return false;
    end;

    local v32, v33 = GameTimeUtils:GameDateFromTime(p30 or workspace:GetServerTimeNow());
    local v34 = v31.BirthdayMonth or -1;
    local v35;

    if (v31.BirthdayDay or -1) == v32 then
        v35 = v34 == v33;
    else
        v35 = false;
    end;

    return v35;
end;

function u1.GetDaysTillAllBdays(p36: table, p37: number?) -- Line: 279
    -- upvalues: GameTimeUtils (copy), u1 (copy)
    local v38, v39 = GameTimeUtils:GameDateFromTime(p37 or workspace:GetServerTimeNow());
    local v40 = (v39 - 1) * 30 + v38 - 1;
    local v41 = {};

    for i, v in u1.NPCEntires do
        if u1:TryGetNPCModel(i) then
            local BirthdayDay = v.BirthdayDay;
            local BirthdayMonth = v.BirthdayMonth;

            if BirthdayDay and BirthdayMonth then
                if BirthdayDay == -1 or BirthdayMonth == -1 then
                    warn((`Invalid birthday for NPC: {i}`));
                    v41[i] = (1 / 0);
                else
                    local v42 = (BirthdayMonth - 1) * 30 + BirthdayDay - 1 - v40;

                    if v42 < 0 then
                        v42 = v42 + 360;
                    end;

                    v41[i] = v42;
                end;
            end;
        end;
    end;

    return v41;
end;

local function RegisterNPC(p43: userdata) -- Line: 325
    -- upvalues: u1 (copy), u3 (copy)
    if not p43:IsA("Model") then
        return;
    end;

    if not p43:HasTag("Feedable") then
        return;
    end;

    local Name = p43.Name;

    if not u1.NPCEntires[Name] then
        warn((`Invalid NPC name: {Name}`));

        return;
    end;

    if u3[p43] then
        return;
    end;

    u3[p43] = Name;
end;

function u1.TryGetNPCModel(p44, p45) -- Line: 345
    -- upvalues: u3 (copy)
    for i, v in u3 do
        if v == p45 then
            return i;
        end;
    end;

    return nil;
end;

function u1.TryGetNPCName(p46: table, p47: userdata) -- Line: 356
    -- upvalues: u3 (copy)
    return u3[p47];
end;

function u1.GetTrackedNPCs(p48) -- Line: 361
    -- upvalues: u3 (copy)
    return u3;
end;

CollectionService:GetInstanceAddedSignal("Feedable"):Connect(function(p49) -- Line: 366
    -- upvalues: RegisterNPC (copy)
    if not p49:IsDescendantOf(workspace) then
        return;
    end;

    RegisterNPC(p49);
end);
task.spawn(function() -- Line: 373
    -- upvalues: CollectionService (copy), RegisterNPC (copy)
    for _, v in CollectionService:GetTagged("Feedable") do
        if v:IsDescendantOf(workspace) then
            RegisterNPC(v);
        end;
    end;
end);

return u1;