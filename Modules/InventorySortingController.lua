-- Decompiled with Potassium's decompiler.

game:GetService("ServerScriptService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
game:GetService("RunService");
local InventorySortingServiceEvents = ReplicatedStorage:WaitForChild("GameEvents"):WaitForChild("InventorySortingServiceEvents");
local v1 = {};
local DataService = require(ReplicatedStorage.Modules.DataService);

function v1.GetEntry(p2: table, p3: string) -- Line: 13
    -- upvalues: DataService (copy)
    local InventorySortData = DataService:GetData().InventorySortData;

    return table.find(InventorySortData, p3);
end;

local MoveEntry = InventorySortingServiceEvents:WaitForChild("MoveEntry");

function v1.MoveEntry(p4: table, p5: string, p6: number) -- Line: 20
    -- upvalues: MoveEntry (copy)
    return MoveEntry:FireServer(p5, p6);
end;

function v1.GetHotbarData(p7) -- Line: 25
    -- upvalues: DataService (copy)
    return DataService:GetData().HotbarData or {};
end;

local SetHotbar = InventorySortingServiceEvents:WaitForChild("SetHotbar", 10);

function v1.SetHotbar(p8: table, p9: table) -- Line: 34
    -- upvalues: SetHotbar (copy)
    if SetHotbar then
        return SetHotbar:FireServer(p9);
    end;
end;

function v1.GetSortedData(p10) -- Line: 39
    -- upvalues: DataService (copy)
    local InventorySortData = DataService:GetData().InventorySortData;

    if not table.find(InventorySortData, "SHOVEL") then
        table.insert(InventorySortData, "SHOVEL");
    end;

    return InventorySortData;
end;

return v1;