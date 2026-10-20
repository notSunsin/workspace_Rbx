-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local script_Types = require(script.Types);
require(ReplicatedStorage.Modules.CommaFormatNumber);
local u1 = {
    Types = script_Types
};
local u2 = {
    Seed = script_Types.Seed,
    Gear = script_Types.Gear,
    ["Seed Pack"] = script_Types.SeedPack,
    Crate = script_Types.Crate,
    Cosmetic = script_Types.Cosmetic,
    Currency = script_Types.Currency,
    Fences = script_Types.Fences,
    Fruit = script_Types.Fruit,
    Pet = script_Types.Pet,
    Egg = script_Types.Egg,
    TradeBoothSkin = script_Types.TradeBoothSkin,
    ["Bee Shard"] = script_Types.BeeShard,
    ["Bee Egg"] = script_Types.BeeEgg
};

function u1.Format(p3, p4) -- Line: 28
    -- upvalues: u2 (copy)
    local v5 = u2[p4.Type];

    if not v5 then
        return "N/A";
    end;

    if v5.Format then
        return v5:Format(p4) or "N/A";
    end;

    warn((`Handler for {p4.Type} does not have a Format function!`));

    return "N/A";
end;

function u1.GetRarity(p6, p7) -- Line: 47
    -- upvalues: u2 (copy)
    if p7.RarityOverride then
        return p7.RarityOverride;
    end;

    local v8 = u2[p7.Type];

    if not v8 then
        return "Common";
    end;

    if v8.GetRarity then
        return v8:GetRarity(p7) or "Common";
    end;

    warn((`Handler for {p7.Type} does not have a GetRarity function!`));

    return "Common";
end;

function u1.GetImage(p9, p10) -- Line: 71
    -- upvalues: u2 (copy)
    local v11 = u2[p10.Type];

    if not v11 then
        return "rbxassetid://0";
    end;

    if v11.GetImage then
        return v11:GetImage(p10);
    end;

    warn((`Handler for {p10.Type} does not have a GetImage function!`));

    return "rbxassetid://0";
end;

function u1.GetRarityColor(p12, p13) -- Line: 87
    -- upvalues: ReplicatedStorage (copy), u1 (copy)
    local GGStaticData = require(ReplicatedStorage.Modules.GardenGuideModules.DataModules.GGStaticData);
    local Rarity = u1:GetRarity(p13);

    return GGStaticData.RarityColorMap[Rarity] or Color3.new(1, 1, 1);
end;

local u14 = {
    Seed = "Seed",
    Holdable = "Fruit",
    ["Seed Pack"] = "Seed Pack",
    PetEgg = "Egg",
    Pet = "Pet"
};
local u15 = {};

for i, v in u14 do
    u15[v] = i;
end;

function u1.InventoryToGiveType(p16: table, p17: string) -- Line: 116
    -- upvalues: u14 (copy)
    local v18 = u14[p17];

    if not v18 then
        warn((`[GiveServiceCommon] No conversion for {p17} to GiveType`));
    end;

    return v18;
end;

function u1.GiveToInventoryType(p19: table, p20: string) -- Line: 125
    -- upvalues: u15 (copy)
    local v21 = u15[p20];

    if not v21 then
        warn((`[GiveServiceCommon] No conversion for {p20} to InventoryType`));
    end;

    return v21;
end;

function u1.MatchesInventoryItem(p22: table, p23: table, p24: any) -- Line: 134
    -- upvalues: u1 (copy)
    if p23.ItemType ~= u1:GiveToInventoryType(p24.Type) then
        return false;
    end;

    if p24.Type == "Seed Pack" then
        if p23.ItemData.Type == p24.Value then
            return true;
        end;
    else
        warn((`[GiveServiceCommon] Type match not implemented {p24.Type}`));
    end;

    return false;
end;

return u1;