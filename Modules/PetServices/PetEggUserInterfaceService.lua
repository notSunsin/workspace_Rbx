-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
game:GetService("UserInputService");
local TweenService = game:GetService("TweenService");
local PetEggUI = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("PetUI"):WaitForChild("PetEggUI");
local CanvasGroup = PetEggUI:WaitForChild("CanvasGroup");
local EggName = CanvasGroup:WaitForChild("EggName");
local EggHatchTime = CanvasGroup:WaitForChild("EggHatchTime");
local EggBoost = CanvasGroup:WaitForChild("EggBoost");
local GetFarmAncestor = require(ReplicatedStorage.Modules.GetFarmAncestor);
local CreateTagHandler = require(ReplicatedStorage.Modules.CreateTagHandler);
require(ReplicatedStorage.Modules.GetMouseToWorld);
local TimeHelper = require(ReplicatedStorage.Modules.TimeHelper);
local PetRegistry = require(ReplicatedStorage.Data.PetRegistry);
require(ReplicatedStorage.Data.EnumRegistry.InventoryServiceEnums);
local PetEggs = PetRegistry.PetEggs;
local u1 = {};
CreateTagHandler({
    Tag = "PetEggLocalHitBox",

    OnInstanceAdded = function(p2: userdata) -- Line: 36, Name: OnInstanceAdded
        -- upvalues: u1 (copy)
        table.insert(u1, p2);
    end,

    OnInstanceRemoved = function(p3: userdata) -- Line: 39, Name: OnInstanceRemoved
        -- upvalues: u1 (copy)
        local table_find_ret = table.find(u1, p3);

        if not table_find_ret then
            return warn((`{p3.Name} hitbox not tracked!`));
        end;

        table.remove(u1, table_find_ret);
    end
});
local workspace_CurrentCamera = workspace.CurrentCamera;
workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function() -- Line: 50
    -- upvalues: workspace_CurrentCamera (ref)
    workspace_CurrentCamera = workspace.CurrentCamera;
end);
local u4 = nil;
RunService.RenderStepped:Connect(function() -- Line: 56
    -- upvalues: u4 (ref), workspace_CurrentCamera (ref), PetEggUI (copy)
    if not u4 then
        return;
    end;

    local v5 = workspace_CurrentCamera:WorldToScreenPoint(u4:GetPivot().Position + Vector3.new(0, 0, 0));
    PetEggUI.Position = UDim2.new(0, v5.X, 0, v5.Y);
end);

local function UpdateRender() -- Line: 62
    -- upvalues: u4 (ref), PetEggs (copy), TweenService (copy), EggName (copy), TimeHelper (copy), EggHatchTime (copy), EggBoost (copy)
    if not u4 then
        return;
    end;

    local v6 = u4:FindFirstAncestor("PetEgg");

    if not v6 then
        return;
    end;

    local Attribute = v6:GetAttribute("EggName");
    local Attribute2 = v6:GetAttribute("TimeToHatch");
    local Attribute3 = v6:GetAttribute("GrowthMultiplier");
    local v7 = v6:GetAttribute("EggBoostAmount") or 0;

    if Attribute3 then
        Attribute3 = Attribute3 > 0;
    end;

    local v8 = PetEggs[Attribute];
    TweenService:Create(EggName, TweenInfo.new(0.2), {
        TextColor3 = v8.Color
    }):Play();
    EggHatchTime.Text = Attribute2 == 0 and "Ready" or TimeHelper:GenerateColonFormatFromTime(Attribute2);
    EggName.Text = Attribute;
    EggBoost.Visible = v7 > 0;
    EggBoost.Text = `{math.floor(v7 * 10) / 10}% Boost`;

    if Attribute3 and Attribute2 ~= 0 then
        EggHatchTime.TextColor3 = Color3.new(0, 0.666667, 0);

        return;
    end;

    EggHatchTime.TextColor3 = Color3.new(1, 1, 1);
end;

task.spawn(function() -- Line: 93
    -- upvalues: u1 (copy), GetFarmAncestor (copy), u4 (ref), UpdateRender (copy), TweenService (copy), CanvasGroup (copy)
    while true do
        local v9, v10, v11;

        repeat
            task.wait(0.25);
            local RaycastParams_new_ret = RaycastParams.new();
            RaycastParams_new_ret.FilterDescendantsInstances = { u1 };
            RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Include;
            v10 = nil;
            v11 = nil;
            v9 = game.Players.LocalPlayer.Character;
        until v9 and v9:IsDescendantOf(workspace);

        local p = v9:GetPivot().p;

        for _, v in game.CollectionService:GetTagged("PetEggServer") do
            if GetFarmAncestor(v) then
                local Magnitude = (p - v:GetPivot().p).Magnitude;

                if Magnitude < 9 and (v11 == nil or Magnitude < v10) then
                    v11 = v:FindFirstChild("HitBox", true);
                    v10 = Magnitude;
                end;
            end;
        end;

        if GetFarmAncestor(v11) then
            u4 = v11;
            UpdateRender();
        else
            u4 = nil;
        end;

        local v12;

        if u4 then
            v12 = u4.Parent.Parent:GetAttribute("ShowTime");
        else
            v12 = nil;
        end;

        local v13 = not v12 and true or v12 <= workspace:GetServerTimeNow();
        TweenService:Create(CanvasGroup, TweenInfo.new(0.25), {
            GroupTransparency = v13 and u4 and 0 or 1
        }):Play();
    end;
end);
task.spawn(function() -- Line: 145
    -- upvalues: UpdateRender (copy)
    while true do
        task.wait(1);
        UpdateRender();
    end;
end);

return {};