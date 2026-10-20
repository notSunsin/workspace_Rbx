-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
game:GetService("ServerScriptService");
game:GetService("RunService");
local _ = ReplicatedStorage.Assets.SFX;
local _ = ReplicatedStorage.Assets.VFX;
require(ReplicatedStorage.Modules.TweenModel);
local CreateTagHandler = require(ReplicatedStorage.Modules.CreateTagHandler);
local Assets = ReplicatedStorage:WaitForChild("Assets");
local EggModels = Assets:WaitForChild("Models"):WaitForChild("EggModels");
local PetRegistry = require(ReplicatedStorage.Data.PetRegistry);
local EggSkipProducts = require(ReplicatedStorage.Data.PetRegistry.EggSkipProducts);
local UpdateService = require(ReplicatedStorage.Modules.UpdateService);
local _ = PetRegistry.PetList;
local _ = Assets.SFX;
local _ = Assets.VFX;
game:GetService("TweenService");
local PetEggService = ReplicatedStorage.GameEvents.PetEggService;
local PetSkipped = ReplicatedStorage.GameEvents.PetSkipped;
local EggReadyToHatch_RE = ReplicatedStorage.GameEvents.EggReadyToHatch_RE;
local u1 = {};
local u2 = {};
local u3 = {};
local u4 = {};

for _, child in script.EggEffects:GetChildren() do
    u1[child.Name] = require(child);
end;

local LocalPlayer = game.Players.LocalPlayer;

local function CreateProximityPromptAttachment(p5: userdata, p6: userdata, p7: vector) -- Line: 42
    local Attachment = Instance.new("Attachment");
    Attachment.Parent = p5;
    Attachment.Name = `{p6.Name}Att`;
    Attachment.CFrame = CFrame.new(p7);
    p6.Parent = Attachment;

    return Attachment;
end;

local function UpdateAttachmentHeight(p8: userdata, p9: userdata) -- Line: 55
    if not p8 then
        return;
    end;

    if not p9 then
        return;
    end;

    local Y = p8:GetExtentsSize().Y;
    p9.CFrame = CFrame.new(0, Y, 0);
end;

local function PlaySound(p10: userdata) -- Line: 63
    local u11 = p10:Clone();
    u11.Parent = workspace;
    u11:Play();
    u11.Ended:Once(function() -- Line: 68
        -- upvalues: u11 (copy)
        u11:Destroy();
    end);
end;

local function TryDoHatchAnim(p12: userdata, p13: number) -- Line: 74
    -- upvalues: u3 (copy), u4 (copy), u1 (copy)
    if not p12 then
        warn("DoHatchAnim | No server egg!");

        return;
    end;

    local v14 = u3[p12];

    if not v14 then
        warn("DoHatchAnim | No state data for server egg");

        return;
    end;

    local Asset = v14.Asset;

    if not Asset then
        warn("DoHatchAnim | No asset!");

        return;
    end;

    local Attribute = p12:GetAttribute("OBJECT_UUID");

    if not Attribute then
        return warn("DoHatchAnim | No egg uuid!");
    end;

    if Asset:GetAttribute("DoingHatch") then
        return;
    end;

    Asset:SetAttribute("DoingHatch", true);
    Asset.Parent = workspace.Visuals;
    local v15 = u4[Attribute];
    local Attribute2 = p12:GetAttribute("EggName");

    if u1[Attribute2] then
        u1[Attribute2](Asset, v15, p13);

        return;
    end;

    if Attribute2 == "Rare Egg" or (Attribute2 == "Legendary Egg" or Attribute2 == "Mythical Egg") then
        u1.Rare(Asset, v15, p13);

        return;
    end;

    u1.Normal(Asset, v15, p13);
end;

local function ActivateEgg(p16: userdata, p17: number) -- Line: 105
    -- upvalues: u3 (copy), TryDoHatchAnim (copy)
    if not p16 then
        warn("ActivateEgg | No server egg!");

        return;
    end;

    local v18 = u3[p16];

    if not v18 then
        warn("ActivateEgg | No state data for server egg");

        return;
    end;

    local Asset = v18.Asset;

    if not Asset then
        warn("ActivateEgg | No asset!");

        return;
    end;

    local PetEgg = p16:FindFirstChild("PetEgg");
    local v19;

    if PetEgg then
        v19 = (PetEgg:FindFirstChild("ProximityPromptAtt") or Asset):FindFirstChild("ProximityPrompt");
    else
        v19 = nil;
    end;

    if v19 then
        v19:Destroy();
    end;

    TryDoHatchAnim(p16, p17);
end;

local function CountReadyEggs() -- Line: 136
    -- upvalues: u3 (copy), LocalPlayer (copy)
    local v20 = 0;

    for i, v in u3 do
        if i:GetAttribute("OWNER") == LocalPlayer.Name and (i:IsDescendantOf(workspace) and not (v.Asset and v.Asset:GetAttribute("DoingHatch"))) then
            local Attribute = i:GetAttribute("TimeToHatch");

            if Attribute and Attribute <= 0 then
                v20 = v20 + 1;
            end;
        end;
    end;

    return v20;
end;

local u21 = nil;
local u22 = false;

local function CheckEggTimer(p23: userdata, p24: boolean?) -- Line: 158
    -- upvalues: LocalPlayer (copy), u3 (copy), CountReadyEggs (copy), u21 (ref), EggSkipProducts (copy), UpdateService (copy)
    if p23:GetAttribute("OWNER") ~= LocalPlayer.Name then
        return;
    end;

    local Attribute = p23:GetAttribute("TimeToHatch");
    local v25 = u3[p23];

    if not v25 then
        warn("CheckEggTimer | No state data for server egg");

        return;
    end;

    local Asset = v25.Asset;

    if not Asset then
        warn("CheckEggTimer | No asset!");

        return;
    end;

    local PetEgg = p23:FindFirstChild("PetEgg");

    if not PetEgg and p24 then
        PetEgg = p23:WaitForChild("PetEgg", 5);
    end;

    local v26 = PetEgg or p23;
    local v27 = v26:FindFirstChild("ProximityPromptAtt") or p23:FindFirstChild("ProximityPromptAtt");
    local v28 = v26:FindFirstChild("SkipAllPromptAtt") or p23:FindFirstChild("SkipAllPromptAtt") or p23;
    local v29 = v26:FindFirstChild("SkipPromptAtt") or p23:FindFirstChild("SkipPromptAtt");
    local ProximityPrompt = (v27 or p23):FindFirstChild("ProximityPrompt");
    local HatchAllPrompt = (v26:FindFirstChild("HatchAllPromptAtt") or p23:FindFirstChild("HatchAllPromptAtt") or p23):FindFirstChild("HatchAllPrompt");
    local SkipAllPrompt = v28:FindFirstChild("SkipAllPrompt");
    local SkipPrompt = (v29 or p23):FindFirstChild("SkipPrompt");

    if not ProximityPrompt then
        return warn((`CheckEggTimer | No Proximity Prompt found for {Asset}`));
    end;

    if not SkipPrompt then
        return warn((`CheckEggTimer | No Skip Prompt found for {Asset}`));
    end;

    if p23 and v27 then
        local Y = p23:GetExtentsSize().Y;
        v27.CFrame = CFrame.new(0, Y, 0);
    end;

    if p23 and v29 then
        local Y = p23:GetExtentsSize().Y;
        v29.CFrame = CFrame.new(0, Y, 0);
    end;

    local Attribute2 = p23:GetAttribute("ShowTime");

    if not Attribute2 and true or Attribute2 <= workspace:GetServerTimeNow() then
        if Attribute <= 0 then
            ProximityPrompt.Enabled = true;
            SkipAllPrompt.Enabled = false;
            SkipPrompt.Enabled = false;
            local v30 = CountReadyEggs();

            if HatchAllPrompt then
                HatchAllPrompt.ObjectText = `{v30} Eggs`;
                HatchAllPrompt.Enabled = v30 >= 2;
            end;

            if not v25.WasReady then
                v25.WasReady = true;
                u21();

                return;
            end;
        else
            ProximityPrompt.Enabled = false;
            v25.WasReady = false;

            if HatchAllPrompt then
                HatchAllPrompt.Enabled = false;
            end;

            local v31 = 0;

            for i, _ in u3 do
                if i:GetAttribute("OWNER") == LocalPlayer.Name and i:GetAttribute("TimeToHatch") > 0 then
                    v31 = v31 + 1;
                end;
            end;

            SkipAllPrompt.ObjectText = `{math.min(v31, #EggSkipProducts)} Eggs`;
            local v32;

            if v31 >= 2 then
                v32 = not UpdateService:IsHiddenFromUpdate("Multi Egg Skip");
            else
                v32 = false;
            end;

            SkipAllPrompt.Enabled = v32;
            SkipPrompt.Enabled = true;
        end;

        return;
    end;

    SkipAllPrompt.Enabled = false;

    if HatchAllPrompt then
        HatchAllPrompt.Enabled = false;
    end;

    ProximityPrompt.Enabled = false;
    SkipPrompt.Enabled = false;
end;

u21 = function() -- Line: 276, Name: RefreshAllEggPrompts
    -- upvalues: u22 (ref), u3 (copy), LocalPlayer (copy), CheckEggTimer (copy)
    if u22 then
        return;
    end;

    u22 = true;

    for i, v in u3 do
        if i:GetAttribute("OWNER") == LocalPlayer.Name and (v.PromptsReady and (i:IsDescendantOf(workspace) and not (v.Asset and v.Asset:GetAttribute("DoingHatch")))) then
            CheckEggTimer(i, false);
        end;
    end;

    u22 = false;
end;

function u2.RenderEgg(p33: table, u34: userdata) -- Line: 294
    -- upvalues: EggModels (copy), PetRegistry (copy), CheckEggTimer (copy), u3 (copy), LocalPlayer (copy), ReplicatedStorage (copy), PetEggService (copy)
    if not u34:GetAttribute("READY") then
        u34:GetAttributeChangedSignal("READY"):Wait();
    end;

    local Attribute = u34:GetAttribute("ShowTime");

    if Attribute then
        local _ = Attribute <= workspace:GetServerTimeNow();
    end;

    local Attribute2 = u34:GetAttribute("EggName");

    if not Attribute2 then
        local v35 = 0;

        repeat
            task.wait(0.5);
            Attribute2 = u34:GetAttribute("EggName");
            v35 = v35 + 1;
        until v35 >= 5 or Attribute2;
    end;

    if not Attribute2 then
        return;
    end;

    local v36 = EggModels:FindFirstChild(Attribute2);

    if not v36 then
        return warn((`Could not find egg model associated with {Attribute2}`));
    end;

    local u37 = v36:Clone();
    u37.PrimaryPart.Anchored = true;
    local HatchTime = PetRegistry.PetEggs[Attribute2].HatchTime;
    local v38 = 1 - 0.5 * (u34:GetAttribute("TimeToHatch") / HatchTime);
    u37:ScaleTo((math.clamp(v38, 0.2, 1)));
    workspace.Terrain.EggParticle.WorldCFrame = u34:GetPivot();

    for _, descendant in workspace.Terrain.EggParticle:GetDescendants() do
        descendant:Emit(descendant:GetAttribute("EmitCount"));
    end;

    local u39 = Vector3.new(0, 1.5, 0);
    local u40 = 0;
    task.spawn(function() -- Line: 341
        -- upvalues: u40 (ref), u39 (ref), u37 (copy), u34 (copy)
        while u40 < 0.25 do
            u40 = u40 + game:GetService("RunService").Heartbeat:Wait();
            u39 = (Vector3.new(0, 3, 0)):Lerp(Vector3.new(0, 0, 0), (game.TweenService:GetValue(u40 / 0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)));
            local Y = u37:GetExtentsSize().Y;
            u37:PivotTo(u34:GetPivot() * CFrame.new(0, u39.Y + Y * 0.5, 0));
        end;
    end);
    u34:GetAttributeChangedSignal("TimeToHatch"):Connect(function() -- Line: 354
        -- upvalues: u37 (copy), u34 (copy), HatchTime (copy), u39 (ref), CheckEggTimer (ref)
        local v41 = 1 - 0.5 * (u34:GetAttribute("TimeToHatch") / HatchTime);
        u37:ScaleTo((math.clamp(v41, 0.2, 1)));
        local Y = u37:GetExtentsSize().Y;
        u37:PivotTo(u34:GetPivot() * CFrame.new(0, u39.Y + Y * 0.5, 0));
        CheckEggTimer(u34, false);
    end);
    u3[u34] = {
        Asset = u37
    };
    local Y = u37:GetExtentsSize().Y;
    u37:PivotTo(u34:GetPivot() * CFrame.new(0, u39.Y + Y * 0.4, 0));
    u37.Parent = u34;

    if u34:GetAttribute("OWNER") ~= LocalPlayer.Name then
        return;
    end;

    local v42 = u34:WaitForChild("PetEgg", 5) or u34;
    local v43 = ReplicatedStorage.ProximityPrompt:Clone();
    v43.ActionText = "Hatch!";
    v43.HoldDuration = 1;
    v43.Enabled = false;
    v43.Parent = v42;
    v43.Triggered:Connect(function() -- Line: 394
        -- upvalues: PetEggService (ref), u34 (copy)
        PetEggService:FireServer("HatchPet", u34);
    end);
    local v44 = ReplicatedStorage.ProximityPrompt:Clone();
    v44.Name = "SkipAllPrompt";
    v44.ActionText = "Skip All Growth";
    v44.HoldDuration = 1;
    v44.KeyboardKeyCode = Enum.KeyCode.R;
    v44.GamepadKeyCode = Enum.KeyCode.ButtonY;
    v44.Enabled = false;
    v44.Parent = v42;
    v44.Triggered:Connect(function() -- Line: 407
        -- upvalues: PetEggService (ref), u34 (copy)
        PetEggService:FireServer("AuthoriseMultiPurchase", u34);
    end);
    local v45 = ReplicatedStorage.ProximityPrompt:Clone();
    v45.ActionText = "Skip Growth";
    v45.Name = "SkipPrompt";
    v45.HoldDuration = 1;
    v45.Enabled = false;
    v45.Parent = v42;
    v45.Triggered:Connect(function() -- Line: 417
        -- upvalues: PetEggService (ref), u34 (copy)
        PetEggService:FireServer("AuthorisePurchase", u34);
    end);
    local v46 = ReplicatedStorage.ProximityPrompt:Clone();
    v46.Name = "HatchAllPrompt";
    v46.ActionText = "Hatch All";
    v46.HoldDuration = 1;
    v46.KeyboardKeyCode = Enum.KeyCode.R;
    v46.GamepadKeyCode = Enum.KeyCode.ButtonY;
    v46.Enabled = false;
    v46.Parent = v42;
    v46.Triggered:Connect(function() -- Line: 429
        -- upvalues: PetEggService (ref)
        PetEggService:FireServer("HatchAllPets");
    end);
    local Attachment = Instance.new("Attachment");
    Attachment.Parent = v42;
    Attachment.Name = `{v43.Name}Att`;
    Attachment.CFrame = CFrame.new(Vector3.new(0, 0, 0));
    v43.Parent = Attachment;
    local Attachment2 = Instance.new("Attachment");
    Attachment2.Parent = v42;
    Attachment2.Name = `{v44.Name}Att`;
    Attachment2.CFrame = CFrame.new(Vector3.new(0, -1, 0));
    v44.Parent = Attachment2;
    local Attachment3 = Instance.new("Attachment");
    Attachment3.Parent = v42;
    Attachment3.Name = `{v46.Name}Att`;
    Attachment3.CFrame = CFrame.new(Vector3.new(0, -1, 0));
    v46.Parent = Attachment3;
    local Attachment4 = Instance.new("Attachment");
    Attachment4.Parent = v42;
    Attachment4.Name = `{v45.Name}Att`;
    Attachment4.CFrame = CFrame.new(Vector3.new(0, 0, 0));
    v45.Parent = Attachment4;

    if u3[u34] then
        u3[u34].PromptsReady = true;
    end;

    CheckEggTimer(u34, true);

    if u34 and Attachment then
        local Y2 = u34:GetExtentsSize().Y;
        Attachment.CFrame = CFrame.new(0, Y2, 0);
    end;

    if u34 and Attachment4 then
        local Y2 = u34:GetExtentsSize().Y;
        Attachment4.CFrame = CFrame.new(0, Y2, 0);
    end;
end;

function u2.DerenderEgg(p47: table, p48: userdata) -- Line: 450
    -- upvalues: u3 (copy), u21 (ref)
    if not p48 then
        warn("PetEggRender:DerenderEgg | No server egg to derender");

        return;
    end;

    local v49 = u3[p48];

    if not v49 then
        warn("PetEggRender:DerenderEgg | No state data for server egg");

        return;
    end;

    local Asset = v49.Asset;

    if not Asset then
        warn("PetEggRender:DerenderEgg | No asset to derender");

        return;
    end;

    if not Asset:GetAttribute("DoingHatch") then
        Asset:Destroy();
    end;

    u21();
end;

CreateTagHandler({
    Tag = "PetEggServer",

    OnInstanceAdded = function(p50: userdata) -- Line: 470, Name: OnInstanceAdded
        -- upvalues: u2 (copy)
        if not p50:IsDescendantOf(workspace) then
            return;
        end;

        u2:RenderEgg(p50);
    end,

    OnInstanceRemoved = function(p51) -- Line: 474, Name: OnInstanceRemoved
        -- upvalues: u2 (copy)
        u2:DerenderEgg(p51);
    end
});
EggReadyToHatch_RE.OnClientEvent:Connect(function(p52: string, p53: string) -- Line: 479
    -- upvalues: u4 (copy)
    u4[p53] = p52;
end);
PetEggService.OnClientEvent:Connect(function(p54, p55) -- Line: 483
    -- upvalues: ActivateEgg (copy)
    ActivateEgg(p54, p55);
end);
local script_SkipEgg = require(script.SkipEgg);
PetSkipped.OnClientEvent:Connect(function(p56) -- Line: 488
    -- upvalues: script_SkipEgg (copy)
    script_SkipEgg(p56);
end);
local GetFarm = require(ReplicatedStorage.Modules.GetFarm);
require(ReplicatedStorage.Modules.SaveSlotControllers.SaveSlotController):GetSaveSlotChangeSignal():Connect(function() -- Line: 495
    -- upvalues: GetFarm (copy), LocalPlayer (copy), u3 (copy)
    local v57 = GetFarm(LocalPlayer);

    if v57 then
        for i, _ in u3 do
            if not i:IsDescendantOf(v57) then
                u3[i] = nil;
            end;
        end;

        return;
    end;

    warn("No player farm");
end);

return u2;