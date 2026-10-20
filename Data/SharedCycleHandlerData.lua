-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CollectionService = game:GetService("CollectionService");
local CycleHandler = require(ReplicatedStorage.Modules.CycleHandler);
local DiggingEventConfigData = require(ReplicatedStorage.Data.DiggingMinigame.DiggingEventConfigData);
local SellingStockData = require(ReplicatedStorage.Data.SellingStockData);
require(ReplicatedStorage.Data.ChristmasEvent.AdventCalendarConfigData);
require(ReplicatedStorage.Data.NewYearsEvent.AdventCalendarConfigData);
local AdminMachineConfigData = require(ReplicatedStorage.Data.AdminMachineConfigData);

local function seconds(p1: number) -- Line: 14
    return p1;
end;

local function minutes(p2: number) -- Line: 18
    return p2 * 60;
end;

local function hours(p3: number) -- Line: 22
    return p3 * 60 * 60;
end;

return {
    TraderEventRequirement = CycleHandler.new({
        Name = "Trader Event Requirement",
        TimeOffset = 0,
        PrintDebug = "None",
        Interval = 600,
        Duration = 600
    }),
    SellingStocksRefresh = CycleHandler.new({
        Name = "Selling Stocks Refresh",
        Duration = 0,
        DisableCommandAutocomplete = true,
        Interval = SellingStockData.SellingStockParameters.STOCK_DURATION
    }),
    PermanentDigging = CycleHandler.new({
        Name = "Treasure Digging",
        TimeOffset = 0,
        PrintDebug = "None",
        Interval = DiggingEventConfigData.PERMANENT_RESET_TIME,
        Duration = DiggingEventConfigData.PERMANENT_RESET_TIME - 3
    }),
    AdminMachine = CycleHandler.new({
        Name = "Admin Machine",
        Duration = 0,
        TimeOffset = 0,
        PrintDebug = "None",
        Interval = AdminMachineConfigData.INTERVAL_LENGTH
    }),
    SafariJoe = CycleHandler.new({
        Name = "Safari Joe",
        Interval = 60,
        Duration = 50,
        TimeOffset = 0
    }),
    WitchesBrew = CycleHandler.new({
        Name = "Witches Brew",
        FolderMoveMode = "ServerOnly",
        PrintDebug = "None",
        Interval = 28800,
        Duration = 14400,
        TimeOffset = 14400,
        EventFolder = CollectionService:GetTagged("WitchesBrewEventFolder")[1]
    }),
    JackOLantern = CycleHandler.new({
        Name = "Jack O Lantern",
        PrintDebug = "None",
        Interval = 7200,
        Duration = 600,
        TimeOffset = 3600
    }),
    HalloweenMarket = CycleHandler.new({
        Name = "Halloween Market",
        TimeOffset = 0,
        PrintDebug = "None",
        Interval = 3600,
        Duration = 900
    }),
    DeadTree = CycleHandler.new({
        Name = "Dead Tree",
        PrintDebug = "None",
        Interval = 28800,
        Duration = 14400,
        TimeOffset = 0
    }),
    Gravedigger = CycleHandler.new({
        Name = "Digging Event",
        PrintDebug = "None",
        Interval = DiggingEventConfigData.EVENT_APPEARANCE_TIME,
        Duration = DiggingEventConfigData.EVENT_ACTIVE_DURATION,
        TimeOffset = DiggingEventConfigData.HALF_EVENT_TIME
    }),
    WitchesBrewAndDeadTree = CycleHandler.new({
        Name = "Witches Brew and Dead Tree",
        PrintDebug = "None",
        Interval = 14400,
        Duration = 10800,
        TimeOffset = -1800
    }),
    HarvestReaper = CycleHandler.new({
        Name = "Harvest Reaper",
        PrintDebug = "None",
        Interval = 14400,
        Duration = 3600,
        TimeOffset = -5400
    }),
    HarvestReaperRestock = CycleHandler.new({
        Name = "Harvest Reaper Restock",
        DisableCommandAutocomplete = true,
        Interval = 14400,
        Duration = 3,
        TimeOffset = 5400
    })
};