-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CollectionService = game:GetService("CollectionService");
local DataService = require(ReplicatedStorage.Modules.DataService);
local GetFarm = require(ReplicatedStorage.Modules.GetFarm);
require(ReplicatedStorage.Data.CookingPotType);
local u15 = {
    GetCookingPotData = function(p1: table, p2: userdata, p3: string) -- Line: 14, Name: GetCookingPotData
        -- upvalues: DataService (copy)
        if not p2 then
            warn("CookingPotClientUtils:GetCookingPotData | No Player given!");

            return nil;
        end;

        if not p3 then
            warn("CookingPotClientUtils:GetCookingPotData | No UUID given!");

            return nil;
        end;

        local Data = DataService:GetData(p2);

        if not Data then
            warn("CookingPotClientUtils:GetCookingPotData | Couldn\'t get player data!");

            return nil;
        end;

        if p3 == "OLD_KITCHEN_COOKING_EVENT" then
            return Data.CookingPot;
        end;

        local SelectedSlot = Data.SaveSlots.SelectedSlot;

        if not SelectedSlot then
            warn("CookingPotServerUtils:GetCookingPotData | Couldn\'t get selected save slot!");

            return nil;
        end;

        local v4 = Data.CookingKit[SelectedSlot];

        if v4 then
            local _ = v4[p3] == nil;

            return v4[p3];
        end;

        warn("CookingPotServerUtils:GetCookingPotData | Couldn\'t get cooking kit data!");

        return nil;
    end,

    GetAllCookingPotModels = function(p5: table, p6: userdata) -- Line: 43, Name: GetAllCookingPotModels
        -- upvalues: GetFarm (copy)
        local v7 = GetFarm(p6);
        local v8 = {};

        if not v7 then
            return v8;
        end;

        for _, child in v7.Important.Cosmetic_Physical:GetChildren() do
            local v9 = child:FindFirstChild("Cooking Kit");

            if v9 then
                table.insert(v8, v9);
            end;
        end;

        return v8;
    end,

    GetAllCookingPotUUIDs = function(p10: table, p11: userdata) -- Line: 61, Name: GetAllCookingPotUUIDs
        -- upvalues: GetFarm (copy)
        local v12 = GetFarm(p11);
        local v13 = {};

        if not v12 then
            return v13;
        end;

        for _, child in v12.Important.Cosmetic_Physical:GetChildren() do
            local v14 = child:FindFirstChild("Cooking Kit");

            if v14 and v14.Parent:GetAttribute("CosmeticUUID") then
                table.insert(v13, v14);
            end;
        end;

        return v13;
    end
};

function u15.GetCookingPotModel(p16: table, p17: userdata, p18: string) -- Line: 78
    -- upvalues: CollectionService (copy), u15 (copy)
    if not p17 then
        warn("CookingPotClientUtils:GetCookingPotModel | No Player given!");

        return nil;
    end;

    if not p18 then
        warn("CookingPotClientUtils:GetCookingPotModel | No UUID given!");

        return nil;
    end;

    if p18 == "OLD_KITCHEN_COOKING_EVENT" then
        print("CookingPotClientUtils:GetCookingPotModel | Using old kitchen event pot...");
        local v19 = CollectionService:GetTagged("CookingEventModel")[1];

        if v19 then
            return v19;
        end;

        warn("CookingPotClientUtils:GetCookingPotModel | No model found! Using baseplate...");

        return nil;
    end;

    local AllCookingPotModels = u15:GetAllCookingPotModels(p17);

    if not AllCookingPotModels then
        warn("CookingPotClientUtils:GetCookingPotModel | No models found!");

        return nil;
    end;

    for _, v in AllCookingPotModels do
        if v.Parent:GetAttribute("CosmeticUUID") == p18 then
            return v;
        end;
    end;

    warn("CookingPotClientUtils:GetCookingPotModel | Model not found!");

    return nil;
end;

return u15;