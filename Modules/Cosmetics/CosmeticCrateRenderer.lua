-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
local RunService = game:GetService("RunService");
local _ = ReplicatedStorage.Assets.SFX;
local _ = ReplicatedStorage.Assets.VFX;
local u1 = {};
require(ReplicatedStorage.Modules.TweenModel);
local CreateTagHandler = require(ReplicatedStorage.Modules.CreateTagHandler);
require(ReplicatedStorage.Modules.Notification);
require(ReplicatedStorage.Modules.UpdateService);
local SoundPlayer = require(ReplicatedStorage.Modules.SoundPlayer);
local SoundData = require(ReplicatedStorage.Data.SoundData);
local Assets = ReplicatedStorage:WaitForChild("Assets");
local CosmeticList = require(ReplicatedStorage.Data.CosmeticRegistry).CosmeticList;
local CosmeticCrates = require(ReplicatedStorage.Data.CosmeticCrateRegistry).CosmeticCrates;
local CrateSkipProducts = require(ReplicatedStorage.Data.CosmeticCrateRegistry.CrateSkipProducts);
local SelectiveAssetReplication = require(ReplicatedStorage.Modules.SelectiveAssetReplication);
local _ = Assets.SFX;
local _ = Assets.VFX;
game:GetService("TweenService");
local CosmeticCrateService = ReplicatedStorage.GameEvents.CosmeticCrateService;
local _ = ReplicatedStorage.GameEvents.CosmeticCrateSkipped;
local CrateReadyToOpen_RE = ReplicatedStorage.GameEvents.CrateReadyToOpen_RE;
local u2 = {};
local u3 = {};
local LocalPlayer = game.Players.LocalPlayer;

function easeOutBack(p4)
    return math.pow(p4 - 1, 3) * 2.70158 + 1 + math.pow(p4 - 1, 2) * 1.70158;
end;

function easeInBack(p5)
    return 1.70158 * p5 * p5 * (2.70158 * p5 - 1.70158);
end;

local function CreatePromptAttachment(p6: userdata, p7: userdata, p8: vector) -- Line: 56
    local PrimaryPart = p6.PrimaryPart;

    if not PrimaryPart then
        p7.Parent = p6;

        return;
    end;

    local Attachment = Instance.new("Attachment");
    Attachment.Name = `{p7.Name}Att`;
    Attachment.CFrame = CFrame.new(p8);
    Attachment.Parent = PrimaryPart;
    p7.Parent = Attachment;
end;

local function TryDoOpenAnim(u9: userdata, u10: number) -- Line: 72
    -- upvalues: u2 (copy), u3 (copy), SoundPlayer (copy), SoundData (copy), CosmeticList (copy), SelectiveAssetReplication (copy), RunService (copy), u1 (copy)
    if not u9 then
        warn("DoOpenAnim | No server Crate!");

        return;
    end;

    local v11 = u2[u9];

    if not v11 then
        warn("DoOpenAnim | No state data for server Crate");

        return;
    end;

    local Asset = v11.Asset;

    if not Asset then
        warn("DoOpenAnim | No asset!");

        return;
    end;

    local Attribute = u9:GetAttribute("OBJECT_UUID");

    if not Attribute then
        return warn("DoOpenAnim | No Crate uuid!");
    end;

    if Asset:GetAttribute("DoingOpen") then
        return;
    end;

    Asset:SetAttribute("DoingOpen", true);
    Asset.Parent = workspace.Visuals;
    local v12 = u3[Attribute];
    u9:GetAttribute("CrateType");
    local v13 = {};
    local v14 = {};

    for _, descendant in Asset:GetDescendants() do
        if descendant:IsA("BasePart") then
            table.insert(v13, descendant);
        elseif descendant:IsA("Weld") or descendant:IsA("WeldConstraint") then
            table.insert(v14, descendant);
        end;
    end;

    local Pivot = u9:GetPivot();
    local ExtentsSize = u9:GetExtentsSize();
    local u15 = SoundPlayer:PlaySound(SoundData.General.CosmeticCrateRenderer.CrateOpen);
    u15.Ended:Once(function() -- Line: 107
        -- upvalues: u15 (copy)
        u15:Destroy();
    end);

    if v12 and v12 ~= "" then
        local _ = CosmeticList[v12];
        local u16 = SelectiveAssetReplication:GetAssetAsync("Cosmetics", v12):Clone();

        if u16.PrimaryPart then
            u16.PrimaryPart.Anchored = true;
        end;

        u16.Parent = workspace.Visuals;

        for _, descendant in u16:GetDescendants() do
            if descendant:IsA("BasePart") then
                descendant.CanCollide = false;
                descendant.CanQuery = false;
            end;
        end;

        task.spawn(function() -- Line: 128
            -- upvalues: u16 (copy), Pivot (copy), ExtentsSize (copy), RunService (ref), u10 (copy), SoundPlayer (ref), SoundData (ref)
            local ExtentsSize2 = u16:GetExtentsSize();
            local u17 = Pivot * CFrame.new(0, -ExtentsSize.Y / 2, 0) * CFrame.new(0, ExtentsSize2.Y / 2, 0);
            local v18 = tick();
            u16:ScaleTo(0.01);
            u16:PivotTo(u17);
            local u19 = 0;
            local u20 = true;
            task.spawn(function() -- Line: 145
                -- upvalues: u20 (ref), u16 (ref), RunService (ref), u19 (ref), u17 (copy)
                while u20 and u16:IsDescendantOf(workspace) do
                    u19 = u19 + RunService.Heartbeat:Wait();
                    local v21 = math.sin(u19 * 3.141592653589793 * 2 / 1.5) * 0.5;
                    local math_rad_ret = math.rad(u19 * 65);
                    u16:PivotTo(u17 * CFrame.new(0, v21, 0) * CFrame.Angles(0, math_rad_ret, 0));
                end;
            end);
            local v22 = 0;

            while v22 < 0.8 and u16:IsDescendantOf(workspace) do
                v22 = v22 + RunService.Heartbeat:Wait();
                local math_clamp_ret = math.clamp(v22 / 0.8, 0, 1);
                u16:ScaleTo(0.01 + (u10 - 0.01) * easeOutBack(math_clamp_ret));
            end;

            while tick() - v18 < 3 and u16:IsDescendantOf(workspace) do
                RunService.Heartbeat:Wait();
            end;

            local v23 = u10;
            local v24 = 0;

            while v24 < 0.8 and u16:IsDescendantOf(workspace) do
                v24 = v24 + RunService.Heartbeat:Wait();
                local math_clamp_ret = math.clamp(v24 / 0.8, 0, 1);
                local v25 = easeInBack(math_clamp_ret);
                local v26 = v23 * (1 - math.clamp(v25, 0, 1.2));
                u16:ScaleTo((math.max(v26, 0.01)));
            end;

            u20 = false;
            local u27 = SoundPlayer:PlaySound(SoundData.General.PopSound, {
                PlaybackSpeed = 0.5,
                Volume = 1.5
            }, nil, workspace);
            u27.Ended:Once(function() -- Line: 193
                -- upvalues: u27 (copy)
                u27:Destroy();
            end);
            u16:Destroy();
        end);
    end;

    local Position = Asset:GetBoundingBox().Position;
    local Random_new_ret = Random.new();

    for _, v in v13 do
        v.Anchored = true;
        v.CanCollide = false;
        v.CanQuery = false;
        v.CanTouch = false;
    end;

    for _, v in v14 do
        if v.Parent then
            v:Destroy();
        end;
    end;

    for _, v in v13 do
        local v28 = v.Position - Position;

        if v28.Magnitude < 0.01 then
            local v29 = Random_new_ret:NextNumber(-1, 1);
            v28 = Vector3.new(v29, 0, Random_new_ret:NextNumber(-1, 1));
        end;

        local Unit = v28.Unit;
        local NumberRange_new_ret = NumberRange.new(20, 40);
        local v30 = Random_new_ret:NextNumber(-10, 10);
        local v31 = Random_new_ret:NextNumber(NumberRange_new_ret.Min, NumberRange_new_ret.Max);
        local v32 = Unit * 15 + Vector3.new(v30, v31, Random_new_ret:NextNumber(-10, 10));
        local v33 = Random_new_ret:NextNumber(-3, 3);
        local v34 = Random_new_ret:NextNumber(-3, 3);
        local Vector3_new_ret = Vector3.new(v33, v34, Random_new_ret:NextNumber(-3, 3));
        v.Anchored = false;
        v.AssemblyLinearVelocity = v32;
        v.AssemblyAngularVelocity = Vector3_new_ret;
    end;

    task.delay(5, function() -- Line: 252
        -- upvalues: Asset (copy), u1 (ref), u9 (copy)
        Asset:SetAttribute("DoingOpen", false);
        u1:DerenderCrate(u9);
    end);
end;

local function ActivateCrate(p35: userdata, p36: number) -- Line: 259
    -- upvalues: u2 (copy), TryDoOpenAnim (copy)
    if not p35 then
        warn("ActivateCrate | No server Crate!");

        return;
    end;

    local v37 = u2[p35];

    if not v37 then
        warn("ActivateCrate | No state data for server Crate");

        return;
    end;

    local Asset = v37.Asset;

    if not Asset then
        warn("ActivateCrate | No asset!");

        return;
    end;

    local ProximityPrompt = Asset:FindFirstChild("ProximityPrompt");

    if not ProximityPrompt then
        return warn((`CosmeticCrateRenderer:RenderCrate | No Proximity Prompt found for {Asset}`));
    end;

    ProximityPrompt:Destroy();

    for _, v in { "OpenAllPrompt", "SkipAllPrompt", "SkipPrompt" } do
        local v38 = Asset:FindFirstChild(v, true);

        if v38 then
            v38.Enabled = false;
        end;
    end;

    TryDoOpenAnim(p35, p36);
end;

local function CountOwnedCrates() -- Line: 285
    -- upvalues: u2 (copy), LocalPlayer (copy), CosmeticCrates (copy)
    local v39 = 0;
    local v40 = 0;

    for i, v in u2 do
        if i:GetAttribute("OWNER") == LocalPlayer.Name and (i:IsDescendantOf(workspace) and not (v.Asset and v.Asset:GetAttribute("DoingOpen"))) then
            local Attribute = i:GetAttribute("TimeToOpen");

            if Attribute then
                if Attribute <= 0 then
                    v39 = v39 + 1;
                else
                    local Attribute2 = i:GetAttribute("CrateType");

                    if Attribute2 then
                        Attribute2 = CosmeticCrates[Attribute2];
                    end;

                    if not (Attribute2 and Attribute2.TimeIsTimestamp) then
                        v40 = v40 + 1;
                    end;
                end;
            end;
        end;
    end;

    return v39, v40;
end;

local u41 = nil;
local u42 = false;

local function CheckCrateTimer(p43: userdata) -- Line: 313
    -- upvalues: LocalPlayer (copy), u2 (copy), CosmeticCrates (copy), CountOwnedCrates (copy), CrateSkipProducts (copy), u41 (ref)
    if p43:GetAttribute("OWNER") ~= LocalPlayer.Name then
        return;
    end;

    local Attribute = p43:GetAttribute("TimeToOpen");
    local v44 = u2[p43];

    if not v44 then
        warn("CheckCrateTimer | No state data for server Crate");

        return;
    end;

    local Asset = v44.Asset;

    if not Asset then
        warn("CheckCrateTimer | No asset!");

        return;
    end;

    local ProximityPrompt = Asset:FindFirstChild("ProximityPrompt");

    if not ProximityPrompt then
        return warn((`CheckCrateTimer | No Proximity Prompt found for {Asset}`));
    end;

    local Attribute2 = p43:GetAttribute("CrateType");

    if not Attribute2 then
        return warn((`CheckCrateTimer | No CrateType for {p43}`));
    end;

    local v45 = CosmeticCrates[Attribute2].TimeIsTimestamp ~= true;
    local v46 = Attribute <= 0;
    local v47, v48 = CountOwnedCrates();
    ProximityPrompt.Enabled = v46;
    local OpenAllPrompt = Asset:FindFirstChild("OpenAllPrompt", true);

    if OpenAllPrompt then
        OpenAllPrompt.ObjectText = `{v47} Crates`;
        local v49;

        if v46 then
            v49 = v47 >= 2;
        else
            v49 = v46;
        end;

        OpenAllPrompt.Enabled = v49;
    end;

    local SkipAllPrompt = Asset:FindFirstChild("SkipAllPrompt", true);

    if SkipAllPrompt then
        local math_min_ret = math.min(v48, #CrateSkipProducts);
        local v50 = CrateSkipProducts[math_min_ret];
        SkipAllPrompt.ObjectText = `{math_min_ret} Crates`;
        local v51 = not v46;

        if v51 then
            if v48 >= 2 and v50 ~= nil then
                v51 = v50 > 0;
            else
                v51 = false;
            end;
        end;

        SkipAllPrompt.Enabled = v51;
    end;

    if v45 then
        local SkipPrompt = Asset:FindFirstChild("SkipPrompt");

        if SkipPrompt then
            SkipPrompt.Enabled = not v46;
        else
            warn((`CheckCrateTimer | No Skip Prompt found for {Asset}`));
        end;
    end;

    if v46 then
        if not v44.WasReady then
            v44.WasReady = true;
            u41();
        end;
    else
        v44.WasReady = false;
    end;
end;

u41 = function() -- Line: 368, Name: RefreshAllCratePrompts
    -- upvalues: u42 (ref), u2 (copy), LocalPlayer (copy), CheckCrateTimer (copy)
    if u42 then
        return;
    end;

    u42 = true;

    for i, v in u2 do
        if i:GetAttribute("OWNER") == LocalPlayer.Name and (v.PromptsReady and (i:IsDescendantOf(workspace) and not (v.Asset and v.Asset:GetAttribute("DoingOpen")))) then
            CheckCrateTimer(i);
        end;
    end;

    u42 = false;
end;

function u1.RenderCrate(p52: table, u53: userdata) -- Line: 385
    -- upvalues: SelectiveAssetReplication (copy), CheckCrateTimer (copy), u2 (copy), LocalPlayer (copy), ReplicatedStorage (copy), CosmeticCrateService (copy), CosmeticCrates (copy)
    if not u53:GetAttribute("READY") then
        u53:GetAttributeChangedSignal("READY"):Wait();
    end;

    local Attribute = u53:GetAttribute("CrateType");

    if not Attribute then
        local v54 = 0;

        repeat
            task.wait(0.5);
            Attribute = u53:GetAttribute("CrateType");
            print("tryting to CrateType for", u53:GetFullName(), Attribute);
            v54 = v54 + 1;
        until v54 >= 5 or Attribute;
    end;

    if not Attribute then
        return;
    end;

    local v55 = 0;
    local v56;

    repeat
        v56 = SelectiveAssetReplication:GetAssetAsync("CrateModels", Attribute, 5);
        v55 = v55 + 1;
    until v56 or (v55 >= 6 or not u53:IsDescendantOf(workspace));

    if not u53:IsDescendantOf(workspace) then
        return;
    end;

    if not v56 then
        return warn((`Could not find Crate model associated with {Attribute} after {v55} attempts`));
    end;

    local u57 = v56:Clone();
    u57.PrimaryPart.Anchored = true;
    local u58 = Vector3.new(0, 1.5, 0);
    local u59 = 0;
    task.spawn(function() -- Line: 435
        -- upvalues: u59 (ref), u58 (ref), u57 (copy), u53 (copy)
        while u59 < 0.25 do
            u59 = u59 + game:GetService("RunService").Heartbeat:Wait();
            u58 = (Vector3.new(0, 3, 0)):Lerp(Vector3.new(0, 0, 0), (game.TweenService:GetValue(u59 / 0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)));
            local Y = u57:GetExtentsSize().Y;
            u57:PivotTo(u53:GetPivot() * CFrame.new(0, u58.Y + Y * 0.5, 0));
        end;
    end);
    u53:GetAttributeChangedSignal("TimeToOpen"):Connect(function() -- Line: 448
        -- upvalues: CheckCrateTimer (ref), u53 (copy)
        CheckCrateTimer(u53);
    end);
    u2[u53] = {
        Asset = u57
    };
    local Y = u57:GetExtentsSize().Y;
    u57:PivotTo(u53:GetPivot() * CFrame.new(0, u58.Y + Y * 0.4, 0));
    u57.Parent = u53;

    if u53:GetAttribute("OWNER") ~= LocalPlayer.Name then
        return;
    end;

    local v60 = ReplicatedStorage.ProximityPrompt:Clone();

    if not v60 then
        return warn("CosmeticCrateRenderer:RenderCrate | No Proximity Prompt found in ReplicatedStorage!");
    end;

    v60.Parent = u57;
    v60.ActionText = "Open!";
    v60.HoldDuration = 1;
    v60.Enabled = false;
    v60.Triggered:Connect(function() -- Line: 469
        -- upvalues: CosmeticCrateService (ref), u53 (copy)
        CosmeticCrateService:FireServer("OpenCrate", u53);
    end);
    local v61 = CosmeticCrates[Attribute].TimeIsTimestamp ~= true;

    if v61 then
        local v62 = ReplicatedStorage.ProximityPrompt:Clone();

        if not v62 then
            return warn("CosmeticCrateRenderer:RenderCrate | No Proximity Prompt found in ReplicatedStorage!");
        end;

        v62.Parent = u57;
        v62.ActionText = "Skip Open Time";
        v62.Name = "SkipPrompt";
        v62.HoldDuration = 1;
        v62.Enabled = false;
        v62.Triggered:Connect(function() -- Line: 484
            -- upvalues: CosmeticCrateService (ref), u53 (copy)
            CosmeticCrateService:FireServer("AuthorisePurchase", u53);
        end);
    end;

    local v63 = -(u57:GetExtentsSize().Y * 0.5 + 0.75);
    local Vector3_new_ret = Vector3.new(0, v63, 0);
    local v64 = ReplicatedStorage.ProximityPrompt:Clone();
    v64.Name = "OpenAllPrompt";
    v64.ActionText = "Open All";
    v64.HoldDuration = 1;
    v64.KeyboardKeyCode = Enum.KeyCode.R;
    v64.GamepadKeyCode = Enum.KeyCode.ButtonY;
    v64.Enabled = false;
    local PrimaryPart = u57.PrimaryPart;

    if PrimaryPart then
        local Attachment = Instance.new("Attachment");
        Attachment.Name = `{v64.Name}Att`;
        Attachment.CFrame = CFrame.new(Vector3_new_ret);
        Attachment.Parent = PrimaryPart;
        v64.Parent = Attachment;
    else
        v64.Parent = u57;
    end;

    v64.Triggered:Connect(function() -- Line: 500
        -- upvalues: CosmeticCrateService (ref)
        CosmeticCrateService:FireServer("OpenAllCrates");
    end);

    if v61 then
        local v65 = ReplicatedStorage.ProximityPrompt:Clone();
        v65.Name = "SkipAllPrompt";
        v65.ActionText = "Skip All Open Time";
        v65.HoldDuration = 1;
        v65.KeyboardKeyCode = Enum.KeyCode.R;
        v65.GamepadKeyCode = Enum.KeyCode.ButtonY;
        v65.Enabled = false;
        local PrimaryPart2 = u57.PrimaryPart;

        if PrimaryPart2 then
            local Attachment = Instance.new("Attachment");
            Attachment.Name = `{v65.Name}Att`;
            Attachment.CFrame = CFrame.new(Vector3_new_ret);
            Attachment.Parent = PrimaryPart2;
            v65.Parent = Attachment;
        else
            v65.Parent = u57;
        end;

        v65.Triggered:Connect(function() -- Line: 513
            -- upvalues: CosmeticCrateService (ref)
            CosmeticCrateService:FireServer("AuthoriseMultiSkipPurchase");
        end);
    end;

    if u2[u53] then
        u2[u53].PromptsReady = true;
    end;

    CheckCrateTimer(u53);
end;

function u1.DerenderCrate(p66: table, p67: userdata) -- Line: 526
    -- upvalues: u2 (copy), u41 (ref)
    if not p67 then
        warn("CosmeticCrateRenderer:DerenderCrate | No server Crate to derender");

        return;
    end;

    local v68 = u2[p67];

    if not v68 then
        warn("CosmeticCrateRenderer:DerenderCrate | No state data for server Crate");

        return;
    end;

    local Asset = v68.Asset;

    if not Asset then
        warn("CosmeticCrateRenderer:DerenderCrate | No asset to derender");

        return;
    end;

    if not Asset:GetAttribute("DoingOpen") then
        Asset:Destroy();
        u2[p67] = nil;
    end;

    u41();
end;

CreateTagHandler({
    Tag = "CosmeticCrateServer",

    OnInstanceAdded = function(p69: userdata) -- Line: 547, Name: OnInstanceAdded
        -- upvalues: u1 (copy)
        if not p69:IsDescendantOf(workspace) then
            return;
        end;

        u1:RenderCrate(p69);
    end,

    OnInstanceRemoved = function(p70) -- Line: 551, Name: OnInstanceRemoved
        -- upvalues: u1 (copy)
        u1:DerenderCrate(p70);
    end
});
CrateReadyToOpen_RE.OnClientEvent:Connect(function(p71: string, p72: string) -- Line: 556
    -- upvalues: u3 (copy)
    u3[p72] = p71;
end);
CosmeticCrateService.OnClientEvent:Connect(function(p73, p74) -- Line: 560
    -- upvalues: ActivateCrate (copy)
    ActivateCrate(p73, p74);
end);

return u1;