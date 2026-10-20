-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CosmeticMutableStats = require(ReplicatedStorage.Data.CosmeticRegistry.CosmeticMutableStats);
require(ReplicatedStorage.Modules.ExponentialScaler);
local DataService = require(ReplicatedStorage.Modules.DataService);
local CosmeticUpgradeService = ReplicatedStorage:WaitForChild("GameEvents"):WaitForChild("CosmeticUpgradeService");

return {
    GetUpgradePrice = function(p1: table, p2: string, p3: number) -- Line: 12, Name: GetUpgradePrice
        -- upvalues: CosmeticMutableStats (copy)
        local v4 = CosmeticMutableStats[p2];

        if v4 then
            local UpgradeData = v4.UpgradeData;

            return UpgradeData.Cost * math.pow(UpgradeData.Scale, p3);
        end;

        warn(p2, "is a invalid cosmetic stat type!");

        return (1 / 0);
    end,

    Upgrade = function(p5: table, p6: string) -- Line: 25, Name: Upgrade
        -- upvalues: CosmeticUpgradeService (copy)
        return CosmeticUpgradeService:FireServer("Upgrade", p6);
    end,

    GetUpgradeValue = function(p7: table, p8: string, p9: number) -- Line: 29, Name: GetUpgradeValue
        -- upvalues: CosmeticMutableStats (copy)
        local v10 = CosmeticMutableStats[p8];

        if v10 then
            return v10.UpgradeData.Increment * p9;
        end;

        warn(p8, "is a invalid cosmetic stat type!");

        return (1 / 0);
    end,

    GetUpgradeLevel = function(p11: table, p12: string) -- Line: 37, Name: GetUpgradeLevel
        -- upvalues: DataService (copy)
        local Data = DataService:GetData();

        if Data then
            return Data.CosmeticData.MutableStats[p12] or 0;
        end;
    end
};