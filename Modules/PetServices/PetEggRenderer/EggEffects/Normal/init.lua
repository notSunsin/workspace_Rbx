-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PetRegistry = require(game.ReplicatedStorage.Data.PetRegistry);
local SelectiveAssetReplication = require(ReplicatedStorage.Modules.SelectiveAssetReplication);
local SoundPlayer = require(ReplicatedStorage.Modules.SoundPlayer);
local SoundData = require(ReplicatedStorage.Data.SoundData);
local PetList = PetRegistry.PetList;
local u1 = {
    ["Black Bunny"] = "rbxassetid://137209605666415",
    Bunny = "rbxassetid://104391359688443",
    Caterpillar = "rbxassetid://74906642952986",
    Deer = "rbxassetid://113898066898530",
    Cow = "rbxassetid://80626295210133",
    ["Giant Ant"] = "rbxassetid://110042917722868",
    Cat = "rbxassetid://74848025639589",
    Dog = "rbxassetid://88539564087126",
    ["Golden Lab"] = "rbxassetid://125173635572785",
    Monkey = "rbxassetid://83148221430148",
    Pig = "rbxassetid://110554034996387",
    ["Praying Mantis"] = "rbxassetid://80710971415313",
    ["Polar Bear"] = "rbxassetid://97880140636687",
    Snail = "rbxassetid://100791898582300",
    ["Silver Monkey"] = "rbxassetid://106847532475922",
    ["Purple Dragonfly"] = "rbxassetid://96794025089185",
    Turtle = "rbxassetid://93929754369579",
    ["Orange Tabby"] = "rbxassetid://96707297910956",
    Poof = "rbxassetid://80584356758887"
};

local function PlaySound(p2: string) -- Line: 34
    -- upvalues: u1 (copy), SoundPlayer (copy)
    local v3 = u1[p2];

    if not v3 then
        return;
    end;

    local u4 = SoundPlayer:PlaySound(v3, nil, nil, workspace);
    u4.Ended:Once(function() -- Line: 42
        -- upvalues: u4 (copy)
        u4:Destroy();
    end);
end;

return function(p5, u6, u7) -- Line: 47
    -- upvalues: SoundPlayer (copy), SoundData (copy), PetList (copy), SelectiveAssetReplication (copy), u1 (copy)
    local u8 = script.EggExplode:Clone();
    u8:PivotTo(p5:GetPivot());
    local Core = u8.Core;
    Core.Parent = workspace.Visuals;
    game.Debris:AddItem(Core, 60);
    u8.Parent = game.ReplicatedStorage;
    SoundPlayer:PlaySound(SoundData.General.PetEggRenderer.NormalSFX, nil, nil, Core);
    task.wait(0.4);
    local Pivot = p5:GetPivot();
    local ExtentsSize = p5:GetExtentsSize();
    local v9 = 0;

    while v9 < 0.8 do
        v9 = v9 + game:GetService("RunService").Heartbeat:Wait();
        local v10 = tick() * 90;
        local v11 = (1 - v9 / 0.8) * math.sin(v10) * 7;
        p5:PivotTo(Pivot * CFrame.Angles(0, 0, (math.rad(v11))));
    end;

    task.wait(0.5);
    local v12 = 0;

    while v12 < 0.8 do
        v12 = v12 + game:GetService("RunService").Heartbeat:Wait();
        local v13 = tick() * 90;
        local v14 = (1 - v12 / 0.8) * math.sin(v13) * 9;
        p5:PivotTo(Pivot * CFrame.Angles(0, 0, (math.rad(v14))));
    end;

    task.wait(0.5);
    local v15 = 0;

    while v15 < 0.8 do
        v15 = v15 + game:GetService("RunService").Heartbeat:Wait();
        local v16 = tick() * 90;
        local v17 = (1 - v15 / 0.8) * math.sin(v16) * 13;
        p5:PivotTo(Pivot * CFrame.Angles(0, 0, (math.rad(v17))));
    end;

    local Attribute = p5:GetAttribute("EggColor");
    local Attribute2 = p5:GetAttribute("EggMaterial");
    local Attribute3 = p5:GetAttribute("EggTransparency");
    local Attribute4 = p5:GetAttribute("EggMaterialVariant");
    p5:Destroy();
    u8.Parent = workspace.Visuals;

    for _, descendant in u8:GetDescendants() do
        if descendant ~= Core and (descendant.Name ~= "RootPart" and descendant:IsA("BasePart")) then
            descendant.Anchored = false;
        end;
    end;

    local v18 = u6:find("Egg/");
    local u19;

    if u6 and (u6 ~= "" and not v18) then
        local u20 = PetList[u6];
        u19 = SelectiveAssetReplication:GetAssetAsync("PetAssets", u6):Clone();
        local v21;

        if u20 then
            v21 = u20.Variant;
        else
            v21 = u20;
        end;

        if u19.PrimaryPart then
            u19.PrimaryPart.Anchored = true;
        end;

        local v22 = script.Highlight:Clone();
        v22.Parent = u19;
        v22.Adornee = u19;
        u19.Parent = workspace.Visuals;
        local u23 = 0;
        task.spawn(function() -- Line: 146
            -- upvalues: u23 (ref), u19 (ref), u7 (copy), u20 (copy), Pivot (copy), ExtentsSize (copy)
            while u23 < 1 do
                u23 = u23 + game:GetService("RunService").Heartbeat:Wait();
                local Value = game.TweenService:GetValue(u23 / 1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut);

                local function lerp(p24, p25, p26) -- Line: 152
                    return p24 + (p25 - p24) * p26;
                end;

                u19:ScaleTo(1 + (u7 - 1) * Value);
                local v27 = u20 and u20.WeldOffset or CFrame.identity;
                u19:PivotTo(Pivot * CFrame.new(0, -ExtentsSize.Y / 2, 0) * CFrame.new(0, u19:GetExtentsSize().Y / 2, 0) * v27);
            end;
        end);
        local v28 = u20 and u20.Animations.Idle;

        if v28 then
            u19.AnimationController:LoadAnimation(v28):Play();
        end;

        for _, descendant in u19:GetDescendants() do
            if descendant:IsA("BasePart") then
                descendant.CanCollide = false;
                descendant.CanQuery = false;
            end;
        end;

        game.TweenService:Create(v22, TweenInfo.new(0.5), {
            FillTransparency = 1
        }):Play();
        task.delay(0.5, function() -- Line: 185
            -- upvalues: u6 (copy), u1 (ref), SoundPlayer (ref)
            local v29 = u1[u6];

            if not v29 then
                return;
            end;

            local u30 = SoundPlayer:PlaySound(v29, nil, nil, workspace);
            u30.Ended:Once(function() -- Line: 42
                -- upvalues: u30 (copy)
                u30:Destroy();
            end);
        end);
    else
        u19 = nil;
    end;

    for _, descendant in u8:GetDescendants() do
        if descendant ~= Core and (descendant.Name ~= "RootPart" and descendant:IsA("BasePart")) then
            local v31 = CFrame.new(Core.Position, descendant.Position).LookVector * 8;
            descendant.Color = Attribute or descendant.Color;
            descendant.Material = Attribute2 or descendant.Material;
            descendant.MaterialVariant = Attribute4 or descendant.MaterialVariant;
            descendant.Transparency = Attribute3 or descendant.Transparency;
            descendant:ApplyImpulse(v31 * descendant.AssemblyMass);
        end;
    end;

    task.delay(3, function() -- Line: 250
        -- upvalues: u8 (copy)
        for _, child in u8:GetChildren() do
            for _, descendant in child:GetDescendants() do
                if descendant:IsA("BasePart") then
                    game.TweenService:Create(descendant, TweenInfo.new(1), {
                        Transparency = 1
                    }):Play();
                end;
            end;
        end;

        game.Debris:AddItem(u8, 1);
    end);

    for _, descendant in Core.Attachment:GetDescendants() do
        if descendant:IsA("ParticleEmitter") then
            descendant:Emit(descendant:GetAttribute("EmitCount"));
        end;
    end;

    task.wait(3);
    local v32 = game.ReplicatedStorage.Assets.EggPoof:Clone();
    v32.CFrame = Pivot;
    v32.Parent = workspace.Visuals;
    local Poof = u1.Poof;

    if Poof then
        local u33 = SoundPlayer:PlaySound(Poof, nil, nil, workspace);
        u33.Ended:Once(function() -- Line: 42
            -- upvalues: u33 (copy)
            u33:Destroy();
        end);
    end;

    for _, child in v32:GetChildren() do
        child:Emit(child:GetAttribute("EmitCount"));
    end;

    game.Debris:AddItem(v32, 6);
    task.delay(0.2, function() -- Line: 291
        -- upvalues: u19 (ref)
        if u19 then
            u19:Destroy();
        end;
    end);
end;