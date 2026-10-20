-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local GiveServiceCommon = require(ReplicatedStorage.Modules.GiveServiceCommon);
local PickRandom = require(ReplicatedStorage.Modules.PickRandom);
require(ReplicatedStorage.Modules.UpdateService);
local Types = GiveServiceCommon.Types;
local u1 = {
    {
        {
            Type = "GiveItem",
            RewardType = "Gear",
            Name = "Harvest Tool",
            Quantity = 50,
            Chance = 9,
            Reward = Types.Gear:Use("Harvest Tool", 50)
        },
        {
            Type = "GiveItem",
            RewardType = "Gear",
            Name = "Reclaimer",
            Quantity = 8,
            Chance = 8,
            Reward = Types.Gear:Use("Reclaimer", 8)
        },
        {
            Type = "GiveItem",
            RewardType = "Gear",
            Name = "Medium Toy",
            Quantity = 3,
            Chance = 6,
            Reward = Types.Gear:Use("Medium Toy", 3)
        },
        {
            Type = "GiveItem",
            RewardType = "Gear",
            Name = "Medium Treat",
            Quantity = 3,
            Chance = 6,
            Reward = Types.Gear:Use("Medium Treat", 3)
        },
        {
            Type = "GiveItem",
            RewardType = "Seed",
            Name = "Pomegranate",
            Quantity = 1,
            Chance = 6.5,
            Reward = Types.Seed:Use("Pomegranate", 1)
        },
        {
            Type = "GiveItem",
            RewardType = "Gear",
            Name = "Large Toy",
            Quantity = 1,
            Chance = 5.5,
            Reward = Types.Gear:Use("Large Toy", 1)
        },
        {
            Type = "GiveItem",
            RewardType = "Crate",
            Name = "Outdoors Crate",
            Quantity = 1,
            Chance = 5,
            Reward = Types.Crate:Use("Outdoors Crate", 1)
        },
        {
            Type = "GiveItem",
            RewardType = "Pet",
            Name = "Geode Turtle",
            Quantity = 1,
            Chance = 4.5,
            Reward = Types.Pet:Use("Geode Turtle")
        }
    },
    {
        {
            Type = "GiveItem",
            RewardType = "Gear",
            Name = "Reclaimer",
            Quantity = 8,
            Chance = 8,
            Reward = Types.Gear:Use("Reclaimer", 8)
        },
        {
            Type = "GiveItem",
            RewardType = "Gear",
            Name = "Medium Toy",
            Quantity = 3,
            Chance = 6,
            Reward = Types.Gear:Use("Medium Toy", 3)
        },
        {
            Type = "GiveItem",
            RewardType = "Gear",
            Name = "Medium Treat",
            Quantity = 3,
            Chance = 6,
            Reward = Types.Gear:Use("Medium Treat", 3)
        },
        {
            Type = "GiveItem",
            RewardType = "Seed",
            Name = "Pomegranate",
            Quantity = 1,
            Chance = 6.5,
            Reward = Types.Seed:Use("Pomegranate", 1)
        },
        {
            Type = "GiveItem",
            RewardType = "Gear",
            Name = "Large Toy",
            Quantity = 1,
            Chance = 5.5,
            Reward = Types.Gear:Use("Large Toy", 1)
        },
        {
            Type = "GiveItem",
            RewardType = "Crate",
            Name = "Outdoors Crate",
            Quantity = 1,
            Chance = 5,
            Reward = Types.Crate:Use("Outdoors Crate", 1)
        },
        {
            Type = "GiveItem",
            RewardType = "Pet",
            Name = "Geode Turtle",
            Quantity = 1,
            Chance = 4.5,
            Reward = Types.Pet:Use("Geode Turtle")
        },
        {
            Type = "GiveItem",
            RewardType = "Egg",
            Name = "Jungle Egg",
            Quantity = 1,
            Chance = 4,
            Reward = Types.Egg:Use("Jungle Egg", 1)
        }
    },
    {
        {
            Type = "GiveItem",
            RewardType = "Gear",
            Name = "Medium Toy",
            Quantity = 3,
            Chance = 6,
            Reward = Types.Gear:Use("Medium Toy", 3)
        },
        {
            Type = "GiveItem",
            RewardType = "Gear",
            Name = "Medium Treat",
            Quantity = 3,
            Chance = 6,
            Reward = Types.Gear:Use("Medium Treat", 3)
        },
        {
            Type = "GiveItem",
            RewardType = "Seed",
            Name = "Pomegranate",
            Quantity = 1,
            Chance = 6.5,
            Reward = Types.Seed:Use("Pomegranate", 1)
        },
        {
            Type = "GiveItem",
            RewardType = "Gear",
            Name = "Large Toy",
            Quantity = 1,
            Chance = 5.5,
            Reward = Types.Gear:Use("Large Toy", 1)
        },
        {
            Type = "GiveItem",
            RewardType = "Crate",
            Name = "Outdoors Crate",
            Quantity = 1,
            Chance = 5,
            Reward = Types.Crate:Use("Outdoors Crate", 1)
        },
        {
            Type = "GiveItem",
            RewardType = "Pet",
            Name = "Geode Turtle",
            Quantity = 1,
            Chance = 4.5,
            Reward = Types.Pet:Use("Geode Turtle")
        },
        {
            Type = "GiveItem",
            RewardType = "Egg",
            Name = "Jungle Egg",
            Quantity = 1,
            Chance = 4,
            Reward = Types.Egg:Use("Jungle Egg", 1)
        },
        {
            Type = "GiveItem",
            RewardType = "Egg",
            Name = "Gem Egg",
            Quantity = 1,
            Chance = 3,
            Reward = Types.Egg:Use("Gem Egg", 1)
        }
    },
    {
        {
            Type = "GiveItem",
            RewardType = "Seed",
            Name = "Pomegranate",
            Quantity = 1,
            Chance = 6.5,
            Reward = Types.Seed:Use("Pomegranate", 1)
        },
        {
            Type = "GiveItem",
            RewardType = "Gear",
            Name = "Large Toy",
            Quantity = 1,
            Chance = 5.5,
            Reward = Types.Gear:Use("Large Toy", 1)
        },
        {
            Type = "GiveItem",
            RewardType = "Crate",
            Name = "Outdoors Crate",
            Quantity = 1,
            Chance = 5,
            Reward = Types.Crate:Use("Outdoors Crate", 1)
        },
        {
            Type = "GiveItem",
            RewardType = "Pet",
            Name = "Geode Turtle",
            Quantity = 1,
            Chance = 4.5,
            Reward = Types.Pet:Use("Geode Turtle")
        },
        {
            Type = "GiveItem",
            RewardType = "Egg",
            Name = "Jungle Egg",
            Quantity = 1,
            Chance = 4,
            Reward = Types.Egg:Use("Jungle Egg", 1)
        },
        {
            Type = "GiveItem",
            RewardType = "Egg",
            Name = "Gem Egg",
            Quantity = 1,
            Chance = 3,
            Reward = Types.Egg:Use("Gem Egg", 1)
        },
        {
            Type = "GiveItem",
            RewardType = "Gear",
            Name = "Levelup Lollipop",
            Quantity = 1,
            Chance = 3,
            Reward = Types.Gear:Use("Levelup Lollipop", 1)
        },
        {
            Type = "GiveItem",
            RewardType = "Seed Pack",
            Name = "Gem Chest",
            Quantity = 1,
            Chance = 2,
            Reward = Types.SeedPack:Use("Gem Chest", 1)
        }
    },
    {
        {
            Type = "GiveItem",
            RewardType = "Gear",
            Name = "Large Toy",
            Quantity = 1,
            Chance = 5.5,
            Reward = Types.Gear:Use("Large Toy", 1)
        },
        {
            Type = "GiveItem",
            RewardType = "Crate",
            Name = "Outdoors Crate",
            Quantity = 1,
            Chance = 5,
            Reward = Types.Crate:Use("Outdoors Crate", 1)
        },
        {
            Type = "GiveItem",
            RewardType = "Pet",
            Name = "Geode Turtle",
            Quantity = 1,
            Chance = 4.5,
            Reward = Types.Pet:Use("Geode Turtle")
        },
        {
            Type = "GiveItem",
            RewardType = "Egg",
            Name = "Jungle Egg",
            Quantity = 1,
            Chance = 4,
            Reward = Types.Egg:Use("Jungle Egg", 1)
        },
        {
            Type = "GiveItem",
            RewardType = "Egg",
            Name = "Gem Egg",
            Quantity = 1,
            Chance = 3,
            Reward = Types.Egg:Use("Gem Egg", 1)
        },
        {
            Type = "GiveItem",
            RewardType = "Gear",
            Name = "Levelup Lollipop",
            Quantity = 1,
            Chance = 3,
            Reward = Types.Gear:Use("Levelup Lollipop", 1)
        },
        {
            Type = "GiveItem",
            RewardType = "Seed Pack",
            Name = "Gem Chest",
            Quantity = 1,
            Chance = 2,
            Reward = Types.SeedPack:Use("Gem Chest", 1)
        },
        {
            Type = "GiveItem",
            RewardType = "Gear",
            Name = "Grandmaster Sprinkler",
            Quantity = 1,
            Chance = 1.5,
            Reward = Types.Gear:Use("Grandmaster Sprinkler", 1)
        }
    },
    {
        {
            Type = "GiveItem",
            RewardType = "Crate",
            Name = "Outdoors Crate",
            Quantity = 1,
            Chance = 5,
            Reward = Types.Crate:Use("Outdoors Crate", 1)
        },
        {
            Type = "GiveItem",
            RewardType = "Pet",
            Name = "Geode Turtle",
            Quantity = 1,
            Chance = 4.5,
            Reward = Types.Pet:Use("Geode Turtle")
        },
        {
            Type = "GiveItem",
            RewardType = "Egg",
            Name = "Jungle Egg",
            Quantity = 1,
            Chance = 4,
            Reward = Types.Egg:Use("Jungle Egg", 1)
        },
        {
            Type = "GiveItem",
            RewardType = "Egg",
            Name = "Gem Egg",
            Quantity = 1,
            Chance = 3,
            Reward = Types.Egg:Use("Gem Egg", 1)
        },
        {
            Type = "GiveItem",
            RewardType = "Gear",
            Name = "Levelup Lollipop",
            Quantity = 1,
            Chance = 3,
            Reward = Types.Gear:Use("Levelup Lollipop", 1)
        },
        {
            Type = "GiveItem",
            RewardType = "Seed Pack",
            Name = "Gem Chest",
            Quantity = 1,
            Chance = 2,
            Reward = Types.SeedPack:Use("Gem Chest", 1)
        },
        {
            Type = "GiveItem",
            RewardType = "Gear",
            Name = "Grandmaster Sprinkler",
            Quantity = 1,
            Chance = 1.5,
            Reward = Types.Gear:Use("Grandmaster Sprinkler", 1)
        },
        {
            Type = "GiveItem",
            RewardType = "Seed",
            Name = "Wild Pineapple",
            Quantity = 1,
            Chance = 1,
            Reward = Types.Seed:Use("Wild Pineapple", 1)
        }
    },
    {
        {
            Type = "GiveItem",
            RewardType = "Pet",
            Name = "Geode Turtle",
            Quantity = 1,
            Chance = 4.5,
            Reward = Types.Pet:Use("Geode Turtle")
        },
        {
            Type = "GiveItem",
            RewardType = "Egg",
            Name = "Jungle Egg",
            Quantity = 1,
            Chance = 4,
            Reward = Types.Egg:Use("Jungle Egg", 1)
        },
        {
            Type = "GiveItem",
            RewardType = "Egg",
            Name = "Gem Egg",
            Quantity = 1,
            Chance = 3,
            Reward = Types.Egg:Use("Gem Egg", 1)
        },
        {
            Type = "GiveItem",
            RewardType = "Gear",
            Name = "Levelup Lollipop",
            Quantity = 1,
            Chance = 3,
            Reward = Types.Gear:Use("Levelup Lollipop", 1)
        },
        {
            Type = "GiveItem",
            RewardType = "Seed Pack",
            Name = "Gem Chest",
            Quantity = 1,
            Chance = 2,
            Reward = Types.SeedPack:Use("Gem Chest", 1)
        },
        {
            Type = "GiveItem",
            RewardType = "Gear",
            Name = "Grandmaster Sprinkler",
            Quantity = 1,
            Chance = 1.5,
            Reward = Types.Gear:Use("Grandmaster Sprinkler", 1)
        },
        {
            Type = "GiveItem",
            RewardType = "Seed",
            Name = "Wild Pineapple",
            Quantity = 1,
            Chance = 1,
            Reward = Types.Seed:Use("Wild Pineapple", 1)
        },
        {
            Type = "GiveItem",
            RewardType = "Gear",
            Name = "Silver Lollipop",
            Quantity = 1,
            Chance = 0.25,
            Reward = Types.Gear:Use("Silver Lollipop", 1)
        }
    },
    {
        {
            Type = "GiveItem",
            RewardType = "Egg",
            Name = "Jungle Egg",
            Quantity = 1,
            Chance = 4,
            Reward = Types.Egg:Use("Jungle Egg", 1)
        },
        {
            Type = "GiveItem",
            RewardType = "Egg",
            Name = "Gem Egg",
            Quantity = 1,
            Chance = 3,
            Reward = Types.Egg:Use("Gem Egg", 1)
        },
        {
            Type = "GiveItem",
            RewardType = "Gear",
            Name = "Levelup Lollipop",
            Quantity = 1,
            Chance = 3,
            Reward = Types.Gear:Use("Levelup Lollipop", 1)
        },
        {
            Type = "GiveItem",
            RewardType = "Seed Pack",
            Name = "Gem Chest",
            Quantity = 1,
            Chance = 2,
            Reward = Types.SeedPack:Use("Gem Chest", 1)
        },
        {
            Type = "GiveItem",
            RewardType = "Gear",
            Name = "Grandmaster Sprinkler",
            Quantity = 1,
            Chance = 1.5,
            Reward = Types.Gear:Use("Grandmaster Sprinkler", 1)
        },
        {
            Type = "GiveItem",
            RewardType = "Seed",
            Name = "Wild Pineapple",
            Quantity = 1,
            Chance = 1,
            Reward = Types.Seed:Use("Wild Pineapple", 1)
        },
        {
            Type = "GiveItem",
            RewardType = "Gear",
            Name = "Silver Lollipop",
            Quantity = 1,
            Chance = 0.25,
            Reward = Types.Gear:Use("Silver Lollipop", 1)
        },
        {
            Type = "GiveItem",
            RewardType = "Pet",
            Name = "Pack Mule",
            Quantity = 1,
            Chance = 0.25,
            Reward = Types.Pet:Use("Pack Mule")
        }
    },
    {
        {
            Type = "GiveItem",
            RewardType = "Egg",
            Name = "Gem Egg",
            Quantity = 1,
            Chance = 3.5,
            Reward = Types.Egg:Use("Gem Egg", 1)
        },
        {
            Type = "GiveItem",
            RewardType = "Gear",
            Name = "Levelup Lollipop",
            Quantity = 1,
            Chance = 3,
            Reward = Types.Gear:Use("Levelup Lollipop", 1)
        },
        {
            Type = "GiveItem",
            RewardType = "Seed Pack",
            Name = "Gem Chest",
            Quantity = 1,
            Chance = 3,
            Reward = Types.SeedPack:Use("Gem Chest", 1)
        },
        {
            Type = "GiveItem",
            RewardType = "Gear",
            Name = "Grandmaster Sprinkler",
            Quantity = 1,
            Chance = 2,
            Reward = Types.Gear:Use("Grandmaster Sprinkler", 1)
        },
        {
            Type = "GiveItem",
            RewardType = "Seed",
            Name = "Wild Pineapple",
            Quantity = 1,
            Chance = 1.5,
            Reward = Types.Seed:Use("Wild Pineapple", 1)
        },
        {
            Type = "GiveItem",
            RewardType = "Gear",
            Name = "Silver Lollipop",
            Quantity = 1,
            Chance = 1,
            Reward = Types.Gear:Use("Silver Lollipop", 1)
        },
        {
            Type = "GiveItem",
            RewardType = "Pet",
            Name = "Pack Mule",
            Quantity = 1,
            Chance = 0.25,
            Reward = Types.Pet:Use("Pack Mule")
        },
        {
            Type = "GiveItem",
            RewardType = "Gear",
            Name = "Large Toy",
            Quantity = 3,
            Chance = 0.25,
            Reward = Types.Gear:Use("Large Toy", 3)
        }
    },
    {
        {
            Type = "GiveItem",
            RewardType = "Gear",
            Name = "Levelup Lollipop",
            Quantity = 1,
            Chance = 3.5,
            Reward = Types.Gear:Use("Levelup Lollipop", 1)
        },
        {
            Type = "GiveItem",
            RewardType = "Seed Pack",
            Name = "Gem Chest",
            Quantity = 1,
            Chance = 3,
            Reward = Types.SeedPack:Use("Gem Chest", 1)
        },
        {
            Type = "GiveItem",
            RewardType = "Gear",
            Name = "Grandmaster Sprinkler",
            Quantity = 1,
            Chance = 3,
            Reward = Types.Gear:Use("Grandmaster Sprinkler", 1)
        },
        {
            Type = "GiveItem",
            RewardType = "Seed",
            Name = "Wild Pineapple",
            Quantity = 1,
            Chance = 2,
            Reward = Types.Seed:Use("Wild Pineapple", 1)
        },
        {
            Type = "GiveItem",
            RewardType = "Gear",
            Name = "Silver Lollipop",
            Quantity = 1,
            Chance = 1.5,
            Reward = Types.Gear:Use("Silver Lollipop", 1)
        },
        {
            Type = "GiveItem",
            RewardType = "Pet",
            Name = "Pack Mule",
            Quantity = 1,
            Chance = 1,
            Reward = Types.Pet:Use("Pack Mule")
        },
        {
            Type = "GiveItem",
            RewardType = "Gear",
            Name = "Large Toy",
            Quantity = 3,
            Chance = 0.25,
            Reward = Types.Gear:Use("Large Toy", 3)
        },
        {
            Type = "GiveItem",
            RewardType = "Crate",
            Name = "Outdoors Crate",
            Quantity = 3,
            Chance = 0.25,
            Reward = Types.Crate:Use("Outdoors Crate", 3)
        }
    },
    {
        {
            Type = "GiveItem",
            RewardType = "Seed Pack",
            Name = "Gem Chest",
            Quantity = 1,
            Chance = 3.5,
            Reward = Types.SeedPack:Use("Gem Chest", 1)
        },
        {
            Type = "GiveItem",
            RewardType = "Gear",
            Name = "Grandmaster Sprinkler",
            Quantity = 1,
            Chance = 3,
            Reward = Types.Gear:Use("Grandmaster Sprinkler", 1)
        },
        {
            Type = "GiveItem",
            RewardType = "Seed",
            Name = "Wild Pineapple",
            Quantity = 1,
            Chance = 3,
            Reward = Types.Seed:Use("Wild Pineapple", 1)
        },
        {
            Type = "GiveItem",
            RewardType = "Gear",
            Name = "Silver Lollipop",
            Quantity = 1,
            Chance = 2,
            Reward = Types.Gear:Use("Silver Lollipop", 1)
        },
        {
            Type = "GiveItem",
            RewardType = "Pet",
            Name = "Pack Mule",
            Quantity = 1,
            Chance = 1.5,
            Reward = Types.Pet:Use("Pack Mule")
        },
        {
            Type = "GiveItem",
            RewardType = "Gear",
            Name = "Large Toy",
            Quantity = 3,
            Chance = 1,
            Reward = Types.Gear:Use("Large Toy", 3)
        },
        {
            Type = "GiveItem",
            RewardType = "Crate",
            Name = "Outdoors Crate",
            Quantity = 3,
            Chance = 1,
            Reward = Types.Crate:Use("Outdoors Crate", 3)
        },
        {
            Type = "GiveItem",
            RewardType = "Egg",
            Name = "Gem Egg",
            Quantity = 3,
            Chance = 0.5,
            Reward = Types.Egg:Use("Gem Egg", 3)
        }
    },
    {
        {
            Type = "GiveItem",
            RewardType = "Seed Pack",
            Name = "Gem Chest",
            Quantity = 1,
            Chance = 3.5,
            Reward = Types.SeedPack:Use("Gem Chest", 1)
        },
        {
            Type = "GiveItem",
            RewardType = "Seed",
            Name = "Wild Pineapple",
            Quantity = 1,
            Chance = 3,
            Reward = Types.Seed:Use("Wild Pineapple", 1)
        },
        {
            Type = "GiveItem",
            RewardType = "Gear",
            Name = "Silver Lollipop",
            Quantity = 1,
            Chance = 3,
            Reward = Types.Gear:Use("Silver Lollipop", 1)
        },
        {
            Type = "GiveItem",
            RewardType = "Pet",
            Name = "Pack Mule",
            Quantity = 1,
            Chance = 2,
            Reward = Types.Pet:Use("Pack Mule")
        },
        {
            Type = "GiveItem",
            RewardType = "Gear",
            Name = "Large Toy",
            Quantity = 3,
            Chance = 1.5,
            Reward = Types.Gear:Use("Large Toy", 3)
        },
        {
            Type = "GiveItem",
            RewardType = "Crate",
            Name = "Outdoors Crate",
            Quantity = 3,
            Chance = 1,
            Reward = Types.Crate:Use("Outdoors Crate", 3)
        },
        {
            Type = "GiveItem",
            RewardType = "Egg",
            Name = "Gem Egg",
            Quantity = 3,
            Chance = 0.5,
            Reward = Types.Egg:Use("Gem Egg", 3)
        },
        {
            Type = "GiveItem",
            RewardType = "Seed Pack",
            Name = "Gem Chest",
            Quantity = 3,
            Chance = 0.5,
            Reward = Types.SeedPack:Use("Gem Chest", 3)
        }
    }
};
local u2 = {
    [17] = {
        {
            Type = "GiveItem",
            RewardType = "Seed Pack",
            Name = "Gem Chest",
            Quantity = 1,
            Chance = 3,
            Reward = Types.SeedPack:Use("Gem Chest", 1)
        },
        {
            Type = "GiveItem",
            RewardType = "Egg",
            Name = "Gem Egg",
            Quantity = 1,
            Chance = 3,
            Reward = Types.Egg:Use("Gem Egg", 1)
        },
        {
            Type = "GiveItem",
            RewardType = "Gear",
            Name = "Silver Lollipop",
            Quantity = 1,
            Chance = 2.9,
            Reward = Types.Gear:Use("Silver Lollipop", 1)
        },
        {
            Type = "GiveItem",
            RewardType = "Seed",
            Name = "Wild Pineapple",
            Quantity = 1,
            Chance = 2.9,
            Reward = Types.Seed:Use("Wild Pineapple", 1)
        },
        {
            Type = "GiveItem",
            RewardType = "Pet",
            Name = "Pack Mule",
            Quantity = 1,
            Chance = 2,
            Reward = Types.Pet:Use("Pack Mule")
        },
        {
            Type = "GiveItem",
            RewardType = "Egg",
            Name = "Gem Egg",
            Quantity = 3,
            Chance = 1,
            Reward = Types.Egg:Use("Gem Egg", 3)
        },
        {
            Type = "GiveItem",
            RewardType = "Seed Pack",
            Name = "Gem Chest",
            Quantity = 3,
            Chance = 1,
            Reward = Types.SeedPack:Use("Gem Chest", 3)
        },
        {
            Type = "GiveItem",
            RewardType = "Seed",
            Name = "Coinfruit",
            Quantity = 1,
            Chance = 0.5,
            Reward = Types.Seed:Use("Coinfruit", 1)
        },
        {
            Type = "GiveItem",
            RewardType = "Pet",
            Name = "Sheckling",
            Quantity = 1,
            Chance = 0.5,
            Reward = Types.Pet:Use("Sheckling")
        }
    },
    [25] = {
        {
            Type = "GiveItem",
            RewardType = "Seed Pack",
            Name = "Gem Chest",
            Quantity = 2,
            Chance = 3,
            Reward = Types.SeedPack:Use("Gem Chest", 2)
        },
        {
            Type = "GiveItem",
            RewardType = "Egg",
            Name = "Gem Egg",
            Quantity = 2,
            Chance = 3,
            Reward = Types.Egg:Use("Gem Egg", 2)
        },
        {
            Type = "GiveItem",
            RewardType = "Gear",
            Name = "Silver Lollipop",
            Quantity = 1,
            Chance = 2.9,
            Reward = Types.Gear:Use("Silver Lollipop", 1)
        },
        {
            Type = "GiveItem",
            RewardType = "Egg",
            Name = "Gem Egg",
            Quantity = 3,
            Chance = 1.5,
            Reward = Types.Egg:Use("Gem Egg", 3)
        },
        {
            Type = "GiveItem",
            RewardType = "Seed Pack",
            Name = "Gem Chest",
            Quantity = 3,
            Chance = 1.5,
            Reward = Types.SeedPack:Use("Gem Chest", 3)
        },
        {
            Type = "GiveItem",
            RewardType = "Pet",
            Name = "Sheckling",
            Quantity = 1,
            Chance = 1,
            Reward = Types.Pet:Use("Sheckling")
        },
        {
            Type = "GiveItem",
            RewardType = "Seed",
            Name = "Coinfruit",
            Quantity = 1,
            Chance = 1,
            Reward = Types.Seed:Use("Coinfruit", 1)
        },
        {
            Type = "GiveItem",
            RewardType = "Pet",
            Name = "Messenger Pigeon",
            Quantity = 1,
            Chance = 0.5,
            Reward = Types.Pet:Use("Messenger Pigeon")
        },
        {
            Type = "GiveItem",
            RewardType = "Seed",
            Name = "Sherrybloom",
            Quantity = 1,
            Chance = 0.5,
            Reward = Types.Seed:Use("Sherrybloom", 1)
        }
    },
    [35] = {
        {
            Type = "GiveItem",
            RewardType = "Egg",
            Name = "Gem Egg",
            Quantity = 3,
            Chance = 3,
            Reward = Types.Egg:Use("Gem Egg", 3)
        },
        {
            Type = "GiveItem",
            RewardType = "Seed Pack",
            Name = "Gem Chest",
            Quantity = 3,
            Chance = 3,
            Reward = Types.SeedPack:Use("Gem Chest", 3)
        },
        {
            Type = "GiveItem",
            RewardType = "Gear",
            Name = "Silver Lollipop",
            Quantity = 1,
            Chance = 2.9,
            Reward = Types.Gear:Use("Silver Lollipop", 1)
        },
        {
            Type = "GiveItem",
            RewardType = "Pet",
            Name = "Sheckling",
            Quantity = 1,
            Chance = 2,
            Reward = Types.Pet:Use("Sheckling")
        },
        {
            Type = "GiveItem",
            RewardType = "Seed",
            Name = "Coinfruit",
            Quantity = 1,
            Chance = 2,
            Reward = Types.Seed:Use("Coinfruit", 1)
        },
        {
            Type = "GiveItem",
            RewardType = "Pet",
            Name = "Messenger Pigeon",
            Quantity = 1,
            Chance = 1,
            Reward = Types.Pet:Use("Messenger Pigeon")
        },
        {
            Type = "GiveItem",
            RewardType = "Seed",
            Name = "Sherrybloom",
            Quantity = 1,
            Chance = 1,
            Reward = Types.Seed:Use("Sherrybloom", 1)
        },
        {
            Type = "GiveItem",
            RewardType = "Pet",
            Name = "Camel",
            Quantity = 1,
            Chance = 0.5,
            Reward = Types.Pet:Use("Camel")
        },
        {
            Type = "GiveItem",
            RewardType = "Seed",
            Name = "Pinkside Dandelion",
            Quantity = 1,
            Chance = 0.5,
            Reward = Types.Seed:Use("Pinkside Dandelion", 1)
        }
    },
    [50] = {
        {
            Type = "GiveItem",
            RewardType = "Egg",
            Name = "Gem Egg",
            Quantity = 3,
            Chance = 4,
            Reward = Types.Egg:Use("Gem Egg", 3)
        },
        {
            Type = "GiveItem",
            RewardType = "Seed Pack",
            Name = "Gem Chest",
            Quantity = 3,
            Chance = 4,
            Reward = Types.SeedPack:Use("Gem Chest", 3)
        },
        {
            Type = "GiveItem",
            RewardType = "Gear",
            Name = "Silver Lollipop",
            Quantity = 1,
            Chance = 2.5,
            Reward = Types.Gear:Use("Silver Lollipop", 1)
        },
        {
            Type = "GiveItem",
            RewardType = "Pet",
            Name = "Messenger Pigeon",
            Quantity = 1,
            Chance = 2,
            Reward = Types.Pet:Use("Messenger Pigeon")
        },
        {
            Type = "GiveItem",
            RewardType = "Seed",
            Name = "Sherrybloom",
            Quantity = 1,
            Chance = 2,
            Reward = Types.Seed:Use("Sherrybloom", 1)
        },
        {
            Type = "GiveItem",
            RewardType = "Pet",
            Name = "Camel",
            Quantity = 1,
            Chance = 1,
            Reward = Types.Pet:Use("Camel")
        },
        {
            Type = "GiveItem",
            RewardType = "Seed",
            Name = "Pinkside Dandelion",
            Quantity = 1,
            Chance = 1,
            Reward = Types.Seed:Use("Pinkside Dandelion", 1)
        },
        {
            Type = "GiveItem",
            RewardType = "Gear",
            Name = "Booth Sign",
            Quantity = 1,
            Chance = 1,
            Reward = Types.Gear:Use("Booth Sign", 1)
        },
        {
            Type = "GiveItem",
            RewardType = "Gear",
            Name = "Gold Lollipop",
            Quantity = 1,
            Chance = 0.25,
            Reward = Types.Gear:Use("Gold Lollipop", 1)
        }
    }
};
local u3 = {
    [1] = {
        {
            Type = "GiveItem",
            RewardType = "Seed",
            Name = "Coinfruit",
            Quantity = 1,
            Chance = 8,
            Reward = Types.Seed:Use("Coinfruit", 1)
        },
        {
            Type = "GiveItem",
            RewardType = "Pet",
            Name = "Sheckling",
            Quantity = 1,
            Chance = 8,
            Reward = Types.Pet:Use("Sheckling")
        }
    },
    [3] = {
        {
            Type = "GiveItem",
            RewardType = "Seed",
            Name = "Coinfruit",
            Quantity = 1,
            Chance = 8,
            Reward = Types.Seed:Use("Coinfruit", 1)
        },
        {
            Type = "GiveItem",
            RewardType = "Pet",
            Name = "Sheckling",
            Quantity = 1,
            Chance = 8,
            Reward = Types.Pet:Use("Sheckling")
        },
        {
            Type = "GiveItem",
            RewardType = "Seed Pack",
            Name = "Gem Chest",
            Quantity = 1,
            Chance = 1,
            Reward = Types.SeedPack:Use("Gem Chest", 1)
        },
        {
            Type = "GiveItem",
            RewardType = "Egg",
            Name = "Gem Egg",
            Quantity = 1,
            Chance = 1,
            Reward = Types.Egg:Use("Gem Egg", 1)
        }
    },
    [5] = {
        {
            Type = "GiveItem",
            RewardType = "Seed",
            Name = "Coinfruit",
            Quantity = 1,
            Chance = 8,
            Reward = Types.Seed:Use("Coinfruit", 1)
        },
        {
            Type = "GiveItem",
            RewardType = "Pet",
            Name = "Sheckling",
            Quantity = 1,
            Chance = 8,
            Reward = Types.Pet:Use("Sheckling")
        },
        {
            Type = "GiveItem",
            RewardType = "Seed Pack",
            Name = "Gem Chest",
            Quantity = 1,
            Chance = 2,
            Reward = Types.SeedPack:Use("Gem Chest", 1)
        },
        {
            Type = "GiveItem",
            RewardType = "Egg",
            Name = "Gem Egg",
            Quantity = 1,
            Chance = 2,
            Reward = Types.Egg:Use("Gem Egg", 1)
        },
        {
            Type = "GiveItem",
            RewardType = "Pet",
            Name = "Messenger Pigeon",
            Quantity = 1,
            Chance = 1,
            Reward = Types.Pet:Use("Messenger Pigeon")
        }
    },
    [7] = {
        {
            Type = "GiveItem",
            RewardType = "Seed",
            Name = "Coinfruit",
            Quantity = 2,
            Chance = 8,
            Reward = Types.Seed:Use("Coinfruit", 2)
        },
        {
            Type = "GiveItem",
            RewardType = "Pet",
            Name = "Sheckling",
            Quantity = 1,
            Chance = 8,
            Reward = Types.Pet:Use("Sheckling")
        },
        {
            Type = "GiveItem",
            RewardType = "Seed Pack",
            Name = "Gem Chest",
            Quantity = 1,
            Chance = 3,
            Reward = Types.SeedPack:Use("Gem Chest", 1)
        },
        {
            Type = "GiveItem",
            RewardType = "Egg",
            Name = "Gem Egg",
            Quantity = 1,
            Chance = 3,
            Reward = Types.Egg:Use("Gem Egg", 1)
        },
        {
            Type = "GiveItem",
            RewardType = "Pet",
            Name = "Messenger Pigeon",
            Quantity = 1,
            Chance = 2,
            Reward = Types.Pet:Use("Messenger Pigeon")
        },
        {
            Type = "GiveItem",
            RewardType = "Seed",
            Name = "Sherrybloom",
            Quantity = 1,
            Chance = 1,
            Reward = Types.Seed:Use("Sherrybloom", 1)
        }
    },
    [9] = {
        {
            Type = "GiveItem",
            RewardType = "Seed Pack",
            Name = "Gem Chest",
            Quantity = 1,
            Chance = 10,
            Reward = Types.SeedPack:Use("Gem Chest", 1)
        },
        {
            Type = "GiveItem",
            RewardType = "Egg",
            Name = "Gem Egg",
            Quantity = 1,
            Chance = 10,
            Reward = Types.Egg:Use("Gem Egg", 1)
        },
        {
            Type = "GiveItem",
            RewardType = "Seed Pack",
            Name = "Gem Chest",
            Quantity = 3,
            Chance = 0.5,
            Reward = Types.SeedPack:Use("Gem Chest", 3)
        },
        {
            Type = "GiveItem",
            RewardType = "Egg",
            Name = "Gem Egg",
            Quantity = 3,
            Chance = 0.5,
            Reward = Types.Egg:Use("Gem Egg", 3)
        },
        {
            Type = "GiveItem",
            RewardType = "Pet",
            Name = "Messenger Pigeon",
            Quantity = 1,
            Chance = 3,
            Reward = Types.Pet:Use("Messenger Pigeon")
        },
        {
            Type = "GiveItem",
            RewardType = "Seed",
            Name = "Sherrybloom",
            Quantity = 1,
            Chance = 2,
            Reward = Types.Seed:Use("Sherrybloom", 1)
        }
    },
    [12] = {
        {
            Type = "GiveItem",
            RewardType = "Seed Pack",
            Name = "Gem Chest",
            Quantity = 1,
            Chance = 10,
            Reward = Types.SeedPack:Use("Gem Chest", 1)
        },
        {
            Type = "GiveItem",
            RewardType = "Egg",
            Name = "Gem Egg",
            Quantity = 1,
            Chance = 10,
            Reward = Types.Egg:Use("Gem Egg", 1)
        },
        {
            Type = "GiveItem",
            RewardType = "Seed Pack",
            Name = "Gem Chest",
            Quantity = 3,
            Chance = 1.5,
            Reward = Types.SeedPack:Use("Gem Chest", 3)
        },
        {
            Type = "GiveItem",
            RewardType = "Egg",
            Name = "Gem Egg",
            Quantity = 3,
            Chance = 1.5,
            Reward = Types.Egg:Use("Gem Egg", 3)
        },
        {
            Type = "GiveItem",
            RewardType = "Seed",
            Name = "Sherrybloom",
            Quantity = 2,
            Chance = 3,
            Reward = Types.Seed:Use("Sherrybloom", 2)
        },
        {
            Type = "GiveItem",
            RewardType = "Pet",
            Name = "Camel",
            Quantity = 1,
            Chance = 1,
            Reward = Types.Pet:Use("Camel", 1)
        }
    },
    [15] = {
        {
            Type = "GiveItem",
            RewardType = "Seed Pack",
            Name = "Gem Chest",
            Quantity = 1,
            Chance = 10,
            Reward = Types.SeedPack:Use("Gem Chest", 1)
        },
        {
            Type = "GiveItem",
            RewardType = "Egg",
            Name = "Gem Egg",
            Quantity = 1,
            Chance = 10,
            Reward = Types.Egg:Use("Gem Egg", 1)
        },
        {
            Type = "GiveItem",
            RewardType = "Seed Pack",
            Name = "Gem Chest",
            Quantity = 3,
            Chance = 3,
            Reward = Types.SeedPack:Use("Gem Chest", 3)
        },
        {
            Type = "GiveItem",
            RewardType = "Egg",
            Name = "Gem Egg",
            Quantity = 3,
            Chance = 3,
            Reward = Types.Egg:Use("Gem Egg", 3)
        },
        {
            Type = "GiveItem",
            RewardType = "Pet",
            Name = "Camel",
            Quantity = 1,
            Chance = 1,
            Reward = Types.Pet:Use("Camel", 1)
        },
        {
            Type = "GiveItem",
            RewardType = "Seed",
            Name = "Pinkside Dandelion",
            Quantity = 1,
            Chance = 0.5,
            Reward = Types.Seed:Use("Pinkside Dandelion", 1)
        }
    }
};
local u4 = {
    { {
            PlantType = "Carrot",
            Amount = 30
        }, {
            PlantType = "Strawberry",
            Amount = 30
        }, {
            PlantType = "Blueberry",
            Amount = 25
        }, {
            PlantType = "Buttercup",
            Amount = 20
        }, {
            PlantType = "Tomato",
            Amount = 20
        }, {
            PlantType = "Corn",
            Amount = 5
        } },
    { {
            PlantType = "Carrot",
            Amount = 40
        }, {
            PlantType = "Strawberry",
            Amount = 40
        }, {
            PlantType = "Blueberry",
            Amount = 35
        }, {
            PlantType = "Buttercup",
            Amount = 26
        }, {
            PlantType = "Tomato",
            Amount = 28
        }, {
            PlantType = "Corn",
            Amount = 10
        } },
    { {
            PlantType = "Carrot",
            Amount = 50
        }, {
            PlantType = "Strawberry",
            Amount = 50
        }, {
            PlantType = "Blueberry",
            Amount = 45
        }, {
            PlantType = "Buttercup",
            Amount = 32
        }, {
            PlantType = "Tomato",
            Amount = 36
        }, {
            PlantType = "Corn",
            Amount = 15
        } },
    { {
            PlantType = "Carrot",
            Amount = 60
        }, {
            PlantType = "Strawberry",
            Amount = 60
        }, {
            PlantType = "Blueberry",
            Amount = 55
        }, {
            PlantType = "Buttercup",
            Amount = 38
        }, {
            PlantType = "Tomato",
            Amount = 44
        }, {
            PlantType = "Corn",
            Amount = 20
        } },
    { {
            PlantType = "Carrot",
            Amount = 70
        }, {
            PlantType = "Strawberry",
            Amount = 70
        }, {
            PlantType = "Blueberry",
            Amount = 65
        }, {
            PlantType = "Buttercup",
            Amount = 44
        }, {
            PlantType = "Tomato",
            Amount = 52
        }, {
            PlantType = "Corn",
            Amount = 25
        } },
    { {
            PlantType = "Carrot",
            Amount = 80
        }, {
            PlantType = "Strawberry",
            Amount = 80
        }, {
            PlantType = "Blueberry",
            Amount = 75
        }, {
            PlantType = "Buttercup",
            Amount = 50
        }, {
            PlantType = "Tomato",
            Amount = 60
        }, {
            PlantType = "Corn",
            Amount = 30
        } },
    { {
            PlantType = "Carrot",
            Amount = 90
        }, {
            PlantType = "Strawberry",
            Amount = 90
        }, {
            PlantType = "Blueberry",
            Amount = 85
        }, {
            PlantType = "Buttercup",
            Amount = 56
        }, {
            PlantType = "Tomato",
            Amount = 68
        }, {
            PlantType = "Corn",
            Amount = 35
        } },
    { {
            PlantType = "Carrot",
            Amount = 100
        }, {
            PlantType = "Strawberry",
            Amount = 100
        }, {
            PlantType = "Blueberry",
            Amount = 95
        }, {
            PlantType = "Buttercup",
            Amount = 62
        }, {
            PlantType = "Tomato",
            Amount = 76
        }, {
            PlantType = "Corn",
            Amount = 40
        } },
    { {
            PlantType = "Carrot",
            Amount = 110
        }, {
            PlantType = "Strawberry",
            Amount = 110
        }, {
            PlantType = "Blueberry",
            Amount = 105
        }, {
            PlantType = "Buttercup",
            Amount = 68
        }, {
            PlantType = "Tomato",
            Amount = 84
        }, {
            PlantType = "Corn",
            Amount = 45
        } },
    { {
            PlantType = "Carrot",
            Amount = 120
        }, {
            PlantType = "Strawberry",
            Amount = 120
        }, {
            PlantType = "Blueberry",
            Amount = 115
        }, {
            PlantType = "Buttercup",
            Amount = 74
        }, {
            PlantType = "Tomato",
            Amount = 92
        }, {
            PlantType = "Corn",
            Amount = 50
        } },
    { {
            PlantType = "Carrot",
            Amount = 130
        }, {
            PlantType = "Strawberry",
            Amount = 130
        }, {
            PlantType = "Blueberry",
            Amount = 125
        }, {
            PlantType = "Buttercup",
            Amount = 80
        }, {
            PlantType = "Tomato",
            Amount = 100
        }, {
            PlantType = "Corn",
            Amount = 55
        } },
    { {
            PlantType = "Carrot",
            Amount = 140
        }, {
            PlantType = "Strawberry",
            Amount = 140
        }, {
            PlantType = "Blueberry",
            Amount = 135
        }, {
            PlantType = "Buttercup",
            Amount = 86
        }, {
            PlantType = "Tomato",
            Amount = 108
        }, {
            PlantType = "Corn",
            Amount = 60
        } }
};
local v5 = {
    RewardsData = u1,
    PartTwoRewardsData = u2,
    BargainBillRewardData = u3
};

local function GetNearestPartTwoKey(p6: number) -- Line: 1575
    -- upvalues: u2 (copy)
    local v7 = nil;

    for i in u2 do
        if i <= p6 and (not v7 or v7 < i) then
            v7 = i;
        end;
    end;

    return v7;
end;

local function DeepClone(p8) -- Line: 1589
    -- upvalues: DeepClone (copy)
    local v9 = {};

    for i, v in pairs(p8) do
        if type(v) == "table" then
            v9[i] = DeepClone(v);
        else
            v9[i] = v;
        end;
    end;

    return v9;
end;

function v5.PickRandomReward(p10: table, p11: number, p12: number, p13: boolean) -- Line: 1601
    -- upvalues: u1 (copy), DeepClone (copy), PickRandom (copy), u2 (copy)
    local Random_new_ret = Random.new(p12);
    local math_max_ret = math.max(1, p11);

    if math_max_ret <= 12 then
        local v14 = DeepClone(u1[math_max_ret]);

        if p13 then
            for i, v in v14 do
                if v.Name == "Booth Sign" then
                    table.remove(v14, i);
                    break;
                end;
            end;
        end;

        return PickRandom.One(v14, Random_new_ret);
    end;

    if math_max_ret <= 16 then
        local v15 = DeepClone(u1[12]);

        if p13 then
            for i, v in v15 do
                if v.Name == "Booth Sign" then
                    table.remove(v15, i);
                    break;
                end;
            end;
        end;

        return PickRandom.One(v15, Random_new_ret);
    end;

    local v16 = nil;

    for i in u2 do
        if i <= math_max_ret and (not v16 or v16 < i) then
            v16 = i;
        end;
    end;

    local v17 = DeepClone(u2[v16 or 17]);

    if p13 then
        for i, v in v17 do
            if v.Name == "Booth Sign" then
                table.remove(v17, i);
                break;
            end;
        end;
    end;

    return PickRandom.One(v17, Random_new_ret);
end;

local function GetNearestKeyDown(p18: number) -- Line: 1693
    -- upvalues: u3 (copy)
    local v19 = nil;

    for i in u3 do
        if i <= p18 and (not v19 or v19 < i) then
            v19 = i;
        end;
    end;

    return v19;
end;

function v5.PickBargainBillReward(p20: table, p21: number) -- Line: 1707
    -- upvalues: u3 (copy), PickRandom (copy)
    local v22 = nil;

    for i in u3 do
        if i <= p21 and (not v22 or v22 < i) then
            v22 = i;
        end;
    end;

    if v22 then
        return PickRandom.One(u3[v22]);
    end;

    return nil;
end;

function v5.GetSubmissionRequirements(p23: table, p24: number, p25: number) -- Line: 1721
    -- upvalues: u1 (copy), PickRandom (copy), u4 (copy)
    local Random_new_ret = Random.new(p25);
    local math_max_ret = math.max(1, p24);
    local math_min_ret = math.min(math_max_ret, 12);

    return PickRandom.One(u4[not u1[math_min_ret] and 1 or math_min_ret], Random_new_ret);
end;

return v5;