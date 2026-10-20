-- Decompiled with Potassium's decompiler.

game:GetService("ServerScriptService");
game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Modules.UpdateService);

return {
    Giant = {
        Friendship = {
            TabItems = { "Skyroot Chest", "Can Of Beans", "Pet Shard GiantBean", "Glowpod", "Bouncy Mushroom", "Griffin Statue", "Beanstalk Painting", "Flare Melon", "Gnome" }
        }
    },
    Seed = {
        ["Tier 2"] = {
            RefreshTime = 3600,
            TabItems = { "Cocomango", "Potato", "Broccoli", "Brussels Sprout" }
        },
        ["Daily Deals"] = {
            RefreshTime = 86400,
            TabItems = {}
        }
    },
    Pet = {
        ["Tier 2"] = {
            TabItems = { "Pet Name Reroller", "Pet Lead", "Rainbow Lollipop" }
        }
    },
    ["Fairy Genius"] = {}
};