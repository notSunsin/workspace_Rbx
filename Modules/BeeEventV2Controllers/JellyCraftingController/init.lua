-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local ConfirmationPromptController = require(ReplicatedStorage.Modules.ConfirmationPromptController);
local SelectiveAssetReplication = require(ReplicatedStorage.Modules.SelectiveAssetReplication);
local CreateTagHandler = require(ReplicatedStorage.Modules.CreateTagHandler);
local InventoryService = require(ReplicatedStorage.Modules.InventoryService);
local Notification = require(ReplicatedStorage.Modules.Notification);
require(ReplicatedStorage.Data.DevProductIds);
local DataService = require(ReplicatedStorage.Modules.DataService);
local SoundPlayer = require(ReplicatedStorage.Modules.SoundPlayer);
local Trove = require(ReplicatedStorage.Modules.Trove);
local SeedData = require(ReplicatedStorage.Data.SeedData);
local Spring = require(ReplicatedStorage.Modules.Spring);
local Chalk = require(ReplicatedStorage.Modules.Chalk);
local script_JellyConfig = require(script.JellyConfig);
local LocalPlayer = Players.LocalPlayer;
local JellyCrafting = ReplicatedStorage.GameEvents.JellyCrafting;
local u1 = {
    States = {}
};

local function FormatTime(p2: number) -- Line: 34
    local math_floor_ret = math.floor(p2);
    local math_max_ret = math.max(0, math_floor_ret);

    if math_max_ret < 60 then
        return `{math_max_ret}s`;
    end;

    if math_max_ret < 3600 then
        return string.format("%d:%02d", math_max_ret // 60, math_max_ret % 60);
    end;

    return string.format("%d:%02d:%02d", math_max_ret // 3600, math_max_ret % 3600 // 60, math_max_ret % 60);
end;

local function GetCraftTime(p3) -- Line: 45
    -- upvalues: script_JellyConfig (copy), SeedData (copy)
    if not (p3 and p3.ItemName) then
        return script_JellyConfig.CRAFT_TIMES.Transcendent;
    end;

    local v4 = SeedData[p3.ItemName];

    if v4 then
        v4 = v4.SeedRarity;
    end;

    return script_JellyConfig.CRAFT_TIMES[v4] or script_JellyConfig.CRAFT_TIMES.Transcendent;
end;

local function GetPrice(p5: string) -- Line: 56
    -- upvalues: SeedData (copy), script_JellyConfig (copy)
    local v6 = SeedData[p5];

    if v6 then
        v6 = v6.SeedRarity;
    end;

    return script_JellyConfig.PRICES[v6] or script_JellyConfig.PRICE_FALLBACK;
end;

local function Notify(p7: string) -- Line: 62
    -- upvalues: Notification (copy), script_JellyConfig (copy), Chalk (copy)
    if script_JellyConfig.NOTIFICATION_COLOR then
        p7 = Chalk.color(script_JellyConfig.NOTIFICATION_COLOR)(p7) or p7;
    end;

    Notification:CreateNotification(p7);
end;

local function GetRotatable(p8: userdata) -- Line: 66
    local v9 = p8:FindFirstChild("Machine") and p8.Machine:FindFirstChild("Centrifuge") and p8.Machine.Centrifuge:FindFirstChild("Rotatable");

    return v9;
end;

local function GetTank(p10: userdata) -- Line: 70
    local Machine = p10:FindFirstChild("Machine");

    if Machine then
        Machine = Machine:FindFirstChild("Tank");
    end;

    return Machine;
end;

local function GetMachineSoundParent(p11: userdata) -- Line: 75
    local Machine = p11:FindFirstChild("Machine");

    if Machine then
        Machine = Machine:FindFirstChild("Tank");
    end;

    if Machine then
        Machine = Machine:FindFirstChild("Container");
    end;

    return Machine;
end;

local function IsMachineInWorld(p12: userdata) -- Line: 83
    return p12:IsDescendantOf(workspace);
end;

local function PlayMachineSound(p13: any, p14: string, p15: any) -- Line: 87
    -- upvalues: SoundPlayer (copy)
    if not p13.Machine:IsDescendantOf(workspace) then
        return;
    end;

    local Machine = p13.Machine:FindFirstChild("Machine");

    if Machine then
        Machine = Machine:FindFirstChild("Tank");
    end;

    if Machine then
        Machine = Machine:FindFirstChild("Container");
    end;

    if Machine then
        return SoundPlayer:PlaySound(p14, p15 or {
            RollOffMaxDistance = 80,
            RollOffMinDistance = 8,
            Volume = 0.65,
            RollOffMode = Enum.RollOffMode.InverseTapered
        }, nil, Machine, { "JellyCraftingSound" });
    end;
end;

local function StopLoopSound(p16) -- Line: 103
    if p16.LoopSound then
        p16.LoopSound:Stop();
        p16.LoopSound:Destroy();
        p16.LoopSound = nil;
    end;
end;

local function StartLoopSound(p17) -- Line: 111
    -- upvalues: PlayMachineSound (copy), script_JellyConfig (copy)
    if p17.LoopSound or not p17.Machine:IsDescendantOf(workspace) then
        return;
    end;

    local v18 = PlayMachineSound(p17, script_JellyConfig.SOUND_ENUMS.Loop, {
        RollOffMaxDistance = 80,
        RollOffMinDistance = 8,
        Volume = 0.45,
        Looped = true,
        FadeInDuration = 0.4,
        RollOffMode = Enum.RollOffMode.InverseTapered
    });

    if not v18 then
        return;
    end;

    if not p17.LoopSound and (p17.IsCrafting and p17.Machine:IsDescendantOf(workspace)) then
        p17.LoopSound = v18;

        return;
    end;

    v18:Stop();
    v18:Destroy();
end;

local function StopCentrifuge(p19) -- Line: 133
    if p19.CentrifugeThread then
        pcall(task.cancel, p19.CentrifugeThread);
        p19.CentrifugeThread = nil;
    end;

    if p19.CentrifugeDriver then
        p19.CentrifugeDriver:Destroy();
        p19.CentrifugeDriver = nil;
    end;

    if p19.LoopSound then
        p19.LoopSound:Stop();
        p19.LoopSound:Destroy();
        p19.LoopSound = nil;
    end;
end;

local function StartCentrifuge(u20) -- Line: 147
    -- upvalues: StartLoopSound (copy), Spring (copy), PlayMachineSound (copy), script_JellyConfig (copy)
    if u20.CentrifugeThread then
        return;
    end;

    local Machine = u20.Machine;
    local u21 = Machine:FindFirstChild("Machine") and Machine.Machine:FindFirstChild("Centrifuge") and Machine.Machine.Centrifuge:FindFirstChild("Rotatable");

    if not u21 then
        return;
    end;

    local Pivot = u21:GetPivot();
    local NumberValue = Instance.new("NumberValue");
    NumberValue.Value = 0;
    u20.CentrifugeDriver = NumberValue;
    local u22 = 0;
    task.spawn(StartLoopSound, u20);
    u20.Trove:Add(NumberValue.Changed:Connect(function(p23) -- Line: 163
        -- upvalues: u22 (ref), u21 (copy)
        local math_rad_ret = math.rad(p23 - u22);
        u22 = p23;
        u21:PivotTo(u21:GetPivot() * CFrame.Angles(0, math_rad_ret, 0));
    end));
    u20.Trove:Add(function() -- Line: 170
        -- upvalues: u20 (copy), u21 (copy), Pivot (copy)
        local v24 = u20;

        if v24.CentrifugeThread then
            pcall(task.cancel, v24.CentrifugeThread);
            v24.CentrifugeThread = nil;
        end;

        if v24.CentrifugeDriver then
            v24.CentrifugeDriver:Destroy();
            v24.CentrifugeDriver = nil;
        end;

        if v24.LoopSound then
            v24.LoopSound:Stop();
            v24.LoopSound:Destroy();
            v24.LoopSound = nil;
        end;

        if u21 then
            u21:PivotTo(Pivot);
        end;
    end);
    u20.CentrifugeThread = task.spawn(function() -- Line: 177
        -- upvalues: u20 (copy), Spring (ref), NumberValue (copy), u22 (ref), PlayMachineSound (ref), script_JellyConfig (ref)
        while u20.IsCrafting do
            Spring.stop(NumberValue, "Value");
            NumberValue.Value = 0;
            u22 = 0;
            Spring.target(NumberValue, 0.6, 1, {
                Value = 360
            });
            PlayMachineSound(u20, script_JellyConfig.SOUND_ENUMS.Spin, {
                RollOffMaxDistance = 80,
                RollOffMinDistance = 8,
                Volume = 0.75,
                TimePosition = 0.45,
                RollOffMode = Enum.RollOffMode.InverseTapered
            });
            task.wait(1.25);

            if not u20.IsCrafting then
                break;
            end;

            task.wait(0.75);
        end;
    end);
end;

local function SetCentrifugesActive(p25: boolean) -- Line: 203
    -- upvalues: u1 (copy), StartCentrifuge (copy)
    for _, v in u1.States do
        v.IsCrafting = p25;

        if p25 then
            StartCentrifuge(v);
        else
            if v.CentrifugeThread then
                pcall(task.cancel, v.CentrifugeThread);
                v.CentrifugeThread = nil;
            end;

            if v.CentrifugeDriver then
                v.CentrifugeDriver:Destroy();
                v.CentrifugeDriver = nil;
            end;

            if v.LoopSound then
                v.LoopSound:Stop();
                v.LoopSound:Destroy();
                v.LoopSound = nil;
            end;
        end;
    end;
end;

local function GetSeedCenterCFrame(p26: userdata) -- Line: 215
    local Machine = p26:FindFirstChild("Machine");

    if Machine then
        Machine = Machine:FindFirstChild("Tank");
    end;

    if Machine then
        Machine = Machine:FindFirstChild("Container");
    end;

    if Machine and Machine:IsA("BasePart") then
        return Machine.CFrame;
    end;
end;

local function CacheBlobBaseCFrames(p27) -- Line: 224
    p27.BlobBaseCFrames = {};
    local Machine = p27.Machine:FindFirstChild("Machine");

    if Machine then
        Machine = Machine:FindFirstChild("Tank");
    end;

    if not Machine then
        return;
    end;

    for _, child in Machine:GetChildren() do
        if child.Name == "Blob" and child:IsA("BasePart") then
            p27.BlobBaseCFrames[child] = child.CFrame;
        end;
    end;
end;

local function DestroyFloatingSeed(p28) -- Line: 237
    if p28.FloatingSeed then
        p28.FloatingSeed:Destroy();
        p28.FloatingSeed = nil;
    end;

    p28.SeedModelT = 0;
end;

local function UpdateFloatingSeedModel(p29) -- Line: 246
    -- upvalues: DataService (copy), SelectiveAssetReplication (copy)
    if p29.FloatingSeed then
        p29.FloatingSeed:Destroy();
        p29.FloatingSeed = nil;
    end;

    p29.SeedModelT = 0;
    local Data = DataService:GetData();

    if not Data then
        return;
    end;

    local ItemName = (Data.JellyCrafting.StoredItem or {}).ItemName;

    if not ItemName then
        return;
    end;

    local Machine = p29.Machine:FindFirstChild("Machine");

    if Machine then
        Machine = Machine:FindFirstChild("Tank");
    end;

    if Machine then
        Machine = Machine:FindFirstChild("Container");
    end;

    local v30;

    if Machine and Machine:IsA("BasePart") then
        v30 = Machine.CFrame;
    else
        v30 = nil;
    end;

    if not v30 then
        warn("[JellyCraftingController] Could not find Machine.Tank.Container for floating seed");

        return;
    end;

    local AssetAsync = SelectiveAssetReplication:GetAssetAsync("Seed_Models", ItemName);

    if not AssetAsync then
        warn((`[JellyCraftingController] Could not get seed model for {ItemName}`));

        return;
    end;

    local Model = Instance.new("Model");
    Model.Name = "FloatingJellySeed";
    local v31 = AssetAsync:Clone();
    v31.Name = "Seed";
    v31.Parent = Model;

    if v31:IsA("BasePart") then
        v31.Anchored = true;
        v31.CFrame = v30;
    elseif v31:IsA("Model") then
        for _, descendant in v31:GetDescendants() do
            if descendant:IsA("BasePart") then
                descendant.Anchored = true;
            end;
        end;

        v31:PivotTo(v30);
    end;

    Model:ScaleTo(2.5);
    p29.FloatingSeed = Model;
    p29.SeedModelT = 0;
    Model.Parent = p29.Machine;
end;

local function UpdateAllFloatingSeedModels() -- Line: 295
    -- upvalues: u1 (copy), UpdateFloatingSeedModel (copy)
    for _, v in u1.States do
        UpdateFloatingSeedModel(v);
    end;
end;

function u1.Start() -- Line: 301
    -- upvalues: CreateTagHandler (copy), u1 (copy), Trove (copy), StartLoopSound (copy), UpdateFloatingSeedModel (copy), CacheBlobBaseCFrames (copy), DataService (copy), LocalPlayer (copy), Notify (copy), script_JellyConfig (copy), InventoryService (copy), JellyCrafting (copy), ConfirmationPromptController (copy), Chalk (copy), SeedData (copy), StartCentrifuge (copy), FormatTime (copy), PlayMachineSound (copy), RunService (copy)
    CreateTagHandler({
        Tag = "JellyCraftingMachine",

        OnInstanceAdded = function(u32: userdata) -- Line: 304, Name: OnInstanceAdded
            -- upvalues: u1 (ref), Trove (ref), StartLoopSound (ref), UpdateFloatingSeedModel (ref), CacheBlobBaseCFrames (ref), DataService (ref), LocalPlayer (ref), Notify (ref), script_JellyConfig (ref), InventoryService (ref), JellyCrafting (ref), ConfirmationPromptController (ref), Chalk (ref), SeedData (ref)
            u1.States[u32] = {
                IsCrafting = false,
                FloatingSeed = nil,
                SeedBobTime = 0,
                BlobBobTime = 0,
                LoopSound = nil,
                HasPlayedDoneSound = false,
                Trove = Trove.new(),
                Machine = u32,
                BlobBaseCFrames = {}
            };
            local Trove2 = u1.States[u32].Trove;
            Trove2:Add(u32.AncestryChanged:Connect(function() -- Line: 319
                -- upvalues: u1 (ref), u32 (copy), StartLoopSound (ref)
                local v33 = u1.States[u32];

                if not v33 then
                    return;
                end;

                if u32:IsDescendantOf(workspace) then
                    if v33.IsCrafting then
                        task.spawn(StartLoopSound, v33);
                    end;
                elseif v33.LoopSound then
                    v33.LoopSound:Stop();
                    v33.LoopSound:Destroy();
                    v33.LoopSound = nil;
                end;
            end));
            Trove2:Add(function() -- Line: 330
                -- upvalues: u1 (ref), u32 (copy)
                local v34 = u1.States[u32];

                if v34 then
                    if v34.FloatingSeed then
                        v34.FloatingSeed:Destroy();
                        v34.FloatingSeed = nil;
                    end;

                    v34.SeedModelT = 0;
                end;

                u1.States[u32] = nil;
            end);
            local v35 = Trove2:Add(Instance.new("Part"));
            v35.Name = "PromptHolder";
            v35.CanCollide = false;
            v35.Anchored = true;
            v35.Size = Vector3.new(0.5, 0.5, 0.5);
            v35:PivotTo(u32:GetPivot());
            local ProximityPrompt = Instance.new("ProximityPrompt");
            ProximityPrompt:SetAttribute("Theme", "ShadowedPrompt");
            ProximityPrompt.Style = Enum.ProximityPromptStyle.Custom;
            ProximityPrompt.RequiresLineOfSight = false;
            ProximityPrompt.ActionText = "Submit";
            ProximityPrompt.ObjectText = "Jelly Incubator";
            ProximityPrompt.UIOffset = Vector2.new(0, 0);
            ProximityPrompt.Parent = v35;
            local ProximityPrompt2 = Instance.new("ProximityPrompt");
            ProximityPrompt2:SetAttribute("Theme", "ShadowedPrompt");
            ProximityPrompt2.Style = Enum.ProximityPromptStyle.Custom;
            ProximityPrompt2.GamepadKeyCode = Enum.KeyCode.ButtonY;
            ProximityPrompt2.RequiresLineOfSight = false;
            ProximityPrompt2.ActionText = "Start";
            ProximityPrompt2.ObjectText = "Jelly Incubator";
            ProximityPrompt2.UIOffset = Vector2.new(0, 40);
            ProximityPrompt2.Enabled = false;
            ProximityPrompt2.Parent = v35;
            local ProximityPrompt3 = Instance.new("ProximityPrompt");
            ProximityPrompt3:SetAttribute("Theme", "ShadowedPrompt");
            ProximityPrompt3.Style = Enum.ProximityPromptStyle.Custom;
            ProximityPrompt3.KeyboardKeyCode = Enum.KeyCode.R;
            ProximityPrompt3.GamepadKeyCode = Enum.KeyCode.ButtonX;
            ProximityPrompt3.RequiresLineOfSight = false;
            ProximityPrompt3.ActionText = "Remove";
            ProximityPrompt3.ObjectText = "Jelly Incubator";
            ProximityPrompt3.UIOffset = Vector2.new(0, -40);
            ProximityPrompt3.Enabled = false;
            ProximityPrompt3.Parent = v35;
            u1.States[u32].Prompt = ProximityPrompt;
            u1.States[u32].StartPrompt = ProximityPrompt2;
            u1.States[u32].RemovePrompt = ProximityPrompt3;
            v35.Parent = u32;
            UpdateFloatingSeedModel(u1.States[u32]);
            CacheBlobBaseCFrames(u1.States[u32]);
            ProximityPrompt.Triggered:Connect(function() -- Line: 387
                -- upvalues: DataService (ref), LocalPlayer (ref), Notify (ref), script_JellyConfig (ref), InventoryService (ref), JellyCrafting (ref)
                local Data = DataService:GetData();

                if not Data then
                    return;
                end;

                if Data.JellyCrafting.StoredItem then
                    JellyCrafting.Claim:FireServer();

                    return;
                end;

                local v36 = LocalPlayer.Character:FindFirstChildWhichIsA("Tool");

                if not v36 then
                    return Notify(script_JellyConfig.NOTIFICATION_ENUMS.WRONG_ITEM_TYPE);
                end;

                local v37 = InventoryService:GetToolData(v36) or {};

                if v37.ItemType ~= "Seed" then
                    return Notify(script_JellyConfig.NOTIFICATION_ENUMS.WRONG_ITEM_TYPE);
                end;

                if v37.ItemData.ItemName == "Super" then
                    return Notify(script_JellyConfig.NOTIFICATION_ENUMS.NO_SUPERSEEDS);
                end;

                if v37.ItemData.Variant == "Jelly" then
                    return Notify(script_JellyConfig.NOTIFICATION_ENUMS.INVALID_VARIANT);
                end;

                JellyCrafting.Submit:FireServer();
            end);
            ProximityPrompt2.Triggered:Connect(function() -- Line: 416
                -- upvalues: DataService (ref), ConfirmationPromptController (ref), Chalk (ref), script_JellyConfig (ref), SeedData (ref), JellyCrafting (ref)
                local Data = DataService:GetData();

                if not Data then
                    return;
                end;

                local ItemName = (Data.JellyCrafting.StoredItem or {}).ItemName;

                if not ItemName then
                    return;
                end;

                local v38 = {
                    Title = "Start Jelly Incubator",
                    Footer = "This action cannot be undone once started.",
                    ConfirmText = "Start",
                    RejectText = "Cancel",
                    Header = `{ItemName} Seed`
                };
                local v39 = Chalk.color(script_JellyConfig.NOTIFICATION_COLOR);
                local v40 = SeedData[ItemName];

                if v40 then
                    v40 = v40.SeedRarity;
                end;

                v38.Middle = `Are you sure you want to apply the Jelly VARIANT to this Seed for {v39((`{script_JellyConfig.PRICES[v40] or script_JellyConfig.PRICE_FALLBACK} Royal Jelly?`))}`;
                ConfirmationPromptController:Open(v38, {
                    ConfirmCallback = function() -- Line: 431, Name: ConfirmCallback
                        -- upvalues: JellyCrafting (ref)
                        JellyCrafting.Start:FireServer();
                    end
                });
            end);
            ProximityPrompt3.Triggered:Connect(function() -- Line: 437
                -- upvalues: JellyCrafting (ref)
                JellyCrafting:FindFirstChild("Remove"):FireServer();
            end);
        end,

        OnInstanceRemoved = function(p41: userdata) -- Line: 441, Name: OnInstanceRemoved
            -- upvalues: u1 (ref)
            if not (u1.States[p41] and u1.States[p41].Trove) then
                return;
            end;

            u1.States[p41].Trove:Clean();
        end
    });
    task.spawn(function() -- Line: 447
        -- upvalues: DataService (ref), script_JellyConfig (ref), SeedData (ref), u1 (ref), StartCentrifuge (ref), FormatTime (ref), PlayMachineSound (ref), UpdateFloatingSeedModel (ref)
        local u42 = nil;

        local function RenderPrompts() -- Line: 450
            -- upvalues: DataService (ref), script_JellyConfig (ref), SeedData (ref), u1 (ref)
            local Data = DataService:GetData();

            if not Data then
                return;
            end;

            local StoredItem = Data.JellyCrafting.StoredItem;
            local v43;

            if StoredItem and StoredItem.ItemName then
                local v44 = SeedData[StoredItem.ItemName];

                if v44 then
                    v44 = v44.SeedRarity;
                end;

                v43 = script_JellyConfig.CRAFT_TIMES[v44] or script_JellyConfig.CRAFT_TIMES.Transcendent;
            else
                v43 = script_JellyConfig.CRAFT_TIMES.Transcendent;
            end;

            local v45 = StoredItem ~= nil;
            local v46 = Data.JellyCrafting.StartTime ~= 0;
            local v47;

            if v45 then
                if v46 then
                    v47 = workspace:GetServerTimeNow() - Data.JellyCrafting.StartTime < v43;
                else
                    v47 = v46;
                end;
            else
                v47 = v45;
            end;

            local v48;

            if v45 then
                if v46 then
                    v48 = v43 <= workspace:GetServerTimeNow() - Data.JellyCrafting.StartTime;
                else
                    v48 = v46;
                end;
            else
                v48 = v45;
            end;

            for _, v in u1.States do
                if v.Prompt then
                    if v45 then
                        if v46 then
                            if v47 then
                                v.Prompt.Enabled = true;
                                v.Prompt.ActionText = "Skip";
                                v.Prompt.ObjectText = "Jelly Incubator";
                            elseif v48 then
                                v.Prompt.Enabled = true;
                                v.Prompt.ActionText = "Claim";
                                v.Prompt.ObjectText = "Jelly Incubator";
                            else
                                v.Prompt.Enabled = false;
                                v.Prompt.ObjectText = "Jelly Incubator";
                            end;
                        else
                            v.Prompt.Enabled = false;
                            v.Prompt.ObjectText = "Jelly Incubator";
                        end;
                    else
                        v.Prompt.Enabled = true;
                        v.Prompt.ActionText = "Submit";
                        v.Prompt.ObjectText = "Jelly Incubator";
                    end;
                end;

                if v.StartPrompt then
                    local v49;

                    if v45 then
                        v49 = not v46;
                    else
                        v49 = v45;
                    end;

                    v.StartPrompt.Enabled = v49;

                    if v45 and not v46 then
                        local v50 = SeedData[StoredItem.ItemName];

                        if v50 then
                            v50 = v50.SeedRarity;
                        end;

                        v.StartPrompt.ObjectText = `Cost: {script_JellyConfig.PRICES[v50] or script_JellyConfig.PRICE_FALLBACK} Royal Jelly`;
                    else
                        v.StartPrompt.ObjectText = "Jelly Incubator";
                    end;
                end;

                if v.RemovePrompt then
                    local v51;

                    if v45 then
                        v51 = not v46;
                    else
                        v51 = v45;
                    end;

                    v.RemovePrompt.Enabled = v51;
                end;
            end;
        end;

        local function Compute() -- Line: 507
            -- upvalues: DataService (ref), script_JellyConfig (ref), SeedData (ref), u1 (ref), u42 (ref), StartCentrifuge (ref), RenderPrompts (copy), FormatTime (ref), PlayMachineSound (ref)
            local Data = DataService:GetData();

            if not Data then
                return;
            end;

            local StartTime = Data.JellyCrafting.StartTime;
            local StoredItem = Data.JellyCrafting.StoredItem;
            local v52;

            if StoredItem and StoredItem.ItemName then
                local v53 = SeedData[StoredItem.ItemName];

                if v53 then
                    v53 = v53.SeedRarity;
                end;

                v52 = script_JellyConfig.CRAFT_TIMES[v53] or script_JellyConfig.CRAFT_TIMES.Transcendent;
            else
                v52 = script_JellyConfig.CRAFT_TIMES.Transcendent;
            end;

            local v54 = StoredItem ~= nil;
            local v55;

            if v54 then
                if StartTime == 0 then
                    v55 = false;
                else
                    v55 = workspace:GetServerTimeNow() - StartTime < v52;
                end;
            else
                v55 = v54;
            end;

            if v54 then
                if StartTime == 0 then
                    v54 = false;
                else
                    v54 = v52 <= workspace:GetServerTimeNow() - StartTime;
                end;
            end;

            if not v55 then
                for _, v in u1.States do
                    v.IsCrafting = false;

                    if v.CentrifugeThread then
                        pcall(task.cancel, v.CentrifugeThread);
                        v.CentrifugeThread = nil;
                    end;

                    if v.CentrifugeDriver then
                        v.CentrifugeDriver:Destroy();
                        v.CentrifugeDriver = nil;
                    end;

                    if v.LoopSound then
                        v.LoopSound:Stop();
                        v.LoopSound:Destroy();
                        v.LoopSound = nil;
                    end;
                end;

                if u42 then
                    pcall(task.cancel, u42);
                    u42 = nil;
                end;

                for i in u1.States do
                    local v56 = i:FindFirstChild("Holder") and i.Holder:FindFirstChild("GUI") and i.Holder.GUI:FindFirstChild("Timer");

                    if v56 then
                        v56.Text = v54 and "Ready to claim!" or "";
                    end;
                end;

                return;
            end;

            for _, v in u1.States do
                v.HasPlayedDoneSound = false;
            end;

            for _, v in u1.States do
                v.IsCrafting = true;
                StartCentrifuge(v);
            end;

            if u42 then
                pcall(task.cancel, u42);
            end;

            u42 = task.spawn(function() -- Line: 545
                -- upvalues: DataService (ref), u1 (ref), RenderPrompts (ref), script_JellyConfig (ref), SeedData (ref), FormatTime (ref), PlayMachineSound (ref)
                while true do
                    local Data2 = DataService:GetData();

                    if not Data2 or Data2.JellyCrafting.StartTime == 0 then
                        break;
                    end;

                    local StoredItem2 = Data2.JellyCrafting.StoredItem;
                    local v57;

                    if StoredItem2 and StoredItem2.ItemName then
                        local v58 = SeedData[StoredItem2.ItemName];

                        if v58 then
                            v58 = v58.SeedRarity;
                        end;

                        v57 = script_JellyConfig.CRAFT_TIMES[v58] or script_JellyConfig.CRAFT_TIMES.Transcendent;
                    else
                        v57 = script_JellyConfig.CRAFT_TIMES.Transcendent;
                    end;

                    local v59 = v57 - (workspace:GetServerTimeNow() - Data2.JellyCrafting.StartTime);
                    local v60 = v59 <= 0;

                    for i in u1.States do
                        local v61 = i:FindFirstChild("Holder") and i.Holder:FindFirstChild("GUI") and i.Holder.GUI:FindFirstChild("Timer");

                        if v61 then
                            v61.Text = v60 and "Ready to claim!" or FormatTime(v59);
                        end;
                    end;

                    RenderPrompts();

                    if v60 then
                        for _, v in u1.States do
                            if not v.HasPlayedDoneSound then
                                v.HasPlayedDoneSound = true;
                                PlayMachineSound(v, script_JellyConfig.SOUND_ENUMS.Done, {
                                    RollOffMaxDistance = 90,
                                    RollOffMinDistance = 8,
                                    Volume = 0.8,
                                    RollOffMode = Enum.RollOffMode.InverseTapered
                                });
                            end;
                        end;

                        for _, v in u1.States do
                            v.IsCrafting = false;

                            if v.CentrifugeThread then
                                pcall(task.cancel, v.CentrifugeThread);
                                v.CentrifugeThread = nil;
                            end;

                            if v.CentrifugeDriver then
                                v.CentrifugeDriver:Destroy();
                                v.CentrifugeDriver = nil;
                            end;

                            if v.LoopSound then
                                v.LoopSound:Stop();
                                v.LoopSound:Destroy();
                                v.LoopSound = nil;
                            end;
                        end;

                        return;
                    end;

                    task.wait(1);
                end;

                for _, v in u1.States do
                    v.IsCrafting = false;

                    if v.CentrifugeThread then
                        pcall(task.cancel, v.CentrifugeThread);
                        v.CentrifugeThread = nil;
                    end;

                    if v.CentrifugeDriver then
                        v.CentrifugeDriver:Destroy();
                        v.CentrifugeDriver = nil;
                    end;

                    if v.LoopSound then
                        v.LoopSound:Stop();
                        v.LoopSound:Destroy();
                        v.LoopSound = nil;
                    end;
                end;

                RenderPrompts();
            end);
        end;

        task.spawn(function() -- Line: 593
            -- upvalues: Compute (copy), RenderPrompts (copy)
            Compute();
            RenderPrompts();
        end);
        DataService:GetPathSignal("JellyCrafting/StoredItem"):Connect(function() -- Line: 598
            -- upvalues: RenderPrompts (copy), u1 (ref), UpdateFloatingSeedModel (ref)
            RenderPrompts();

            for _, v in u1.States do
                UpdateFloatingSeedModel(v);
            end;
        end);
        DataService:GetPathSignal("JellyCrafting/StartTime"):Connect(function() -- Line: 602
            -- upvalues: Compute (copy), RenderPrompts (copy)
            Compute();
            RenderPrompts();
        end);
    end);
    RunService.PreRender:Connect(function(p62) -- Line: 608
        -- upvalues: u1 (ref)
        for _, v in u1.States do
            if v.FloatingSeed then
                v.SeedBobTime = v.SeedBobTime + p62;
                local Machine = v.Machine:FindFirstChild("Machine");

                if Machine then
                    Machine = Machine:FindFirstChild("Tank");
                end;

                if Machine then
                    Machine = Machine:FindFirstChild("Container");
                end;

                local v63;

                if Machine and Machine:IsA("BasePart") then
                    v63 = Machine.CFrame;
                else
                    v63 = nil;
                end;

                if v63 then
                    local v64 = math.sin(v.SeedBobTime * 1) * 0.35;
                    local v65 = v63 + Vector3.new(0, v64, 0);
                    local Seed = v.FloatingSeed:FindFirstChild("Seed");

                    if Seed then
                        if Seed:IsA("BasePart") then
                            Seed.CFrame = v65;
                        elseif Seed:IsA("Model") then
                            Seed:PivotTo(v65);
                        end;
                    end;
                end;
            else
                v.SeedBobTime = 0;
            end;

            v.BlobBobTime = v.BlobBobTime + p62;
            local v66 = v;
            local v67 = 0;

            for i, v2 in v.BlobBaseCFrames do
                v67 = v67 + 1;

                if i and i.Parent then
                    local v68 = math.sin(v66.BlobBobTime * 1 + v67 * 0.45) * 0.2;
                    i.CFrame = v2 + Vector3.new(0, v68, 0);
                end;
            end;
        end;
    end);
end;

task.spawn(u1.Start);

return u1;