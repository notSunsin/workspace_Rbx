-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
require(ReplicatedStorage.Modules.GuiController);
require(ReplicatedStorage.Modules.UpdateService);
require(ReplicatedStorage.Modules.DataService);
require(ReplicatedStorage.Modules.SaveSlotControllers.SaveSlotController);
require(ReplicatedStorage.Modules.SaveSlotControllers.SaveSlotUIController);
require(ReplicatedStorage.Modules.SetupButton);
require(ReplicatedStorage.Types.SlotServiceTypes);
local EasterEvent = ReplicatedStorage:WaitForChild("GameEvents"):WaitForChild("EasterEvent");
EasterEvent:WaitForChild("EasterEventPopupSeenRE");
EasterEvent:WaitForChild("EasterSignBE");
EasterEvent:WaitForChild("LoadSpecialGardenRE");
EasterEvent:WaitForChild("LoadNormalGardenRE");
EasterEvent:WaitForChild("OptInRE");
EasterEvent:WaitForChild("EasterShowPopupRE");
EasterEvent:WaitForChild("EasterHidePopupRE");
local LocalPlayer = Players.LocalPlayer;
assert(LocalPlayer, "LocalPlayer not found");
local PlayerGui = LocalPlayer.PlayerGui;
local BackpackGui = PlayerGui:WaitForChild("BackpackGui");
local EasterEvent_UI = PlayerGui:WaitForChild("EasterEvent_UI");
local _ = EasterEvent_UI.Frame.Main.Buttons.SwitchEaster;
local _ = EasterEvent_UI.Frame.Main.Buttons.SwitchNormal;
local _ = EasterEvent_UI.Frame.Main.Buttons.Participate;
local v1 = {};
local u2 = nil;

local function HideEasterWorldItems() -- Line: 52
    local Interaction = workspace:FindFirstChild("Interaction");

    if not Interaction then
        return;
    end;

    local UpdateItems = Interaction:FindFirstChild("UpdateItems");

    if not UpdateItems then
        return;
    end;

    local Easter2026 = UpdateItems:FindFirstChild("Easter2026");

    if Easter2026 then
        Easter2026:Destroy();
    end;
end;

local function StartHidingEasterWorldItems() -- Line: 69
    -- upvalues: u2 (ref)
    local Interaction = workspace:FindFirstChild("Interaction");

    if Interaction then
        local UpdateItems = Interaction:FindFirstChild("UpdateItems");
        local v3 = UpdateItems and UpdateItems:FindFirstChild("Easter2026");

        if v3 then
            v3:Destroy();
        end;
    end;

    task.spawn(function() -- Line: 72
        -- upvalues: u2 (ref)
        local v4 = workspace:FindFirstChild("Interaction") or workspace:WaitForChild("Interaction", 30);

        if not v4 then
            return;
        end;

        local v5 = v4:FindFirstChild("UpdateItems") or v4:WaitForChild("UpdateItems", 30);

        if not v5 then
            return;
        end;

        local Interaction2 = workspace:FindFirstChild("Interaction");

        if Interaction2 then
            local UpdateItems = Interaction2:FindFirstChild("UpdateItems");
            local v6 = UpdateItems and UpdateItems:FindFirstChild("Easter2026");

            if v6 then
                v6:Destroy();
            end;
        end;

        if u2 then
            u2:Disconnect();
            u2 = nil;
        end;

        u2 = v5.ChildAdded:Connect(function(p7) -- Line: 90
            if p7.Name == "Easter2026" then
                p7:Destroy();
            end;
        end);
    end);
end;

local Interaction = workspace:FindFirstChild("Interaction");

if Interaction then
    local UpdateItems = Interaction:FindFirstChild("UpdateItems");
    local v8 = UpdateItems and UpdateItems:FindFirstChild("Easter2026");

    if v8 then
        v8:Destroy();
    end;
end;

task.spawn(function() -- Line: 72
    -- upvalues: u2 (ref)
    local v9 = workspace:FindFirstChild("Interaction") or workspace:WaitForChild("Interaction", 30);

    if not v9 then
        return;
    end;

    local v10 = v9:FindFirstChild("UpdateItems") or v9:WaitForChild("UpdateItems", 30);

    if not v10 then
        return;
    end;

    local Interaction2 = workspace:FindFirstChild("Interaction");

    if Interaction2 then
        local UpdateItems = Interaction2:FindFirstChild("UpdateItems");
        local v11 = UpdateItems and UpdateItems:FindFirstChild("Easter2026");

        if v11 then
            v11:Destroy();
        end;
    end;

    if u2 then
        u2:Disconnect();
        u2 = nil;
    end;

    u2 = v10.ChildAdded:Connect(function(p12) -- Line: 90
        if p12.Name == "Easter2026" then
            p12:Destroy();
        end;
    end);
end);
EasterEvent_UI.Enabled = false;
BackpackGui.Enabled = true;

function v1.Open(p13) -- Line: 103
    -- upvalues: EasterEvent_UI (copy), BackpackGui (copy)
    local Interaction2 = workspace:FindFirstChild("Interaction");

    if Interaction2 then
        local UpdateItems = Interaction2:FindFirstChild("UpdateItems");
        local v14 = UpdateItems and UpdateItems:FindFirstChild("Easter2026");

        if v14 then
            v14:Destroy();
        end;
    end;

    EasterEvent_UI.Enabled = false;
    BackpackGui.Enabled = true;
end;

function v1.Close(p15) -- Line: 109
    -- upvalues: EasterEvent_UI (copy), BackpackGui (copy)
    EasterEvent_UI.Enabled = false;
    BackpackGui.Enabled = true;
end;

function v1.Start(p16) -- Line: 114
    -- upvalues: u2 (ref), EasterEvent_UI (copy), BackpackGui (copy)
    local Interaction2 = workspace:FindFirstChild("Interaction");

    if Interaction2 then
        local UpdateItems = Interaction2:FindFirstChild("UpdateItems");
        local v17 = UpdateItems and UpdateItems:FindFirstChild("Easter2026");

        if v17 then
            v17:Destroy();
        end;
    end;

    task.spawn(function() -- Line: 72
        -- upvalues: u2 (ref)
        local v18 = workspace:FindFirstChild("Interaction") or workspace:WaitForChild("Interaction", 30);

        if not v18 then
            return;
        end;

        local v19 = v18:FindFirstChild("UpdateItems") or v18:WaitForChild("UpdateItems", 30);

        if not v19 then
            return;
        end;

        local Interaction3 = workspace:FindFirstChild("Interaction");

        if Interaction3 then
            local UpdateItems = Interaction3:FindFirstChild("UpdateItems");
            local v20 = UpdateItems and UpdateItems:FindFirstChild("Easter2026");

            if v20 then
                v20:Destroy();
            end;
        end;

        if u2 then
            u2:Disconnect();
            u2 = nil;
        end;

        u2 = v19.ChildAdded:Connect(function(p21) -- Line: 90
            if p21.Name == "Easter2026" then
                p21:Destroy();
            end;
        end);
    end);
    EasterEvent_UI.Enabled = false;
    BackpackGui.Enabled = true;
end;

return v1;