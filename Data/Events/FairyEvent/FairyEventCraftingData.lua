-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Data.CraftingData.CraftingTypeRegistry);

return {
    ["Fairy Bell"] = {
        TimeToCraft = 900,
        PurchaseID = 3717331168,
        RobuxPrice = 159,
        LayoutOrder = 12,
        DisplayInCrafting = true,
        Inputs = { {
                ItemType = "Seed",
                ItemData = {
                    ItemName = "Jellycap",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Pet",
                ItemData = {
                    ItemName = "Wolpertinger",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Holdable",
                ItemData = {
                    ItemName = "Jellycap",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Holdable",
                ItemData = {
                    ItemName = "Glimmervine",
                    AcceptAllTypes = false
                }
            } },
        Outputs = { {
                ItemType = "Gear",
                ItemData = {
                    ItemName = "Fairy Bell",
                    Quantity = 1
                }
            } },
        EventConfig = {
            EventID = "FairyEventPart1",
            EventSet = "FairyEvent"
        },
        MachineTypes = { "GearEventWorkbench" },
        Cost = {
            CurrencyType = "Sheckles",
            Amount = 1000000
        }
    },
    ["Fairy Net"] = {
        TimeToCraft = 30,
        PurchaseID = 3395556018,
        RobuxPrice = 109,
        LayoutOrder = 10,
        Inputs = { {
                ItemType = "Holdable",
                ItemData = {
                    ItemName = "Sunbulb",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Seed",
                ItemData = {
                    ItemName = "Strawberry",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Harvest Tool",
                ItemData = {
                    ItemName = "Harvest Tool",
                    AcceptAllTypes = false
                }
            } },
        Outputs = { {
                ItemType = "Gear",
                ItemData = {
                    ItemName = "Fairy Net",
                    Quantity = 20
                }
            } },
        MachineTypes = { "FairyGeniusEventWorkbench" },
        Cost = {
            CurrencyType = "FairyPoints",
            Amount = 100
        }
    },
    ["Glimmering Radar"] = {
        TimeToCraft = 300,
        PurchaseID = 3395556015,
        RobuxPrice = 199,
        LayoutOrder = 20,
        Inputs = { {
                ItemType = "Fairy Jar",
                ItemData = {
                    ItemName = "Fairy Jar",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Harvest Tool",
                ItemData = {
                    ItemName = "Harvest Tool",
                    AcceptAllTypes = false
                }
            } },
        Outputs = { {
                ItemType = "Gear",
                ItemData = {
                    ItemName = "Glimmering Radar",
                    Quantity = 5
                }
            } },
        MachineTypes = { "FairyGeniusEventWorkbench" },
        Cost = {
            CurrencyType = "Sheckles",
            Amount = 1000000
        }
    },
    ["Fairy Targeter"] = {
        TimeToCraft = 450,
        PurchaseID = 3395556011,
        RobuxPrice = 149,
        LayoutOrder = 30,
        Inputs = { {
                ItemType = "Fairy Jar",
                ItemData = {
                    ItemName = "Fairy Jar",
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
                    ItemName = "Bamboo",
                    AcceptAllTypes = false
                }
            } },
        Outputs = { {
                ItemType = "Gear",
                ItemData = {
                    ItemName = "Fairy Targeter",
                    Quantity = 1
                }
            } },
        MachineTypes = { "FairyGeniusEventWorkbench" },
        Cost = {
            CurrencyType = "Sheckles",
            Amount = 1000000
        }
    },
    ["Fairy Caller"] = {
        TimeToCraft = 480,
        PurchaseID = 3395556013,
        RobuxPrice = 209,
        LayoutOrder = 40,
        Inputs = { {
                ItemType = "Fairy Jar",
                ItemData = {
                    ItemName = "Fairy Jar",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Sprinkler",
                ItemData = {
                    ItemName = "Godly Sprinkler",
                    AcceptAllTypes = false
                }
            } },
        Outputs = { {
                ItemType = "Gear",
                ItemData = {
                    ItemName = "Fairy Caller",
                    Quantity = 2
                }
            } },
        MachineTypes = { "FairyGeniusEventWorkbench" },
        Cost = {
            CurrencyType = "Sheckles",
            Amount = 2500000
        }
    },
    ["Fairy Power Extender"] = {
        TimeToCraft = 600,
        PurchaseID = 3395556012,
        RobuxPrice = 299,
        LayoutOrder = 50,
        Inputs = { {
                ItemType = "Fairy Jar",
                ItemData = {
                    ItemName = "Fairy Jar",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Fairy Caller",
                ItemData = {
                    ItemName = "Fairy Caller",
                    AcceptAllTypes = false
                }
            } },
        Outputs = { {
                ItemType = "Gear",
                ItemData = {
                    ItemName = "Fairy Power Extender",
                    Quantity = 1
                }
            } },
        MachineTypes = { "FairyGeniusEventWorkbench" },
        Cost = {
            CurrencyType = "Sheckles",
            Amount = 5000000
        }
    },
    ["Luminous Wand"] = {
        TimeToCraft = 900,
        PurchaseID = 3395556016,
        RobuxPrice = 219,
        LayoutOrder = 60,
        Inputs = { {
                ItemType = "Fairy Jar",
                ItemData = {
                    ItemName = "Fairy Jar",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Fairy Jar",
                ItemData = {
                    ItemName = "Fairy Jar",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Fairy Power Extender",
                ItemData = {
                    ItemName = "Fairy Power Extender",
                    AcceptAllTypes = false
                }
            } },
        Outputs = { {
                ItemType = "Gear",
                ItemData = {
                    ItemName = "Luminous Wand",
                    Quantity = 1
                }
            } },
        MachineTypes = { "FairyGeniusEventWorkbench" },
        Cost = {
            CurrencyType = "Sheckles",
            Amount = 10000000
        }
    },
    ["Fairy Summoner"] = {
        TimeToCraft = 3600,
        PurchaseID = 3395556009,
        RobuxPrice = 399,
        LayoutOrder = 80,
        Inputs = { {
                ItemType = "Fairy Jar",
                ItemData = {
                    ItemName = "Fairy Jar",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Fairy Net",
                ItemData = {
                    ItemName = "Fairy Net",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Fairy Power Extender",
                ItemData = {
                    ItemName = "Fairy Power Extender",
                    AcceptAllTypes = false
                }
            } },
        Outputs = { {
                ItemType = "Gear",
                ItemData = {
                    ItemName = "Fairy Summoner",
                    Quantity = 1
                }
            } },
        MachineTypes = { "FairyGeniusEventWorkbench" },
        Cost = {
            CurrencyType = "Sheckles",
            Amount = 15000000
        }
    },
    ["Enchanted Chest"] = {
        TimeToCraft = 1800,
        PurchaseID = 3394265025,
        RobuxPrice = 199,
        LayoutOrder = 10,
        Inputs = { {
                ItemType = "Holdable",
                ItemData = {
                    ItemName = "Sunbulb",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Seed Pack",
                ItemData = {
                    ItemName = "Enchanted Seed Pack",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "PetEgg",
                ItemData = {
                    ItemName = "Enchanted Egg",
                    AcceptAllTypes = false
                }
            } },
        Outputs = { {
                ItemType = "Seed Pack",
                ItemData = {
                    ItemName = "Enchanted Chest",
                    Quantity = 1
                }
            } },
        MachineTypes = { "FairyWorldCraftingWorkBench" },
        Cost = {
            CurrencyType = "FairyPoints",
            Amount = 6000
        }
    },
    ["Enchanted Seed Pack"] = {
        TimeToCraft = 300,
        PurchaseID = 3394271793,
        RobuxPrice = 99,
        LayoutOrder = 20,
        Inputs = { {
                ItemType = "Seed",
                ItemData = {
                    ItemName = "Mushroom",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Seed",
                ItemData = {
                    ItemName = "Mushroom",
                    AcceptAllTypes = false
                }
            } },
        Outputs = { {
                ItemType = "Seed Pack",
                ItemData = {
                    ItemName = "Enchanted Seed Pack",
                    Quantity = 1
                }
            } },
        MachineTypes = { "FairyWorldCraftingWorkBench" },
        Cost = {
            CurrencyType = "FairyPoints",
            Amount = 1500
        }
    },
    ["Enchanted Egg"] = {
        TimeToCraft = 600,
        PurchaseID = 3394272325,
        RobuxPrice = 129,
        LayoutOrder = 30,
        Inputs = { {
                ItemType = "Holdable",
                ItemData = {
                    ItemName = "Glowthorn",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Seed Pack",
                ItemData = {
                    ItemName = "Enchanted Seed Pack",
                    AcceptAllTypes = false
                }
            } },
        Outputs = { {
                ItemType = "PetEgg",
                ItemData = {
                    ItemName = "Enchanted Egg",
                    Quantity = 1
                }
            } },
        MachineTypes = { "FairyWorldCraftingWorkBench" },
        Cost = {
            CurrencyType = "FairyPoints",
            Amount = 3000
        }
    },
    ["Enchanted Crate"] = {
        TimeToCraft = 300,
        PurchaseID = 3394272617,
        RobuxPrice = 179,
        LayoutOrder = 40,
        Inputs = { {
                ItemType = "Seed Pack",
                ItemData = {
                    ItemName = "Enchanted Seed Pack",
                    AcceptAllTypes = false
                }
            } },
        Outputs = { {
                ItemType = "CosmeticCrate",
                ItemData = {
                    ItemName = "Enchanted Crate",
                    Quantity = 1
                }
            } },
        MachineTypes = { "FairyWorldCraftingWorkBench" },
        Cost = {
            CurrencyType = "FairyPoints",
            Amount = 1000
        }
    },
    ["Glimmering Crate"] = {
        TimeToCraft = 300,
        PurchaseID = 3394269769,
        RobuxPrice = 179,
        LayoutOrder = 50,
        Inputs = { {
                ItemType = "CosmeticCrate",
                ItemData = {
                    ItemName = "Enchanted Crate",
                    AcceptAllTypes = false
                }
            } },
        Outputs = { {
                ItemType = "CosmeticCrate",
                ItemData = {
                    ItemName = "Glimmering Crate",
                    Quantity = 1
                }
            } },
        MachineTypes = { "FairyWorldCraftingWorkBench" },
        Cost = {
            CurrencyType = "FairyPoints",
            Amount = 1000
        }
    }
};