-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Data.CraftingData.CraftingTypeRegistry);

return {
    ["Beanpod Crate"] = {
        TimeToCraft = 1800,
        PurchaseID = 3710039899,
        RobuxPrice = 179,
        LayoutOrder = 10,
        Inputs = { {
                ItemType = "Holdable",
                ItemData = {
                    ItemName = "Beanstalk",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Holdable",
                ItemData = {
                    ItemName = "Glowpod",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Holdable",
                ItemData = {
                    ItemName = "Twist Berry",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "CosmeticCrate",
                ItemData = {
                    ItemName = "Sprout Crate",
                    AcceptAllTypes = false
                }
            } },
        Outputs = { {
                ItemType = "CosmeticCrate",
                ItemData = {
                    ItemName = "Beanpod Crate",
                    Quantity = 1
                }
            } },
        MachineTypes = { "GiantBeanstalkEventWorkbench" },
        Cost = {
            CurrencyType = "Sheckles",
            Amount = 20000000
        }
    },
    ["Beanpod Egg"] = {
        TimeToCraft = 1800,
        PurchaseID = 3710039865,
        RobuxPrice = 149,
        LayoutOrder = 20,
        Inputs = { {
                ItemType = "Holdable",
                ItemData = {
                    ItemName = "Beanstalk",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Holdable",
                ItemData = {
                    ItemName = "Beanstalk",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Seed Pack",
                ItemData = {
                    ItemName = "Sprout Seed Pack",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "PetEgg",
                ItemData = {
                    ItemName = "Uncommon Egg",
                    AcceptAllTypes = false
                }
            } },
        Outputs = { {
                ItemType = "PetEgg",
                ItemData = {
                    ItemName = "Beanpod Egg",
                    Quantity = 1
                }
            } },
        MachineTypes = { "GiantBeanstalkEventWorkbench" },
        Cost = {
            CurrencyType = "Sheckles",
            Amount = 2500000
        }
    },
    ["Lilypad Cluster"] = {
        TimeToCraft = 1800,
        PurchaseID = 3711186931,
        RobuxPrice = 589,
        LayoutOrder = 30,
        Inputs = { {
                ItemType = "Pet",
                ItemData = {
                    ItemName = "Tree Frog",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Holdable",
                ItemData = {
                    ItemName = "Fableflower",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Holdable",
                ItemData = {
                    ItemName = "Nimbush",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Holdable",
                ItemData = {
                    ItemName = "Flare Daisy",
                    AcceptAllTypes = false
                }
            } },
        Outputs = { {
                ItemType = "Seed",
                ItemData = {
                    ItemName = "Lilypad Cluster",
                    Quantity = 1
                }
            } },
        MachineTypes = { "GiantBeanstalkEventWorkbench" },
        Cost = {
            CurrencyType = "Sheckles",
            Amount = 5500000
        }
    },
    ["Brown Bouncy Mushroom"] = {
        TimeToCraft = 900,
        PurchaseID = 3711186882,
        RobuxPrice = 239,
        LayoutOrder = 40,
        Inputs = { {
                ItemType = "Holdable",
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
                ItemType = "Seed Pack",
                ItemData = {
                    ItemName = "Sprout Seed Pack",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "CosmeticCrate",
                ItemData = {
                    ItemName = "Sprout Crate",
                    AcceptAllTypes = false
                }
            } },
        Outputs = { {
                ItemType = "Cosmetic",
                ItemData = {
                    ItemName = "Brown Bouncy Mushroom",
                    Quantity = 1
                }
            } },
        MachineTypes = { "GiantBeanstalkEventWorkbench" },
        Cost = {
            CurrencyType = "Sheckles",
            Amount = 4500000
        }
    },
    ["Green Bean Memories"] = {
        TimeToCraft = 900,
        PurchaseID = 3379259309,
        RobuxPrice = 239,
        LayoutOrder = 50,
        Inputs = { {
                ItemType = "Holdable",
                ItemData = {
                    ItemName = "Beanstalk",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Holdable",
                ItemData = {
                    ItemName = "Beanstalk",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "Seed Pack",
                ItemData = {
                    ItemName = "Sprout Seed Pack",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "CosmeticCrate",
                ItemData = {
                    ItemName = "Sprout Crate",
                    AcceptAllTypes = false
                }
            } },
        Outputs = { {
                ItemType = "Cosmetic",
                ItemData = {
                    ItemName = "Green Bean Memories",
                    Quantity = 1
                }
            } },
        MachineTypes = { "GiantBeanstalkEventWorkbench" },
        Cost = {
            CurrencyType = "Sheckles",
            Amount = 4500000
        }
    },
    ["Bean Pool Table"] = {
        TimeToCraft = 900,
        PurchaseID = 3379259523,
        RobuxPrice = 209,
        LayoutOrder = 60,
        Inputs = { {
                ItemType = "Holdable",
                ItemData = {
                    ItemName = "Beanstalk",
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
                    ItemName = "Coconut",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "CosmeticCrate",
                ItemData = {
                    ItemName = "Sprout Crate",
                    AcceptAllTypes = false
                }
            } },
        Outputs = { {
                ItemType = "Cosmetic",
                ItemData = {
                    ItemName = "Bean Pool Table",
                    Quantity = 1
                }
            } },
        MachineTypes = { "GiantBeanstalkEventWorkbench" },
        Cost = {
            CurrencyType = "Sheckles",
            Amount = 4500000
        }
    },
    ["Bean Sprout Float Light"] = {
        TimeToCraft = 900,
        PurchaseID = 3379259737,
        RobuxPrice = 149,
        LayoutOrder = 70,
        Inputs = { {
                ItemType = "Holdable",
                ItemData = {
                    ItemName = "Beanstalk",
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
                    ItemName = "Flare Melon",
                    AcceptAllTypes = false
                }
            }, {
                ItemType = "CosmeticCrate",
                ItemData = {
                    ItemName = "Sprout Crate",
                    AcceptAllTypes = false
                }
            } },
        Outputs = { {
                ItemType = "Cosmetic",
                ItemData = {
                    ItemName = "Bean Sprout Float Light",
                    Quantity = 1
                }
            } },
        MachineTypes = { "GiantBeanstalkEventWorkbench" },
        Cost = {
            CurrencyType = "Sheckles",
            Amount = 4500000
        }
    },
    ["Pet Shard GiantBean"] = {
        TimeToCraft = 3600,
        PurchaseID = 3379333073,
        RobuxPrice = 279,
        LayoutOrder = 80,
        Inputs = { {
                ItemType = "Holdable",
                ItemData = {
                    ItemName = "Beanstalk",
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
                    ItemName = "Beanstalk",
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
                ItemType = "PetShard",
                ItemData = {
                    ItemName = "Pet Shard GiantBean",
                    Quantity = 1
                }
            } },
        MachineTypes = { "GiantBeanstalkEventWorkbench" },
        Cost = {
            CurrencyType = "Sheckles",
            Amount = 15000000
        }
    }
};