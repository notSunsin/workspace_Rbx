-- Decompiled with Potassium's decompiler.

local CollectionService = game:GetService("CollectionService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local HttpService = game:GetService("HttpService");
local HarvestReaperConfigData = require(ReplicatedStorage.Data.Events.HalloweenEvent.HarvestReaperConfigData);
local ItemImageFinder = require(ReplicatedStorage.Modules.ItemImageFinder);
local u1 = RunService:IsServer();
local u2 = RunService:IsClient();
local u3 = {};
u3.__index = u3;

function u3.new(p4: userdata, p5: table, p6) -- Line: 68
    -- upvalues: u3 (copy), u2 (copy)
    local u7 = setmetatable({}, u3);
    u7.Instance = p4;
    u7.Connections = {};
    u7.Completed = false;
    u7.RequiredPlant = p5;
    u7.StartCFrame = p6;
    u7.EffectOffset = Vector3.new(0, 0, 0);
    u7.ID = p4:GetAttribute("ID") or -1;
    u7.DebounceBobbing = false;
    u7.BobbingPhaseOffset = Random.new(u7.ID):NextNumber(0, 100);
    u7:SetupComponents();

    if u2 then
        u7:StartBobbingAnimation();
    end;

    table.insert(u7.Connections, u7.Instance.Destroying:Connect(function() -- Line: 90
        -- upvalues: u7 (copy)
        u7:Destroy();
    end));

    return u7;
end;

function u3.fromAttributes(u8: userdata) -- Line: 98
    -- upvalues: HttpService (copy), u3 (copy), u2 (copy)
    local Attribute = u8:GetAttribute("RitualPoint_ID");
    local Attribute2 = u8:GetAttribute("RitualPoint_Completed");
    local Attribute3 = u8:GetAttribute("RitualPoint_PlantName");
    local Attribute4 = u8:GetAttribute("RitualPoint_Mutations");
    local Attribute5 = u8:GetAttribute("RitualPoint_StartX");
    local Attribute6 = u8:GetAttribute("RitualPoint_StartY");
    local Attribute7 = u8:GetAttribute("RitualPoint_StartZ");
    local Attribute8 = u8:GetAttribute("RitualPoint_StartRotY");
    local Attribute9 = u8:GetAttribute("RitualPoint_PhaseOffset");
    local Attribute10 = u8:GetAttribute("RitualPoint_DebounceBobbing");

    if not (Attribute and Attribute5) then
        warn((`Cannot create RitualPoint from {u8.Name} - missing attributes`));

        return nil;
    end;

    local v9 = {};
    local v10;

    if Attribute4 then
        local v11;
        v11, v10 = pcall(function() -- Line: 120
            -- upvalues: HttpService (ref), Attribute4 (copy)
            return HttpService:JSONDecode(Attribute4);
        end);

        if not v11 then
            v10 = v9;
        end;
    else
        v10 = v9;
    end;

    local u12 = setmetatable({}, u3);
    u12.Instance = u8;
    u12.Connections = {};
    u12.Completed = Attribute2 or false;
    u12.RequiredPlant = {
        PlantName = Attribute3 or "",
        Mutations = v10
    };
    u12.StartCFrame = CFrame.new(Attribute5, Attribute6, Attribute7) * CFrame.Angles(0, Attribute8, 0);
    u12.EffectOffset = Vector3.new(0, 0, 0);
    u12.ID = Attribute;
    u12.BobbingPhaseOffset = Attribute9 or 0;
    u12.DebounceBobbing = Attribute10;
    u12:SetupComponents();

    if u2 then
        u12:StartBobbingAnimation();
        local Connections = u12.Connections;
        local AttributeChangedSignal = u8:GetAttributeChangedSignal("RitualPoint_Completed");
        table.insert(Connections, AttributeChangedSignal:Connect(function() -- Line: 149
            -- upvalues: u12 (copy)
            u12:OnCompletedChanged();
        end));
        local Connections2 = u12.Connections;
        local AttributeChangedSignal2 = u8:GetAttributeChangedSignal("RitualPoint_DebounceBobbing");
        table.insert(Connections2, AttributeChangedSignal2:Connect(function() -- Line: 153
            -- upvalues: u12 (copy), u8 (copy)
            u12.DebounceBobbing = u8:GetAttribute("RitualPoint_DebounceBobbing");
        end));
    end;

    table.insert(u12.Connections, u12.Instance.Destroying:Connect(function() -- Line: 159
        -- upvalues: u12 (copy)
        u12:Destroy();
    end));

    return u12;
end;

function u3.SetupComponents(p13) -- Line: 167
    local Instance2 = p13.Instance;
    local BillboardUI = Instance2:WaitForChild("BillboardUI");

    if not BillboardUI then
        return;
    end;

    local BillboardGui = BillboardUI:WaitForChild("BillboardGui");
    local Frame = BillboardGui:WaitForChild("Frame");
    local ImageLabel = Frame:WaitForChild("ImageLabel");
    local Name = Frame:WaitForChild("Name");
    local ProximityPrompt = Instance2:WaitForChild("Root"):WaitForChild("ProximityPrompt");
    local Mutations = Frame:WaitForChild("Mutations");
    local FXAttachment = Instance2:FindFirstChild("RitualBowl"):FindFirstChild("FXAttachment");
    local FireRed = FXAttachment:FindFirstChild("FireRed");
    local FireBlue = FXAttachment:FindFirstChild("FireBlue");
    local PointLight = FXAttachment:FindFirstChild("PointLight");
    local Smoke = FXAttachment:FindFirstChild("Smoke");
    local ParticleEmitter = FXAttachment:FindFirstChild("SprayEmitter"):FindFirstChild("ParticleEmitter");
    p13.Components = {
        UIRoot = BillboardUI,
        Billboard = BillboardGui,
        RootFrame = Frame,
        ImageLabel = ImageLabel,
        NameLabel = Name,
        ProxPrompt = ProximityPrompt,
        MutationsLabel = Mutations,
        FireRedFX = FireRed,
        FireBlueFX = FireBlue,
        SmokeFX = Smoke,
        PointLight = PointLight,
        ExitDetection = Instance2:FindFirstChild("Root"):FindFirstChild("Exit_Detection"),
        SprayEmitter = ParticleEmitter,
        SubmitSound = FXAttachment:FindFirstChild("SubmitSound")
    };
end;

function u3.StartBobbingAnimation(u14) -- Line: 210
    -- upvalues: u2 (copy), RunService (copy)
    if not u2 then
        return;
    end;

    if u14.BobbingConnection then
        return;
    end;

    u14.BobbingConnection = RunService.Heartbeat:Connect(function(p15: number) -- Line: 214
        -- upvalues: u14 (copy)
        if not (u14.Instance and u14.Instance.Parent) then
            u14:StopBobbingAnimation();

            return;
        end;

        if u14.DebounceBobbing then
            return;
        end;

        local v16 = u14:CalculateBobbingCFrame(u14.StartCFrame, os.clock()) + u14.EffectOffset;
        local v17 = u14.Instance:GetPivot():Lerp(v16, 0.3);
        u14.Instance:PivotTo(v17);
    end);
    table.insert(u14.Connections, u14.BobbingConnection);
end;

function u3.StopBobbingAnimation(p18) -- Line: 233
    if p18.BobbingConnection then
        p18.BobbingConnection:Disconnect();
        p18.BobbingConnection = nil;
    end;
end;

function u3.CalculateBobbingCFrame(p19: table, p20, p21: number?) -- Line: 241
    local v22 = p21 or os.clock();
    local v23 = p20 or p19.StartCFrame;
    local v24 = (math.sin(v22 * 2 + p19.BobbingPhaseOffset) + 1) * 0.5;
    local math_lerp_ret = math.lerp(-0.4, 0.4, v24);

    return v23 + Vector3.new(0, math_lerp_ret, 0);
end;

function u3.TweenTo(u25: table, p26: userdata, p27) -- Line: 252
    -- upvalues: TweenService (copy)
    local CFrameValue = Instance.new("CFrameValue");
    CFrameValue.Value = u25.Instance:GetPivot();
    CFrameValue:GetPropertyChangedSignal("Value"):Connect(function() -- Line: 256
        -- upvalues: u25 (copy), CFrameValue (copy)
        u25.Instance:PivotTo(CFrameValue.Value);
    end);
    local v28 = TweenService:Create(CFrameValue, p26, {
        Value = p27
    });
    v28:Play();
    v28.Completed:Connect(function() -- Line: 263
        -- upvalues: CFrameValue (copy)
        CFrameValue:Destroy();
    end);

    return v28;
end;

function u3.TweenScaleTo(u29: table, p30: userdata, p31: number) -- Line: 271
    -- upvalues: TweenService (copy)
    local NumberValue = Instance.new("NumberValue");
    NumberValue.Value = u29.Instance:GetScale();
    NumberValue:GetPropertyChangedSignal("Value"):Connect(function() -- Line: 275
        -- upvalues: u29 (copy), NumberValue (copy)
        u29.Instance:ScaleTo(NumberValue.Value);
    end);
    local v32 = TweenService:Create(NumberValue, p30, {
        Value = p31
    });
    v32:Play();
    v32.Completed:Connect(function() -- Line: 282
        -- upvalues: NumberValue (copy)
        NumberValue:Destroy();
    end);

    return v32;
end;

function u3.UpdateRitualPointVisuals(p33) -- Line: 290
    -- upvalues: ItemImageFinder (copy), CollectionService (copy), HarvestReaperConfigData (copy)
    if not p33.Components then
        return;
    end;

    local v34 = p33.RequiredPlant.PlantName or "";
    p33.Components.NameLabel.Text = v34;
    local v35 = "";

    if p33.RequiredPlant.Mutations then
        for i, v in p33.RequiredPlant.Mutations do
            v35 = v35 .. v .. (i == #p33.RequiredPlant.Mutations and "" or ", ");
        end;
    end;

    if string.len(v35) > 0 then
        p33.Components.MutationsLabel.Text = `[{v35}]`;
        p33.Components.MutationsLabel.Visible = true;
    else
        p33.Components.MutationsLabel.Visible = false;
    end;

    p33.Components.ImageLabel.Image = ItemImageFinder(v34, "Holdable");
    local v36 = CollectionService:GetTagged("HarvestReaperRitualCenter")[1];

    if v36 then
        local Position = p33.Instance:GetPivot().Position;
        local Unit = (v36:GetPivot().Position - Position).Unit;
        p33.Components.SprayEmitter.Acceleration = Unit * HarvestReaperConfigData.CIRCLE_RADIUS * 2;
    end;

    if p33.Completed then
        p33.Components.FireRedFX.Enabled = false;
        p33.Components.FireBlueFX.Enabled = true;
        p33.Components.Billboard.Enabled = false;
        p33.Components.ProxPrompt.Enabled = false;
        p33.Components.PointLight.Color = Color3.fromRGB(7, 156, 255);

        return;
    end;

    p33.Components.FireRedFX.Enabled = true;
    p33.Components.FireBlueFX.Enabled = false;
    p33.Components.Billboard.Enabled = true;
    p33.Components.ProxPrompt.Enabled = true;
    p33.Components.PointLight.Color = Color3.fromRGB(255, 68, 6);
end;

function u3.UpdateAttributes(p37) -- Line: 336
    -- upvalues: u1 (copy), HttpService (copy), CollectionService (copy), HarvestReaperConfigData (copy)
    if not u1 then
        return;
    end;

    local Instance2 = p37.Instance;
    Instance2:SetAttribute("RitualPoint_ID", p37.ID);
    Instance2:SetAttribute("RitualPoint_Completed", p37.Completed);
    Instance2:SetAttribute("RitualPoint_PlantName", p37.RequiredPlant.PlantName or "");
    Instance2:SetAttribute("RitualPoint_Mutations", HttpService:JSONEncode(p37.RequiredPlant.Mutations or {}));
    local StartCFrame = p37.StartCFrame;
    Instance2:SetAttribute("RitualPoint_StartX", StartCFrame.X);
    Instance2:SetAttribute("RitualPoint_StartY", StartCFrame.Y);
    Instance2:SetAttribute("RitualPoint_StartZ", StartCFrame.Z);
    local _, v38, _ = StartCFrame:ToOrientation();
    Instance2:SetAttribute("RitualPoint_StartRotY", v38);
    Instance2:SetAttribute("RitualPoint_PhaseOffset", p37.BobbingPhaseOffset);
    Instance2:SetAttribute("RitualPoint_DebounceBobbing", p37.DebounceBobbing);
    local v39 = CollectionService:GetTagged("HarvestReaperRitualCenter")[1];

    if v39 then
        local Position = v39:GetPivot().Position;
        Instance2:SetAttribute("RitualPoint_CenterX", Position.X);
        Instance2:SetAttribute("RitualPoint_CenterY", Position.Y);
        Instance2:SetAttribute("RitualPoint_CenterZ", Position.Z);
    end;

    Instance2:SetAttribute("RitualPoint_CircleRadius", HarvestReaperConfigData.CIRCLE_RADIUS);
end;

function u3.OnCompletedChanged(p40) -- Line: 367
    if p40.Instance:GetAttribute("RitualPoint_Completed") and not p40.Completed then
        p40.Completed = true;
        p40:UpdateRitualPointVisuals();
        p40:PlayDropAnimation();

        if p40.Components then
            p40.Components.SubmitSound:Play();
        end;
    end;
end;

function u3.PlayDropAnimation(u41) -- Line: 382
    -- upvalues: u2 (copy), TweenService (copy)
    if not u2 then
        return;
    end;

    task.spawn(function() -- Line: 385
        -- upvalues: u41 (copy), TweenService (ref)
        local Vector3Value = Instance.new("Vector3Value");
        Vector3Value.Value = u41.EffectOffset;
        Vector3Value:GetPropertyChangedSignal("Value"):Connect(function() -- Line: 393
            -- upvalues: u41 (ref), Vector3Value (copy)
            u41.EffectOffset = Vector3Value.Value;
        end);
        local v42 = TweenService:Create(Vector3Value, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Value = Vector3.new(0, -1, 0)
        });
        v42:Play();
        v42.Completed:Wait();
        local v43 = TweenService:Create(Vector3Value, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Value = Vector3.new(0, 0, 0)
        });
        v43:Play();
        v43.Completed:Wait();
        Vector3Value:Destroy();
    end);
end;

function u3.MarkCompleted(p44) -- Line: 412
    p44.Completed = true;
    p44:UpdateAttributes();
    p44:UpdateRitualPointVisuals();
end;

function u3.Destroy(p45) -- Line: 418
    p45:StopBobbingAnimation();

    for _, v in p45.Connections do
        v:Disconnect();
    end;

    p45.Connections = {};

    if p45.Instance then
        p45.Instance:Destroy();
    end;
end;

return u3;