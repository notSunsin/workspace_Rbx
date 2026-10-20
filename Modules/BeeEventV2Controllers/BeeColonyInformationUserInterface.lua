-- Decompiled with Potassium's decompiler.

local CollectionService = game:GetService("CollectionService");
local UserInputService = game:GetService("UserInputService");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local BeeRegistry = require(ReplicatedStorage.Data.BeeEvent.BeeRegistry);
local BeeEnchantmentRegistry = require(ReplicatedStorage.Data.BeeEvent.BeeEnchantmentRegistry);
local GetFarmAsync = require(ReplicatedStorage.Modules.GetFarmAsync);
local LocalPlayer = Players.LocalPlayer;
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui");
local workspace_CurrentCamera = workspace.CurrentCamera;
local v1 = {};
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = false;
local u7 = nil;
local RaycastParams_new_ret = RaycastParams.new();
RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Include;
local u8 = {
    Common = Color3.new(0.666667, 0.666667, 0.666667),
    Rare = Color3.new(0.027451, 0.466667, 1),
    Legendary = Color3.new(0.921569, 0.921569, 0.00392157),
    Mythical = Color3.new(0.666667, 0.333333, 1),
    Transcendent = Color3.new(0.333333, 0, 0.498039),
    Divine = Color3.new(0.729412, 0.670588, 0.239216)
};

local function GetRarityColor(p9: string?) -- Line: 36
    -- upvalues: u8 (copy)
    return u8[p9 or "Common"] or Color3.fromRGB(255, 255, 255);
end;

local function FormatMultiplier(p10: number) -- Line: 41
    local math_floor_ret = math.floor((p10 - 1) * 100 + 0.5);

    return `{math_floor_ret >= 0 and "+" or ""}{math_floor_ret}%`;
end;

local function FormatEnchantBuffs(p11: table?) -- Line: 47
    if not p11 then
        return "";
    end;

    local v12 = {};

    if p11.DamageMult then
        local math_floor_ret = math.floor((p11.DamageMult - 1) * 100 + 0.5);
        local v13 = `{`{math_floor_ret >= 0 and "+" or ""}{math_floor_ret}%`} Damage`;
        table.insert(v12, v13);
    end;

    if p11.SpeedMult then
        local math_floor_ret = math.floor((p11.SpeedMult - 1) * 100 + 0.5);
        local v14 = `{`{math_floor_ret >= 0 and "+" or ""}{math_floor_ret}%`} Speed`;
        table.insert(v12, v14);
    end;

    if p11.MaxHealthMult then
        local math_floor_ret = math.floor((p11.MaxHealthMult - 1) * 100 + 0.5);
        local v15 = `{`{math_floor_ret >= 0 and "+" or ""}{math_floor_ret}%`} Health`;
        table.insert(v12, v15);
    end;

    if p11.HealRateMult then
        local math_floor_ret = math.floor((p11.HealRateMult - 1) * 100 + 0.5);
        local v16 = `{`{math_floor_ret >= 0 and "+" or ""}{math_floor_ret}%`} Regen`;
        table.insert(v12, v16);
    end;

    if p11.PollinationQualityMult then
        local math_floor_ret = math.floor((p11.PollinationQualityMult - 1) * 100 + 0.5);
        local v17 = `{`{math_floor_ret >= 0 and "+" or ""}{math_floor_ret}%`} Quality`;
        table.insert(v12, v17);
    end;

    if p11.PollinationRateMult then
        local math_floor_ret = math.floor((p11.PollinationRateMult - 1) * 100 + 0.5);
        local v18 = `{`{math_floor_ret >= 0 and "+" or ""}{math_floor_ret}%`} Rate`;
        table.insert(v12, v18);
    end;

    if p11.CritChanceAdd then
        local v19 = `+{math.floor(p11.CritChanceAdd * 100 + 0.5)}% Crit`;
        table.insert(v12, v19);
    end;

    return table.concat(v12, "  ");
end;

local function UpdateRaycastFilter() -- Line: 65
    -- upvalues: CollectionService (copy), RaycastParams_new_ret (copy)
    local v20 = {};

    for _, v in CollectionService:GetTagged("BeeHover") do
        table.insert(v20, v);
    end;

    for _, v in CollectionService:GetTagged("BeeNestHover") do
        table.insert(v20, v);
    end;

    RaycastParams_new_ret.FilterDescendantsInstances = v20;
end;

local function FindHoverHitbox(p21: userdata) -- Line: 79
    -- upvalues: CollectionService (copy)
    while p21 do
        if CollectionService:HasTag(p21, "BeeNestHover") and p21:IsA("BasePart") then
            return p21, "Nest";
        end;

        if CollectionService:HasTag(p21, "BeeHover") and p21:IsA("BasePart") then
            return p21, "Bee";
        end;

        p21 = p21.Parent;
    end;

    return nil, nil;
end;

local function GetHive() -- Line: 97
    -- upvalues: u7 (ref), GetFarmAsync (copy), LocalPlayer (copy)
    if u7 and u7.Parent then
        return u7;
    end;

    local v22 = GetFarmAsync(LocalPlayer);

    if not v22 then
        return nil;
    end;

    local CurrentExpansion = v22:FindFirstChild("CurrentExpansion");

    if CurrentExpansion then
        CurrentExpansion = CurrentExpansion:FindFirstChild("Custom");
    end;

    if CurrentExpansion then
        CurrentExpansion = CurrentExpansion:FindFirstChild("Hive");
    end;

    u7 = CurrentExpansion;

    return CurrentExpansion;
end;

local function GetHiveSlotTarget(p23) -- Line: 116
    -- upvalues: u7 (ref), GetFarmAsync (copy), LocalPlayer (copy)
    local v24 = tonumber(p23);

    if not v24 then
        return nil;
    end;

    local v25;

    if u7 and u7.Parent then
        v25 = u7;
    else
        local v26 = GetFarmAsync(LocalPlayer);

        if v26 then
            v25 = v26:FindFirstChild("CurrentExpansion");

            if v25 then
                v25 = v25:FindFirstChild("Custom");
            end;

            if v25 then
                v25 = v25:FindFirstChild("Hive");
            end;

            u7 = v25;
        else
            v25 = nil;
        end;
    end;

    if not v25 then
        return nil;
    end;

    local v27 = v25:FindFirstChild((tostring(v24)));

    if not v27 then
        return nil;
    end;

    if v27:IsA("Model") or v27:IsA("BasePart") then
        return v27;
    end;

    for _, child in v27:GetChildren() do
        if child:IsA("Model") or child:IsA("BasePart") then
            return child;
        end;
    end;

    return nil;
end;

local function IsPointInsidePart(p28: userdata, p29: vector) -- Line: 145
    local v30 = p28.CFrame:PointToObjectSpace(p29);
    local v31 = p28.Size * 0.5;
    local v32;

    if math.abs(v30.X) <= v31.X + 0.75 and math.abs(v30.Y) <= v31.Y + 0.75 then
        v32 = math.abs(v30.Z) <= v31.Z + 0.75;
    else
        v32 = false;
    end;

    return v32;
end;

local function GetNestPartForBee(p33: userdata) -- Line: 155
    -- upvalues: CollectionService (copy)
    local v34 = p33:GetAttribute("Slot") or p33:GetAttribute("BeeSlot");

    for _, v in CollectionService:GetTagged("BeeNestHover") do
        if v:IsA("BasePart") and (v34 ~= nil and v:GetAttribute("Slot") == v34) then
            return v;
        end;
    end;

    return nil;
end;

local function IsBeeNesting(p35: userdata) -- Line: 171
    -- upvalues: GetNestPartForBee (copy), IsPointInsidePart (copy)
    if p35:GetAttribute("IsNesting") == true then
        return true;
    end;

    local v36 = p35:GetAttribute("State") or p35:GetAttribute("BeeState");
    local string_lower_ret = string.lower((tostring(v36 or "")));

    if string.find(string_lower_ret, "nest", 1, true) or string.find(string_lower_ret, "hive", 1, true) then
        return true;
    end;

    local v37 = GetNestPartForBee(p35);

    return v37 and IsPointInsidePart(v37, p35.Position) and true or false;
end;

local function MakeLabel(p38: userdata, p39: string, p40: number, p41, p42, p43: number) -- Line: 191
    local TextLabel = Instance.new("TextLabel");
    TextLabel.Name = p39;
    TextLabel.Size = UDim2.new(0, 0, 0, 0);
    TextLabel.AutomaticSize = Enum.AutomaticSize.XY;
    TextLabel.BackgroundTransparency = 1;
    TextLabel.TextColor3 = p41;
    TextLabel.Text = "";
    TextLabel.TextSize = p43;
    TextLabel.FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Bold);
    TextLabel.TextXAlignment = Enum.TextXAlignment.Center;
    TextLabel.RichText = true;
    TextLabel.LayoutOrder = p40;
    TextLabel.Parent = p38;
    local UIStroke = Instance.new("UIStroke");
    UIStroke.Color = p42 or Color3.fromRGB(0, 0, 0);
    UIStroke.Thickness = 1.5;
    UIStroke.Parent = TextLabel;

    return TextLabel;
end;

local function CreateUI() -- Line: 214
    -- upvalues: PlayerGui (copy), MakeLabel (copy), UserInputService (copy)
    local ScreenGui = Instance.new("ScreenGui");
    ScreenGui.Name = "BeeHoverUI";
    ScreenGui.ResetOnSpawn = false;
    ScreenGui.IgnoreGuiInset = true;
    ScreenGui.DisplayOrder = -1;
    ScreenGui.Parent = PlayerGui;
    local Frame = Instance.new("Frame");
    Frame.Name = "BeeInfo";
    Frame.Size = UDim2.new(0, 0, 0, 0);
    Frame.AutomaticSize = Enum.AutomaticSize.XY;
    Frame.BackgroundTransparency = 1;
    Frame.Visible = false;
    Frame.AnchorPoint = Vector2.new(0.5, 1);
    Frame.Parent = ScreenGui;
    local UIListLayout = Instance.new("UIListLayout");
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder;
    UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center;
    UIListLayout.Padding = UDim.new(0, 2);
    UIListLayout.Parent = Frame;
    MakeLabel(Frame, "BeeName", 1, Color3.fromRGB(255, 255, 255), nil, 24);
    MakeLabel(Frame, "Rarity", 2, Color3.fromRGB(255, 255, 255), nil, 18);
    local v44 = MakeLabel(Frame, "Description", 3, Color3.fromRGB(255, 255, 255), nil, 15);
    v44.Size = UDim2.fromOffset(280, 0);
    v44.AutomaticSize = Enum.AutomaticSize.Y;
    v44.TextWrapped = true;
    MakeLabel(Frame, "StatSpeed", 4, Color3.fromRGB(85, 255, 0), nil, 15);
    MakeLabel(Frame, "StatQuality", 5, Color3.fromRGB(85, 255, 0), nil, 15);
    MakeLabel(Frame, "StatRate", 6, Color3.fromRGB(85, 255, 0), nil, 15);
    MakeLabel(Frame, "EnchantDivider", 7, Color3.fromRGB(150, 150, 150), nil, 12).Text = "─────────";
    MakeLabel(Frame, "EnchantName", 8, Color3.fromRGB(255, 255, 255), nil, 17);
    local v45 = MakeLabel(Frame, "EnchantBuffs", 9, Color3.fromRGB(255, 196, 84), nil, 14);
    v45.Size = UDim2.fromOffset(280, 0);
    v45.AutomaticSize = Enum.AutomaticSize.Y;
    v45.TextWrapped = true;
    local UIScale = Instance.new("UIScale");
    UIScale.Parent = Frame;

    local function UpdateScale() -- Line: 262
        -- upvalues: UserInputService (ref), UIScale (copy)
        UIScale.Scale = (workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize.Y or 1080) / 1080 * 2.5 * (UserInputService.PreferredInput == Enum.PreferredInput.Touch and 1.3 or 1);
    end;

    UIScale.Scale = (workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize.Y or 1080) / 1080 * 2.5 * (UserInputService.PreferredInput == Enum.PreferredInput.Touch and 1.3 or 1);
    UserInputService:GetPropertyChangedSignal("PreferredInput"):Connect(UpdateScale);

    if workspace.CurrentCamera then
        workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(UpdateScale);
    end;

    return ScreenGui;
end;

local function SetFullInfoVisible(p46: userdata, p47: boolean) -- Line: 278
    p46.Rarity.Visible = p47;
    p46.Description.Visible = p47;
    p46.StatSpeed.Visible = p47;
    p46.StatQuality.Visible = p47;
    p46.StatRate.Visible = p47;
end;

local function GetHighlightTarget(p48: userdata, p49: string, p50: boolean) -- Line: 286
    -- upvalues: GetHiveSlotTarget (copy), GetNestPartForBee (copy)
    if p49 == "Nest" then
        return GetHiveSlotTarget(p48:GetAttribute("Slot")) or p48, true;
    end;

    if p50 then
        local v51 = GetHiveSlotTarget(p48:GetAttribute("Slot") or p48:GetAttribute("BeeSlot"));

        if v51 then
            return v51, true;
        end;

        local v52 = GetNestPartForBee(p48);

        if v52 then
            return v52, true;
        end;
    end;

    return p48:FindFirstAncestorOfClass("Model") or p48, false;
end;

local function ShowHighlight(p53: userdata, p54: boolean) -- Line: 307
    -- upvalues: u3 (ref), u5 (ref), u6 (ref)
    if u3 then
        u3:Destroy();
        u3 = nil;
    end;

    local Highlight = Instance.new("Highlight");
    Highlight.FillColor = Color3.fromRGB(255, 220, 60);
    Highlight.OutlineColor = Color3.fromRGB(255, 220, 60);
    Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop;

    if p54 then
        Highlight.FillTransparency = 0.82;
        Highlight.OutlineTransparency = 0;
    else
        Highlight.FillTransparency = 1;
        Highlight.OutlineTransparency = 0;
    end;

    Highlight.Adornee = p53;
    Highlight.Parent = p53;
    u3 = Highlight;
    u5 = p53;
    u6 = p54;
end;

local function HideHighlight() -- Line: 334
    -- upvalues: u3 (ref), u5 (ref), u6 (ref)
    if u3 then
        u3:Destroy();
        u3 = nil;
    end;

    u5 = nil;
    u6 = false;
end;

function v1.Start(p55) -- Line: 344
    -- upvalues: CreateUI (copy), CollectionService (copy), UpdateRaycastFilter (copy), RunService (copy), u2 (ref), workspace_CurrentCamera (ref), UserInputService (copy), RaycastParams_new_ret (copy), FindHoverHitbox (copy), u4 (ref), u3 (ref), u5 (ref), u6 (ref), BeeRegistry (copy), u8 (copy), IsBeeNesting (copy), BeeEnchantmentRegistry (copy), FormatEnchantBuffs (copy), GetHighlightTarget (copy), ShowHighlight (copy)
    local u56 = CreateUI();
    local BeeInfo = u56.BeeInfo;
    CollectionService:GetInstanceAddedSignal("BeeHover"):Connect(UpdateRaycastFilter);
    CollectionService:GetInstanceRemovedSignal("BeeHover"):Connect(UpdateRaycastFilter);
    CollectionService:GetInstanceAddedSignal("BeeNestHover"):Connect(UpdateRaycastFilter);
    CollectionService:GetInstanceRemovedSignal("BeeNestHover"):Connect(UpdateRaycastFilter);
    UpdateRaycastFilter();
    local u57 = 0;
    RunService.PostSimulation:Connect(function(p58) -- Line: 358
        -- upvalues: u2 (ref), workspace_CurrentCamera (ref), BeeInfo (copy), u57 (ref), UserInputService (ref), RaycastParams_new_ret (ref), FindHoverHitbox (ref), u4 (ref), u3 (ref), u5 (ref), u6 (ref), BeeRegistry (ref), u8 (ref), IsBeeNesting (ref), u56 (copy), BeeEnchantmentRegistry (ref), FormatEnchantBuffs (ref), GetHighlightTarget (ref), ShowHighlight (ref)
        workspace_CurrentCamera = u2 and (u2.Parent and workspace.CurrentCamera);

        if workspace_CurrentCamera then
            local v59, v60 = workspace_CurrentCamera:WorldToViewportPoint(u2.Position + Vector3.new(0, u2.Size.Y * 0.5 + 1.5, 0));

            if v60 then
                BeeInfo.Position = UDim2.fromOffset(v59.X, v59.Y);
            end;
        end;

        u57 = u57 + p58;

        if u57 < 0.1 then
            return;
        end;

        u57 = 0;
        workspace_CurrentCamera = workspace.CurrentCamera;

        if not workspace_CurrentCamera then
            return;
        end;

        local MouseLocation = UserInputService:GetMouseLocation();
        local v61 = workspace_CurrentCamera:ViewportPointToRay(MouseLocation.X, MouseLocation.Y);
        local v62 = workspace:Raycast(v61.Origin, v61.Direction * 100, RaycastParams_new_ret);
        local v63, v64;

        if v62 and v62.Instance then
            v63, v64 = FindHoverHitbox(v62.Instance);
        else
            v63 = nil;
            v64 = nil;
        end;

        if not (v63 and v64) then
            if u2 then
                u2 = nil;
                u4 = nil;
                BeeInfo.Visible = false;

                if u3 then
                    u3:Destroy();
                    u3 = nil;
                end;

                u5 = nil;
                u6 = false;
            end;

            return;
        end;

        local v65 = v63 ~= u2 and true or v64 ~= u4;
        u2 = v63;
        u4 = v64;
        local Attribute = v63:GetAttribute("BeeName");

        if Attribute then
            Attribute = BeeRegistry[Attribute];
        end;

        if not Attribute then
            BeeInfo.Visible = false;

            if u3 then
                u3:Destroy();
                u3 = nil;
            end;

            u5 = nil;
            u6 = false;

            return;
        end;

        local v66 = Attribute.Rarity or "Common";
        local v67 = u8[v66 or "Common"] or Color3.fromRGB(255, 255, 255);
        local v68 = v64 == "Nest" and true or IsBeeNesting(v63);
        local v69 = v63:GetAttribute("IsIllusion") == true;
        local v70;

        if v64 == "Bee" then
            v70 = v63:GetAttribute("Health") <= 0;
        else
            v70 = false;
        end;

        u56.DisplayOrder = -1;
        local BeeName = BeeInfo.BeeName;
        local v71;

        if v69 then
            v71 = `Illusion {Attribute.DisplayName}`;
        else
            v71 = Attribute.DisplayName;
        end;

        BeeName.Text = v71;
        BeeInfo.BeeName.TextColor3 = v67;
        local v72 = BeeInfo;
        local v73;

        if v68 then
            v73 = not v70;
        else
            v73 = v68;
        end;

        v72.Rarity.Visible = v73;
        v72.Description.Visible = v73;
        v72.StatSpeed.Visible = v73;
        v72.StatQuality.Visible = v73;
        v72.StatRate.Visible = v73;

        if v68 and not v70 then
            local Stats = Attribute.Stats;
            local v74 = v63:GetAttribute("Speed") or Stats.Speed;
            local v75 = v63:GetAttribute("PollinationQuality") or Stats.PollinationQuality;
            local v76 = v63:GetAttribute("PollinationRate") or Stats.PollinationRate;
            local v77 = Attribute.Description or "";
            u56.DisplayOrder = 1;
            BeeInfo.Rarity.Text = v66;
            BeeInfo.Rarity.TextColor3 = v67;
            BeeInfo.Description.Text = v77;
            BeeInfo.StatSpeed.Text = `Speed: {v74}`;
            BeeInfo.StatQuality.Text = `Quality: {v75}`;
            BeeInfo.StatRate.Text = `Rate: {v76}`;
        end;

        local Attribute2 = v63:GetAttribute("Enchantment");

        if Attribute2 then
            Attribute2 = BeeEnchantmentRegistry.Entries[Attribute2];
        end;

        local v78 = v68 and not v70 and Attribute2 ~= nil;
        BeeInfo.EnchantDivider.Visible = v78;
        BeeInfo.EnchantName.Visible = v78;
        BeeInfo.EnchantBuffs.Visible = v78;

        if v78 then
            BeeInfo.EnchantName.Text = Attribute2.DisplayName;
            BeeInfo.EnchantName.TextColor3 = Attribute2.NameColor or (Attribute2.Color or Color3.fromRGB(255, 255, 255));
            BeeInfo.EnchantBuffs.Text = FormatEnchantBuffs(Attribute2.Modifiers);
        end;

        BeeInfo.Visible = true;
        local v79, v80 = GetHighlightTarget(v63, v64, v68);

        if v65 or (v79 ~= u5 or v80 ~= u6) then
            ShowHighlight(v79, v80);
        end;
    end);
end;

v1:Start();

return v1;