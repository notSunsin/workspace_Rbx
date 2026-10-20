-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Data.EventShopData.EventShopTypes);
local BizzyBee2026EventShopData = require(ReplicatedStorage.Data.BeeEvent.BizzyBee2026EventShopData);
require(ReplicatedStorage.Data.EasterEvent.EasterEventShopData);
local Events = ReplicatedStorage.Data.Events;
local LunarGlowEventShopData = require(Events.LunarGlowEvent.LunarGlowEventShopData);
local BeanstalkEventShopData = require(Events.BeanstalkEvent.BeanstalkEventShopData);
local FallMarketEventShopData = require(Events.FallMarketEvent.FallMarketEventShopData);
local ZenEventShopData = require(Events.ZenEvent.ZenEventShopData);
local HalloweenEventShopData = require(Events.HalloweenEvent.HalloweenEventShopData);
local HarvestMoonEventShopData = require(Events.HarvestMoonEvent.HarvestMoonEventShopData);
local Summer2026EventShopData = require(Events.Summer2026Event.Summer2026EventShopData);
local SafariHarvestEventShopData = require(Events.SafariEvent.SafariHarvestEventShopData);
local Halloween2026EventShopData = require(Events.Halloween2026Event.Halloween2026EventShopData);
local u1 = {
    REQUIRED_WEIGHT = 30,
    ROTATING_SHOP_SLOTS = 5,
    BASE_RESTOCK_COST = 100000,
    RESTOCK_COST_MULTIPLIER = 3,
    MAX_RESTOCK_COST = (1 / 0),
    RESTOCK_COST_RESET_TIME = 86400,
    RESTOCK_CURRENCY = "ROBUX",
    SHOP_LOCK_TYPE = "PLAYER",
    SHOP_TYPE = "EventShop",
    SHOP_RESET_TIME = 300,
    SHOP_UI_NAME = "EventShop_UI",
    SHOW_STOCK_ODDS_BUTTON = false,
    EVENT_SET = nil
};
local u2 = {
    ["Royal Jelly Shop"] = BizzyBee2026EventShopData.RoyalJellyShopConfig,
    ["Honey Seed Shop"] = BizzyBee2026EventShopData.HoneySeedShopConfig,
    ["Honey Coin Shop"] = BizzyBee2026EventShopData.HoneyCoinShopConfig,
    ["Twilight Shop"] = LunarGlowEventShopData.TwilightShopConfig,
    ["Blood Moon Shop"] = LunarGlowEventShopData.BloodMoonShopConfig,
    ["Goliath\'s Goods"] = BeanstalkEventShopData.MainShopConfig,
    ["Goliath\'s Friends Deals"] = BeanstalkEventShopData.FriendShopConfig,
    ["Fall Market Gear Shop"] = FallMarketEventShopData.GearShopConfig,
    ["Fall Market Pet Shop"] = FallMarketEventShopData.PetShopConfig,
    ["Fall Market Cosmetic Shop"] = FallMarketEventShopData.CosmeticShopConfig,
    ["Fall Market Seed Shop"] = FallMarketEventShopData.SeedShopConfig,
    ["Tranquil Treasures"] = ZenEventShopData.TranquilTreasuresConfig,
    ["Ghostly Gadgets"] = HalloweenEventShopData.GearShopConfig,
    ["Devilish Decor"] = HalloweenEventShopData.CosmeticShopConfig,
    ["Creepy Critters"] = HalloweenEventShopData.PetShopConfig,
    ["Spooky Seeds"] = HalloweenEventShopData.SeedShopConfig,
    ["Demonic Decor"] = Halloween2026EventShopData.CosmeticShopConfig,
    ["Frightening Fauna"] = Halloween2026EventShopData.PetShopConfig,
    ["Scary Seeds"] = Halloween2026EventShopData.SeedShopConfig,
    ["Safari Shop"] = SafariHarvestEventShopData.SafariShopConfig,
    ["Moon Coin Shop"] = HarvestMoonEventShopData.MoonCoinShopConfig,
    ["Tide Token Shop"] = Summer2026EventShopData.TideTokenShopConfig,
    ["Summer Seed Shop"] = Summer2026EventShopData.SummerSeedShopConfig
};
local u5 = {
    GetConfig = function(p3: string) -- Line: 91, Name: GetConfig
        -- upvalues: u2 (copy), u1 (copy)
        local v4 = u2[p3];

        if not v4 then
            return u1;
        end;

        local table_clone_ret = table.clone(u1);

        for i, v in v4 do
            table_clone_ret[i] = v;
        end;

        return table_clone_ret;
    end
};

function u5.GetShopResetTime(p6: string) -- Line: 106
    -- upvalues: u5 (copy)
    return u5.GetConfig(p6).SHOP_RESET_TIME;
end;

function u5.GetShopUIName(p7: string) -- Line: 110
    -- upvalues: u5 (copy)
    return u5.GetConfig(p7).SHOP_UI_NAME;
end;

function u5.GetLinkedShops(p8: string) -- Line: 114
    -- upvalues: u5 (copy)
    return u5.GetConfig(p8).LINKED_SHOPS;
end;

function u5.GetShowStockOddsButton(p9: string) -- Line: 118
    -- upvalues: u5 (copy)
    return u5.GetConfig(p9).SHOW_STOCK_ODDS_BUTTON == true;
end;

for i, v in u1 do
    u5[i] = v;
end;

return u5;