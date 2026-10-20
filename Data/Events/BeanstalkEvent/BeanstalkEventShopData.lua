-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Data.EventShopData.EventShopTypes);

return {
    MainShopConfig = {
        SHOP_RESET_TIME = 900,
        SHOP_UI_NAME = "BeanstalkEventShop_UI",
        RESTOCK_CURRENCY = "Sheckles",
        BASE_RESTOCK_COST = 1000000000,
        LINKED_SHOPS = {
            {
                Index = "Goliath\'s Goods",
                Label = "Main",
                Color = Color3.fromRGB(170, 255, 0)
            },
            {
                Index = "Goliath\'s Friends Deals",
                Label = "Friendship",
                Color = Color3.fromRGB(85, 170, 0)
            }
        }
    },
    MainShop = {},
    FriendShopConfig = {
        SHOP_RESET_TIME = 900,
        SHOP_UI_NAME = "GiantsFriendShop_UI",
        RESTOCK_CURRENCY = "Sheckles",
        BASE_RESTOCK_COST = 1000000000,
        LINKED_SHOPS = {
            {
                Index = "Goliath\'s Goods",
                Label = "Main",
                Color = Color3.fromRGB(170, 255, 0)
            },
            {
                Index = "Goliath\'s Friends Deals",
                Label = "Friendship",
                Color = Color3.fromRGB(85, 170, 0)
            }
        }
    },
    FriendShop = {}
};