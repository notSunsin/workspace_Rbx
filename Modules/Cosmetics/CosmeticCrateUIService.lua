-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
game:GetService("UserInputService");
local TweenService = game:GetService("TweenService");
local CrateUI = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("CrateUI");
local Size = CrateUI.Size;
local u1 = nil;
local GetFarmAncestor = require(ReplicatedStorage.Modules.GetFarmAncestor);
local CreateTagHandler = require(ReplicatedStorage.Modules.CreateTagHandler);
require(ReplicatedStorage.Modules.GetMouseToWorld);
local TimeHelper = require(ReplicatedStorage.Modules.TimeHelper);
local CosmeticCrates = require(ReplicatedStorage.Data.CosmeticCrateRegistry).CosmeticCrates;
local CosmeticList = require(ReplicatedStorage.Data.CosmeticRegistry.CosmeticList);
require(ReplicatedStorage.Modules.EffectController.Libraries.TableUtil);
local u2 = {};
CreateTagHandler({
    Tag = "CosmeticCrateLocalHitBox",

    OnInstanceAdded = function(p3: userdata) -- Line: 30, Name: OnInstanceAdded
        -- upvalues: u2 (copy)
        table.insert(u2, p3);
    end,

    OnInstanceRemoved = function(p4: userdata) -- Line: 33, Name: OnInstanceRemoved
        -- upvalues: u2 (copy)
        local table_find_ret = table.find(u2, p4);

        if not table_find_ret then
            return warn((`{p4.Name} hitbox not tracked!`));
        end;

        table.remove(u2, table_find_ret);
    end
});
local workspace_CurrentCamera = workspace.CurrentCamera;
workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function() -- Line: 44
    -- upvalues: workspace_CurrentCamera (ref)
    workspace_CurrentCamera = workspace.CurrentCamera;
end);
local u5 = nil;

local function UpdateRender() -- Line: 62
    -- upvalues: u5 (ref), CosmeticCrates (copy), TweenService (copy), TimeHelper (copy)
    if not u5 then
        return;
    end;

    local v6 = u5:FindFirstAncestor("CosmeticCrate");

    if not v6 then
        return;
    end;

    local Attribute = v6:GetAttribute("CrateType");
    local Attribute2 = v6:GetAttribute("TimeToOpen");
    local Attribute3 = v6:GetAttribute("GrowthMultiplier");

    if Attribute3 then
        Attribute3 = Attribute3 > 0;
    end;

    local v7 = Attribute == "Mysterious Crate";
    local CrateUI2 = u5:FindFirstChild("CrateUI");

    if not CrateUI2 then
        return;
    end;

    local Frame_UpdateTimer = CrateUI2:WaitForChild("Frame_UpdateTimer");
    Frame_UpdateTimer.Visible = v7;
    local Frame_WithContent = CrateUI2:WaitForChild("Frame_WithContent");
    Frame_WithContent.Visible = not v7;

    if v7 then
        Frame_WithContent = Frame_UpdateTimer;
    end;

    local Frame = Frame_WithContent:WaitForChild("TextUI"):WaitForChild("Frame");
    Frame_WithContent:WaitForChild("ContentUI"):WaitForChild("ContentGrid");
    local v8 = Frame:WaitForChild("2_TimerFrame");
    local v9 = v8:WaitForChild("2_CrateTimeToOpen");
    local v10;

    if v7 then
        v10 = Frame:WaitForChild("1_CrateType");
    else
        v10 = v8:WaitForChild("1_CrateType");
    end;

    local v11 = CosmeticCrates[Attribute];
    TweenService:Create(v10, TweenInfo.new(0.2), {
        TextColor3 = v11.Color
    }):Play();
    v9.Text = Attribute2 <= 0 and "Ready" or TimeHelper:GenerateColonFormatFromTime(Attribute2);
    v10.Text = Attribute;

    if Attribute3 or Attribute2 <= 0 then
        v9.TextColor3 = Color3.new(0, 0.666667, 0);

        return;
    end;

    v9.TextColor3 = Color3.new(1, 1, 1);
end;

local function ClearUI(u12) -- Line: 103
    -- upvalues: TweenService (copy)
    if not u12 then
        return;
    end;

    local v13 = TweenService:Create(u12, TweenInfo.new(0.25), {
        Size = UDim2.new(0, 0)
    });
    v13:Play();
    v13.Completed:Once(function() -- Line: 108
        -- upvalues: u12 (copy)
        u12:Destroy();
    end);
end;

local function shuffle(p14) -- Line: 113
    for i = #p14, 1, -1 do
        local math_random_ret = math.random(i);
        local v15 = p14[i];
        p14[i] = p14[math_random_ret];
        p14[math_random_ret] = v15;
        local _ = i;
    end;
end;

local function SetInstance(p16) -- Line: 122
    -- upvalues: u5 (ref), ClearUI (copy), u1 (ref), CrateUI (copy), TweenService (copy), Size (copy), CosmeticCrates (copy), CosmeticList (copy), shuffle (copy), UpdateRender (copy)
    if p16 == u5 then
        return;
    end;

    u5 = p16;
    ClearUI(u1);
    local v17 = u5:FindFirstAncestor("CosmeticCrate");

    if not v17 then
        return;
    end;

    local Attribute = v17:GetAttribute("CrateType");
    u1 = CrateUI:Clone();
    u1.Parent = u5;
    u1.Enabled = true;
    u1.Size = UDim2.new(0, 0);
    TweenService:Create(u1, TweenInfo.new(0.25), {
        Size = Size
    }):Play();
    local v18 = {};
    local v19 = CosmeticCrates[Attribute];

    if not v19 then
        warn((`No crate data for type: {Attribute}`));

        return;
    end;

    for _, v in v19.CosmeticRolls.Items do
        local v20 = CosmeticList[v.Name];

        if v20 then
            table.insert(v18, v20.Icon);
        end;
    end;

    shuffle(v18);
    local v21;

    if Attribute == "Mysterious Crate" then
        v21 = u1.Frame_UpdateTimer.ContentUI.ContentGrid;
    else
        v21 = u1.Frame_WithContent.ContentUI.ContentGrid;
    end;

    local CosmeticTemplate = v21.CosmeticTemplate;

    for i, v in v18 do
        if i > 6 then
            break;
        end;

        local v22 = CosmeticTemplate:Clone();
        v22.Parent = v21;
        v22.Visible = true;
        v22.Image.Image = v;
    end;

    UpdateRender();
end;

task.spawn(function() -- Line: 170
    -- upvalues: u2 (copy), GetFarmAncestor (copy), SetInstance (copy), u5 (ref), ClearUI (copy), u1 (ref)
    while true do
        local v23, v24, v25;

        repeat
            task.wait(0.25);
            local RaycastParams_new_ret = RaycastParams.new();
            RaycastParams_new_ret.FilterDescendantsInstances = { u2 };
            RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Include;
            v24 = nil;
            v25 = nil;
            v23 = game.Players.LocalPlayer.Character;
        until v23 and v23:IsDescendantOf(workspace);

        local p = v23:GetPivot().p;

        for _, v in game.CollectionService:GetTagged("CosmeticCrateServer") do
            if GetFarmAncestor(v) then
                local Magnitude = (p - v:GetPivot().p).Magnitude;

                if Magnitude < 9 and (v25 == nil or Magnitude < v24) then
                    v25 = v:FindFirstChild("HitBox", true);
                    v24 = Magnitude;
                end;
            end;
        end;

        if GetFarmAncestor(v25) then
            SetInstance(v25);
        else
            u5 = nil;
            ClearUI(u1);
        end;
    end;
end);
task.spawn(function() -- Line: 225
    -- upvalues: UpdateRender (copy)
    while true do
        task.wait(1);
        UpdateRender();
    end;
end);

return {};