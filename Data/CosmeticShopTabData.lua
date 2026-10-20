-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CosmeticItemShopData = require(ReplicatedStorage.Data.CosmeticItemShopData);
local CosmeticCrateShopData = require(ReplicatedStorage.Data.CosmeticCrateShopData);
require(ReplicatedStorage.Modules.UITabHelperModule);
require(ReplicatedStorage.Modules.Chalk);
local v1 = {
    Tabs = {
        Cosmetics = {
            Crates = CosmeticCrateShopData,
            Items = CosmeticItemShopData
        },
        Fences = {
            Crates = {},
            Items = {
                ["Garden Lanterns"] = {
                    CosmeticName = "Garden Lanterns",
                    Price = 6000000,
                    PurchaseID = 3420511116,
                    FallbackPrice = 119,
                    StockAmount = { 1, 1 }
                },
                ["Glass Bookshelf"] = {
                    CosmeticName = "Glass Bookshelf",
                    Price = 15000000,
                    PurchaseID = 3420491492,
                    FallbackPrice = 189,
                    StockAmount = { 1, 1 }
                },
                ["Glass Staircase"] = {
                    CosmeticName = "Glass Staircase",
                    Price = 15000000,
                    PurchaseID = 3420489054,
                    FallbackPrice = 189,
                    StockAmount = { 1, 1 }
                },
                ["Glass Table"] = {
                    CosmeticName = "Glass Table",
                    Price = 2000000,
                    PurchaseID = 3420488284,
                    FallbackPrice = 119,
                    StockAmount = { 1, 1 }
                },
                ["Party Lights"] = {
                    CosmeticName = "Party Lights",
                    Price = 10000000,
                    PurchaseID = 3420511513,
                    FallbackPrice = 119,
                    StockAmount = { 1, 1 }
                },
                ["Round Lantern"] = {
                    CosmeticName = "Round Lantern",
                    Price = 2000000,
                    PurchaseID = 3420487839,
                    FallbackPrice = 119,
                    StockAmount = { 1, 1 }
                },
                ["Street Lantern"] = {
                    CosmeticName = "Street Lantern",
                    Price = 2000000,
                    PurchaseID = 3420511919,
                    FallbackPrice = 119,
                    StockAmount = { 1, 1 }
                },
                ["Woody Sign"] = {
                    CosmeticName = "Woody Sign",
                    Price = 50000,
                    PurchaseID = 0,
                    FallbackPrice = 9999,
                    StockAmount = { 1, 1 }
                },
                ["Stalky Sign"] = {
                    CosmeticName = "Stalky Sign",
                    Price = 50000,
                    PurchaseID = 0,
                    FallbackPrice = 9999,
                    StockAmount = { 1, 1 }
                },
                ["Spicy Sign"] = {
                    CosmeticName = "Spicy Sign",
                    Price = 50000,
                    PurchaseID = 0,
                    FallbackPrice = 9999,
                    StockAmount = { 1, 1 }
                },
                ["Sweet Sign"] = {
                    CosmeticName = "Sweet Sign",
                    Price = 50000,
                    PurchaseID = 0,
                    FallbackPrice = 9999,
                    StockAmount = { 1, 1 }
                },
                ["Tropical Sign"] = {
                    CosmeticName = "Tropical Sign",
                    Price = 50000,
                    PurchaseID = 0,
                    FallbackPrice = 9999,
                    StockAmount = { 1, 1 }
                },
                ["Vegetable Sign"] = {
                    CosmeticName = "Vegetable Sign",
                    Price = 50000,
                    PurchaseID = 0,
                    FallbackPrice = 9999,
                    StockAmount = { 1, 1 }
                },
                ["Prickly Sign"] = {
                    CosmeticName = "Prickly Sign",
                    Price = 50000,
                    PurchaseID = 0,
                    FallbackPrice = 9999,
                    StockAmount = { 1, 1 }
                },
                ["Berry Sign"] = {
                    CosmeticName = "Berry Sign",
                    Price = 50000,
                    PurchaseID = 0,
                    FallbackPrice = 9999,
                    StockAmount = { 1, 1 }
                },
                ["Flower Sign"] = {
                    CosmeticName = "Flower Sign",
                    Price = 50000,
                    PurchaseID = 0,
                    FallbackPrice = 9999,
                    StockAmount = { 1, 1 }
                },
                ["Fruit Sign"] = {
                    CosmeticName = "Fruit Sign",
                    Price = 50000,
                    PurchaseID = 0,
                    FallbackPrice = 9999,
                    StockAmount = { 1, 1 }
                },
                ["Leafy Sign"] = {
                    CosmeticName = "Leafy Sign",
                    Price = 50000,
                    PurchaseID = 0,
                    FallbackPrice = 9999,
                    StockAmount = { 1, 1 }
                }
            },
            Fences = {
                ANCIENTOAK = {
                    FenceName = "ANCIENTOAK",
                    Price = 20000000000000,
                    PurchaseID = 0,
                    FallbackPrice = 9999,
                    ShecklesPurchaseOnly = true
                },
                FLOWER = {
                    FenceName = "FLOWER",
                    Price = 20000000000000,
                    PurchaseID = 0,
                    FallbackPrice = 9999,
                    ShecklesPurchaseOnly = true
                },
                LIGHT = {
                    FenceName = "LIGHT",
                    Price = 20000000000000,
                    PurchaseID = 0,
                    FallbackPrice = 9999,
                    ShecklesPurchaseOnly = true
                },
                BAMBOO = {
                    FenceName = "BAMBOO",
                    Price = 20000000000000,
                    PurchaseID = 0,
                    FallbackPrice = 9999,
                    ShecklesPurchaseOnly = true
                },
                STAR = {
                    FenceName = "STAR",
                    Price = 20000000000000,
                    PurchaseID = 0,
                    FallbackPrice = 9999,
                    ShecklesPurchaseOnly = true
                },
                ICE = {
                    FenceName = "ICE",
                    Price = 20000000000000,
                    PurchaseID = 0,
                    FallbackPrice = 9999,
                    ShecklesPurchaseOnly = true
                },
                VINE = {
                    FenceName = "VINE",
                    Price = 20000000000000,
                    PurchaseID = 0,
                    FallbackPrice = 9999,
                    ShecklesPurchaseOnly = true
                },
                DARKLANTERN = {
                    FenceName = "DARKLANTERN",
                    Price = 20000000000000,
                    PurchaseID = 0,
                    FallbackPrice = 9999,
                    ShecklesPurchaseOnly = true
                },
                FAIRYLIGHT = {
                    FenceName = "FAIRYLIGHT",
                    Price = 20000000000000,
                    PurchaseID = 0,
                    FallbackPrice = 9999,
                    ShecklesPurchaseOnly = true
                }
            }
        }
    },
    TabTable = {}
};

for i, _ in v1.Tabs do
    table.insert(v1.TabTable, {
        IsLocked = false,
        Name = i
    });
end;

return v1;