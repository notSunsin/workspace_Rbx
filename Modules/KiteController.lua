-- Decompiled with Potassium's decompiler.

local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local Debris = game:GetService("Debris");
local GameEvents = game:GetService("ReplicatedStorage").GameEvents;
local CreateKiteClient = GameEvents:WaitForChild("CreateKiteClient");
local RemoveKiteClient = GameEvents:WaitForChild("RemoveKiteClient");
local u1 = {};

local function DestroyKite(p2: userdata) -- Line: 26
    -- upvalues: u1 (copy)
    local v3 = u1[p2];

    if v3 then
        if v3.KiteModel then
            v3.KiteModel:Destroy();
        end;

        if v3.HandAttach then
            v3.HandAttach:Destroy();
        end;

        if v3.Beam then
            v3.Beam:Destroy();
        end;

        if v3.KiteAttach then
            v3.KiteAttach:Destroy();
        end;
    end;

    u1[p2] = nil;
end;

GameEvents:WaitForChild("UseKiteClient").OnClientEvent:Connect(function(p4: userdata) -- Line: 40
    -- upvalues: u1 (copy), Debris (copy), TweenService (copy), RunService (copy)
    if not (p4 and p4:IsA("Player")) then
        return;
    end;

    local v5 = u1[p4];

    if not (v5 and v5.KiteModel) then
        return;
    end;

    local KiteModel = v5.KiteModel;

    if v5.Beam then
        v5.Beam:Destroy();
    end;

    if v5.HandAttach then
        v5.HandAttach:Destroy();
    end;

    if v5.KiteAttach then
        v5.KiteAttach:Destroy();
    end;

    u1[p4] = nil;

    if not KiteModel.PrimaryPart then
        KiteModel:Destroy();

        return;
    end;

    Debris:AddItem(KiteModel, 5);
    TweenService:Create(KiteModel.PrimaryPart, TweenInfo.new(5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
        CFrame = KiteModel.PrimaryPart.CFrame * CFrame.new(0, 100, 0)
    }):Play();
    task.spawn(function() -- Line: 72
        -- upvalues: KiteModel (copy), RunService (ref)
        local os_clock_ret = os.clock();

        while KiteModel.Parent and os.clock() - os_clock_ret < 5 do
            local Pivot = KiteModel:GetPivot();
            local CFrame_Angles = CFrame.Angles;
            local v6 = os.clock() * 2;
            local v7 = math.sin(v6) * 0.05;
            local v8 = os.clock() * 1.5;
            KiteModel:PivotTo(Pivot * CFrame_Angles(0, v7, math.cos(v8) * 0.05));
            RunService.Heartbeat:Wait();
        end;
    end);
    task.delay(3, function() -- Line: 87
        -- upvalues: KiteModel (copy), TweenService (ref)
        for _, descendant in ipairs(KiteModel:GetDescendants()) do
            if descendant:IsA("BasePart") then
                TweenService:Create(descendant, TweenInfo.new(2, Enum.EasingStyle.Linear), {
                    Transparency = 1
                }):Play();
            end;
        end;
    end);
end);
CreateKiteClient.OnClientEvent:Connect(function(p9: userdata, p10: userdata) -- Line: 103
    -- upvalues: DestroyKite (copy), u1 (copy)
    if not (p10 and (typeof(p10) == "Instance" or p10:IsA("Model"))) then
        return;
    end;

    if not (p9 and (typeof(p9) == "Instance" or p9:IsA("Player"))) then
        return;
    end;

    DestroyKite(p9);
    local Character = p9.Character;

    if not Character then
        return;
    end;

    local v11 = Character:FindFirstChildOfClass("Tool");

    if not (v11 and v11:FindFirstChild("Handle")) then
        return;
    end;

    local Handle = v11.Handle;
    local v12 = p10:Clone();
    v12.Parent = workspace.Visuals;
    v12:PivotTo(p9.Character:GetPivot() + Vector3.new(0, 5, 0));
    local Attachment = Instance.new("Attachment");
    Attachment.Name = "KiteHandAttachment";
    Attachment.Parent = Handle;
    local Attachment2 = Instance.new("Attachment");
    Attachment2.Name = "KiteAttachment";
    Attachment2.Position = Vector3.new(0, 0, 0);
    Attachment2.Parent = v12.PrimaryPart;
    local Beam = Instance.new("Beam");
    Beam.Name = "KiteString";
    Beam.Attachment0 = Attachment;
    Beam.Attachment1 = Attachment2;
    Beam.Width0 = 0.05;
    Beam.Width1 = 0.05;
    Beam.TextureSpeed = 0;
    Beam.Color = ColorSequence.new(Color3.new(1, 1, 1));
    Beam.Transparency = NumberSequence.new(0.1);
    Beam.FaceCamera = true;
    Beam.Parent = v12;
    u1[p9] = {
        KiteModel = v12,
        HandAttach = Attachment,
        KiteAttach = Attachment2,
        Beam = Beam
    };
end);
RemoveKiteClient.OnClientEvent:Connect(function(p13: userdata) -- Line: 153
    -- upvalues: DestroyKite (copy)
    if not (p13 and (typeof(p13) == "Instance" or p13:IsA("Player"))) then
        return;
    end;

    DestroyKite(p13);
end);
RunService.Heartbeat:Connect(function(p14) -- Line: 161
    -- upvalues: u1 (copy)
    local os_clock_ret = os.clock();

    for i, v in pairs(u1) do
        local KiteModel = v.KiteModel;

        if i.Character and (i.Character:FindFirstChild("HumanoidRootPart") and (KiteModel and KiteModel.Parent)) then
            local HumanoidRootPart = i.Character.HumanoidRootPart;
            local v15 = HumanoidRootPart.CFrame:PointToWorldSpace(Vector3.new(0, 10, 5));
            local v16 = math.sin(os_clock_ret * 1.5 + i.UserId) * 0.5;
            local v17 = math.sin(os_clock_ret * 2 + i.UserId) * 0.8;
            local v18 = math.cos(os_clock_ret * 1.2 + i.UserId) * 0.5;
            local v19 = v15 + Vector3.new(v16, v17, v18);
            local Pivot = KiteModel:GetPivot();
            KiteModel:PivotTo(CFrame.new(Pivot.Position:Lerp(v19, 0.1), HumanoidRootPart.Position) * CFrame.Angles(math.sin(os_clock_ret + i.UserId) * 0.05, math.cos(os_clock_ret + i.UserId) * 0.05, math.sin(os_clock_ret * 0.5 + i.UserId) * 0.05));
        else
            if v.KiteModel then
                v.KiteModel:Destroy();
            end;

            if v.HandAttach then
                v.HandAttach:Destroy();
            end;

            if v.Beam then
                v.Beam:Destroy();
            end;

            if v.KiteAttach then
                v.KiteAttach:Destroy();
            end;

            u1[i] = nil;
        end;
    end;
end);

return {};