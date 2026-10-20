-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local SoundService = game:GetService("SoundService");
local Players = game:GetService("Players");
local TweenService = game:GetService("TweenService");
local BeeColonyStateController = require(ReplicatedStorage.Modules.BeeEventV2Controllers.BeeColonyStateController);
local BeeRegistry = require(ReplicatedStorage.Data.BeeEvent.BeeRegistry);
local Notification = require(ReplicatedStorage.Modules.Notification);
local TimeHelper = require(ReplicatedStorage.Modules.TimeHelper);
local WaspTimer = ReplicatedStorage.Assets.VFX.WaspTimer;
local Color3_fromRGB_ret = Color3.fromRGB(255, 150, 10);
local Color3_fromRGB_ret2 = Color3.fromRGB(255, 220, 150);
local WaspBossUI = Players.LocalPlayer.PlayerGui:WaitForChild("WaspBossUI");
local u1 = nil;
local v2 = {};

local function playSound(p3: string, p4: userdata) -- Line: 26
    -- upvalues: SoundService (copy)
    local EvilWasp = SoundService:FindFirstChild("EvilWasp");

    if not EvilWasp then
        return;
    end;

    local v5 = EvilWasp:FindFirstChild(p3);

    if v5 then
        local u6 = v5:Clone();
        u6.Parent = p4 or SoundService;
        u6:Play();
        u6.Ended:Once(function() -- Line: 36
            -- upvalues: u6 (copy)
            u6:Destroy();
        end);

        return u6;
    end;
end;

local function startCombatLoop(u7: userdata, p8: number?, p9: number?) -- Line: 41
    -- upvalues: Players (copy), TweenService (copy)
    local u10 = p8 or 0;
    local u11 = p9 or u7.Volume;
    local u12 = nil;
    task.spawn(function() -- Line: 46
        -- upvalues: u7 (copy), u10 (copy), u11 (copy), Players (ref), u12 (ref), TweenService (ref)
        while u7 and u7.Parent do
            local v13 = u10 + math.random() * (u11 - u10);
            local v14 = 1 + math.random() * 4;
            local v15 = not Players.LocalPlayer:GetAttribute("InWaspCombat") and 0 or v13;

            if u12 then
                u12:Cancel();
            end;

            u12 = TweenService:Create(u7, TweenInfo.new(v14, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                Volume = v15
            });
            u12:Play();
            u12.Completed:Wait();
            task.wait(math.random() * 2);
        end;
    end);
end;

local function createPulse(p16: userdata, u17: number, p18: number, p19, u20: number) -- Line: 73
    -- upvalues: TweenService (copy)
    local u21 = p16:Clone();
    u21.Name = "WaspEggHologram";
    local v22 = {};

    for _, descendant in u21:GetDescendants() do
        if descendant:IsA("BasePart") then
            if descendant.Transparency < 1 then
                descendant.Material = Enum.Material.Neon;
                descendant.Color = p19;
                descendant.Transparency = p18;
                descendant.CanCollide = false;
                descendant.CanQuery = false;
                descendant.CanTouch = false;
                table.insert(v22, descendant);
            end;
        elseif descendant:IsA("Decal") then
            descendant.Transparency = 1;
        end;
    end;

    u21:PivotTo(p16:GetPivot());
    u21.Parent = workspace;

    for _, v in v22 do
        TweenService:Create(v, TweenInfo.new(u20, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Transparency = 1
        }):Play();
    end;

    task.spawn(function() -- Line: 102
        -- upvalues: u21 (copy), u17 (copy), u20 (copy)
        for i = 1, 12 do
            u21:ScaleTo((u17 - 1) * (1 - (1 - i / 12) ^ 2) + 1);
            task.wait(u20 / 12);
            local _ = i;
        end;

        u21:Destroy();
    end);
end;

local function createRing(p23: vector) -- Line: 114
    -- upvalues: Color3_fromRGB_ret (copy), TweenService (copy)
    local Part = Instance.new("Part");
    Part.Shape = Enum.PartType.Cylinder;
    Part.Size = Vector3.new(0.2, 0.5, 0.5);
    Part.CFrame = CFrame.new(p23) * CFrame.Angles(0, 0, 1.5707963267948966);
    Part.Material = Enum.Material.Neon;
    Part.Color = Color3_fromRGB_ret;
    Part.Transparency = 0.3;
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.Parent = workspace;
    TweenService:Create(Part, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Size = Vector3.new(0.2, 10, 10),
        Transparency = 1
    }):Play();
    task.delay(0.4, function() -- Line: 133
        -- upvalues: Part (copy)
        Part:Destroy();
    end);
end;

local function playSpawnAnimation(p24: userdata) -- Line: 136
    -- upvalues: playSound (copy), createPulse (copy), Color3_fromRGB_ret2 (copy), Color3_fromRGB_ret (copy), createRing (copy), TweenService (copy)
    task.wait(0.1);

    if not p24.Parent then
        return;
    end;

    local v25 = p24.PrimaryPart or p24:FindFirstChildWhichIsA("BasePart");
    local Position = p24:GetPivot().Position;
    playSound("Wasp_EggSpawn", v25 or p24);
    createPulse(p24, 1.12, 0.4, Color3_fromRGB_ret2, 0.3);
    task.wait(0.05);
    createPulse(p24, 1.2, 0.6, Color3_fromRGB_ret, 0.4);
    createRing(Position);
    local Highlight = Instance.new("Highlight");
    Highlight.FillColor = Color3_fromRGB_ret;
    Highlight.FillTransparency = 0.6;
    Highlight.OutlineColor = Color3_fromRGB_ret2;
    Highlight.OutlineTransparency = 0;
    Highlight.Parent = p24;
    local PointLight = Instance.new("PointLight");
    PointLight.Color = Color3_fromRGB_ret;
    PointLight.Brightness = 4;
    PointLight.Range = 12;

    if v25 then
        PointLight.Parent = v25;
    end;

    TweenService:Create(Highlight, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        FillTransparency = 1,
        OutlineTransparency = 1
    }):Play();
    TweenService:Create(PointLight, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        Brightness = 0
    }):Play();
    task.wait(0.4);
    Highlight:Destroy();
    PointLight:Destroy();
end;

local function formatNumber(p26: number) -- Line: 181
    local v27 = math.floor(p26 * 100) / 100;
    local v28 = tostring(v27);
    local string_gsub_ret = string.gsub(string.reverse(v28), "(%d%d%d)", "%1,");

    return string.gsub(string.reverse(string_gsub_ret), "^,", "");
end;

function v2.Start(p29) -- Line: 189
    -- upvalues: Notification (copy), Players (copy), playSpawnAnimation (copy), WaspTimer (copy), TimeHelper (copy), BeeRegistry (copy), BeeColonyStateController (copy), WaspBossUI (copy), formatNumber (copy), playSound (copy), TweenService (copy), u1 (ref)
    local u30 = nil;
    local u31 = nil;
    workspace.ChildAdded:Connect(function(u32) -- Line: 194
        -- upvalues: Notification (ref), Players (ref), playSpawnAnimation (ref), WaspTimer (ref), TimeHelper (ref)
        if u32.Name == "WaspEgg" and u32:IsA("Model") then
            local v33 = u32:GetAttribute("IsWaspWaveSurvival") == true;
            local Attribute = u32:GetAttribute("SurvivalOwnerUserId");

            if not v33 then
                Notification:CreateNotification("A Wasp Wave has spawned! Find the egg and defeat the Wasps!");
            end;

            if not v33 or Attribute == Players.LocalPlayer.UserId then
                task.spawn(playSpawnAnimation, u32);
            end;

            task.spawn(function() -- Line: 207
                -- upvalues: u32 (copy), WaspTimer (ref), TimeHelper (ref)
                local v34 = nil;

                while u32.Parent do
                    local Attribute2 = u32:GetAttribute("WaveEndTime");
                    local v35 = Attribute2 and Attribute2 - workspace:GetServerTimeNow() or (1 / 0);

                    if v35 <= 120 then
                        if not v34 then
                            v34 = WaspTimer:Clone();
                            v34.Adornee = u32.PrimaryPart or u32:FindFirstChildWhichIsA("BasePart");
                            v34.Parent = u32;
                            v34.StudsOffsetWorldSpace = -v34.StudsOffsetWorldSpace;
                        end;

                        local TimeLabel = v34.TimeLabel;
                        local math_ceil_ret = math.ceil(v35);
                        TimeLabel.Text = TimeHelper:GenerateColonFormatFromTime((math.max(0, math_ceil_ret)));
                    elseif v34 then
                        v34:Destroy();
                        v34 = nil;
                    end;

                    task.wait(0.5);
                end;

                if v34 then
                    v34:Destroy();
                end;
            end);
        end;
    end);
    local MaxHealth = BeeRegistry["Wasp King"].Stats.MaxHealth;
    BeeColonyStateController.OnBeeCreated:Connect(function(p36, p37) -- Line: 242
        -- upvalues: Players (ref), Notification (ref), u30 (ref), u31 (ref), MaxHealth (ref), WaspBossUI (ref), formatNumber (ref), playSound (ref), TweenService (ref)
        if p37.Server.BeeName == "Wasp King" then
            local WaspWaveSurvivalOwner = p37.Server.WaspWaveSurvivalOwner;

            if WaspWaveSurvivalOwner and WaspWaveSurvivalOwner ~= Players.LocalPlayer.UserId then
                return;
            end;

            Notification:CreateNotification("A Wasp King has spawned!");
            u30 = p36;
            u31 = p37.Server.Player;
            MaxHealth = p37.Server.Health;
            WaspBossUI.BossHealthbar.Main.HealthAmount.Text = `{formatNumber(MaxHealth)} / {formatNumber(MaxHealth)}`;
            WaspBossUI.BossHealthbar.Main.Bar.Size = UDim2.new(1, 0, 1, 0);
            local u38 = playSound("WaspCombatLoop", p37.Client.Hitbox);
            local u39 = nil;
            local u40 = 0;
            local u41 = 4;
            task.spawn(function() -- Line: 46
                -- upvalues: u38 (copy), u40 (copy), u41 (copy), Players (ref), u39 (ref), TweenService (ref)
                while u38 and u38.Parent do
                    local v42 = u40 + math.random() * (u41 - u40);
                    local v43 = 1 + math.random() * 4;
                    local v44 = not Players.LocalPlayer:GetAttribute("InWaspCombat") and 0 or v42;

                    if u39 then
                        u39:Cancel();
                    end;

                    u39 = TweenService:Create(u38, TweenInfo.new(v43, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                        Volume = v44
                    });
                    u39:Play();
                    u39.Completed:Wait();
                    task.wait(math.random() * 2);
                end;
            end);
        end;
    end);
    BeeColonyStateController.OnBeeDestroyed:Connect(function(p45, p46) -- Line: 266
        -- upvalues: WaspBossUI (ref), u1 (ref), playSound (ref)
        if p46.Server.BeeName == "Wasp King" then
            WaspBossUI.Enabled = false;

            if u1 then
                u1:Destroy();
                u1 = nil;
            end;

            task.delay(0.5, playSound, "Wasp_Victory");
        end;
    end);
    local u47 = nil;
    BeeColonyStateController.OnBeeStateUpdate:Connect(function(p48, p49, p50, p51) -- Line: 281
        -- upvalues: u30 (ref), MaxHealth (ref), u47 (ref), TweenService (ref), WaspBossUI (ref), formatNumber (ref)
        if p49.Server.BeeName == "Wasp King" and (p50 == "Health" and (p48 == u30 and MaxHealth)) then
            if u47 then
                u47:Cancel();
            end;

            local TweenInfo_new_ret = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
            u47 = TweenService:Create(WaspBossUI.BossHealthbar.Main.Bar, TweenInfo_new_ret, {
                Size = UDim2.new(p51 / MaxHealth, 0, 1, 0)
            });
            u47:Play();
            WaspBossUI.BossHealthbar.Main.HealthAmount.Text = `{formatNumber(p51)} / {formatNumber(MaxHealth)}`;
        end;
    end);
    task.spawn(function() -- Line: 296
        -- upvalues: u30 (ref), u31 (ref), BeeColonyStateController (ref), Players (ref), WaspBossUI (ref), u1 (ref), TweenService (ref), playSound (ref)
        while true do
            while true do
                task.wait(0.2);

                if not u30 then
                    break;
                end;

                local v52 = u31 and BeeColonyStateController:GetEntry(u31, u30);

                if v52 then
                    if Players.LocalPlayer:GetAttribute("ShovelOnCooldown") then
                        WaspBossUI.Enabled = true;
                    elseif Players.LocalPlayer:GetAttribute("InWaspCombat") then
                        if not u1 then
                            u1 = playSound("WaspBossMusic");
                            local Volume = u1.Volume;
                            u1.Volume = 0;
                            TweenService:Create(u1, TweenInfo.new(3, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
                                Volume = Volume
                            }):Play();
                        end;

                        local Magnitude = ((v52.Client.SmoothedCFrame or (v52.Client.PredictedCFrame or v52.Server.CFrame)).Position - Players.LocalPlayer.Character:GetPivot().Position).Magnitude;
                        WaspBossUI.Enabled = Magnitude < 50;
                        workspace:SetAttribute("WaspBoss", Magnitude < 50);
                    else
                        WaspBossUI.Enabled = false;

                        if u1 then
                            TweenService:Create(u1, TweenInfo.new(3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                                Volume = 0
                            }):Play();
                            task.delay(3, function() -- Line: 327
                                -- upvalues: u1 (ref)
                                if not u1 then
                                    return;
                                end;

                                u1:Destroy();
                                u1 = nil;
                            end);
                        end;
                    end;
                else
                    workspace:SetAttribute("WaspBoss", nil);
                end;
            end;

            workspace:SetAttribute("WaspBoss", nil);
        end;
    end);
end;

task.spawn(v2.Start, v2);

return v2;