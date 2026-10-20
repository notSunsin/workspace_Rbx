-- Decompiled with Potassium's decompiler.

local CollectionService = game:GetService("CollectionService");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local v1 = {};
local u2 = {};

local function CreateProgressGui(p3: userdata) -- Line: 10
    local PrimaryPart = p3.PrimaryPart;

    if not PrimaryPart then
        return nil;
    end;

    local BoundingBox, v4 = p3:GetBoundingBox();
    local math_max_ret = math.max(4, BoundingBox.Position.Y + v4.Y * 0.5 - PrimaryPart.Position.Y + 2);
    local BillboardGui = Instance.new("BillboardGui");
    BillboardGui.Name = "PollinateProgress";
    BillboardGui.Size = UDim2.fromOffset(60, 20);
    BillboardGui.StudsOffset = Vector3.new(0, math_max_ret, 0);
    BillboardGui.AlwaysOnTop = true;
    BillboardGui.MaxDistance = 200;
    BillboardGui.Adornee = PrimaryPart;
    BillboardGui.Parent = PrimaryPart;
    local UIListLayout = Instance.new("UIListLayout");
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder;
    UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center;
    UIListLayout.Padding = UDim.new(0, 2);
    UIListLayout.Parent = BillboardGui;
    local Frame = Instance.new("Frame");
    Frame.Name = "Background";
    Frame.Size = UDim2.new(1, 0, 0, 6);
    Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30);
    Frame.BackgroundTransparency = 0.5;
    Frame.BorderSizePixel = 0;
    Frame.LayoutOrder = 1;
    Frame.Parent = BillboardGui;
    local UICorner = Instance.new("UICorner");
    UICorner.CornerRadius = UDim.new(1, 0);
    UICorner.Parent = Frame;
    local UIStroke = Instance.new("UIStroke");
    UIStroke.Color = Color3.fromRGB(0, 0, 0);
    UIStroke.Thickness = 1.5;
    UIStroke.Transparency = 0.3;
    UIStroke.Parent = Frame;
    local Frame2 = Instance.new("Frame");
    Frame2.Name = "Fill";
    Frame2.Size = UDim2.fromScale(0, 1);
    Frame2.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
    Frame2.BorderSizePixel = 0;
    Frame2.Parent = Frame;
    local UICorner2 = Instance.new("UICorner");
    UICorner2.CornerRadius = UDim.new(1, 0);
    UICorner2.Parent = Frame2;
    local UIGradient = Instance.new("UIGradient");
    UIGradient.Color = ColorSequence.new(Color3.fromRGB(255, 180, 0), Color3.fromRGB(255, 240, 80));
    UIGradient.Parent = Frame2;
    local TextLabel = Instance.new("TextLabel");
    TextLabel.Name = "Timer";
    TextLabel.Size = UDim2.new(1, 0, 0, 12);
    TextLabel.BackgroundTransparency = 1;
    TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255);
    TextLabel.TextSize = 12;
    TextLabel.FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Bold);
    TextLabel.LayoutOrder = 2;
    TextLabel.Parent = BillboardGui;
    local UIStroke2 = Instance.new("UIStroke");
    UIStroke2.Color = Color3.fromRGB(0, 0, 0);
    UIStroke2.Thickness = 0.75;
    UIStroke2.Parent = TextLabel;

    return BillboardGui;
end;

local TweenInfo_new_ret = TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
local TweenInfo_new_ret2 = TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.In);

local function OnPlantAdded(p5: userdata) -- Line: 88
    -- upvalues: u2 (copy), CreateProgressGui (copy)
    if u2[p5] then
        return;
    end;

    local v6 = CreateProgressGui(p5);

    if v6 then
        u2[p5] = v6;
    end;
end;

local function OnPlantRemoved(p7: userdata) -- Line: 96
    -- upvalues: u2 (copy), TweenService (copy), TweenInfo_new_ret (copy), TweenInfo_new_ret2 (copy)
    local v8 = u2[p7];

    if v8 then
        v8:Destroy();
        u2[p7] = nil;
    end;

    if not p7.Parent then
        return;
    end;

    local Highlight = Instance.new("Highlight");
    Highlight.FillTransparency = 1;
    Highlight.OutlineColor = Color3.fromRGB(255, 220, 60);
    Highlight.OutlineTransparency = 1;
    Highlight.Adornee = p7;
    Highlight.Parent = p7;
    TweenService:Create(Highlight, TweenInfo_new_ret, {
        OutlineTransparency = 0
    }):Play();
    task.delay(2, function() -- Line: 114
        -- upvalues: Highlight (copy), TweenService (ref), TweenInfo_new_ret2 (ref)
        if not Highlight.Parent then
            return;
        end;

        local v9 = TweenService:Create(Highlight, TweenInfo_new_ret2, {
            OutlineTransparency = 1
        });
        v9:Play();
        v9.Completed:Once(function() -- Line: 118
            -- upvalues: Highlight (ref)
            Highlight:Destroy();
        end);
    end);
end;

function v1.Start(p10) -- Line: 124
    -- upvalues: CollectionService (copy), OnPlantAdded (copy), OnPlantRemoved (copy), u2 (copy), CreateProgressGui (copy), RunService (copy)
    CollectionService:GetInstanceAddedSignal("PollinatingPlant"):Connect(OnPlantAdded);
    CollectionService:GetInstanceRemovedSignal("PollinatingPlant"):Connect(OnPlantRemoved);

    for _, v in CollectionService:GetTagged("PollinatingPlant") do
        if not u2[v] then
            local v11 = CreateProgressGui(v);

            if v11 then
                u2[v] = v11;
            end;
        end;
    end;

    RunService.RenderStepped:Connect(function() -- Line: 132
        -- upvalues: u2 (ref)
        for i, v in u2 do
            local v12 = (i:GetAttribute("PollinateProgress") or 0) / (i:GetAttribute("PollinateThreshold") or 1);
            local math_clamp_ret = math.clamp(v12, 0, 1);
            v.Background.Fill.Size = UDim2.fromScale(math_clamp_ret, 1);
            local v13 = i:GetAttribute("PollinateTimeRemaining") or 0;
            v.Timer.Text = `{v13}s`;
        end;
    end);
end;

v1:Start();

return v1;