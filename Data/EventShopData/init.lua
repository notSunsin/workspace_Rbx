-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Data.EventShopData.EventShopTypes);
require(ReplicatedStorage.Modules.UpdateService);
require(ReplicatedStorage.Data.SeedData);
local BizzyBee2026EventShopData = require(ReplicatedStorage.Data.BeeEvent.BizzyBee2026EventShopData);
require(ReplicatedStorage.Data.EasterEvent.EasterEventShopData);
local Events = ReplicatedStorage.Data.Events;
require(Events.LunarGlowEvent.LunarGlowEventShopData);
require(Events.BeanstalkEvent.BeanstalkEventShopData);
local FallMarketEventShopData = require(Events.FallMarketEvent.FallMarketEventShopData);
require(Events.ZenEvent.ZenEventShopData);
local HalloweenEventShopData = require(Events.HalloweenEvent.HalloweenEventShopData);
local HarvestMoonEventShopData = require(Events.HarvestMoonEvent.HarvestMoonEventShopData);
local Summer2026EventShopData = require(Events.Summer2026Event.Summer2026EventShopData);
local SafariHarvestEventShopData = require(Events.SafariEvent.SafariHarvestEventShopData);
local Halloween2026EventShopData = require(Events.Halloween2026Event.Halloween2026EventShopData);

return {
    ["Royal Jelly Shop"] = BizzyBee2026EventShopData.RoyalJellyShop,
    ["Honey Seed Shop"] = BizzyBee2026EventShopData.HoneySeedShop,
    ["Honey Coin Shop"] = BizzyBee2026EventShopData.HoneyCoinShop,
    ["Fall Market Gear Shop"] = FallMarketEventShopData.GearShop,
    ["Fall Market Pet Shop"] = FallMarketEventShopData.PetShop,
    ["Fall Market Cosmetic Shop"] = FallMarketEventShopData.CosmeticShop,
    ["Fall Market Seed Shop"] = FallMarketEventShopData.SeedShop,
    ["Ghostly Gadgets"] = HalloweenEventShopData.GearShop,
    ["Devilish Decor"] = HalloweenEventShopData.CosmeticShop,
    ["Creepy Critters"] = HalloweenEventShopData.PetShop,
    ["Spooky Seeds"] = HalloweenEventShopData.SeedShop,
    ["Demonic Decor"] = Halloween2026EventShopData.CosmeticShop,
    ["Frightening Fauna"] = Halloween2026EventShopData.PetShop,
    ["Scary Seeds"] = Halloween2026EventShopData.SeedShop,
    ["Safari Shop"] = SafariHarvestEventShopData.SafariShop,
    ["Moon Coin Shop"] = HarvestMoonEventShopData.MoonCoinShop,
    ["Tide Token Shop"] = Summer2026EventShopData.TideTokenShop,
    ["Summer Seed Shop"] = Summer2026EventShopData.SummerSeedShop
};