-- Decompiled with Potassium's decompiler.

return {
    SchemaVersion = 1,
    Enabled = true,
    UI = {
        Title = "Moon Crafting",
        CraftTimeLabel = "Craft Time",
        LockedText = "Summon Harvest Moon [COUNT] more times<br/>to unlock",
        LockedTextSingular = "Summon Harvest Moon [COUNT] more time<br/>to unlock"
    },
    Station = {
        PromptObjectText = "Moon Crafting",
        Capacity = 1
    },
    Recipes = {
        {
            Id = "Starry Strawberry",
            DisplayName = "Starry Strawberry",
            LayoutOrder = 1,
            TimeToCraft = 600,
            PurchaseID = 3704521007,
            RobuxPrice = 0,
            Inputs = { {
                    ItemType = "Seed",
                    ItemData = {
                        ItemName = "Strawberry",
                        AcceptAllTypes = false
                    }
                }, {
                    ItemType = "Seed",
                    ItemData = {
                        ItemName = "Strawberry",
                        AcceptAllTypes = false
                    }
                }, {
                    ItemType = "Holdable",
                    ItemData = {
                        ItemName = "Lunar Lily",
                        AcceptAllTypes = false
                    }
                } },
            Outputs = { {
                    ItemType = "Seed",
                    ItemData = {
                        ItemName = "Starry Strawberry",
                        Quantity = 1
                    }
                } },
            Cost = {
                CurrencyType = "MoonCoins",
                Amount = 15
            }
        },
        {
            Id = "Moonbeam Radar",
            DisplayName = "Moonbeam Radar",
            LayoutOrder = 10,
            TimeToCraft = 900,
            PurchaseID = 3613106243,
            RobuxPrice = 0,
            Inputs = { {
                    ItemType = "SprayBottle",
                    ItemData = {
                        ItemName = "Cleaning Spray",
                        AcceptAllTypes = false
                    }
                }, {
                    ItemType = "Holdable",
                    ItemData = {
                        ItemName = "Starry Strawberry",
                        AcceptAllTypes = false
                    }
                }, {
                    ItemType = "Holdable",
                    ItemData = {
                        ItemName = "Crescent Reed",
                        AcceptAllTypes = false
                    }
                } },
            Outputs = { {
                    ItemType = "Gear",
                    ItemData = {
                        ItemName = "Moonbeam Radar",
                        Quantity = 1
                    }
                } },
            Cost = {
                CurrencyType = "MoonCoins",
                Amount = 5
            }
        },
        {
            Id = "Wheat Crow",
            DisplayName = "Wheat Crow",
            LayoutOrder = 20,
            TimeToCraft = 900,
            RequiredSummonContributions = 4,
            PurchaseID = 3704524083,
            RobuxPrice = 0,
            Inputs = { {
                    ItemType = "PetEgg",
                    ItemData = {
                        ItemName = "Rare Egg",
                        AcceptAllTypes = false
                    }
                }, {
                    ItemType = "Holdable",
                    ItemData = {
                        ItemName = "Mango",
                        AcceptAllTypes = false
                    }
                }, {
                    ItemType = "Seed",
                    ItemData = {
                        ItemName = "Daffodil",
                        AcceptAllTypes = false
                    }
                }, {
                    ItemType = "Seed",
                    ItemData = {
                        ItemName = "Daffodil",
                        AcceptAllTypes = false
                    }
                } },
            Outputs = { {
                    ItemType = "Pet",
                    ItemData = {
                        ItemName = "Wheat Crow",
                        Quantity = 1
                    }
                } },
            Cost = {
                CurrencyType = "MoonCoins",
                Amount = 100
            }
        },
        {
            Id = "Wheatcap",
            DisplayName = "Wheatcap",
            LayoutOrder = 30,
            TimeToCraft = 1200,
            RequiredSummonContributions = 8,
            PurchaseID = 3704522375,
            RobuxPrice = 0,
            Inputs = { {
                    ItemType = "Seed",
                    ItemData = {
                        ItemName = "Mushroom",
                        AcceptAllTypes = false
                    }
                }, {
                    ItemType = "Holdable",
                    ItemData = {
                        ItemName = "Mushroom",
                        AcceptAllTypes = false
                    }
                }, {
                    ItemType = "Holdable",
                    ItemData = {
                        ItemName = "Bamboo",
                        AcceptAllTypes = false
                    }
                }, {
                    ItemType = "Holdable",
                    ItemData = {
                        ItemName = "Fennel",
                        AcceptAllTypes = false
                    }
                } },
            Outputs = { {
                    ItemType = "Seed",
                    ItemData = {
                        ItemName = "Wheatcap",
                        Quantity = 1
                    }
                } },
            Cost = {
                CurrencyType = "MoonCoins",
                Amount = 75
            }
        },
        {
            Id = "Moon Egg",
            DisplayName = "Moon Egg",
            LayoutOrder = 35,
            TimeToCraft = 2700,
            RequiredSummonContributions = 12,
            PurchaseID = 3612390678,
            RobuxPrice = 0,
            Inputs = { {
                    ItemType = "PetEgg",
                    ItemData = {
                        ItemName = "Legendary Egg",
                        AcceptAllTypes = false
                    }
                }, {
                    ItemType = "Seed",
                    ItemData = {
                        ItemName = "Wheatcap",
                        AcceptAllTypes = false
                    }
                }, {
                    ItemType = "Holdable",
                    ItemData = {
                        ItemName = "Octobloom",
                        AcceptAllTypes = false
                    }
                }, {
                    ItemType = "Holdable",
                    ItemData = {
                        ItemName = "Harvest Melon",
                        AcceptAllTypes = false
                    }
                } },
            Outputs = { {
                    ItemType = "PetEgg",
                    ItemData = {
                        ItemName = "Moon Egg",
                        Quantity = 1
                    }
                } },
            Cost = {
                CurrencyType = "MoonCoins",
                Amount = 400
            }
        },
        {
            Id = "Harvest Golem",
            DisplayName = "Harvest Golem",
            LayoutOrder = 40,
            TimeToCraft = 5400,
            RequiredSummonContributions = 12,
            PurchaseID = 3704524955,
            RobuxPrice = 0,
            Inputs = { {
                    ItemType = "PetEgg",
                    ItemData = {
                        ItemName = "Moon Egg",
                        AcceptAllTypes = false,
                        AcceptedNames = { "Premium Moon Egg" }
                    }
                }, {
                    ItemType = "PetEgg",
                    ItemData = {
                        ItemName = "Mythical Egg",
                        AcceptAllTypes = false
                    }
                }, {
                    ItemType = "Seed",
                    ItemData = {
                        ItemName = "Burning Bud",
                        AcceptAllTypes = false
                    }
                }, {
                    ItemType = "Seed",
                    ItemData = {
                        ItemName = "Romanesco",
                        AcceptAllTypes = false
                    }
                } },
            Outputs = { {
                    ItemType = "Pet",
                    ItemData = {
                        ItemName = "Harvest Golem",
                        Quantity = 1
                    }
                } },
            Cost = {
                CurrencyType = "MoonCoins",
                Amount = 500
            }
        },
        {
            Id = "Harvest Melon",
            DisplayName = "Harvest Melon",
            LayoutOrder = 50,
            TimeToCraft = 7200,
            RequiredSummonContributions = 16,
            PurchaseID = 3704523121,
            RobuxPrice = 0,
            Inputs = { {
                    ItemType = "Seed",
                    ItemData = {
                        ItemName = "Watermelon",
                        AcceptAllTypes = false
                    }
                }, {
                    ItemType = "Seed",
                    ItemData = {
                        ItemName = "Fennel",
                        AcceptAllTypes = false
                    }
                }, {
                    ItemType = "Seed",
                    ItemData = {
                        ItemName = "Crimson Thorn",
                        AcceptAllTypes = false
                    }
                }, {
                    ItemType = "Seed Pack",
                    ItemData = {
                        ItemName = "Moon Chest",
                        AcceptAllTypes = false,
                        AcceptedNames = { "Exotic Moon Chest" }
                    }
                } },
            Outputs = { {
                    ItemType = "Seed",
                    ItemData = {
                        ItemName = "Harvest Melon",
                        Quantity = 1
                    }
                } },
            Cost = {
                CurrencyType = "MoonCoins",
                Amount = 1000
            }
        }
    }
};