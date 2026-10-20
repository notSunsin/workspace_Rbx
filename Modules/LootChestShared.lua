-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local u1 = {
    CHEST_ANIMATION_ID = "rbxassetid://106090826986158",
    PLAYER_ANIMATION_ID = "rbxassetid://84968284292690",
    PROMPT_ACTION_TEXT = "Open",
    PROMPT_OBJECT_TEXT = "Loot Chest",
    PROMPT_MAX_DISTANCE = 6,
    PROMPT_HOLD_DURATION = 0,
    FADE_TIME = 0.8,
    SERVER_ACK_TIMEOUT = 5,
    CHEST_AUTO_COLLECT_TIMEOUT = 60,
    CHEST_TIMER_SHOW_THRESHOLD = 30,
    TEMPLATE_PARENT = "Assets",
    TEMPLATE_NAME = "LootChest",
    TEMPLATE_FOLDER = "LootChests",
    NUM_TIERS = 4,
    LOCAL_CHEST_FOLDER_NAME = "LocalLootChests",
    SPAWN_DROP_HEIGHT = 25,
    SPAWN_DROP_TIME = 0.55,
    CURRENCY_MODEL_NAMES = {
        HoneyCoin = "HoneyCoins",
        HoneyCoins = "HoneyCoins",
        RoyalJelly = "RoyalJelly",
        ["Royal Jelly"] = "RoyalJelly"
    },
    EGG_MODEL_FOLDERS = { "EggModels", "BeeEggs" },
    SEED_MODEL_FOLDER = "SeedModels",
    SEED_PACK_MODEL_FOLDER = "SeedPackModels",
    PET_MODEL_FOLDER = "PetModels",
    DROP_FLY_TIME = 0.55,
    DROP_ARC_HEIGHT = 7,
    DROP_SPAWN_RADIUS = 3.5,
    DROP_STAGGER = 0.05,
    DROP_MAX_CURRENCY = 5,
    DROP_SCALE = 1,
    DROP_LID_OPEN_TIME = 1.08
};

function u1.GetEggModel(p2: string) -- Line: 58
    -- upvalues: ReplicatedStorage (copy), u1 (copy)
    local Assets = ReplicatedStorage:FindFirstChild("Assets");

    if Assets then
        Assets = Assets:FindFirstChild("Models");
    end;

    if not Assets then
        return nil;
    end;

    for _, v in u1.EGG_MODEL_FOLDERS do
        local v3 = Assets:FindFirstChild(v);

        if v3 then
            v3 = v3:FindFirstChild(p2);
        end;

        if v3 and v3:IsA("Model") then
            return v3;
        end;
    end;

    return nil;
end;

function u1.GetSeedModel(p4: string) -- Line: 74
    -- upvalues: ReplicatedStorage (copy), u1 (copy)
    local Assets = ReplicatedStorage:FindFirstChild("Assets");

    if Assets then
        Assets = Assets:FindFirstChild("Models");
    end;

    if Assets then
        Assets = Assets:FindFirstChild(u1.SEED_MODEL_FOLDER);
    end;

    if Assets then
        Assets = Assets:FindFirstChild(p4);
    end;

    if Assets and Assets:IsA("Model") then
        return Assets;
    end;

    return nil;
end;

function u1.GetSeedPackModel(p5: string) -- Line: 85
    -- upvalues: ReplicatedStorage (copy), u1 (copy)
    local Assets = ReplicatedStorage:FindFirstChild("Assets");

    if Assets then
        Assets = Assets:FindFirstChild("Models");
    end;

    if Assets then
        Assets = Assets:FindFirstChild(u1.SEED_PACK_MODEL_FOLDER);
    end;

    if Assets then
        Assets = Assets:FindFirstChild(p5);
    end;

    if Assets and Assets:IsA("Model") then
        return Assets;
    end;

    return nil;
end;

function u1.GetPetModel(p6: string) -- Line: 96
    -- upvalues: ReplicatedStorage (copy), u1 (copy)
    local Assets = ReplicatedStorage:FindFirstChild("Assets");

    if Assets then
        Assets = Assets:FindFirstChild("Models");
    end;

    if Assets then
        Assets = Assets:FindFirstChild(u1.PET_MODEL_FOLDER);
    end;

    if Assets then
        Assets = Assets:FindFirstChild(p6);
    end;

    if Assets and Assets:IsA("Model") then
        return Assets;
    end;

    return nil;
end;

function u1.UsesPhysicalDrop(p7: table) -- Line: 110
    -- upvalues: u1 (copy)
    if typeof(p7) ~= "table" then
        return false;
    end;

    if p7.Type == "Currency" then
        return u1.CURRENCY_MODEL_NAMES[p7.Value] ~= nil;
    end;

    if p7.Type == "Egg" then
        return u1.GetEggModel(p7.Value) ~= nil;
    end;

    if p7.Type == "Seed" then
        return u1.GetSeedModel(p7.Value) ~= nil;
    end;

    if p7.Type == "Seed Pack" then
        return u1.GetSeedPackModel(p7.Value) ~= nil;
    end;

    if p7.Type == "Gear" then
        return u1.GetEggModel(p7.Value) ~= nil;
    end;

    if p7.Type == "Pet" then
        return u1.GetPetModel(p7.Value) ~= nil;
    end;

    return false;
end;

function u1.GetRemote(p8: string) -- Line: 132
    -- upvalues: ReplicatedStorage (copy)
    return ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("LootChest"):WaitForChild(p8);
end;

function u1.GetTemplate(p9: number?) -- Line: 137
    -- upvalues: ReplicatedStorage (copy), u1 (copy)
    local v10 = ReplicatedStorage:FindFirstChild(u1.TEMPLATE_PARENT);

    if not v10 then
        return nil;
    end;

    local v11 = v10:FindFirstChild(u1.TEMPLATE_FOLDER);

    if v11 then
        local v12 = v11:FindFirstChild("Tier" .. math.clamp(p9 or 1, 1, u1.NUM_TIERS));

        if v12 and v12:IsA("Model") then
            return v12;
        end;
    end;

    return v10:FindFirstChild(u1.TEMPLATE_NAME);
end;

return u1;