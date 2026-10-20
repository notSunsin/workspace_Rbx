-- Decompiled with Potassium's decompiler.

game:GetService("Selection");
local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("CollectionService");
local RunService = game:GetService("RunService");
game:GetService("UserInputService");
game:GetService("GuiService");
local workspace_CurrentCamera = workspace.CurrentCamera;
workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function() -- Line: 12
    -- upvalues: workspace_CurrentCamera (ref)
    workspace_CurrentCamera = workspace.CurrentCamera;
end);
local ActivePetsService = require(ReplicatedStorage.Modules.PetServices.ActivePetsService);
local WaitForDescendant = require(ReplicatedStorage.Modules.WaitForDescendant);
local PetRegistry = require(ReplicatedStorage.Data.PetRegistry);
local PetUtilities = require(ReplicatedStorage.Modules.PetServices.PetUtilities);
local PetList = PetRegistry.PetList;
local MAX_LEVEL = PetRegistry.PetConfig.XP_CONFIG.MAX_LEVEL;
local PetInformationUI = Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("PetUI"):WaitForChild("PetInformationUI");
local u1 = WaitForDescendant(PetInformationUI, "CanvasGroup");
local u2 = WaitForDescendant(PetInformationUI, "DROP_SHADOW");
local u3 = WaitForDescendant(PetInformationUI, "PET_TEXT");
local u4 = WaitForDescendant(PetInformationUI, "LEVEL_TEXT");
local u5 = WaitForDescendant(PetInformationUI, "HUNGER_BAR");
local u6 = WaitForDescendant(PetInformationUI, "LEVEL_PROGRESS_BAR");
local u7 = WaitForDescendant(PetInformationUI, "LEVEL_ICON");
local u8 = WaitForDescendant(PetInformationUI, "LEVEL_MAXED_TEXT");
local u9 = WaitForDescendant(PetInformationUI, "CANVAS_STROKE");
local u10 = {
    Active = false,
    Target = nil
};

function u10.SetTarget(p11: table, p12: userdata) -- Line: 50
    -- upvalues: u10 (copy), ActivePetsService (copy), u3 (copy), u4 (copy)
    u10.Target = p12;

    if not p12 then
        return;
    end;

    local PetDataFromPetObject = ActivePetsService:GetPetDataFromPetObject(p12);

    if not PetDataFromPetObject then
        return;
    end;

    local PetData = PetDataFromPetObject.PetData;
    local Name = PetData.Name;

    if Name == "" then
        Name = nil;
    end;

    u3.Text = Name or PetDataFromPetObject.PetType;
    u4.Text = `Age {PetData.Level}`;
    u10:Update(0);
end;

function u10.Update(p13, p14) -- Line: 69
    -- upvalues: u10 (copy), ActivePetsService (copy), PetList (copy), TweenService (copy), u5 (copy), PetUtilities (copy), MAX_LEVEL (copy), u6 (copy), u8 (copy), u7 (copy)
    local Target = u10.Target;

    if not Target then
        return;
    end;

    local PetDataFromPetObject = ActivePetsService:GetPetDataFromPetObject(Target);

    if not PetDataFromPetObject then
        return;
    end;

    local PetData = PetDataFromPetObject.PetData;
    local v15 = PetData.Hunger / PetList[PetDataFromPetObject.PetType].DefaultHunger;
    TweenService:Create(u5, TweenInfo.new(p14 or 0.2), {
        Size = UDim2.fromScale(v15, 1)
    }):Play();
    local Level = PetData.Level;
    local CurrentLevelXPCost = PetUtilities:GetCurrentLevelXPCost(Level);
    local v16 = MAX_LEVEL <= Level;
    local v17 = v16 and 1 or (PetData.LevelProgress or 0) / CurrentLevelXPCost;
    TweenService:Create(u6, TweenInfo.new(p14 or 0.2), {
        Size = UDim2.fromScale(v17, 1)
    }):Play();
    u8.Visible = v16;
    u7.Visible = not v16;
end;

function u10.Toggle(p18, p19) -- Line: 103
    -- upvalues: u10 (copy), TweenService (copy), u1 (copy), u2 (copy), u9 (copy)
    if u10.Active == p19 then
        return;
    end;

    u10.Active = p19;
    local v20 = TweenService:Create(u1, TweenInfo.new(0.15), {
        GroupTransparency = p19 and 0 or 1
    });
    TweenService:Create(u2, TweenInfo.new(0.15), {
        ImageTransparency = p19 and 0.6 or 1
    });
    v20:Play();
    TweenService:Create(u9, TweenInfo.new(0.15), {
        Transparency = p19 and 0 or 1
    }):Play();

    if not p19 then
        u10.Target = nil;
    end;
end;

local function GetWorldToPosition(p21) -- Line: 129
    -- upvalues: workspace_CurrentCamera (ref)
    if p21 then
        local v22 = workspace_CurrentCamera:WorldToScreenPoint(p21);

        return UDim2.fromOffset(v22.X, v22.Y);
    end;
end;

RunService.RenderStepped:Connect(function() -- Line: 136
    -- upvalues: u10 (copy), PetInformationUI (copy), workspace_CurrentCamera (ref)
    if not u10.Active then
        return;
    end;

    if not u10.Target then
        u10:Toggle(false);

        return;
    end;

    local v23 = u10.Target.Position + Vector3.new(0, 5, 0);
    local v24;

    if v23 then
        local v25 = workspace_CurrentCamera:WorldToScreenPoint(v23);
        v24 = UDim2.fromOffset(v25.X, v25.Y);
    else
        v24 = nil;
    end;

    PetInformationUI.Position = v24;
end);
task.spawn(function() -- Line: 142
    -- upvalues: u10 (copy)
    while true do
        task.wait(1);
        u10:Update();
    end;
end);

return u10;