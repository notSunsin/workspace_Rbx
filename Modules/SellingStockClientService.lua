-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local SellingStockClientService = require(ReplicatedStorage.Modules.EventService).new("SellingStockClientService", "Sell Stocks");
local _ = ReplicatedStorage.Data.SellStocks;

function SellingStockClientService.GetCurrentStockMultiplier(p1: table, p2: string) -- Line: 10
    return p1.IsRunning and 1 or 1;
end;

return SellingStockClientService;