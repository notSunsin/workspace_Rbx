-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
game:GetService("TweenService");
require(ReplicatedStorage.Modules.GuiController);
require(ReplicatedStorage.Modules.Trove);
require(ReplicatedStorage.Modules.ItemImageFinder);
require(ReplicatedStorage.Modules.NumberUtil);
require(ReplicatedStorage.Modules.CommaFormatNumber);
require(ReplicatedStorage.Modules.GiveServiceCommon);
require(ReplicatedStorage.Modules.UpdateService);
require(ReplicatedStorage.Modules.Signal);
require(ReplicatedStorage.Modules.DataService);
require(ReplicatedStorage.Modules.GardenGuideModules.ImageCycle);
local EventService = require(ReplicatedStorage.Modules.EventService);
require(ReplicatedStorage.Modules.QuestsController);
require(ReplicatedStorage.Comma_Module);
local Spr = require(ReplicatedStorage.Code.Spr);
require(ReplicatedStorage.Modules.MarketController);
require(ReplicatedStorage.Modules.UIComponents.QuestView);
local _ = require(ReplicatedStorage.Data.SharedCycleHandlerData).HeartstruckRain;
require(ReplicatedStorage.Data.DevProductIds);
local PetRegistry = require(ReplicatedStorage.Data.PetRegistry);
local PetMutationRegistry = require(ReplicatedStorage.Data.PetRegistry.PetMutationRegistry);
local Shop_UI = Players.LocalPlayer.PlayerGui:WaitForChild("Shop_UI");
local AlienEventController = EventService.new("AlienEventController", "Alien Event");
local SubmitPet = ReplicatedStorage.GameEvents.AlienEvent.SubmitPet;

local function BlendColor(p1, p2, p3: number) -- Line: 50
    return p1:Lerp(p2, p3);
end;

local function ApplyMutationVisuals(p4: userdata, p5: string) -- Line: 55
    -- upvalues: PetMutationRegistry (copy)
    local v6 = PetMutationRegistry.PetMutationRegistry[p5];

    if not v6 then
        return;
    end;

    local Color = v6.Color;

    if not Color then
        return;
    end;

    for _, descendant in p4:GetDescendants() do
        if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and not descendant:HasTag("Effect") then
            if descendant:IsA("UnionOperation") then
                descendant.UsePartColor = true;
            end;

            descendant.Color = descendant.Color:Lerp(Color, 0.75);
        end;
    end;
end;

local function TweenPetToUFO(p7: userdata, p8: string, p9: string?, p10: userdata?, p11: vector) -- Line: 79
    -- upvalues: PetRegistry (copy), ApplyMutationVisuals (copy), Spr (copy), RunService (copy)
    if not p7 then
        return;
    end;

    if not p7.Character then
        return;
    end;

    local Pivot = p7.Character:GetPivot();
    local v12 = PetRegistry.PetList[p8];
    local u13 = p10:Clone();

    for _, descendant in u13:GetDescendants() do
        if descendant:IsA("BasePart") then
            descendant.CanCollide = false;
            descendant.CanQuery = false;
            descendant.CanTouch = false;
            descendant.Anchored = true;
        end;
    end;

    u13:PivotTo(Pivot);
    u13.Parent = workspace.CurrentCamera;

    if p9 then
        ApplyMutationVisuals(u13, p9);
    end;

    local AnimationController = u13:FindFirstChild("AnimationController");

    if AnimationController then
        AnimationController = AnimationController:FindFirstChild("Animator");
    end;

    if AnimationController and (v12.Animations and v12.Animations.Idle) then
        local v14 = AnimationController:LoadAnimation(v12.Animations.Idle);
        v14.Looped = true;
        v14:Play();
    end;

    local Scale = u13:GetScale();
    local CFrame_new_ret = CFrame.new(p11 - Vector3.new(0, 3, 0), p11);
    Spr.target(u13, 0.5, 0.3, {
        Pivot = CFrame_new_ret
    });
    local os_clock_ret = os.clock();
    local u16 = RunService.RenderStepped:Connect(function() -- Line: 133
        -- upvalues: os_clock_ret (copy), u13 (copy), Scale (copy)
        local v15 = (os.clock() - os_clock_ret) / 6;
        local math_clamp_ret = math.clamp(v15, 0, 1);
        u13:ScaleTo((math.max(0.01, Scale * (1 - math_clamp_ret * 0.9))));
    end);
    Spr.completed(u13, function() -- Line: 139
        -- upvalues: u16 (copy), u13 (copy)
        u16:Disconnect();
        u13:Destroy();
    end);
end;

local function BulkTweenPetToUFO(p17: userdata, p18: string, p19: string?, p20: userdata?, p21: vector) -- Line: 147
    -- upvalues: PetRegistry (copy), ApplyMutationVisuals (copy), Spr (copy), RunService (copy)
    if not p17 then
        return;
    end;

    if not p17.Character then
        return;
    end;

    local Pivot = p17.Character:GetPivot();
    local v22 = PetRegistry.PetList[p18];
    local u23 = p20:Clone();

    for _, descendant in u23:GetDescendants() do
        if descendant:IsA("BasePart") then
            descendant.CanCollide = false;
            descendant.CanQuery = false;
            descendant.CanTouch = false;
            descendant.Anchored = true;
        end;
    end;

    u23:PivotTo(Pivot);
    u23.Parent = workspace.CurrentCamera;
    print(u23);

    if p19 then
        ApplyMutationVisuals(u23, p19);
    end;

    local AnimationController = u23:FindFirstChild("AnimationController");

    if AnimationController then
        AnimationController = AnimationController:FindFirstChild("Animator");
    end;

    if AnimationController and (v22.Animations and v22.Animations.Idle) then
        local v24 = AnimationController:LoadAnimation(v22.Animations.Idle);
        v24.Looped = true;
        v24:Play();
    end;

    local Scale = u23:GetScale();
    local CFrame_new_ret = CFrame.new(p21 - Vector3.new(0, 3, 0), p21);
    Spr.target(u23, 0.5, 0.5, {
        Pivot = CFrame_new_ret
    });
    local os_clock_ret = os.clock();
    local u26 = RunService.RenderStepped:Connect(function() -- Line: 203
        -- upvalues: os_clock_ret (copy), u23 (copy), Scale (copy)
        local v25 = (os.clock() - os_clock_ret) / 3;
        local math_clamp_ret = math.clamp(v25, 0, 1);
        u23:ScaleTo((math.max(0.01, Scale * (1 - math_clamp_ret * 0.9))));
    end);
    Spr.completed(u23, function() -- Line: 209
        -- upvalues: u26 (copy), u23 (copy)
        u26:Disconnect();
        u23:Destroy();
    end);
end;

function AlienEventController.OnStarted(p27) -- Line: 217
    -- upvalues: Shop_UI (copy), SubmitPet (copy), TweenPetToUFO (copy)
    local UFO = game.Workspace.Interaction:WaitForChild("AlienStand", 300):WaitForChild("UFO", 300);

    if not UFO then
        return;
    end;

    local UFOShardsFrame = Shop_UI:WaitForChild("Frame", 30):WaitForChild("ScrollingFrame", 30):WaitForChild("UFOShardsFrame", 30);

    if UFOShardsFrame then
        UFOShardsFrame.Visible = true;
    end;

    p27:Bind(SubmitPet.OnClientEvent:Connect(function(u28, p29) -- Line: 234
        -- upvalues: TweenPetToUFO (ref), UFO (copy)
        for i, v in p29 do
            task.spawn(function() -- Line: 237
                -- upvalues: v (copy), i (copy), TweenPetToUFO (ref), u28 (copy), UFO (ref)
                if not (v.Clone and v.Clone.Parent) then
                    return;
                end;

                local v30 = v.Clone:Clone();
                v30.Parent = workspace.CurrentCamera;
                task.wait(0.25 * i);
                TweenPetToUFO(u28, v.PetType, v.MutationName, v30, UFO.Position);
            end);
        end;
    end));
end;

function AlienEventController.OnStopped(p31) -- Line: 255
    -- upvalues: Shop_UI (copy)
    local UFOShardsFrame = Shop_UI:WaitForChild("Frame", 30):WaitForChild("ScrollingFrame", 30):WaitForChild("UFOShardsFrame", 30);

    if UFOShardsFrame then
        UFOShardsFrame.Visible = false;
    end;
end;

function AlienEventController.Open(p32) -- Line: 262
end;

function AlienEventController.Close(p33) -- Line: 266
end;

return AlienEventController;