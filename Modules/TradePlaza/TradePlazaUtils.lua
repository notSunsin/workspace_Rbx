-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local TradeBoothSkinRegistry = require(ReplicatedStorage.Data.TradeBoothSkinRegistry);
local SeedData = require(ReplicatedStorage.Data.SeedData);
local PetList = require(ReplicatedStorage.Data.PetRegistry.PetList);
local CosmeticCrates = require(ReplicatedStorage.Data.CosmeticCrateRegistry.CosmeticCrates);
local TradePlazaBlacklist = require(ReplicatedStorage.Data.TradePlaza.TradePlazaBlacklist);
local GGStaticData = require(ReplicatedStorage.Modules.GardenGuideModules.DataModules.GGStaticData);
local TokenRAPController = require(ReplicatedStorage.Modules.TradeTokens.TokenRAPController);
local TokenRAPUtil = require(ReplicatedStorage.Modules.TradeTokens.TokenRAPUtil);
require(ReplicatedStorage.Data.TradeData);
local UpdateService = require(ReplicatedStorage.Modules.UpdateService);
local StringUtils = require(ReplicatedStorage.Modules.StringUtils);
local v1 = ReplicatedStorage.GameEvents.GardenGuide.GetGGBlacklist:InvokeServer();
local _ = Players.LocalPlayer.PlayerGui;
local _ = ReplicatedStorage.Data.TradePlaza.IndexTemplates.ItemTemplate;
local RarityLayoutMap = GGStaticData.RarityLayoutMap;
local u2 = {
    Seeds = {
        Data = SeedData,
        TP = TradePlazaBlacklist.SeedBlacklist,
        GG = v1.PlantBlacklist
    },
    Plants = {
        Data = SeedData,
        TP = TradePlazaBlacklist.PlantBlacklist,
        GG = v1.PlantBlacklist
    },
    Pets = {
        Data = PetList,
        TP = TradePlazaBlacklist.PetBlacklist,
        GG = v1.PetBlacklist
    },
    Crates = {
        Data = CosmeticCrates,
        TP = TradePlazaBlacklist.CrateBlacklist,
        GG = v1.CosmeticBlacklist
    },
    TradeBoothSkins = {
        Data = TradeBoothSkinRegistry,
        TP = TradePlazaBlacklist.TradeBoothSkinsBlacklist,
        GG = {}
    }
};
local v3 = {};

local function CategoryDataProcessor(p4, p5, p6) -- Line: 67
    -- upvalues: TokenRAPUtil (copy), TokenRAPController (copy)
    local v7 = {
        id = "-",
        type = "Holdable"
    };

    if p4 == "Seeds" then
        return v7;
    end;

    if p4 == "Plants" then
        local ItemId = TokenRAPUtil.GetItemId("Holdable", {
            MutationString = "",
            ItemName = p5
        });
        local v8 = TokenRAPController:GetRAPById("Holdable", ItemId) or 0;

        return {
            type = "Holdable",
            id = ItemId,
            data = {
                MutationString = "",
                Variant = "Normal",
                FakeItem = true,
                ItemName = p5,
                ImageId = p6.FruitIcon,
                Rarity = p6.SeedRarity,
                RAPValue = v8
            }
        };
    end;

    if p4 == "Pets" then
        local ItemId = TokenRAPUtil.GetItemId("Pet", {
            PetType = p5,
            PetData = {
                MutationType = "",
                Level = 0
            }
        });
        local v9 = TokenRAPController:GetRAPById("Pet", ItemId) or 0;

        return {
            type = "Pet",
            id = ItemId,
            data = {
                FakeItem = true,
                ItemName = p5,
                ImageId = p6.Icon,
                Rarity = p6.Rarity,
                RAPValue = v9,
                PetType = p5,
                PetData = {
                    MutationType = "Normal",
                    Level = 1
                }
            }
        };
    end;

    if p4 == "Crates" then
        return v7;
    end;

    if p4 == "TradeBoothSkins" then
        local ItemId = TokenRAPUtil.GetItemId("TradeBoothSkin", {
            SkinID = p5
        });
        local v10 = TokenRAPController:GetRAPById("TradeBoothSkin", ItemId) or 0;
        v7 = {
            type = "TradeBoothSkin",
            id = ItemId,
            data = {
                FakeItem = true,
                ItemName = p5,
                ImageId = p6.Icon,
                Rarity = p6.Rarity,
                RAPValue = v10,
                SkinID = p5
            }
        };
    end;

    return v7;
end;

function v3.GetItemsForCategory(p11: string, p12: string?) -- Line: 169
    -- upvalues: u2 (copy), UpdateService (copy), StringUtils (copy), CategoryDataProcessor (copy)
    local TP = u2[p11].TP;
    local GG = u2[p11].GG;
    local v13 = {};

    for i, v in u2[p11].Data do
        if not UpdateService:IsHiddenFromUpdate(i) then
            local v14 = StringUtils:StipFlavourText(i);

            if not (TP[i] or (TP[v14] or (GG[i] or (GG[v14] or not string.find(string.lower(i), string.lower(p12 or "")))))) then
                local v15 = CategoryDataProcessor(p11, i, v);
                table.insert(v13, v15);
            end;
        end;
    end;

    return v13;
end;

function v3.SortItems(p16: table, u17: string) -- Line: 198
    -- upvalues: RarityLayoutMap (copy)
    table.sort(p16, function(p18, p19) -- Line: 199
        -- upvalues: u17 (copy), RarityLayoutMap (ref)
        if u17 == "RAP Value Desc" then
            if p18.data.RAPValue == p19.data.RAPValue then
                return p18.data.ItemName < p19.data.ItemName;
            end;

            return p18.data.RAPValue > p19.data.RAPValue;
        end;

        if u17 == "Rarity Asc" then
            if RarityLayoutMap[p18.data.Rarity] == RarityLayoutMap[p19.data.Rarity] then
                return p18.data.ItemName < p19.data.ItemName;
            end;

            return RarityLayoutMap[p18.data.Rarity] < RarityLayoutMap[p19.data.Rarity];
        end;

        if u17 ~= "Rarity Desc" then
            return p18.data.RAPValue < p19.data.RAPValue;
        end;

        if RarityLayoutMap[p18.data.Rarity] == RarityLayoutMap[p19.data.Rarity] then
            return p18.data.ItemName < p19.data.ItemName;
        end;

        return RarityLayoutMap[p18.data.Rarity] > RarityLayoutMap[p19.data.Rarity];
    end);
end;

return v3;