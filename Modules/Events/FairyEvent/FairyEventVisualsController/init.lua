-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CollectionService = game:GetService("CollectionService");
local Players = game:GetService("Players");
local Debris = game:GetService("Debris");
local FairyEventClientUtils = require(ReplicatedStorage.Modules.Events.FairyEvent.FairyEventClientUtils);
local FairyDialogueData = require(ReplicatedStorage.Data.Events.FairyEvent.FairyDialogueData);
local InventoryServiceEnums = require(ReplicatedStorage.Data.EnumRegistry.InventoryServiceEnums);
local ItemTypeEnums = require(ReplicatedStorage.Data.EnumRegistry.ItemTypeEnums);
local Bezier_2 = require(ReplicatedStorage.Code.Bezier_2);
local Top_Text = require(ReplicatedStorage.Top_Text);
local Spr = require(ReplicatedStorage.Code.Spr);
local EventRotationClientBinder = require(ReplicatedStorage.Modules.EventRotation.EventRotationClientBinder);
local u1 = require(ReplicatedStorage.Modules.Trove).new();
local GameEvents = ReplicatedStorage:WaitForChild("GameEvents");
local _ = GameEvents.Notification;
local _ = GameEvents.EndWeatherevent;
local _ = GameEvents.SendClientSpecialEvent;
local _ = GameEvents.HighlightRemote;
local FairyEvent = GameEvents.Events:WaitForChild("FairyEvent");
local CreateFairy = FairyEvent.CreateFairy;
local DestroyFairy = FairyEvent.DestroyFairy;
local CreateLooseFairy = FairyEvent.CreateLooseFairy;
local DestroyLooseFairy = FairyEvent.DestroyLooseFairy;
local CollectLooseFairy = FairyEvent.CollectLooseFairy;
local LooseFairyFlyToFruit = FairyEvent.LooseFairyFlyToFruit;
local Children = ReplicatedStorage.Assets.FairyEventFairies:GetChildren();
local LocalPlayer = Players.LocalPlayer;

local function getClosestPointOnPartSurface(p2, p3: vector, p4: vector) -- Line: 39
    local v5 = p2:PointToObjectSpace(p4);
    local v6 = Vector3.new(0, 0, 0);
    local v7 = p3.X / 2 - math.abs(v5.X);
    local v8 = p3.Y / 2 - math.abs(v5.Y);
    local v9 = p3.Z / 2 - math.abs(v5.Z);

    if v7 <= v8 and v7 <= v9 then
        local v10 = math.sign(v5.X) * p3.X / 2;
        local math_clamp_ret = math.clamp(v5.Y, -p3.Y / 2, p3.Y / 2);
        local math_clamp_ret2 = math.clamp(v5.Z, -p3.Z / 2, p3.Z / 2);
        v6 = Vector3.new(v10, math_clamp_ret, math_clamp_ret2);
    elseif v8 <= v7 and v8 <= v9 then
        local math_clamp_ret = math.clamp(v5.X, -p3.X / 2, p3.X / 2);
        local v11 = math.sign(v5.Y) * p3.Y / 2;
        local math_clamp_ret2 = math.clamp(v5.Z, -p3.Z / 2, p3.Z / 2);
        v6 = Vector3.new(math_clamp_ret, v11, math_clamp_ret2);
    elseif v9 <= v7 and v9 <= v8 then
        local math_clamp_ret = math.clamp(v5.X, -p3.X / 2, p3.X / 2);
        local math_clamp_ret2 = math.clamp(v5.Y, -p3.Y / 2, p3.Y / 2);
        local v12 = math.sign(v5.Z) * p3.Z / 2;
        v6 = Vector3.new(math_clamp_ret, math_clamp_ret2, v12);
    end;

    return p2:PointToWorldSpace(v6);
end;

local function getProximityPromptEnabledState() -- Line: 53
    -- upvalues: FairyEventClientUtils (copy), LocalPlayer (copy), InventoryServiceEnums (copy), ItemTypeEnums (copy)
    if not FairyEventClientUtils:IsInFairyEvent() then
        return false;
    end;

    local Character = LocalPlayer.Character;

    if Character then
        Character = Character:FindFirstChildWhichIsA("Tool");
    end;

    return not Character or Character:GetAttribute(InventoryServiceEnums.ITEM_TYPE) ~= ItemTypeEnums["Fairy Net"];
end;

local u13 = {};
local u14 = {};
local u15 = {};

function u13.GetAllFairies(p16) -- Line: 66
    -- upvalues: u15 (copy), u14 (copy)
    local v17 = {};

    for i, v in u15 do
        if v and v:IsDescendantOf(workspace) then
            table.insert(v17, {
                Id = i,
                Position = v.PrimaryPart.CFrame.Position
            });
        end;
    end;

    for i, v in u14 do
        if v and v:IsDescendantOf(workspace) then
            table.insert(v17, {
                Id = i,
                Position = v.PrimaryPart.CFrame.Position
            });
        end;
    end;

    return v17;
end;

function u13.CreateLooseFairy(p18: table, u19: string, p20: vector, p21: string) -- Line: 82
    -- upvalues: u13 (copy), FairyEventClientUtils (copy), Children (copy), LocalPlayer (copy), InventoryServiceEnums (copy), ItemTypeEnums (copy), FairyDialogueData (copy), Top_Text (copy), CollectLooseFairy (copy), u14 (copy), Spr (copy)
    u13:DestroyLooseFairy(u19);

    if not FairyEventClientUtils:IsInFairyEvent() then
        return;
    end;

    local Random_new_ret = Random.new();
    local CFrame_Angles_ret = CFrame.Angles(0, Random_new_ret:NextNumber(0, 6.283185307179586), 0);
    local u22 = Children[Random_new_ret:NextInteger(1, #Children)]:Clone();
    u22:PivotTo(CFrame.new(p20 - Vector3.new(0, 30, 0) + Random_new_ret:NextUnitVector() * 20) * CFrame_Angles_ret);
    u22.PrimaryPart.Anchored = true;
    local v23 = script.IdleSound:Clone();
    v23.Parent = u22.PrimaryPart;
    u22.Parent = workspace;
    v23:Play();
    local v24 = u22:FindFirstChild("AnimationController"):FindFirstChild("Animator"):LoadAnimation(script.Idle);
    v24.Looped = true;
    v24.Priority = Enum.AnimationPriority.Idle;
    v24:Play();
    local ProximityPrompt = Instance.new("ProximityPrompt");
    local v25;

    if FairyEventClientUtils:IsInFairyEvent() then
        local Character = LocalPlayer.Character;

        if Character then
            Character = Character:FindFirstChildWhichIsA("Tool");
        end;

        v25 = not Character or Character:GetAttribute(InventoryServiceEnums.ITEM_TYPE) ~= ItemTypeEnums["Fairy Net"];
    else
        v25 = false;
    end;

    ProximityPrompt.Enabled = v25;
    ProximityPrompt.ActionText = "Interact";
    ProximityPrompt.MaxActivationDistance = 6.8;
    ProximityPrompt.ObjectText = "Fairy";
    ProximityPrompt.RequiresLineOfSight = false;
    ProximityPrompt.Style = Enum.ProximityPromptStyle.Custom;
    ProximityPrompt:AddTag("FairyPrompt");
    ProximityPrompt.Parent = u22;
    ProximityPrompt.Style = Enum.ProximityPromptStyle.Custom;
    ProximityPrompt:SetAttribute("Theme", "ShadowedPrompt");
    local u26;

    if p21 == "Server" then
        u26 = FairyDialogueData.SERVER_LOOSE_FAIRIES_DIALOGUES;
    else
        u26 = FairyDialogueData.LOOSE_FAIRIES_DIALOGUES;
    end;

    ProximityPrompt.Triggered:Connect(function() -- Line: 127
        -- upvalues: ProximityPrompt (copy), Top_Text (ref), u22 (copy), u26 (copy), Random_new_ret (copy), CollectLooseFairy (ref), u19 (copy), u14 (ref), FairyEventClientUtils (ref), LocalPlayer (ref), InventoryServiceEnums (ref), ItemTypeEnums (ref)
        if ProximityPrompt:GetAttribute("Collecting") then
            return;
        end;

        ProximityPrompt:SetAttribute("Collecting", true);
        ProximityPrompt.Enabled = false;
        Top_Text.NpcText(u22, u26[Random_new_ret:NextInteger(1, #u26)], true);
        task.wait(1);

        if u22:FindFirstChild("Head") then
            Top_Text.TakeAwayNPCText(u22);
        end;

        CollectLooseFairy:FireServer(u19);
        task.delay(2, function() -- Line: 138
            -- upvalues: u14 (ref), u19 (ref), u22 (ref), ProximityPrompt (ref), FairyEventClientUtils (ref), LocalPlayer (ref), InventoryServiceEnums (ref), ItemTypeEnums (ref)
            if u14[u19] ~= u22 or not ProximityPrompt.Parent then
                return;
            end;

            if u22:GetAttribute("_destroying") or u22:GetAttribute("CollectAccepted") then
                return;
            end;

            ProximityPrompt:SetAttribute("Collecting", nil);
            local v27;

            if FairyEventClientUtils:IsInFairyEvent() then
                local Character = LocalPlayer.Character;

                if Character then
                    Character = Character:FindFirstChildWhichIsA("Tool");
                end;

                v27 = not Character or Character:GetAttribute(InventoryServiceEnums.ITEM_TYPE) ~= ItemTypeEnums["Fairy Net"];
            else
                v27 = false;
            end;

            ProximityPrompt.Enabled = v27;
        end);
    end);
    Spr.target(u22, 1, 4, {
        Pivot = CFrame.new(p20) * CFrame_Angles_ret
    });
    u14[u19] = u22;
end;

function u13.DestroyFairyId(p28: table, p29: string) -- Line: 154
    -- upvalues: u15 (copy)
    if u15[p29] == nil then
        return;
    end;

    u15[p29]:Destroy();
    u15[p29] = nil;
end;

function u13.DestroyFairy(p30: table, u31: userdata) -- Line: 163
    -- upvalues: Bezier_2 (copy), Spr (copy)
    if u31:GetAttribute("_destroying") then
        return;
    end;

    u31:SetAttribute("_destroying", true);
    local Random_new_ret = Random.new();
    local Pivot = u31:GetPivot();
    local Position = Pivot.Position;
    local v32 = 100 * (Random_new_ret:NextInteger(0, 1) * 2 - 1);
    local v33 = Position + Vector3.new(0, 40, 0) + Vector3.new(v32, 0, 0);
    local v34 = Position + Pivot.LookVector * 20;
    local v35 = Position:Lerp(v33, 0.5) + Vector3.new(0, 30, 0) + Pivot.LookVector * 30;
    local v36 = Position:Lerp(v33, 0.75) + Vector3.new(0, 40, 0) - Pivot.LookVector * 40;
    local v37 = Bezier_2.new(Position, v34, v35, v36, v33):CreateCFrameTween(u31.PrimaryPart, { "CFrame" }, TweenInfo.new(3, Enum.EasingStyle.Sine, Enum.EasingDirection.In));
    v37:Play();

    for _, descendant in u31:GetDescendants() do
        if descendant:IsA("BasePart") then
            task.delay(2, Spr.target, descendant, 1, 5, {
                Transparency = 1
            });
        elseif descendant:IsA("ParticleEmitter") or descendant:IsA("Trail") then
            descendant.Enabled = false;
        end;
    end;

    local u38 = nil;
    task.spawn(pcall, function() -- Line: 195
        -- upvalues: u31 (copy), u38 (ref)
        u38 = u31:FindFirstChild("AnimationController"):FindFirstChild("Animator"):LoadAnimation(script.Walk);
        u38:Play();
    end);
    v37.Completed:Connect(function() -- Line: 202
        -- upvalues: u31 (copy), u38 (ref)
        u31:Destroy();

        if u38 then
            u38:Stop();
            u38:Destroy();
        end;
    end);
end;

function u13.DestroyLooseFairy(p39: table, p40: string, p41: boolean?) -- Line: 212
    -- upvalues: u14 (copy), u13 (copy)
    local v42 = u14[p40];

    if not v42 then
        return;
    end;

    if p41 then
        v42:Destroy();
    else
        u13:DestroyFairy(v42);
    end;

    u14[p40] = nil;
end;

function u13.FlyToFruit(p43: table, u44: userdata, p45, p46: string, p47: userdata, p48: number, p49: boolean?) -- Line: 225
    -- upvalues: getClosestPointOnPartSurface (copy), Debris (copy), Bezier_2 (copy), Spr (copy), u13 (copy)
    local Position = p45.Position;
    local BoundingBox, v50 = p47:GetBoundingBox();
    local v51 = getClosestPointOnPartSurface(BoundingBox, v50, Position);
    local v52 = v51 - (v51 - Position).Unit * 2;
    local u53 = nil;
    task.spawn(pcall, function() -- Line: 237
        -- upvalues: u44 (copy), u53 (ref)
        u53 = u44:FindFirstChild("AnimationController"):FindFirstChild("Animator"):LoadAnimation(script.Walk);
        u53:Play();
    end);
    Debris:AddItem(u44, p48 + 3 + (p49 and 3 or p48));
    local v54 = Position:Lerp(v52, 0.05) + p45.LookVector * 25;
    local v55 = Position:Lerp(v52, 0.5) + Vector3.new(0, 18, 0);
    local v56 = Position:Lerp(v52, 0.75) + Vector3.new(0, 8, 0);
    local v57 = p49 and 0 or 0.4;

    if not p49 then
        local v58 = script.Poof:Clone();
        v58.CFrame = CFrame.new(Position);
        v58.Parent = workspace;
        v58.PixelSmoke:Emit(8);
        Debris:AddItem(v58, 2);
    end;

    local v59 = Bezier_2.new(Position, v54, v55, v56, v52):CreateCFrameTween(u44.PrimaryPart, { "CFrame" }, TweenInfo.new(p48 - v57, Enum.EasingStyle.Sine));
    v59:Play();
    v59.Completed:Wait();

    if not (u44 and (u44.PrimaryPart and u44:IsDescendantOf(workspace))) then
        return;
    end;

    Spr.target(u44.PrimaryPart, 1, 2.5, {
        CFrame = CFrame.lookAt(v52, BoundingBox.Position)
    });

    if p49 then
        task.wait(2);
        u13:DestroyFairy(u44);
    else
        task.wait(v57 + 1.5);

        if not (u44 and (u44.PrimaryPart and u44:IsDescendantOf(workspace))) then
            return;
        end;

        Spr.target(u44.PrimaryPart, 1, 2.5, {
            CFrame = CFrame.lookAt(v52, v56)
        });
        task.wait(v57);

        if not (u44 and (u44.PrimaryPart and u44:IsDescendantOf(workspace))) then
            return;
        end;

        Spr.stop(u44.PrimaryPart);
        local v60 = Bezier_2.new(v52, v56, v55, v54, Position):CreateCFrameTween(u44.PrimaryPart, { "CFrame" }, TweenInfo.new(p48, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut));
        v60:Play();
        v60.Completed:Wait();

        if not (u44 and (u44.PrimaryPart and u44:IsDescendantOf(workspace))) then
            return;
        end;

        for _, descendant in u44:GetDescendants() do
            if descendant:IsA("Trail") then
                descendant.Enabled = false;
            end;
        end;

        local v61 = script.Poof:Clone();
        v61.CFrame = CFrame.new(Position);
        v61.Parent = workspace;
        v61.PixelSmoke:Emit(8);
        Debris:AddItem(v61, 2);
        task.wait(0.1);
        u44:Destroy();
    end;

    if u53 then
        u53:Stop();
        u53:Destroy();
    end;
end;

function u13.LooseFairyFlyToFruit(p62: table, p63: string, p64: string, p65: userdata, p66: number) -- Line: 332
    -- upvalues: u14 (copy), u13 (copy)
    local v67 = u14[p63];

    if not v67 then
        return;
    end;

    v67:SetAttribute("CollectAccepted", true);
    u13:FlyToFruit(v67, v67:GetPivot(), p64, p65, p66, true);
end;

function u13.CreateFairy(p68: table, p69: string, p70: string, p71: userdata, p72: number) -- Line: 340
    -- upvalues: CollectionService (copy), Children (copy), u15 (copy), u13 (copy)
    local v73 = CollectionService:GetTagged("FairySpawnPoint")[1];
    local v74;

    if v73 then
        v74 = v73:GetPivot();
    else
        v74 = CFrame.identity;
    end;

    local v75 = Children[Random.new():NextInteger(1, #Children)]:Clone();
    v75:PivotTo(v74);
    local v76 = script.IdleSound:Clone();
    v76.Parent = v75.PrimaryPart;
    v75.Parent = workspace;
    v76:Play();
    u15[p69] = v75;
    u13:FlyToFruit(v75, v74, p70, p71, p72);
end;

function u13.Start(p77) -- Line: 357
    -- upvalues: FairyEventClientUtils (copy), u1 (copy), CreateFairy (copy), LocalPlayer (copy), u13 (copy), DestroyFairy (copy), CreateLooseFairy (copy), DestroyLooseFairy (copy), LooseFairyFlyToFruit (copy), InventoryServiceEnums (copy), ItemTypeEnums (copy), CollectionService (copy)
    if not FairyEventClientUtils:IsInFairyEvent() then
        return;
    end;

    u1:Add(CreateFairy.OnClientEvent:Connect(function(...) -- Line: 360
        -- upvalues: FairyEventClientUtils (ref), LocalPlayer (ref), u13 (ref)
        if not FairyEventClientUtils:IsInFairyEvent() then
            return;
        end;

        if LocalPlayer:GetAttribute("FirstTimePlayer") then
            return;
        end;

        u13:CreateFairy(...);
    end));
    u1:Add(DestroyFairy.OnClientEvent:Connect(function(...) -- Line: 367
        -- upvalues: u13 (ref)
        u13:DestroyFairyId(...);
    end));
    u1:Add(CreateLooseFairy.OnClientEvent:Connect(function(...) -- Line: 371
        -- upvalues: FairyEventClientUtils (ref), LocalPlayer (ref), u13 (ref)
        if not FairyEventClientUtils:IsInFairyEvent() then
            return;
        end;

        if LocalPlayer:GetAttribute("FirstTimePlayer") then
            return;
        end;

        u13:CreateLooseFairy(...);
    end));
    u1:Add(DestroyLooseFairy.OnClientEvent:Connect(function(...) -- Line: 378
        -- upvalues: u13 (ref)
        u13:DestroyLooseFairy(...);
    end));
    u1:Add(LooseFairyFlyToFruit.OnClientEvent:Connect(function(...) -- Line: 382
        -- upvalues: FairyEventClientUtils (ref), LocalPlayer (ref), u13 (ref)
        if not FairyEventClientUtils:IsInFairyEvent() then
            return;
        end;

        if LocalPlayer:GetAttribute("FirstTimePlayer") then
            return;
        end;

        u13:LooseFairyFlyToFruit(...);
    end));
    u1:Add(task.spawn(function() -- Line: 389
        -- upvalues: FairyEventClientUtils (ref), LocalPlayer (ref), InventoryServiceEnums (ref), ItemTypeEnums (ref), CollectionService (ref)
        local v78 = nil;

        while FairyEventClientUtils:IsInFairyEvent() do
            task.wait(0.1);
            local v79;

            if FairyEventClientUtils:IsInFairyEvent() then
                local Character = LocalPlayer.Character;

                if Character then
                    Character = Character:FindFirstChildWhichIsA("Tool");
                end;

                v79 = not Character or Character:GetAttribute(InventoryServiceEnums.ITEM_TYPE) ~= ItemTypeEnums["Fairy Net"];
            else
                v79 = false;
            end;

            if v78 ~= v79 then
                v78 = v79;

                for _, v in CollectionService:GetTagged("FairyPrompt") do
                    local v80;

                    if v79 then
                        v80 = not v:GetAttribute("Collecting");
                    else
                        v80 = v79;
                    end;

                    v.Enabled = v80;
                end;
            end;
        end;
    end));
end;

EventRotationClientBinder:Bind({
    EventSet = "FairyEvent",
    Script = script,

    OnStart = function() -- Line: 411, Name: OnStart
        -- upvalues: u13 (copy)
        task.spawn(u13.Start, u13);
    end,

    OnStop = function() -- Line: 412, Name: OnStop
        -- upvalues: u1 (copy)
        u1:Clean();
    end
});

return u13;