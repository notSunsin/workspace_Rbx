-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Modules.GiveServiceCommon);
local u1 = {
    HarvestSpiritRewards = { {
            Type = "Crate",
            Value = "Autumn Crate",
            Quantity = 1
        }, {
            Type = "Seed Pack",
            Value = "Autumn Seed Pack",
            Quantity = 1
        }, {
            Type = "Egg",
            Value = "Fall Egg",
            Quantity = 1
        }, {
            Type = "Crate",
            Value = "Fall Crate",
            Quantity = 1
        }, {
            Type = "Gear",
            Value = "Watering Can",
            Quantity = 10
        } },
    FallEnergyRewards = {
        [50] = { {
                Type = "Gear",
                Value = "Rake",
                Quantity = 3
            }, {
                Type = "Gear",
                Value = "Firefly Jar",
                Quantity = 1
            }, {
                Type = "Gear",
                Value = "Sky Lantern",
                Quantity = 1
            }, {
                Type = "Gear",
                Value = "Maple Leaf Kite",
                Quantity = 1
            } },
        [100] = { {
                Type = "Gear",
                Value = "Reclaimer",
                Quantity = 3
            }, {
                Type = "Gear",
                Value = "Event Lantern",
                Quantity = 30
            }, {
                Type = "Gear",
                Value = "Watering Can",
                Quantity = 20
            }, {
                Type = "Gear",
                Value = "Leaf Blower",
                Quantity = 1
            }, {
                Type = "Gear",
                Value = "Rake",
                Quantity = 10
            }, {
                Type = "Gear",
                Value = "Firefly Jar",
                Quantity = 3
            }, {
                Type = "Gear",
                Value = "Sky Lantern",
                Quantity = 3
            }, {
                Type = "Gear",
                Value = "Maple Leaf Kite",
                Quantity = 3
            } },
        [150] = { {
                Type = "Gear",
                Value = "Small Treat",
                Quantity = 2
            }, {
                Type = "Gear",
                Value = "Small Toy",
                Quantity = 2
            }, {
                Type = "Gear",
                Value = "Godly Sprinkler",
                Quantity = 1
            }, {
                Type = "Gear",
                Value = "Leaf Blower",
                Quantity = 3
            }, {
                Type = "Gear",
                Value = "Rake",
                Quantity = 15
            }, {
                Type = "Gear",
                Value = "Super Leaf Blower",
                Quantity = 1
            } },
        [200] = { {
                Type = "Gear",
                Value = "Maple Sprinkler",
                Quantity = 1
            }, {
                Type = "Gear",
                Value = "Rake",
                Quantity = 20
            }, {
                Type = "Gear",
                Value = "Super Leaf Blower",
                Quantity = 2
            }, {
                Type = "Crate",
                Value = "Autumn Crate",
                Quantity = 1
            }, {
                Type = "Seed Pack",
                Value = "Autumn Seed Pack",
                Quantity = 1
            }, {
                Type = "Egg",
                Value = "Fall Egg",
                Quantity = 1
            }, {
                Type = "Gear",
                Value = "Harvest Tool",
                Quantity = 10
            } },
        [250] = { {
                Type = "Gear",
                Value = "Maple Sprinkler",
                Quantity = 1
            }, {
                Type = "Crate",
                Value = "Maple Crate",
                Quantity = 2
            }, {
                Type = "Crate",
                Value = "Autumn Crate",
                Quantity = 2
            }, {
                Type = "Seed Pack",
                Value = "Autumn Seed Pack",
                Quantity = 2
            }, {
                Type = "Egg",
                Value = "Autumn Egg",
                Quantity = 1
            }, {
                Type = "Gear",
                Value = "Rake",
                Quantity = 30
            } },
        [350] = { {
                Type = "Crate",
                Value = "Autumn Crate",
                Quantity = 3
            }, {
                Type = "Seed Pack",
                Value = "Autumn Seed Pack",
                Quantity = 3
            }, {
                Type = "Egg",
                Value = "Autumn Egg",
                Quantity = 2
            }, {
                Type = "Crate",
                Value = "Fall Crate",
                Quantity = 3
            }, {
                Type = "Gear",
                Value = "Maple Leaf Charm",
                Quantity = 1
            }, {
                Type = "Gear",
                Value = "Acorn Lollipop",
                Quantity = 2
            }, {
                Type = "Gear",
                Value = "Gold Fertilizer",
                Quantity = 1
            } },
        [500] = { {
                Type = "Seed Pack",
                Value = "Autumn Seed Pack",
                Quantity = 5
            }, {
                Type = "Egg",
                Value = "Autumn Egg",
                Quantity = 4
            }, {
                Type = "Gear",
                Value = "Acorn Lollipop",
                Quantity = 3
            }, {
                Type = "Gear",
                Value = "Super Watering Can",
                Quantity = 1
            }, {
                Type = "Seed",
                Value = "Maple Resin",
                Quantity = 1
            }, {
                Type = "Gear",
                Value = "Golden Acorn",
                Quantity = 1
            }, {
                Type = "Gear",
                Value = "Rainbow Fertilizer",
                Quantity = 1
            }, {
                Type = "Gear",
                Value = "Grandmaster Sprinkler",
                Quantity = 1
            }, {
                Type = "Gear",
                Value = "Silver Lollipop",
                Quantity = 1
            } }
    }
};

function u1.PickRandom(p2) -- Line: 294
    -- upvalues: u1 (copy)
    local HarvestSpiritRewards = u1.HarvestSpiritRewards;

    return HarvestSpiritRewards[math.random(1, #HarvestSpiritRewards)];
end;

function u1.PickFallEnergyReward(p3: table, p4: number) -- Line: 299
    -- upvalues: u1 (copy)
    if p4 < 50 then
        return nil;
    end;

    local FallEnergyRewards = u1.FallEnergyRewards;
    local v5 = 0;

    for i, _ in FallEnergyRewards do
        if i <= p4 and v5 < i then
            v5 = i;
        end;
    end;

    local v6 = FallEnergyRewards[v5];

    return v6[math.random(1, #v6)];
end;

function u1.GetFallEnergyRewards(p7) -- Line: 314
    -- upvalues: u1 (copy)
    return u1.FallEnergyRewards;
end;

function u1.GetFallEnergyRewardsTierless(p8) -- Line: 319
    -- upvalues: u1 (copy)
    local v9 = {};

    for _, v in u1.FallEnergyRewards do
        for _, v2 in v do
            table.insert(v9, v2);
        end;
    end;

    return v9;
end;

return u1;