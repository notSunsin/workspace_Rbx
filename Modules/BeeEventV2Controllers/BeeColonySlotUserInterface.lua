-- Decompiled with Potassium's decompiler.

local CollectionService = game:GetService("CollectionService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local BeeRegistry = require(ReplicatedStorage.Data.BeeEvent.BeeRegistry);
local DataService = require(ReplicatedStorage.Modules.DataService);
local GetFarmAsync = require(ReplicatedStorage.Modules.GetFarmAsync);
local SaveSlotController = require(ReplicatedStorage.Modules.SaveSlotControllers.SaveSlotController);
local Reliable = ReplicatedStorage.GameEvents.BeeColonyStateService.Reliable;

local function CreateBillboard() -- Line: 22
    -- upvalues: CollectionService (copy)
    local Part = Instance.new("Part");
    Part.Name = "BeeNestHover";
    Part.Size = Vector3.new(4.5, 4.5, 0.2);
    Part.Transparency = 1;
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanQuery = true;
    Part.CanTouch = false;
    Part.CastShadow = false;
    CollectionService:AddTag(Part, "BeeNestHover");
    local SurfaceGui = Instance.new("SurfaceGui");
    SurfaceGui.Face = Enum.NormalId.Back;
    SurfaceGui.Adornee = Part;
    SurfaceGui.Name = "BeeInfoUI";
    SurfaceGui.ResetOnSpawn = false;
    SurfaceGui.Parent = Part;
    local Frame = Instance.new("Frame");
    Frame.Name = "BeeInfo";
    Frame.Size = UDim2.new(1, 0, 1, 0);
    Frame.BackgroundTransparency = 1;
    Frame.Visible = true;
    Frame.Parent = SurfaceGui;
    local TextLabel = Instance.new("TextLabel");
    TextLabel.Name = "BeeName";
    TextLabel.Size = UDim2.new(0.5, 0, 0.22, 0);
    TextLabel.BackgroundTransparency = 1;
    TextLabel.Position = UDim2.new(0.5, 0, 0.1, 0);
    TextLabel.AnchorPoint = Vector2.new(0.5, 0);
    TextLabel.Text = "";
    TextLabel.ZIndex = 999;
    TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255);
    TextLabel.TextScaled = true;
    TextLabel.Font = Enum.Font.GothamBold;
    TextLabel.LayoutOrder = 0;
    TextLabel.Parent = Frame;
    local ImageLabel = Instance.new("ImageLabel");
    ImageLabel.Name = "BeeIcon";
    ImageLabel.Position = UDim2.new(0.5, 0, 0.56, 0);
    ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5);
    ImageLabel.Size = UDim2.new(0.75, 0, 0.75, 0);
    ImageLabel.BackgroundTransparency = 1;
    ImageLabel.LayoutOrder = 1;
    ImageLabel.Parent = Frame;
    local UIStroke = Instance.new("UIStroke");
    UIStroke.Thickness = 4;
    UIStroke.Color = Color3.fromRGB(0, 0, 0);
    UIStroke.Parent = TextLabel;

    return Part;
end;

local function GetHiveSlotsAsync(p1: userdata) -- Line: 82
    -- upvalues: GetFarmAsync (copy)
    local v2 = {};
    local v3 = GetFarmAsync(p1);

    if not v3 then
        return v2;
    end;

    local CurrentExpansion = v3:WaitForChild("CurrentExpansion", 20);

    if CurrentExpansion then
        CurrentExpansion = CurrentExpansion:WaitForChild("Custom", 20);
    end;

    if CurrentExpansion then
        CurrentExpansion = CurrentExpansion:WaitForChild("Hive", 20);
    end;

    if not CurrentExpansion then
        return v2;
    end;

    for _, child in CurrentExpansion:GetChildren() do
        local v4 = tonumber(child.Name);

        if v4 then
            v2[v4] = child.CFrame;
        end;
    end;

    return v2;
end;

local function ClearHoverAttributes(p5: userdata) -- Line: 109
    p5:SetAttribute("BeeName", nil);
    p5:SetAttribute("State", nil);
    p5:SetAttribute("BeeState", nil);
    p5:SetAttribute("BeeSlot", nil);
    p5:SetAttribute("IsNesting", nil);
    p5:SetAttribute("Enchantment", nil);
end;

local function ApplyHoverAttributes(p6, p7) -- Line: 118
    if p7.Speed ~= nil then
        p6:SetAttribute("Speed", p7.Speed);
    end;

    if p7.PollinationQuality ~= nil then
        p6:SetAttribute("PollinationQuality", p7.PollinationQuality);
    end;

    if p7.PollinationRate ~= nil then
        p6:SetAttribute("PollinationRate", p7.PollinationRate);
    end;
end;

local function RenderSlot(p8: any, p9: table?) -- Line: 124
    -- upvalues: ClearHoverAttributes (copy), BeeRegistry (copy)
    local BeeInfoUI = p8.BeeInfoUI;
    local BeeInfo = BeeInfoUI.BeeInfo;

    if not p9 then
        BeeInfoUI.Enabled = false;
        p8.CanQuery = false;
        ClearHoverAttributes(p8);

        return;
    end;

    if p9.Data.State ~= "Active" then
        BeeInfoUI.Enabled = false;
        p8.CanQuery = true;
        ClearHoverAttributes(p8);

        return;
    end;

    BeeInfoUI.Enabled = true;
    p8.CanQuery = true;
    local v10 = BeeRegistry[p9.BeeName];

    if not v10 then
        warn((`[BeeColonySlotUserInterface] Missing registry data for bee: {p9.BeeName}`));
        BeeInfo.BeeName.Text = "UNKNOWN BEE";
        BeeInfo.BeeIcon.Image = "";
        ClearHoverAttributes(p8);

        return;
    end;

    local _ = v10.Stats;
    p8:SetAttribute("BeeName", p9.BeeName);
    p8:SetAttribute("State", p9.Data.State);
    p8:SetAttribute("BeeState", p9.Data.State);
    p8:SetAttribute("BeeSlot", p9.Data.Slot);
    p8:SetAttribute("IsNesting", true);
    p8:SetAttribute("Enchantment", p9.Data.Enchantment);
    BeeInfo.BeeName.Text = v10.DisplayName;
    BeeInfo.BeeIcon.Image = v10.Icon;
end;

local u11 = {
    Billboards = {}
};

local function ProcessStateSynchronize(p12, p13) -- Line: 175
    -- upvalues: DataService (copy), u11 (copy), RenderSlot (copy)
    local BeeInventoryData = DataService:GetData().BeeEventData.BeeInventoryData;

    for _, v in p12 do
        for i, v2 in v.ActiveBees do
            local v14 = BeeInventoryData[i];

            if v14 then
                local Slot = v14.Data.Slot;

                if Slot then
                    Slot = u11.Billboards[Slot];
                end;

                if Slot then
                    RenderSlot(Slot, v14);

                    if v2.Speed ~= nil then
                        Slot:SetAttribute("Speed", v2.Speed);
                    end;

                    if v2.PollinationQuality ~= nil then
                        Slot:SetAttribute("PollinationQuality", v2.PollinationQuality);
                    end;

                    if v2.PollinationRate ~= nil then
                        Slot:SetAttribute("PollinationRate", v2.PollinationRate);
                    end;
                end;
            end;
        end;
    end;
end;

local function ProcessStateUpdate(p15, p16) -- Line: 196
    -- upvalues: DataService (copy), u11 (copy), RenderSlot (copy)
    local BeeInventoryData = DataService:GetData().BeeEventData.BeeInventoryData;

    for _, v in p15 do
        for i, v2 in v do
            local v17 = BeeInventoryData[i];

            if v17 then
                local v18 = v17.Data and v17.Data.Slot;

                if v18 then
                    local v19 = u11.Billboards[v18];

                    if v19 then
                        RenderSlot(v19, v17);

                        if v2.Speed ~= nil then
                            v19:SetAttribute("Speed", v2.Speed);
                        end;

                        if v2.PollinationQuality ~= nil then
                            v19:SetAttribute("PollinationQuality", v2.PollinationQuality);
                        end;

                        if v2.PollinationRate ~= nil then
                            v19:SetAttribute("PollinationRate", v2.PollinationRate);
                        end;
                    end;
                end;
            end;
        end;
    end;
end;

local function OnReliable(p20) -- Line: 217
    -- upvalues: ProcessStateSynchronize (copy), ProcessStateUpdate (copy)
    if p20.Synchronize then
        ProcessStateSynchronize(p20.Synchronize);
    end;

    if p20.Create then
        ProcessStateUpdate(p20.Create);
    end;

    if p20.StateUpdate then
        ProcessStateUpdate(p20.StateUpdate);
    end;
end;

function u11.ClearRender(p21) -- Line: 231
    -- upvalues: ClearHoverAttributes (copy)
    for _, v in p21.Billboards do
        local BeeInfoUI = v.BeeInfoUI;
        local _ = BeeInfoUI.BeeInfo;
        BeeInfoUI.Enabled = false;
        v.CanQuery = false;
        ClearHoverAttributes(v);
    end;
end;

function u11.EnsureBillboards(p22) -- Line: 237
    -- upvalues: GetHiveSlotsAsync (copy), Players (copy), CreateBillboard (copy)
    for i, v in GetHiveSlotsAsync(Players.LocalPlayer) do
        if not p22.Billboards[i] then
            local v23 = CreateBillboard();
            v23:SetAttribute("Slot", i);
            v23.CFrame = v * CFrame.new(0, 0, 0.1);
            v23.Parent = workspace;
            p22.Billboards[i] = v23;
        end;
    end;
end;

function u11.RenderAsync(p24) -- Line: 254
    -- upvalues: DataService (copy), RenderSlot (copy)
    for _, v in DataService:GetData().BeeEventData.BeeInventoryData do
        local v25 = p24.Billboards[v.Data.Slot];

        if v25 then
            RenderSlot(v25, v);
        else
            warn("[BeeColonySlotUserInterface] Missing billboards for player\'s bee slot!");
        end;
    end;
end;

function u11.Start(u26) -- Line: 271
    -- upvalues: DataService (copy), SaveSlotController (copy), Reliable (copy), OnReliable (copy)
    DataService:GetPathSignal("BeeEventData/BeeInventoryData/@"):Connect(function() -- Line: 272
        -- upvalues: SaveSlotController (ref), u26 (copy)
        if not SaveSlotController:GetCurrentSaveSlot().IsBeeSlot then
            return;
        end;

        u26:EnsureBillboards();
        u26:ClearRender();
        u26:RenderAsync();
    end);
    SaveSlotController:GetSaveSlotChangeSignal():Connect(function() -- Line: 282
        -- upvalues: SaveSlotController (ref), u26 (copy)
        if not SaveSlotController:GetCurrentSaveSlot().IsBeeSlot then
            u26:ClearRender();

            return;
        end;

        u26:EnsureBillboards();
        u26:ClearRender();
        u26:RenderAsync();
    end);
    DataService:GetPathSignal("BeeEventData/BeeSkillTree/@"):Connect(function() -- Line: 292
        -- upvalues: SaveSlotController (ref), u26 (copy)
        if not SaveSlotController:GetCurrentSaveSlot().IsBeeSlot then
            return;
        end;

        u26:EnsureBillboards();
        u26:ClearRender();
        u26:RenderAsync();
    end);

    if SaveSlotController:GetCurrentSaveSlot().IsBeeSlot then
        u26:EnsureBillboards();
        u26:RenderAsync();
    end;

    Reliable.OnClientEvent:Connect(OnReliable);
    Reliable:FireServer("RequestSync");
end;

task.spawn(u11.Start, u11);

return u11;