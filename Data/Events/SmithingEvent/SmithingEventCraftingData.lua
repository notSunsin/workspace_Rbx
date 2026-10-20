-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Data.CraftingData.CraftingTypeRegistry);

return {
    ["Gem Egg"] = {
        TimeToCraft = 600,
        PurchaseID = 3455269673,
        RobuxPrice = 209,
        LayoutOrder = 100,
        Inputs = { {
                ItemType = "PetEgg",
                ItemData = {
                    ItemName = "Common Egg",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Common Coal",
                ItemData = {
                    ItemName = "Common Coal",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Common Coal",
                ItemData = {
                    ItemName = "Common Coal",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Rare Coal",
                ItemData = {
                    ItemName = "Rare Coal",
                    AcceptAllTypes = false
                }
            } },
        Outputs = { {
                ItemType = "PetEgg",
                ItemData = {
                    ItemName = "Gem Egg",
                    Quantity = 1
                }
            } },
        MachineTypes = { "SmithingEventPetWorkbench" },
        Cost = {
            CurrencyType = "Sheckles",
            Amount = 1000000
        }
    },
    ["Smithing Dog"] = {
        TimeToCraft = 1200,
        PurchaseID = 3455274572,
        RobuxPrice = 229,
        LayoutOrder = 200,
        Inputs = { {
                ItemType = "Pet",
                ItemData = {
                    ItemName = "Dog",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Rare Coal",
                ItemData = {
                    ItemName = "Rare Coal",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Rare Coal",
                ItemData = {
                    ItemName = "Rare Coal",
                    AcceptAllTypes = false
                }
            } },
        Outputs = { {
                ItemType = "Pet",
                ItemData = {
                    ItemName = "Smithing Dog",
                    Quantity = 1
                }
            } },
        MachineTypes = { "SmithingEventPetWorkbench" },
        Cost = {
            CurrencyType = "Sheckles",
            Amount = 3000000
        }
    },
    Cheetah = {
        TimeToCraft = 2400,
        PurchaseID = 3455274866,
        RobuxPrice = 549,
        LayoutOrder = 300,
        Inputs = { {
                ItemType = "Pet",
                ItemData = {
                    ItemName = "Orange Tabby",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Legendary Coal",
                ItemData = {
                    ItemName = "Legendary Coal",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Legendary Coal",
                ItemData = {
                    ItemName = "Legendary Coal",
                    AcceptAllTypes = false
                }
            } },
        Outputs = { {
                ItemType = "Pet",
                ItemData = {
                    ItemName = "Cheetah",
                    Quantity = 1
                }
            } },
        MachineTypes = { "SmithingEventPetWorkbench" },
        Cost = {
            CurrencyType = "Sheckles",
            Amount = 8500000
        }
    },
    Anvil = {
        TimeToCraft = 900,
        PurchaseID = 3455270076,
        RobuxPrice = 119,
        LayoutOrder = 100,
        Inputs = { {
                ItemType = "Common Coal",
                ItemData = {
                    ItemName = "Common Coal",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Common Coal",
                ItemData = {
                    ItemName = "Common Coal",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Common Coal",
                ItemData = {
                    ItemName = "Common Coal",
                    AcceptAllTypes = false
                }
            } },
        Outputs = { {
                ItemType = "Cosmetic",
                ItemData = {
                    ItemName = "Anvil",
                    Quantity = 1
                }
            } },
        MachineTypes = { "SmithingEventCosmeticWorkbench" },
        Cost = {
            CurrencyType = "Sheckles",
            Amount = 1500000
        }
    },
    ["Coal Box"] = {
        TimeToCraft = 900,
        PurchaseID = 3455270320,
        RobuxPrice = 119,
        LayoutOrder = 200,
        Inputs = { {
                ItemType = "Common Coal",
                ItemData = {
                    ItemName = "Common Coal",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Rare Coal",
                ItemData = {
                    ItemName = "Rare Coal",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Legendary Coal",
                ItemData = {
                    ItemName = "Legendary Coal",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Seed",
                ItemData = {
                    ItemName = "Coconut",
                    AcceptAllTypes = false
                }
            } },
        Outputs = { {
                ItemType = "Cosmetic",
                ItemData = {
                    ItemName = "Coal Box",
                    Quantity = 1
                }
            } },
        MachineTypes = { "SmithingEventCosmeticWorkbench" },
        Cost = {
            CurrencyType = "Sheckles",
            Amount = 1500000
        }
    },
    ["Blacksmith Grinder"] = {
        TimeToCraft = 900,
        PurchaseID = 3455270632,
        RobuxPrice = 189,
        LayoutOrder = 300,
        Inputs = { {
                ItemType = "Common Coal",
                ItemData = {
                    ItemName = "Common Coal",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Rare Coal",
                ItemData = {
                    ItemName = "Rare Coal",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Holdable",
                ItemData = {
                    ItemName = "Giant Pinecone",
                    AcceptAllTypes = false
                }
            } },
        Outputs = { {
                ItemType = "Cosmetic",
                ItemData = {
                    ItemName = "Blacksmith Grinder",
                    Quantity = 1
                }
            } },
        MachineTypes = { "SmithingEventCosmeticWorkbench" },
        Cost = {
            CurrencyType = "Sheckles",
            Amount = 6000000
        }
    },
    ["Tools Rack"] = {
        TimeToCraft = 900,
        PurchaseID = 3455271054,
        RobuxPrice = 119,
        LayoutOrder = 180,
        Inputs = { {
                ItemType = "Common Coal",
                ItemData = {
                    ItemName = "Common Coal",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Rare Coal",
                ItemData = {
                    ItemName = "Rare Coal",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Holdable",
                ItemData = {
                    ItemName = "Olive",
                    AcceptAllTypes = false
                }
            } },
        Outputs = { {
                ItemType = "Cosmetic",
                ItemData = {
                    ItemName = "Tools Rack",
                    Quantity = 1
                }
            } },
        MachineTypes = { "SmithingEventCosmeticWorkbench" },
        Cost = {
            CurrencyType = "Sheckles",
            Amount = 7000000
        }
    },
    ["Shield Statue"] = {
        TimeToCraft = 900,
        PurchaseID = 3455271420,
        RobuxPrice = 239,
        LayoutOrder = 400,
        Inputs = { {
                ItemType = "Rare Coal",
                ItemData = {
                    ItemName = "Rare Coal",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Favorite Tool",
                ItemData = {
                    ItemName = "Favorite Tool",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Holdable",
                ItemData = {
                    ItemName = "Apple",
                    AcceptAllTypes = false
                }
            } },
        Outputs = { {
                ItemType = "Cosmetic",
                ItemData = {
                    ItemName = "Shield Statue",
                    Quantity = 1
                }
            } },
        MachineTypes = { "SmithingEventCosmeticWorkbench" },
        Cost = {
            CurrencyType = "Sheckles",
            Amount = 10500000
        }
    },
    ["Horse Shoe Magnet"] = {
        TimeToCraft = 7200,
        PurchaseID = 3455271745,
        RobuxPrice = 537,
        LayoutOrder = 500,
        Inputs = { {
                ItemType = "Smith Hammer of Harvest",
                ItemData = {
                    ItemName = "Smith Hammer of Harvest"
                }
            }, {
                ItemType = "Holdable",
                ItemData = {
                    ItemName = "Hollow Bamboo",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Legendary Coal",
                ItemData = {
                    ItemName = "Legendary Coal",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Divine Coal",
                ItemData = {
                    ItemName = "Divine Coal",
                    AcceptAllTypes = false
                }
            } },
        Outputs = { {
                ItemType = "Cosmetic",
                ItemData = {
                    ItemName = "Horse Shoe Magnet",
                    Quantity = 1
                }
            } },
        MachineTypes = { "SmithingEventCosmeticWorkbench" },
        Cost = {
            CurrencyType = "Sheckles",
            Amount = 15000000
        }
    },
    ["Smith Treat"] = {
        TimeToCraft = 600,
        PurchaseID = 3455273350,
        RobuxPrice = 229,
        LayoutOrder = 205,
        Inputs = { {
                ItemType = "Common Coal",
                ItemData = {
                    ItemName = "Common Coal",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Rare Coal",
                ItemData = {
                    ItemName = "Rare Coal",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "PetBoost",
                ItemData = {
                    ItemName = "Small Treat",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "PetBoost",
                ItemData = {
                    ItemName = "Small Treat",
                    AcceptAllTypes = false
                }
            } },
        Outputs = { {
                ItemType = "Gear",
                ItemData = {
                    ItemName = "Smith Treat",
                    Quantity = 1
                }
            } },
        MachineTypes = { "SmithingEventGearWorkbench" },
        Cost = {
            CurrencyType = "Sheckles",
            Amount = 4000000
        }
    },
    ["Smith Hammer of Harvest"] = {
        TimeToCraft = 1800,
        PurchaseID = 3455273154,
        RobuxPrice = 149,
        LayoutOrder = 220,
        Inputs = { {
                ItemType = "Harvest Tool",
                ItemData = {
                    ItemName = "Harvest Tool",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Rare Coal",
                ItemData = {
                    ItemName = "Rare Coal",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Rare Coal",
                ItemData = {
                    ItemName = "Rare Coal",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Rare Coal",
                ItemData = {
                    ItemName = "Rare Coal",
                    AcceptAllTypes = false
                }
            } },
        Outputs = { {
                ItemType = "Gear",
                ItemData = {
                    ItemName = "Smith Hammer of Harvest",
                    Quantity = 1
                }
            } },
        MachineTypes = { "SmithingEventGearWorkbench" },
        Cost = {
            CurrencyType = "Sheckles",
            Amount = 6000000
        }
    },
    ["Pet Shard Forger"] = {
        TimeToCraft = 3600,
        PurchaseID = 3455275888,
        RobuxPrice = 499,
        LayoutOrder = 210,
        Inputs = { {
                ItemType = "PetEgg",
                ItemData = {
                    ItemName = "Gem Egg",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Legendary Coal",
                ItemData = {
                    ItemName = "Legendary Coal",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "PetShard",
                ItemData = {
                    ItemName = "Cleansing Pet Shard",
                    AcceptAllTypes = false
                }
            } },
        Outputs = { {
                ItemType = "Gear",
                ItemData = {
                    ItemName = "Pet Shard Forger",
                    Quantity = 1
                }
            } },
        MachineTypes = { "SmithingEventGearWorkbench" },
        Cost = {
            CurrencyType = "Sheckles",
            Amount = 15000000
        }
    },
    Thundelbringer = {
        TimeToCraft = 4500,
        PurchaseID = 3455277251,
        RobuxPrice = 489,
        LayoutOrder = 500,
        Inputs = { {
                ItemType = "Smith Hammer of Harvest",
                ItemData = {
                    ItemName = "Smith Hammer of Harvest"
                }
            }, {
                ItemType = "Legendary Coal",
                ItemData = {
                    ItemName = "Legendary Coal",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Divine Coal",
                ItemData = {
                    ItemName = "Divine Coal",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Lightning Rod",
                ItemData = {
                    ItemName = "Lightning Rod",
                    AcceptAllTypes = false
                }
            } },
        Outputs = { {
                ItemType = "Gear",
                ItemData = {
                    ItemName = "Thundelbringer",
                    Quantity = 1
                }
            } },
        MachineTypes = { "SmithingEventGearWorkbench" },
        Cost = {
            CurrencyType = "Sheckles",
            Amount = 40000000
        }
    },
    Olive = {
        TimeToCraft = 900,
        PurchaseID = 0,
        RobuxPrice = 129,
        LayoutOrder = 100,
        Inputs = { {
                ItemType = "Common Coal",
                ItemData = {
                    ItemName = "Common Coal",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Common Coal",
                ItemData = {
                    ItemName = "Common Coal",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Holdable",
                ItemData = {
                    ItemName = "Grape",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Seed",
                ItemData = {
                    ItemName = "Tomato",
                    AcceptAllTypes = false
                }
            } },
        Outputs = { {
                ItemType = "Seed",
                ItemData = {
                    ItemName = "Olive",
                    Quantity = 1
                }
            } },
        MachineTypes = { "SmithingEventSeedWorkbench" },
        Cost = {
            CurrencyType = "Sheckles",
            Amount = 500000
        }
    },
    ["Hollow Bamboo"] = {
        TimeToCraft = 2700,
        PurchaseID = 0,
        RobuxPrice = 507,
        LayoutOrder = 200,
        Inputs = { {
                ItemType = "Rare Coal",
                ItemData = {
                    ItemName = "Rare Coal",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Legendary Coal",
                ItemData = {
                    ItemName = "Legendary Coal",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Holdable",
                ItemData = {
                    ItemName = "Bamboo",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Seed",
                ItemData = {
                    ItemName = "Cactus",
                    AcceptAllTypes = false
                }
            } },
        Outputs = { {
                ItemType = "Seed",
                ItemData = {
                    ItemName = "Hollow Bamboo",
                    Quantity = 1
                }
            } },
        MachineTypes = { "SmithingEventSeedWorkbench" },
        Cost = {
            CurrencyType = "Sheckles",
            Amount = 1500000
        }
    },
    Yarrow = {
        TimeToCraft = 3600,
        PurchaseID = 0,
        RobuxPrice = 729,
        LayoutOrder = 300,
        Inputs = { {
                ItemType = "Divine Coal",
                ItemData = {
                    ItemName = "Divine Coal",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Divine Coal",
                ItemData = {
                    ItemName = "Divine Coal",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Holdable",
                ItemData = {
                    ItemName = "Burning Bud",
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
                ItemType = "Seed",
                ItemData = {
                    ItemName = "Yarrow",
                    Quantity = 1
                }
            } },
        MachineTypes = { "SmithingEventSeedWorkbench" },
        Cost = {
            CurrencyType = "Sheckles",
            Amount = 10000000
        }
    }
};