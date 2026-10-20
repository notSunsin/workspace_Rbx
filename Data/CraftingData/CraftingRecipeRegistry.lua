-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Data.CraftingData.CraftingTypeRegistry);
local u1 = {};

local function GetTableForMachineType(p2) -- Line: 1232
    -- upvalues: u1 (copy)
    local v3 = u1[p2];

    if not v3 then
        v3 = {};
        u1[p2] = v3;
    end;

    return v3;
end;

local v4 = {
    ["Lightning Rod"] = {
        TimeToCraft = 2700,
        PurchaseID = 3265946758,
        RobuxPrice = 179,
        LayoutOrder = 5,
        Inputs = { {
                ItemType = "Sprinkler",
                ItemData = {
                    ItemName = "Basic Sprinkler",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Sprinkler",
                ItemData = {
                    ItemName = "Advanced Sprinkler",
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
                    ItemName = "Lightning Rod",
                    Quantity = 1
                }
            } },
        MachineTypes = { "GearEventWorkbench" },
        Cost = {
            CurrencyType = "Sheckles",
            Amount = 500000
        }
    },
    ["Tanning Mirror"] = {
        TimeToCraft = 2700,
        PurchaseID = 3311159836,
        RobuxPrice = 219,
        LayoutOrder = 6,
        Inputs = { {
                ItemType = "Sprinkler",
                ItemData = {
                    ItemName = "Basic Sprinkler",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Sprinkler",
                ItemData = {
                    ItemName = "Advanced Sprinkler",
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
                    ItemName = "Tanning Mirror",
                    Quantity = 1
                }
            } },
        MachineTypes = { "GearEventWorkbench" },
        Cost = {
            CurrencyType = "Sheckles",
            Amount = 500000
        }
    },
    Reclaimer = {
        TimeToCraft = 1500,
        PurchaseID = 3309686533,
        RobuxPrice = 199,
        LayoutOrder = 8,
        Inputs = { {
                ItemType = "PetEgg",
                ItemData = {
                    ItemName = "Common Egg",
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
                    ItemName = "Reclaimer",
                    Quantity = 3
                }
            } },
        MachineTypes = { "GearEventWorkbench" },
        Cost = {
            CurrencyType = "Sheckles",
            Amount = 500000
        }
    },
    ["Event Lantern"] = {
        TimeToCraft = 10,
        PurchaseID = 3388358462,
        RobuxPrice = 39,
        LayoutOrder = 10,
        Inputs = { {
                ItemType = "Recall Wrench",
                ItemData = {
                    ItemName = "Recall Wrench",
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
                ItemType = "Gear",
                ItemData = {
                    ItemName = "Event Lantern",
                    Quantity = 30
                }
            } },
        MachineTypes = { "GearEventWorkbench" },
        Cost = {
            CurrencyType = "Sheckles",
            Amount = 350000
        }
    },
    ["Pet Pouch"] = {
        TimeToCraft = 1800,
        PurchaseID = 3369521127,
        RobuxPrice = 89,
        LayoutOrder = 118,
        Inputs = { {
                ItemType = "PetEgg",
                ItemData = {
                    ItemName = "Common Egg",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Food",
                ItemData = {
                    ItemName = "Corndog",
                    Quantity = 1
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
                    ItemName = "Small Toy",
                    AcceptAllTypes = false
                }
            } },
        Outputs = { {
                ItemType = "Gear",
                ItemData = {
                    ItemName = "Pet Pouch",
                    Quantity = 1
                }
            } },
        MachineTypes = { "GearEventWorkbench" },
        Cost = {
            CurrencyType = "Sheckles",
            Amount = 50000000
        }
    },
    ["Small Toy"] = {
        TimeToCraft = 600,
        PurchaseID = 3329526448,
        RobuxPrice = 139,
        LayoutOrder = 113,
        Inputs = { {
                ItemType = "PetEgg",
                ItemData = {
                    ItemName = "Common Egg",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Seed",
                ItemData = {
                    ItemName = "Coconut",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Holdable",
                ItemData = {
                    ItemName = "Coconut",
                    AcceptAllTypes = false
                }
            } },
        Outputs = { {
                ItemType = "Gear",
                ItemData = {
                    ItemName = "Small Toy",
                    Quantity = 3
                }
            } },
        MachineTypes = { "GearEventWorkbench" },
        Cost = {
            CurrencyType = "Sheckles",
            Amount = 1000000
        }
    },
    ["Small Treat"] = {
        TimeToCraft = 600,
        PurchaseID = 3329527534,
        RobuxPrice = 89,
        LayoutOrder = 115,
        Inputs = { {
                ItemType = "PetEgg",
                ItemData = {
                    ItemName = "Common Egg",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Seed",
                ItemData = {
                    ItemName = "Dragon Fruit",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Holdable",
                ItemData = {
                    ItemName = "Blueberry",
                    AcceptAllTypes = false
                }
            } },
        Outputs = { {
                ItemType = "Gear",
                ItemData = {
                    ItemName = "Small Treat",
                    Quantity = 3
                }
            } },
        MachineTypes = { "GearEventWorkbench" },
        Cost = {
            CurrencyType = "Sheckles",
            Amount = 1000000
        }
    },
    ["Tropical Mist Sprinkler"] = {
        TimeToCraft = 3600,
        PurchaseID = 3306484251,
        RobuxPrice = 229,
        LayoutOrder = 10,
        DisplayInCrafting = false,
        Inputs = { {
                ItemType = "Holdable",
                ItemData = {
                    ItemName = "Coconut",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Holdable",
                ItemData = {
                    ItemName = "Dragon Fruit",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Holdable",
                ItemData = {
                    ItemName = "Mango",
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
                    ItemName = "Tropical Mist Sprinkler",
                    Quantity = 1
                }
            } },
        MachineTypes = { "GearEventWorkbench" }
    },
    ["Berry Blusher Sprinkler"] = {
        TimeToCraft = 3600,
        PurchaseID = 3306484242,
        RobuxPrice = 229,
        LayoutOrder = 20,
        DisplayInCrafting = false,
        Inputs = { {
                ItemType = "Holdable",
                ItemData = {
                    ItemName = "Grape",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Holdable",
                ItemData = {
                    ItemName = "Blueberry",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Holdable",
                ItemData = {
                    ItemName = "Strawberry",
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
                    ItemName = "Berry Blusher Sprinkler",
                    Quantity = 1
                }
            } },
        MachineTypes = { "GearEventWorkbench" }
    },
    ["Spice Spritzer Sprinkler"] = {
        TimeToCraft = 3600,
        PurchaseID = 3306484232,
        RobuxPrice = 229,
        LayoutOrder = 30,
        DisplayInCrafting = false,
        Inputs = { {
                ItemType = "Holdable",
                ItemData = {
                    ItemName = "Pepper",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Holdable",
                ItemData = {
                    ItemName = "Ember Lily",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Holdable",
                ItemData = {
                    ItemName = "Cacao",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Sprinkler",
                ItemData = {
                    ItemName = "Master Sprinkler",
                    AcceptAllTypes = false
                }
            } },
        Outputs = { {
                ItemType = "Gear",
                ItemData = {
                    ItemName = "Spice Spritzer Sprinkler",
                    Quantity = 1
                }
            } },
        MachineTypes = { "GearEventWorkbench" }
    },
    ["Sweet Soaker Sprinkler"] = {
        TimeToCraft = 3600,
        PurchaseID = 3306484252,
        RobuxPrice = 229,
        LayoutOrder = 40,
        DisplayInCrafting = false,
        Inputs = { {
                ItemType = "Holdable",
                ItemData = {
                    ItemName = "Watermelon",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Holdable",
                ItemData = {
                    ItemName = "Watermelon",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Holdable",
                ItemData = {
                    ItemName = "Watermelon",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Sprinkler",
                ItemData = {
                    ItemName = "Master Sprinkler",
                    AcceptAllTypes = false
                }
            } },
        Outputs = { {
                ItemType = "Gear",
                ItemData = {
                    ItemName = "Sweet Soaker Sprinkler",
                    Quantity = 1
                }
            } },
        MachineTypes = { "GearEventWorkbench" }
    },
    ["Flower Froster Sprinkler"] = {
        TimeToCraft = 3600,
        PurchaseID = 3306484243,
        RobuxPrice = 229,
        LayoutOrder = 50,
        DisplayInCrafting = false,
        Inputs = { {
                ItemType = "Holdable",
                ItemData = {
                    ItemName = "Orange Tulip",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Holdable",
                ItemData = {
                    ItemName = "Daffodil",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Sprinkler",
                ItemData = {
                    ItemName = "Advanced Sprinkler",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Sprinkler",
                ItemData = {
                    ItemName = "Basic Sprinkler",
                    AcceptAllTypes = false
                }
            } },
        Outputs = { {
                ItemType = "Gear",
                ItemData = {
                    ItemName = "Flower Froster Sprinkler",
                    Quantity = 1
                }
            } },
        MachineTypes = { "GearEventWorkbench" }
    },
    ["Stalk Sprout Sprinkler"] = {
        TimeToCraft = 3600,
        PurchaseID = 3306484241,
        RobuxPrice = 229,
        LayoutOrder = 60,
        DisplayInCrafting = false,
        Inputs = { {
                ItemType = "Holdable",
                ItemData = {
                    ItemName = "Bamboo",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Holdable",
                ItemData = {
                    ItemName = "Beanstalk",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Holdable",
                ItemData = {
                    ItemName = "Mushroom",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Sprinkler",
                ItemData = {
                    ItemName = "Advanced Sprinkler",
                    AcceptAllTypes = false
                }
            } },
        Outputs = { {
                ItemType = "Gear",
                ItemData = {
                    ItemName = "Stalk Sprout Sprinkler",
                    Quantity = 1
                }
            } },
        MachineTypes = { "GearEventWorkbench" }
    },
    ["Mutation Spray Choc"] = {
        TimeToCraft = 720,
        PurchaseID = 3306484247,
        RobuxPrice = 179,
        LayoutOrder = 70,
        DisplayInCrafting = false,
        Inputs = { {
                ItemType = "SprayBottle",
                ItemData = {
                    ItemName = "Cleaning Spray",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Holdable",
                ItemData = {
                    ItemName = "Cacao",
                    AcceptAllTypes = false
                }
            } },
        Outputs = { {
                ItemType = "Gear",
                ItemData = {
                    ItemName = "Mutation Spray Choc",
                    Quantity = 1
                }
            } },
        MachineTypes = { "GearEventWorkbench" },
        Cost = {
            CurrencyType = "Sheckles",
            Amount = 200000
        }
    },
    ["Mutation Spray Chilled"] = {
        TimeToCraft = 300,
        PurchaseID = 3317772898,
        RobuxPrice = 189,
        LayoutOrder = 80,
        DisplayInCrafting = false,
        Inputs = { {
                ItemType = "SprayBottle",
                ItemData = {
                    ItemName = "Cleaning Spray",
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
                    ItemName = "Mutation Spray Chilled",
                    Quantity = 1
                }
            } },
        MachineTypes = { "GearEventWorkbench" },
        Cost = {
            CurrencyType = "Sheckles",
            Amount = 500000
        }
    },
    ["Mutation Spray Pollinated"] = {
        TimeToCraft = 300,
        PurchaseID = 3306484250,
        RobuxPrice = 179,
        LayoutOrder = 80,
        DisplayInCrafting = false,
        Inputs = { {
                ItemType = "SprayBottle",
                ItemData = {
                    ItemName = "Cleaning Spray",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Holdable",
                ItemData = {
                    ItemName = "Bee Balm",
                    AcceptAllTypes = false
                }
            } },
        Outputs = { {
                ItemType = "Gear",
                ItemData = {
                    ItemName = "Mutation Spray Pollinated",
                    Quantity = 1
                }
            } },
        MachineTypes = { "GearEventWorkbench" },
        Cost = {
            CurrencyType = "Honey",
            Amount = 25
        }
    },
    ["Mutation Spray Shocked"] = {
        TimeToCraft = 1800,
        PurchaseID = 3306484253,
        RobuxPrice = 199,
        LayoutOrder = 90,
        DisplayInCrafting = false,
        Inputs = { {
                ItemType = "SprayBottle",
                ItemData = {
                    ItemName = "Cleaning Spray",
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
                    ItemName = "Mutation Spray Shocked",
                    Quantity = 1
                }
            } },
        MachineTypes = { "GearEventWorkbench" },
        Cost = {
            CurrencyType = "Sheckles",
            Amount = 1000000
        }
    },
    ["Honey Crafters Crate"] = {
        TimeToCraft = 1800,
        PurchaseID = 3306484248,
        RobuxPrice = 179,
        LayoutOrder = 100,
        DisplayInCrafting = false,
        Inputs = { {
                ItemType = "CosmeticCrate",
                ItemData = {
                    ItemName = "Bee Crate",
                    AcceptAllTypes = false
                }
            } },
        Outputs = { {
                ItemType = "CosmeticCrate",
                ItemData = {
                    ItemName = "Honey Crafters Crate",
                    Quantity = 1
                }
            } },
        MachineTypes = { "GearEventWorkbench" },
        Cost = {
            CurrencyType = "Honey",
            Amount = 12
        }
    },
    ["Anti Bee Egg"] = {
        TimeToCraft = 7200,
        PurchaseID = 3306484244,
        RobuxPrice = 149,
        LayoutOrder = 110,
        DisplayInCrafting = false,
        Inputs = { {
                ItemType = "PetEgg",
                ItemData = {
                    ItemName = "Bee Egg",
                    AcceptAllTypes = false
                }
            } },
        Outputs = { {
                ItemType = "PetEgg",
                ItemData = {
                    ItemName = "Anti Bee Egg",
                    Quantity = 1
                }
            } },
        MachineTypes = { "GearEventWorkbench" },
        Cost = {
            CurrencyType = "Honey",
            Amount = 25
        }
    },
    ["Pack Bee"] = {
        TimeToCraft = 14400,
        PurchaseID = 3306484257,
        RobuxPrice = 799,
        LayoutOrder = 120,
        DisplayInCrafting = false,
        Inputs = { {
                ItemType = "PetEgg",
                ItemData = {
                    ItemName = "Anti Bee Egg",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Holdable",
                ItemData = {
                    ItemName = "Legacy Sunflower",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Holdable",
                ItemData = {
                    ItemName = "Purple Dahlia",
                    AcceptAllTypes = false
                }
            } },
        Outputs = { {
                ItemType = "Pet",
                ItemData = {
                    ItemName = "Pack Bee",
                    Quantity = 1
                }
            } },
        MachineTypes = { "GearEventWorkbench" },
        Cost = {
            CurrencyType = "Honey",
            Amount = 250
        }
    },
    ["Silver Ingot"] = {
        TimeToCraft = 60,
        PurchaseID = 3460380386,
        RobuxPrice = 29,
        LayoutOrder = 130,
        Inputs = { {
                ItemType = "Holdable",
                ItemData = {
                    ItemName = "Sugar Apple",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Seed",
                ItemData = {
                    ItemName = "Buttercup",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Sprinkler",
                ItemData = {
                    ItemName = "Basic Sprinkler",
                    AcceptAllTypes = false
                }
            } },
        Outputs = { {
                ItemType = "Cosmetic",
                ItemData = {
                    ItemName = "Silver Ingot",
                    Quantity = 1
                }
            } },
        MachineTypes = { "GearEventWorkbench" },
        Cost = {
            CurrencyType = "Sheckles",
            Amount = 150000
        }
    },
    ["Gold Ingot"] = {
        TimeToCraft = 60,
        PurchaseID = 3460381002,
        RobuxPrice = 33,
        LayoutOrder = 140,
        Inputs = { {
                ItemType = "Holdable",
                ItemData = {
                    ItemName = "Giant Pinecone",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Seed",
                ItemData = {
                    ItemName = "Daffodil",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Sprinkler",
                ItemData = {
                    ItemName = "Advanced Sprinkler",
                    AcceptAllTypes = false
                }
            } },
        Outputs = { {
                ItemType = "Cosmetic",
                ItemData = {
                    ItemName = "Gold Ingot",
                    Quantity = 1
                }
            } },
        MachineTypes = { "GearEventWorkbench" },
        Cost = {
            CurrencyType = "Sheckles",
            Amount = 300000
        }
    },
    ["Silver Piggy"] = {
        TimeToCraft = 1800,
        PurchaseID = 3460381175,
        RobuxPrice = 419,
        LayoutOrder = 150,
        Inputs = { {
                ItemType = "Pet",
                ItemData = {
                    ItemName = "Pig",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Food",
                ItemData = {
                    ItemName = "Sushi",
                    Quantity = 1
                }
            }, {
                ItemType = "Lightning Rod",
                ItemData = {
                    ItemName = "Lightning Rod",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "PetBoost",
                ItemData = {
                    ItemName = "Medium Toy",
                    AcceptAllTypes = false
                }
            } },
        Outputs = { {
                ItemType = "Pet",
                ItemData = {
                    ItemName = "Silver Piggy",
                    Quantity = 1
                }
            } },
        MachineTypes = { "GearEventWorkbench" },
        Cost = {
            CurrencyType = "Sheckles",
            Amount = 150000000
        }
    },
    ["Golden Piggy"] = {
        TimeToCraft = 2700,
        PurchaseID = 3460381429,
        RobuxPrice = 459,
        LayoutOrder = 160,
        Inputs = { {
                ItemType = "Pet",
                ItemData = {
                    ItemName = "Silver Piggy",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Food",
                ItemData = {
                    ItemName = "Pizza",
                    Quantity = 1
                }
            }, {
                ItemType = "Tanning Mirror",
                ItemData = {
                    ItemName = "Tanning Mirror",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "PetBoost",
                ItemData = {
                    ItemName = "Medium Treat",
                    AcceptAllTypes = false
                }
            } },
        Outputs = { {
                ItemType = "Pet",
                ItemData = {
                    ItemName = "Golden Piggy",
                    Quantity = 1
                }
            } },
        MachineTypes = { "GearEventWorkbench" },
        Cost = {
            CurrencyType = "Sheckles",
            Amount = 300000000
        }
    },
    ["Chimera Stone"] = {
        TimeToCraft = 3600,
        PurchaseID = 3460382022,
        RobuxPrice = 199,
        LayoutOrder = 170,
        DisplayInCrafting = true,
        Inputs = { {
                ItemType = "PetEgg",
                ItemData = {
                    ItemName = "Mythical Egg",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "PetEgg",
                ItemData = {
                    ItemName = "Bug Egg",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "PetEgg",
                ItemData = {
                    ItemName = "Jungle Egg",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "PetEgg",
                ItemData = {
                    ItemName = "Gem Egg",
                    AcceptAllTypes = false
                }
            } },
        Outputs = { {
                ItemType = "Gear",
                ItemData = {
                    ItemName = "Chimera Stone",
                    Quantity = 1
                }
            } },
        MachineTypes = { "GearEventWorkbench" },
        Cost = {
            CurrencyType = "Sheckles",
            Amount = 500000000
        }
    },
    ["Black Spotty Egg"] = {
        TimeToCraft = 14400,
        PurchaseID = 3596451885,
        RobuxPrice = 829,
        LayoutOrder = 180,
        DisplayInCrafting = true,
        Inputs = { {
                ItemType = "PetEgg",
                ItemData = {
                    ItemName = "Rare Egg",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Seed",
                ItemData = {
                    ItemName = "Octobloom",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Seed",
                ItemData = {
                    ItemName = "Zebrazinkle",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Seed",
                ItemData = {
                    ItemName = "Crimson Thorn",
                    AcceptAllTypes = false
                }
            } },
        Outputs = { {
                ItemType = "PetEgg",
                ItemData = {
                    ItemName = "Black Spotty Egg",
                    Quantity = 1
                }
            } },
        MachineTypes = { "GearEventWorkbench" },
        Cost = {
            CurrencyType = "Sheckles",
            Amount = 1000000000000000
        }
    },
    ["Shadow Cat"] = {
        TimeToCraft = 3600,
        PurchaseID = 3605258641,
        RobuxPrice = 0,
        LayoutOrder = 190,
        DisplayInCrafting = true,
        Inputs = { {
                ItemType = "Pet",
                ItemData = {
                    ItemName = "Orange Tabby",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Seed",
                ItemData = {
                    ItemName = "Grape",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Holdable",
                ItemData = {
                    ItemName = "Octobloom",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Sprinkler",
                ItemData = {
                    ItemName = "Grandmaster Sprinkler",
                    AcceptAllTypes = false
                }
            } },
        Outputs = { {
                ItemType = "Pet",
                ItemData = {
                    ItemName = "Shadow Cat",
                    Quantity = 1
                }
            } },
        MachineTypes = { "GearEventWorkbench" },
        Cost = {
            CurrencyType = "Sheckles",
            Amount = 50000000
        }
    },
    ["Crafters Seed Pack"] = {
        TimeToCraft = 1200,
        PurchaseID = 3306485034,
        RobuxPrice = 199,
        LayoutOrder = 130,
        DisplayInCrafting = false,
        Inputs = { {
                ItemType = "Seed Pack",
                ItemData = {
                    ItemName = "Flower Seed Pack",
                    AcceptAllTypes = false
                }
            } },
        Outputs = { {
                ItemType = "Seed Pack",
                ItemData = {
                    ItemName = "Crafters Seed Pack",
                    Quantity = 1
                }
            } },
        MachineTypes = { "SeedEventWorkbench" },
        Cost = {
            CurrencyType = "Honey",
            Amount = 10
        }
    },
    ["Peace Lily"] = {
        TimeToCraft = 600,
        PurchaseID = 3317730044,
        RobuxPrice = 129,
        LayoutOrder = 140,
        DisplayInCrafting = false,
        Inputs = { {
                ItemType = "Seed",
                ItemData = {
                    ItemName = "Rafflesia",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Seed",
                ItemData = {
                    ItemName = "Cauliflower",
                    AcceptAllTypes = false
                }
            } },
        Outputs = { {
                ItemType = "Seed",
                ItemData = {
                    ItemName = "Peace Lily",
                    Quantity = 1
                }
            } },
        MachineTypes = { "SeedEventWorkbench" },
        Cost = {
            CurrencyType = "SummerCoins",
            Amount = 3
        }
    },
    ["Aloe Vera"] = {
        TimeToCraft = 600,
        PurchaseID = 3317175501,
        RobuxPrice = 299,
        LayoutOrder = 143,
        DisplayInCrafting = false,
        Inputs = { {
                ItemType = "Seed",
                ItemData = {
                    ItemName = "Peace Lily",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Holdable",
                ItemData = {
                    ItemName = "Prickly Pear",
                    AcceptAllTypes = false
                }
            } },
        Outputs = { {
                ItemType = "Seed",
                ItemData = {
                    ItemName = "Aloe Vera",
                    Quantity = 1
                }
            } },
        MachineTypes = { "SeedEventWorkbench" },
        Cost = {
            CurrencyType = "SummerCoins",
            Amount = 18
        }
    },
    Guanabana = {
        TimeToCraft = 600,
        PurchaseID = 3317175618,
        RobuxPrice = 779,
        LayoutOrder = 145,
        DisplayInCrafting = false,
        Inputs = { {
                ItemType = "Seed",
                ItemData = {
                    ItemName = "Aloe Vera",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Seed",
                ItemData = {
                    ItemName = "Prickly Pear",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Holdable",
                ItemData = {
                    ItemName = "Banana",
                    AcceptAllTypes = false
                }
            } },
        Outputs = { {
                ItemType = "Seed",
                ItemData = {
                    ItemName = "Guanabana",
                    Quantity = 1
                }
            } },
        MachineTypes = { "SeedEventWorkbench" },
        Cost = {
            CurrencyType = "SummerCoins",
            Amount = 30
        }
    },
    ["Manuka Flower"] = {
        TimeToCraft = 600,
        PurchaseID = 3306485030,
        RobuxPrice = 99,
        LayoutOrder = 140,
        DisplayInCrafting = false,
        Inputs = { {
                ItemType = "Seed",
                ItemData = {
                    ItemName = "Daffodil",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Seed",
                ItemData = {
                    ItemName = "Orange Tulip",
                    AcceptAllTypes = false
                }
            } },
        Outputs = { {
                ItemType = "Seed",
                ItemData = {
                    ItemName = "Manuka Flower",
                    Quantity = 1
                }
            } },
        MachineTypes = { "SeedEventWorkbench" },
        Cost = {
            CurrencyType = "Honey",
            Amount = 6
        }
    },
    Dandelion = {
        TimeToCraft = 960,
        PurchaseID = 3306485029,
        RobuxPrice = 199,
        LayoutOrder = 150,
        DisplayInCrafting = false,
        Inputs = { {
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
            }, {
                ItemType = "Seed",
                ItemData = {
                    ItemName = "Manuka Flower",
                    AcceptAllTypes = false
                }
            } },
        Outputs = { {
                ItemType = "Seed",
                ItemData = {
                    ItemName = "Dandelion",
                    Quantity = 1
                }
            } },
        MachineTypes = { "SeedEventWorkbench" },
        Cost = {
            CurrencyType = "Honey",
            Amount = 20
        }
    },
    Lumira = {
        TimeToCraft = 1200,
        PurchaseID = 3306485023,
        RobuxPrice = 529,
        LayoutOrder = 160,
        DisplayInCrafting = false,
        Inputs = { {
                ItemType = "Holdable",
                ItemData = {
                    ItemName = "Pumpkin",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Holdable",
                ItemData = {
                    ItemName = "Pumpkin",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Seed",
                ItemData = {
                    ItemName = "Dandelion",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Seed Pack",
                ItemData = {
                    ItemName = "Flower Seed Pack",
                    AcceptAllTypes = false
                }
            } },
        Outputs = { {
                ItemType = "Seed",
                ItemData = {
                    ItemName = "Lumira",
                    Quantity = 1
                }
            } },
        MachineTypes = { "SeedEventWorkbench" },
        Cost = {
            CurrencyType = "Honey",
            Amount = 40
        }
    },
    Honeysuckle = {
        TimeToCraft = 1440,
        PurchaseID = 3306485032,
        RobuxPrice = 619,
        LayoutOrder = 170,
        DisplayInCrafting = false,
        Inputs = { {
                ItemType = "Seed",
                ItemData = {
                    ItemName = "Pink Lily",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Seed",
                ItemData = {
                    ItemName = "Purple Dahlia",
                    AcceptAllTypes = false
                }
            } },
        Outputs = { {
                ItemType = "Seed",
                ItemData = {
                    ItemName = "Honeysuckle",
                    Quantity = 1
                }
            } },
        MachineTypes = { "SeedEventWorkbench" },
        Cost = {
            CurrencyType = "Honey",
            Amount = 80
        }
    },
    ["Bee Balm"] = {
        TimeToCraft = 900,
        PurchaseID = 3306485036,
        RobuxPrice = 179,
        LayoutOrder = 180,
        DisplayInCrafting = false,
        Inputs = { {
                ItemType = "Holdable",
                ItemData = {
                    ItemName = "Crocus",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Holdable",
                ItemData = {
                    ItemName = "Lavender",
                    AcceptAllTypes = false
                }
            } },
        Outputs = { {
                ItemType = "Seed",
                ItemData = {
                    ItemName = "Bee Balm",
                    Quantity = 1
                }
            } },
        MachineTypes = { "SeedEventWorkbench" },
        Cost = {
            CurrencyType = "Honey",
            Amount = 10
        }
    },
    ["Nectar Thorn"] = {
        TimeToCraft = 1800,
        PurchaseID = 3306485033,
        RobuxPrice = 659,
        LayoutOrder = 190,
        DisplayInCrafting = false,
        Inputs = { {
                ItemType = "Holdable",
                ItemData = {
                    ItemName = "Cactus",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Holdable",
                ItemData = {
                    ItemName = "Cactus",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Seed",
                ItemData = {
                    ItemName = "Cactus",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Seed",
                ItemData = {
                    ItemName = "Nectarshade",
                    AcceptAllTypes = false
                }
            } },
        Outputs = { {
                ItemType = "Seed",
                ItemData = {
                    ItemName = "Nectar Thorn",
                    Quantity = 1
                }
            } },
        MachineTypes = { "SeedEventWorkbench" },
        Cost = {
            CurrencyType = "Honey",
            Amount = 20
        }
    },
    Suncoil = {
        TimeToCraft = 2700,
        PurchaseID = 3306485035,
        RobuxPrice = 749,
        LayoutOrder = 200,
        DisplayInCrafting = false,
        Inputs = { {
                ItemType = "Holdable",
                ItemData = {
                    ItemName = "Crocus",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Holdable",
                ItemData = {
                    ItemName = "Daffodil",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Holdable",
                ItemData = {
                    ItemName = "Dandelion",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Holdable",
                ItemData = {
                    ItemName = "Pink Lily",
                    AcceptAllTypes = false
                }
            } },
        Outputs = { {
                ItemType = "Seed",
                ItemData = {
                    ItemName = "Suncoil",
                    Quantity = 1
                }
            } },
        MachineTypes = { "SeedEventWorkbench" },
        Cost = {
            CurrencyType = "Honey",
            Amount = 40
        }
    },
    ["Egg Melon"] = {
        TimeToCraft = 2700,
        PurchaseID = 3577373554,
        RobuxPrice = 699,
        LayoutOrder = 1,
        DisplayInCrafting = false,
        Inputs = { {
                ItemType = "Seed",
                ItemData = {
                    ItemName = "Easter Egg Melon",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Seed",
                ItemData = {
                    ItemName = "Easter Egg Melon",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Seed",
                ItemData = {
                    ItemName = "Easter Egg Melon",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Seed",
                ItemData = {
                    ItemName = "Easter Egg Melon",
                    AcceptAllTypes = false
                }
            } },
        Outputs = { {
                ItemType = "Seed",
                ItemData = {
                    ItemName = "Egg Melon",
                    Quantity = 1
                }
            } },
        MachineTypes = { "SeedEventWorkbench" },
        Cost = {
            CurrencyType = "Sheckles",
            Amount = 10000000
        }
    },
    Mandrake = {
        TimeToCraft = 300,
        PurchaseID = 3371045808,
        RobuxPrice = 199,
        LayoutOrder = 5,
        Inputs = { {
                ItemType = "Seed",
                ItemData = {
                    ItemName = "Carrot",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Holdable",
                ItemData = {
                    ItemName = "Beanstalk",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "PetEgg",
                ItemData = {
                    ItemName = "Common Egg",
                    AcceptAllTypes = false
                }
            } },
        Outputs = { {
                ItemType = "Seed",
                ItemData = {
                    ItemName = "Mandrake",
                    Quantity = 3
                }
            } },
        MachineTypes = { "SeedEventWorkbench" }
    },
    ["Evo Apple I"] = {
        TimeToCraft = 600,
        PurchaseID = 3420523696,
        RobuxPrice = 195,
        LayoutOrder = 10,
        DisplayInCrafting = true,
        Inputs = { {
                ItemType = "Holdable",
                ItemData = {
                    ItemName = "Evo Beetroot IV",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Holdable",
                ItemData = {
                    ItemName = "Evo Blueberry IV",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Holdable",
                ItemData = {
                    ItemName = "Evo Pumpkin IV",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Holdable",
                ItemData = {
                    ItemName = "Evo Mushroom IV",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Seed",
                ItemData = {
                    ItemName = "Sugar Apple",
                    AcceptAllTypes = false
                }
            } },
        Outputs = { {
                ItemType = "Seed",
                ItemData = {
                    ItemName = "Evo Apple I",
                    Quantity = 1
                }
            } },
        MachineTypes = { "SeedEventWorkbench" }
    },
    ["Evo Apple II"] = {
        TimeToCraft = 1200,
        PurchaseID = 3420524026,
        RobuxPrice = 349,
        LayoutOrder = 15,
        DisplayInCrafting = true,
        Inputs = { {
                ItemType = "Seed",
                ItemData = {
                    ItemName = "Evo Apple I",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Holdable",
                ItemData = {
                    ItemName = "Evo Apple I",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Holdable",
                ItemData = {
                    ItemName = "Evo Apple I",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Seed",
                ItemData = {
                    ItemName = "Burning Bud",
                    AcceptAllTypes = false
                }
            } },
        Outputs = { {
                ItemType = "Seed",
                ItemData = {
                    ItemName = "Evo Apple II",
                    Quantity = 1
                }
            } },
        MachineTypes = { "SeedEventWorkbench" },
        Cost = {
            CurrencyType = "Sheckles",
            Amount = 30000000
        }
    },
    ["Evo Apple III"] = {
        TimeToCraft = 1800,
        PurchaseID = 3420524301,
        RobuxPrice = 679,
        LayoutOrder = 20,
        DisplayInCrafting = true,
        Inputs = { {
                ItemType = "Seed",
                ItemData = {
                    ItemName = "Evo Apple II",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Holdable",
                ItemData = {
                    ItemName = "Evo Apple II",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Holdable",
                ItemData = {
                    ItemName = "Evo Apple II",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Seed",
                ItemData = {
                    ItemName = "Giant Pinecone",
                    AcceptAllTypes = false
                }
            } },
        Outputs = { {
                ItemType = "Seed",
                ItemData = {
                    ItemName = "Evo Apple III",
                    Quantity = 1
                }
            } },
        MachineTypes = { "SeedEventWorkbench" },
        Cost = {
            CurrencyType = "Sheckles",
            Amount = 70000000
        }
    },
    ["Evo Apple IV"] = {
        TimeToCraft = 2400,
        PurchaseID = 3420524565,
        RobuxPrice = 849,
        LayoutOrder = 30,
        DisplayInCrafting = true,
        Inputs = { {
                ItemType = "Seed",
                ItemData = {
                    ItemName = "Evo Apple III",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Holdable",
                ItemData = {
                    ItemName = "Evo Apple III",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Holdable",
                ItemData = {
                    ItemName = "Evo Apple III",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Seed",
                ItemData = {
                    ItemName = "Elder Strawberry",
                    AcceptAllTypes = false
                }
            } },
        Outputs = { {
                ItemType = "Seed",
                ItemData = {
                    ItemName = "Evo Apple IV",
                    Quantity = 1
                }
            } },
        MachineTypes = { "SeedEventWorkbench" },
        Cost = {
            CurrencyType = "Sheckles",
            Amount = 100000000
        }
    },
    ["Olive@SeedEventWorkbench"] = {
        TimeToCraft = 900,
        PurchaseID = 0,
        RobuxPrice = 129,
        LayoutOrder = 40,
        Inputs = { {
                ItemType = "Sprinkler",
                ItemData = {
                    ItemName = "Basic Sprinkler",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Sprinkler",
                ItemData = {
                    ItemName = "Basic Sprinkler",
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
        MachineTypes = { "SeedEventWorkbench" },
        Cost = {
            CurrencyType = "Sheckles",
            Amount = 750000
        }
    },
    ["Hollow Bamboo@SeedEventWorkbench"] = {
        TimeToCraft = 2700,
        PurchaseID = 0,
        RobuxPrice = 507,
        LayoutOrder = 50,
        Inputs = { {
                ItemType = "Sprinkler",
                ItemData = {
                    ItemName = "Advanced Sprinkler",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Sprinkler",
                ItemData = {
                    ItemName = "Godly Sprinkler",
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
        MachineTypes = { "SeedEventWorkbench" },
        Cost = {
            CurrencyType = "Sheckles",
            Amount = 5000000
        }
    },
    ["Yarrow@SeedEventWorkbench"] = {
        TimeToCraft = 3600,
        PurchaseID = 0,
        RobuxPrice = 729,
        LayoutOrder = 60,
        Inputs = { {
                ItemType = "Sprinkler",
                ItemData = {
                    ItemName = "Master Sprinkler",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Sprinkler",
                ItemData = {
                    ItemName = "Master Sprinkler",
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
        MachineTypes = { "SeedEventWorkbench" },
        Cost = {
            CurrencyType = "Sheckles",
            Amount = 18000000
        }
    },
    ["Shadow Spine"] = {
        TimeToCraft = 3600,
        PurchaseID = 3605258615,
        RobuxPrice = 0,
        LayoutOrder = 70,
        DisplayInCrafting = true,
        Inputs = { {
                ItemType = "Seed",
                ItemData = {
                    ItemName = "Beanstalk",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Seed",
                ItemData = {
                    ItemName = "Beanstalk",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Holdable",
                ItemData = {
                    ItemName = "Zebrazinkle",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Sprinkler",
                ItemData = {
                    ItemName = "Master Sprinkler",
                    AcceptAllTypes = false
                }
            } },
        Outputs = { {
                ItemType = "Seed",
                ItemData = {
                    ItemName = "Shadow Spine",
                    Quantity = 1
                }
            } },
        MachineTypes = { "SeedEventWorkbench" },
        Cost = {
            CurrencyType = "Sheckles",
            Amount = 50000000
        }
    },
    ["Twisted Tangle"] = {
        TimeToCraft = 900,
        PurchaseID = 3354091176,
        RobuxPrice = 239,
        LayoutOrder = 10,
        DisplayInCrafting = false,
        Inputs = { {
                ItemType = "Seed",
                ItemData = {
                    ItemName = "Cactus",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Seed",
                ItemData = {
                    ItemName = "Bamboo",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Holdable",
                ItemData = {
                    ItemName = "Cactus",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Holdable",
                ItemData = {
                    ItemName = "Mango",
                    AcceptAllTypes = false
                }
            } },
        Outputs = { {
                ItemType = "Seed",
                ItemData = {
                    ItemName = "Twisted Tangle",
                    Quantity = 1
                }
            } },
        MachineTypes = { "SeedEventWorkbench" },
        Cost = {
            CurrencyType = "Sheckles",
            Amount = 50000
        }
    },
    Veinpetal = {
        TimeToCraft = 1200,
        PurchaseID = 3354091526,
        RobuxPrice = 459,
        LayoutOrder = 15,
        DisplayInCrafting = false,
        Inputs = { {
                ItemType = "Seed",
                ItemData = {
                    ItemName = "Orange Tulip",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Seed",
                ItemData = {
                    ItemName = "Daffodil",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Holdable",
                ItemData = {
                    ItemName = "Beanstalk",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Holdable",
                ItemData = {
                    ItemName = "Burning Bud",
                    AcceptAllTypes = false
                }
            } },
        Outputs = { {
                ItemType = "Seed",
                ItemData = {
                    ItemName = "Veinpetal",
                    Quantity = 1
                }
            } },
        MachineTypes = { "SeedEventWorkbench" },
        Cost = {
            CurrencyType = "Sheckles",
            Amount = 650000
        }
    },
    Horsetail = {
        TimeToCraft = 900,
        PurchaseID = 3329520820,
        RobuxPrice = 199,
        LayoutOrder = 20,
        DisplayInCrafting = false,
        Inputs = { {
                ItemType = "Seed",
                ItemData = {
                    ItemName = "Daffodil",
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
                    ItemName = "Corn",
                    AcceptAllTypes = false
                }
            } },
        Outputs = { {
                ItemType = "Seed",
                ItemData = {
                    ItemName = "Horsetail",
                    Quantity = 1
                }
            } },
        MachineTypes = { "SeedEventWorkbench" },
        Cost = {
            CurrencyType = "Sheckles",
            Amount = 15000
        }
    },
    Lingonberry = {
        TimeToCraft = 900,
        PurchaseID = 3329520955,
        RobuxPrice = 209,
        LayoutOrder = 25,
        DisplayInCrafting = false,
        Inputs = { {
                ItemType = "Seed",
                ItemData = {
                    ItemName = "Blueberry",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Seed",
                ItemData = {
                    ItemName = "Blueberry",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Seed",
                ItemData = {
                    ItemName = "Blueberry",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Holdable",
                ItemData = {
                    ItemName = "Horsetail",
                    AcceptAllTypes = false
                }
            } },
        Outputs = { {
                ItemType = "Seed",
                ItemData = {
                    ItemName = "Lingonberry",
                    Quantity = 1
                }
            } },
        MachineTypes = { "SeedEventWorkbench" },
        Cost = {
            CurrencyType = "Sheckles",
            Amount = 450000
        }
    },
    ["Amber Spine"] = {
        TimeToCraft = 1800,
        PurchaseID = 3329520620,
        RobuxPrice = 625,
        LayoutOrder = 30,
        DisplayInCrafting = false,
        Inputs = { {
                ItemType = "Seed",
                ItemData = {
                    ItemName = "Cactus",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Holdable",
                ItemData = {
                    ItemName = "Pumpkin",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Holdable",
                ItemData = {
                    ItemName = "Horsetail",
                    AcceptAllTypes = false
                }
            } },
        Outputs = { {
                ItemType = "Seed",
                ItemData = {
                    ItemName = "Amber Spine",
                    Quantity = 1
                }
            } },
        MachineTypes = { "SeedEventWorkbench" },
        Cost = {
            CurrencyType = "Sheckles",
            Amount = 650000
        }
    },
    ["Grand Volcania"] = {
        TimeToCraft = 2700,
        PurchaseID = 3329521774,
        RobuxPrice = 819,
        LayoutOrder = 30,
        DisplayInCrafting = false,
        Inputs = { {
                ItemType = "Holdable",
                ItemData = {
                    ItemName = "Ember Lily",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Holdable",
                ItemData = {
                    ItemName = "Ember Lily",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "PetEgg",
                ItemData = {
                    ItemName = "Dinosaur Egg",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Seed Pack",
                ItemData = {
                    ItemName = "Ancient Seed Pack",
                    AcceptAllTypes = false
                }
            } },
        Outputs = { {
                ItemType = "Seed",
                ItemData = {
                    ItemName = "Grand Volcania",
                    Quantity = 1
                }
            } },
        MachineTypes = { "SeedEventWorkbench" },
        Cost = {
            CurrencyType = "Sheckles",
            Amount = 900000
        }
    },
    ["Mutation Spray Amber"] = {
        TimeToCraft = 3600,
        PurchaseID = 3322971805,
        RobuxPrice = 189,
        LayoutOrder = 90,
        Inputs = { {
                ItemType = "SprayBottle",
                ItemData = {
                    ItemName = "Cleaning Spray",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "PetEgg",
                ItemData = {
                    ItemName = "Dinosaur Egg",
                    AcceptAllTypes = false
                }
            } },
        Outputs = { {
                ItemType = "Gear",
                ItemData = {
                    ItemName = "Mutation Spray Amber",
                    Quantity = 1
                }
            } },
        MachineTypes = { "DinoEventWorkbench" },
        Cost = {
            CurrencyType = "Sheckles",
            Amount = 1000000
        }
    },
    ["Ancient Seed Pack"] = {
        TimeToCraft = 3600,
        PurchaseID = 3324600388,
        RobuxPrice = 199,
        LayoutOrder = 100,
        Inputs = { {
                ItemType = "PetEgg",
                ItemData = {
                    ItemName = "Dinosaur Egg",
                    AcceptAllTypes = false
                }
            } },
        Outputs = { {
                ItemType = "Seed Pack",
                ItemData = {
                    ItemName = "Ancient Seed Pack",
                    Quantity = 2
                }
            } },
        MachineTypes = { "DinoEventWorkbench" },
        Cost = {
            CurrencyType = "Sheckles",
            Amount = 5500000
        }
    },
    ["Dino Crate"] = {
        TimeToCraft = 1800,
        PurchaseID = 3324601485,
        RobuxPrice = 179,
        LayoutOrder = 110,
        Inputs = { {
                ItemType = "PetEgg",
                ItemData = {
                    ItemName = "Dinosaur Egg",
                    AcceptAllTypes = false
                }
            } },
        Outputs = { {
                ItemType = "CosmeticCrate",
                ItemData = {
                    ItemName = "Dino Crate",
                    Quantity = 2
                }
            } },
        MachineTypes = { "DinoEventWorkbench" },
        Cost = {
            CurrencyType = "Sheckles",
            Amount = 5500000
        }
    },
    ["Archaeologist Crate"] = {
        TimeToCraft = 1800,
        PurchaseID = 3329654888,
        RobuxPrice = 179,
        LayoutOrder = 115,
        Inputs = { {
                ItemType = "PetEgg",
                ItemData = {
                    ItemName = "Dinosaur Egg",
                    AcceptAllTypes = false
                }
            } },
        Outputs = { {
                ItemType = "CosmeticCrate",
                ItemData = {
                    ItemName = "Archaeologist Crate",
                    Quantity = 2
                }
            } },
        MachineTypes = { "DinoEventWorkbench" },
        Cost = {
            CurrencyType = "Sheckles",
            Amount = 5500000
        }
    },
    ["Dinosaur Egg"] = {
        TimeToCraft = 1800,
        PurchaseID = 3329519291,
        RobuxPrice = 149,
        LayoutOrder = 120,
        IsUnlockable = true,
        Inputs = { {
                ItemType = "PetEgg",
                ItemData = {
                    ItemName = "Common Egg",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Holdable",
                ItemData = {
                    ItemName = "Bone Blossom",
                    AcceptAllTypes = false
                }
            } },
        Outputs = { {
                ItemType = "PetEgg",
                ItemData = {
                    ItemName = "Dinosaur Egg",
                    Quantity = 1
                }
            } },
        MachineTypes = { "DinoEventWorkbench" },
        Cost = {
            CurrencyType = "Sheckles",
            Amount = 5500000
        }
    },
    ["Primal Egg"] = {
        TimeToCraft = 1800,
        PurchaseID = 3329518200,
        RobuxPrice = 149,
        LayoutOrder = 130,
        IsUnlockable = true,
        Inputs = { {
                ItemType = "PetEgg",
                ItemData = {
                    ItemName = "Dinosaur Egg",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Holdable",
                ItemData = {
                    ItemName = "Bone Blossom",
                    AcceptAllTypes = false
                }
            } },
        Outputs = { {
                ItemType = "PetEgg",
                ItemData = {
                    ItemName = "Primal Egg",
                    Quantity = 1
                }
            } },
        MachineTypes = { "DinoEventWorkbench" },
        Cost = {
            CurrencyType = "Sheckles",
            Amount = 5500000
        }
    }
};

for _, v in { require(ReplicatedStorage.Data.Events.BeanstalkEvent.BeanstalkEventCraftingData), require(ReplicatedStorage.Data.Events.SmithingEvent.SmithingEventCraftingData), (require(ReplicatedStorage.Data.Events.FairyEvent.FairyEventCraftingData)) } do
    for i, v2 in v do
        v4[i] = v2;
    end;
end;

for i, v in v4 do
    local v5 = v;
    local v6 = i;

    for _, v2 in v.MachineTypes do
        local v7 = u1[v2];

        if not v7 then
            v7 = {};
            u1[v2] = v7;
        end;

        v7[v6] = v5;
    end;
end;

return {
    ItemRecipes = v4,
    RecipiesSortedByMachineType = u1
};