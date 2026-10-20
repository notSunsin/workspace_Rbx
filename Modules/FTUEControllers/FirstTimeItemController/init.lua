-- Decompiled with Potassium's decompiler.

local u1 = {};
local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Complete = ReplicatedStorage.GameEvents.FirstTimeItemService.Complete;
local LocalPlayer = Players.LocalPlayer;
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui");
local DataService = require(ReplicatedStorage.Modules.DataService);

function u1.Start(p2) -- Line: 16
    -- upvalues: DataService (copy), PlayerGui (copy), LocalPlayer (copy), Complete (copy)
    local Data = DataService:GetData();

    if Data.ArbitraryFTUEData.AcknowledgedBackpack then
        return;
    end;

    local Inventory = PlayerGui:WaitForChild("BackpackGui"):WaitForChild("Backpack"):WaitForChild("Inventory");
    local InventoryIcon = PlayerGui:WaitForChild("TopbarStandard"):WaitForChild("Holders"):WaitForChild("Left"):WaitForChild("InventoryIcon");

    if not InventoryIcon:FindFirstChild("ClickRegion", true) then
        return;
    end;

    local NotificationTemplate = script:WaitForChild("NotificationTemplate");

    local function UpdateButton() -- Line: 37
        -- upvalues: Data (copy), InventoryIcon (copy)
        local AcknowledgedBackpack = Data.ArbitraryFTUEData.AcknowledgedBackpack;
        local NotificationTemplate2 = InventoryIcon:FindFirstChild("NotificationTemplate");

        if AcknowledgedBackpack and NotificationTemplate2 then
            NotificationTemplate2:Destroy();
        end;
    end;

    local function CreateButton() -- Line: 48
        -- upvalues: Data (copy), InventoryIcon (copy), NotificationTemplate (copy)
        if Data.ArbitraryFTUEData.AcknowledgedBackpack then
            return;
        end;

        if InventoryIcon:FindFirstChild("NotificationTemplate") then
            return;
        end;

        NotificationTemplate:Clone().Parent = InventoryIcon;
    end;

    local AcknowledgedBackpack = Data.ArbitraryFTUEData.AcknowledgedBackpack;
    local NotificationTemplate2 = InventoryIcon:FindFirstChild("NotificationTemplate");

    if AcknowledgedBackpack and NotificationTemplate2 then
        NotificationTemplate2:Destroy();
    end;

    DataService:GetPathSignal("ArbitraryFTUEData/@"):Connect(function() -- Line: 60
        -- upvalues: Data (copy), InventoryIcon (copy)
        local AcknowledgedBackpack2 = Data.ArbitraryFTUEData.AcknowledgedBackpack;
        local NotificationTemplate3 = InventoryIcon:FindFirstChild("NotificationTemplate");

        if AcknowledgedBackpack2 and NotificationTemplate3 then
            NotificationTemplate3:Destroy();
        end;
    end);
    task.delay(1, function() -- Line: 64
        -- upvalues: LocalPlayer (ref), Data (copy), InventoryIcon (copy), NotificationTemplate (copy)
        LocalPlayer:WaitForChild("Backpack").ChildAdded:Connect(function() -- Line: 67
            -- upvalues: Data (ref), InventoryIcon (ref), NotificationTemplate (ref)
            if Data.ArbitraryFTUEData.AcknowledgedBackpack then
                return;
            end;

            if InventoryIcon:FindFirstChild("NotificationTemplate") then
                return;
            end;

            NotificationTemplate:Clone().Parent = InventoryIcon;
        end);
    end);
    Inventory:GetPropertyChangedSignal("Visible"):Connect(function() -- Line: 72
        -- upvalues: Inventory (copy), Complete (ref)
        if Inventory.Visible then
            Complete:FireServer();
        end;
    end);
end;

task.spawn(function() -- Line: 80
    -- upvalues: u1 (copy)
    u1:Start();
end);

return u1;