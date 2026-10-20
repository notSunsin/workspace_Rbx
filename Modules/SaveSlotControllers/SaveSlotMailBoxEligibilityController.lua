-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("CollectionService");
local LocalPlayer = game:GetService("Players").LocalPlayer;
local DataService = require(ReplicatedStorage.Modules.DataService);
local UpdateService = require(ReplicatedStorage.Modules.UpdateService);
local GetFarmsAsync = require(ReplicatedStorage.Modules.GetFarmsAsync);
require(ReplicatedStorage.Modules.GetFarmAsync)(LocalPlayer);

local function ToggleMailBox(p1, p2) -- Line: 16
    local Attribute = p1:GetAttribute("DefaultCFrame");

    if not Attribute then
        Attribute = p1:GetPivot();
        p1:SetAttribute("DefaultCFrame", Attribute);
    end;

    if not p2 then
        Attribute = CFrame.new(0, 1000000000, 0);
    end;

    p1:PivotTo(Attribute);
end;

local SaveSlotController = require(ReplicatedStorage.Modules.SaveSlotControllers.SaveSlotController);

local function UpdateMailboxes() -- Line: 29
    -- upvalues: DataService (copy), UpdateService (copy), SaveSlotController (copy), ToggleMailBox (copy)
    local Data = DataService:GetData();
    local v3 = not UpdateService:IsHiddenFromUpdate("Save Slots");

    if Data.Sheckles >= 10000000 then
        SaveSlotController:RememberUnlockage();
    end;

    for _, child in workspace.Farm:GetChildren() do
        local Mailbox = child:FindFirstChild("Mailbox");

        if Mailbox then
            local v4;

            if v3 then
                v4 = Data.SaveSlots.UnlockedBefore;
            else
                v4 = v3;
            end;

            ToggleMailBox(Mailbox, v4);
        end;
    end;
end;

local function UpdateRelativeToData() -- Line: 45
    -- upvalues: UpdateMailboxes (copy)
    UpdateMailboxes();
end;

DataService:GetPathSignal("Sheckles"):Connect(UpdateMailboxes);
DataService:GetPathSignal("SaveSlots/UnlockedBefore"):Connect(UpdateMailboxes);
task.spawn(UpdateMailboxes);
UpdateMailboxes();
local v5 = {};

for _, v in GetFarmsAsync() do
    xpcall(function() -- Line: 56
        -- upvalues: v (copy), UpdateMailboxes (copy)
        v.Important.Data.Owner:GetPropertyChangedSignal("Value"):Connect(UpdateMailboxes);
    end, warn);
    v.ChildAdded:Connect(function(p6: userdata) -- Line: 60
        -- upvalues: UpdateMailboxes (copy)
        if p6.Name == "Mailbox" then
            UpdateMailboxes();
        end;
    end);
    v.ChildRemoved:Connect(function(p7: userdata) -- Line: 66
        -- upvalues: UpdateMailboxes (copy)
        if p7.Name == "Mailbox" then
            UpdateMailboxes();
        end;
    end);
end;

task.spawn(function() -- Line: 73
    -- upvalues: UpdateService (copy), UpdateMailboxes (copy)
    while UpdateService:IsHiddenFromUpdate("Save Slots") do
        task.wait(1);
    end;

    UpdateMailboxes();
end);

return v5;