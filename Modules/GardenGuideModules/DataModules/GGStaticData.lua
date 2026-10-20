-- Decompiled with Potassium's decompiler.

local GardenGuideModules = game:GetService("ReplicatedStorage").Modules.GardenGuideModules;
local GGAnimateColor = require(GardenGuideModules.GGAnimateColor);
local ColorSequence_new_ret = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromHex("#fee84e")),
    ColorSequenceKeypoint.new(0.106, Color3.fromHex("#feec51")),
    ColorSequenceKeypoint.new(0.438, Color3.fromHex("#fed741")),
    ColorSequenceKeypoint.new(0.682, Color3.fromHex("#fcbd2e")),
    ColorSequenceKeypoint.new(1, Color3.fromHex("#d06f2a"))
});
local ColorSequence_new_ret2 = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromHex("#fefefe")),
    ColorSequenceKeypoint.new(0.106, Color3.fromHex("#fefefe")),
    ColorSequenceKeypoint.new(0.438, Color3.fromHex("#c7c7c7")),
    ColorSequenceKeypoint.new(0.682, Color3.fromHex("#8c8c8c")),
    ColorSequenceKeypoint.new(1, Color3.fromHex("#5d5d5d"))
});

return {
    RarityBackground = {
        Common = "rbxassetid://113795487793472",
        Uncommon = "rbxassetid://75534035624064",
        Rare = "rbxassetid://82134954265224",
        Legendary = "rbxassetid://75452144950361",
        Mythical = "rbxassetid://138488165601588",
        Divine = "rbxassetid://116720708807761",
        Prismatic = "rbxassetid://100807390217621",
        Transcendent = "rbxassetid://73351141633292"
    },
    RarityColorMap = {
        Common = Color3.fromRGB(217, 217, 217),
        Uncommon = Color3.fromRGB(105, 170, 0),
        Rare = Color3.fromRGB(0, 85, 255),
        Legendary = Color3.fromRGB(255, 255, 0),
        Mythical = Color3.fromRGB(187, 0, 255),
        Divine = Color3.fromRGB(255, 85, 0),
        Prismatic = Color3.fromHSV(0, 1, 1),
        Transcendent = Color3.fromHSV(0.7, 1, 1)
    },
    RarityLayoutMap = {
        Common = 1,
        Uncommon = 2,
        Rare = 3,
        Legendary = 4,
        Mythical = 5,
        Divine = 6,
        Prismatic = 7,
        Transcendent = 8
    },
    AnimatedColors = {
        Prismatic = GGAnimateColor.AnimatePrismaticColor,
        Transcendent = GGAnimateColor.AnimateTranscendentColor
    },
    GoldColorSequence = ColorSequence_new_ret,
    NormalColorSequence = ColorSequence_new_ret2,
    TextWordsMap = {
        Plant = "Harvested",
        Pet = "Hatched",
        Cosmetic = "Opened",
        Food = "Cooked"
    },
    CoverColors = {
        Color3.fromRGB(163, 75, 75),
        Color3.fromRGB(206, 130, 0),
        Color3.fromRGB(255, 223, 64),
        Color3.fromRGB(53, 148, 43),
        Color3.fromRGB(54, 62, 163),
        Color3.fromRGB(120, 70, 163)
    }
};