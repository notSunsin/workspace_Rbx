-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Data.BeeEvent.BeeRegistry);

function BeeEggEntry(p1: table)
    return p1;
end;

local u2 = {};
local v3 = {
    Common = Color3.fromRGB(199, 199, 199),
    Rare = Color3.fromRGB(4, 119, 253),
    Mythical = Color3.fromRGB(169, 84, 255),
    Transcendent = Color3.fromRGB(85, 0, 127)
};
u2.Entries = {
    ["Common Bee Egg"] = BeeEggEntry({
        Icon = "rbxassetid://95209902180915",
        HatchTime = 300,
        Rarity = "Common",
        StockChance = 1,
        Price = 10,
        BeeWeights = { {
                BeeName = "Bee",
                Weight = 30
            }, {
                BeeName = "Swift Bee",
                Weight = 15
            }, {
                BeeName = "Pollen Bee",
                Weight = 15
            }, {
                BeeName = "Clockwork Bee",
                Weight = 5
            }, {
                BeeName = "Baby Bee",
                Weight = 3
            } },
        Color = Color3.fromRGB(199, 199, 199),
        NameColor = v3.Common
    }),
    ["Rare Bee Egg"] = BeeEggEntry({
        Icon = "rbxassetid://105215475946278",
        HatchTime = 1800,
        Rarity = "Rare",
        StockChance = 3,
        Price = 100,
        BeeWeights = { {
                BeeName = "Busy Bee",
                Weight = 30
            }, {
                BeeName = "Rumble Bee",
                Weight = 30
            }, {
                BeeName = "Merchant Bee",
                Weight = 10
            }, {
                BeeName = "Jester Bee",
                Weight = 3
            }, {
                BeeName = "Panic Bee",
                Weight = 1
            } },
        Color = Color3.fromRGB(4, 119, 253),
        NameColor = v3.Rare
    }),
    ["Mythical Bee Egg"] = BeeEggEntry({
        Icon = "rbxassetid://72198514955680",
        HatchTime = 3600,
        Rarity = "Mythical",
        StockChance = 10,
        Price = 500,
        BeeWeights = { {
                BeeName = "Royal Bee",
                Weight = 30
            }, {
                BeeName = "Turbo Bee",
                Weight = 30
            }, {
                BeeName = "Treasure Bee",
                Weight = 10
            }, {
                BeeName = "Princess Bee",
                Weight = 3
            }, {
                BeeName = "Illusion Bee",
                Weight = 1
            } },
        Color = Color3.fromRGB(169, 84, 255),
        NameColor = v3.Mythical
    }),
    ["Transcendent Bee Egg"] = BeeEggEntry({
        Icon = "rbxassetid://75891322555145",
        HatchTime = 7200,
        Rarity = "Transcendent",
        StockChance = 20,
        Price = 5000,
        BeeWeights = { {
                BeeName = "Necromancer Bee",
                Weight = 35
            }, {
                BeeName = "Chaos Bee",
                Weight = 20
            }, {
                BeeName = "Chrono Bee",
                Weight = 20
            }, {
                BeeName = "Overlord Bee",
                Weight = 3
            }, {
                BeeName = "Genesis Bee",
                Weight = 1
            } },
        Color = Color3.fromRGB(85, 0, 127),
        NameColor = v3.Transcendent
    })
};
u2.RarityNameColors = v3;
u2.BeeNames = {};

for i, _ in u2.Entries do
    u2.BeeNames[i] = i;
end;

function u2.GetBeeChance(p4) -- Line: 120
    -- upvalues: u2 (copy)
    local v5 = 0;
    local v6 = 0;

    for _, v in u2.Entries do
        for _, v2 in v.BeeWeights do
            v5 = v5 + v2.Weight;

            if v2.BeeName == p4 then
                v6 = v6 + v2.Weight;
            end;
        end;
    end;

    return v5 <= 0 and 0 or v6 / v5 * 100;
end;

return u2;