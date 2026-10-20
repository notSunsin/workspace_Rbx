-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Data.EventShopData.EventShopTypes);

return {
    TwilightShopConfig = {
        SHOP_RESET_TIME = 1200,
        SHOP_UI_NAME = "TwilightShopEventShop_UI",
        LINKED_SHOPS = {}
    },
    TwilightShop = {},
    BloodMoonShopConfig = {
        SHOP_RESET_TIME = 900,
        SHOP_UI_NAME = "BloodMoonShopEventShop_UI",
        LINKED_SHOPS = {}
    },
    BloodMoonShop = {}
};