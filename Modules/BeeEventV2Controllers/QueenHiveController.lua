-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local CollectionService = game:GetService("CollectionService");
local DataService = require(ReplicatedStorage.Modules.DataService);
local QueenHiveConfig = require(ReplicatedStorage.Data.BeeEvent.QueenHiveConfig);
require(ReplicatedStorage.Modules.NPCDialogueController);
require(ReplicatedStorage.Top_Text);
require(ReplicatedStorage.Modules.UpdateService);
local DevProductIds = require(ReplicatedStorage.Data.DevProductIds);
local ConfirmationPromptController = require(ReplicatedStorage.Modules.ConfirmationPromptController);
local MarketController = require(ReplicatedStorage.Modules.MarketController);
local SelectiveAssetReplication = require(ReplicatedStorage.Modules.SelectiveAssetReplication);
local SeedData = require(ReplicatedStorage.Data.SeedData);
local EventShopData = require(ReplicatedStorage.Data.EventShopData);
require(ReplicatedStorage.Data.GrowableData);
local TimeHelper = require(ReplicatedStorage.Modules.TimeHelper);
local BeeQueenHiveRemote = ReplicatedStorage:WaitForChild("GameEvents"):WaitForChild("BeeQueenHiveRemote");
local u1 = CollectionService:GetTagged("BizzyBee2026")[1];
local Incubator = u1:FindFirstChild("Incubator", true);
local Machine = Incubator:FindFirstChild("Machine");
local TimerGui = Incubator:FindFirstChild("TimerGui", true);
local StartPrompt = Incubator:FindFirstChild("StartPrompt", true);
local InsertPrompt = Incubator:FindFirstChild("InsertPrompt", true);
local SeedSpawn = Incubator:FindFirstChild("SeedSpawn", true);
local SoundLoop1 = Incubator:FindFirstChild("SoundLoop1", true);
local SoundLoop2 = Incubator:FindFirstChild("SoundLoop2", true);
local JarHoney = Incubator:FindFirstChild("JarHoney", true);
local PourLoopSound = Incubator:FindFirstChild("PourLoopSound", true);
Incubator:FindFirstChild("PourStartSound", true);
local FlowPart = Incubator:FindFirstChild("FlowPart", true);
local u2 = nil;
local u3 = nil;
local Pivot = Machine:GetPivot();
local Size = JarHoney.Size;
local Position = JarHoney.Position;
local u13 = {
    ShakeMachine = function(p4: table, p5: number) -- Line: 50, Name: ShakeMachine
        -- upvalues: Machine (copy), Pivot (copy)
        local v6 = p5 or 0.01;
        local v7 = math.random(-100, 100) / 100 * v6;
        local v8 = math.random(-100, 100) / 100 * v6;
        Machine:PivotTo(Pivot + Vector3.new(v7, 0, v8));
    end,

    DoPourAnimationAsync = function(p9) -- Line: 62, Name: DoPourAnimationAsync
        -- upvalues: DataService (copy), u3 (ref), FlowPart (copy), JarHoney (copy), Size (copy), Position (copy), PourLoopSound (copy), TweenService (copy), SelectiveAssetReplication (copy), u1 (copy)
        local CurrentSeed = DataService:GetData().BeeEventData.HoneyIncubatorData.CurrentSeed;

        if CurrentSeed == "" then
            warn("[QueenHiveController] no current seed, aborting pour animation");

            return;
        end;

        if u3 then
            u3:Destroy();
            u3 = nil;
        end;

        FlowPart.Transparency = 0;
        JarHoney.Transparency = 0;
        JarHoney.Size = Size * Vector3.new(1, 0, 1);
        JarHoney.Position = Position - Size.Y * Vector3.new(0, 1, 0) / 2;
        PourLoopSound:Play();
        local v10 = TweenService:Create(JarHoney, TweenInfo.new(2, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0), {
            Size = Size,
            Position = Position
        });
        v10:Play();
        v10.Completed:Wait();
        local string_match_ret = string.match(CurrentSeed, "^Honey (.*)");

        if not string_match_ret then
            warn("[QueenHiveController] could not get CurrentSeed");

            return;
        end;

        u3 = SelectiveAssetReplication:GetAssetAsync("Seed_Models", string_match_ret):Clone();
        u3.CFrame = CFrame.new(Position) * CFrame.Angles(0, 0, 1.5707963267948966);
        u3.Anchored = true;
        u3.Parent = u1;
        FlowPart.Transparency = 1;
        PourLoopSound:Stop();
        local v11 = TweenService:Create(u3, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, 0, false, 0), {
            CFrame = CFrame.new(Position + Vector3.new(0, Size.Y / 2, 0)) * CFrame.Angles(0, 0, 1.5707963267948966)
        });
        v11:Play();
        v11.Completed:Wait();
    end,

    ResetPourAnimation = function(p12) -- Line: 127, Name: ResetPourAnimation
        -- upvalues: FlowPart (copy), JarHoney (copy), PourLoopSound (copy), u3 (ref)
        FlowPart.Transparency = 1;
        JarHoney.Transparency = 1;
        PourLoopSound:Stop();

        if u3 then
            u3:Destroy();
            u3 = nil;
        end;
    end
};

function u13.UpdatePourAnimations(p14) -- Line: 139
    -- upvalues: DataService (copy), u13 (copy)
    if DataService:GetData().BeeEventData.HoneyIncubatorData.Claimable then
        u13:DoPourAnimationAsync();

        return;
    end;

    u13:ResetPourAnimation();
end;

local function refreshPrompt(p15: userdata) -- Line: 151
    p15.Enabled = false;
    task.wait(0.1);
    p15.Enabled = true;
end;

function u13.UpdatePrompts(p16) -- Line: 157
    -- upvalues: DataService (copy), StartPrompt (copy), QueenHiveConfig (copy), InsertPrompt (copy), TimerGui (copy)
    local Data = DataService:GetData();

    if not Data then
        return;
    end;

    local HoneyIncubatorData = Data.BeeEventData.HoneyIncubatorData;

    if HoneyIncubatorData.Running or (HoneyIncubatorData.Claimable or HoneyIncubatorData.CurrentSeed == "") then
        StartPrompt.Enabled = false;
    else
        StartPrompt.Enabled = true;
        local v17 = QueenHiveConfig.RequiredHoneyCoinCosts[HoneyIncubatorData.CurrentSeed];
        StartPrompt.ActionText = "Start Incubator";
        StartPrompt.ObjectText = `Cost: {v17} Honey Coins`;
    end;

    if HoneyIncubatorData.Running then
        InsertPrompt.KeyboardKeyCode = Enum.KeyCode.E;
        InsertPrompt.ActionText = "Skip Incubator";
        InsertPrompt.ObjectText = "Incubator";
    elseif HoneyIncubatorData.Claimable then
        TimerGui.Holder.Timer.Text = "READY";
        InsertPrompt.KeyboardKeyCode = Enum.KeyCode.E;
        InsertPrompt.ActionText = "Claim Seed";
        InsertPrompt.ObjectText = "Incubator";
    elseif HoneyIncubatorData.CurrentSeed == "" then
        TimerGui.Holder.Timer.Text = "";
        InsertPrompt.KeyboardKeyCode = Enum.KeyCode.E;
        InsertPrompt.ActionText = "Insert Seed";
        InsertPrompt.ObjectText = "Incubator";
    else
        TimerGui.Holder.Timer.Text = "";
        InsertPrompt.KeyboardKeyCode = Enum.KeyCode.R;
        InsertPrompt.ActionText = "Remove Seed";
        InsertPrompt.ObjectText = "Incubator";
    end;

    local v18 = InsertPrompt;
    v18.Enabled = false;
    task.wait(0.1);
    v18.Enabled = true;
end;

function u13.UpdateFloatingSeedModel(p19) -- Line: 203
    -- upvalues: DataService (copy), u2 (ref), SelectiveAssetReplication (copy), SeedSpawn (copy), u1 (copy)
    local HoneyIncubatorData = DataService:GetData().BeeEventData.HoneyIncubatorData;

    if u2 then
        u2:Destroy();
        u2 = nil;
    end;

    if HoneyIncubatorData.CurrentSeed == "" then
        return;
    end;

    local AssetAsync = SelectiveAssetReplication:GetAssetAsync("Seed_Models", HoneyIncubatorData.CurrentSeed);

    if not AssetAsync then
        warn("[QueenHiveController] could not get seed model from server");

        return;
    end;

    local Model = Instance.new("Model");
    local v20 = AssetAsync:Clone();
    v20.Parent = Model;
    Model:ScaleTo(2.5);
    v20.Anchored = true;
    v20.CFrame = SeedSpawn.CFrame;
    v20.Name = "Seed";
    u2 = Model;
    Model.Parent = u1;
end;

function u13.Start(p21) -- Line: 236
    -- upvalues: InsertPrompt (copy), DataService (copy), BeeQueenHiveRemote (copy), DevProductIds (copy), SeedData (copy), EventShopData (copy), MarketController (copy), StartPrompt (copy), ConfirmationPromptController (copy), u13 (copy), SoundLoop1 (copy), SoundLoop2 (copy), QueenHiveConfig (copy), TimeHelper (copy), TimerGui (copy), RunService (copy), u2 (ref), SeedSpawn (copy)
    InsertPrompt.Triggered:Connect(function(p22) -- Line: 237
        -- upvalues: DataService (ref), BeeQueenHiveRemote (ref), DevProductIds (ref), SeedData (ref), EventShopData (ref), MarketController (ref)
        local HoneyIncubatorData = DataService:GetData().BeeEventData.HoneyIncubatorData;

        if HoneyIncubatorData.Claimable then
            BeeQueenHiveRemote:FireServer("ClaimSeed");

            return;
        end;

        if not HoneyIncubatorData.Running and HoneyIncubatorData.CurrentSeed ~= "" then
            BeeQueenHiveRemote:FireServer("RemoveSeed");

            return;
        end;

        if not (HoneyIncubatorData.Running or (HoneyIncubatorData.Claimable or HoneyIncubatorData.CurrentSeed ~= "")) then
            BeeQueenHiveRemote:FireServer("SubmitSeed");

            return;
        end;

        local v23 = {
            Common = DevProductIds.SkipIncubatorCommonUncommon,
            Uncommon = DevProductIds.SkipIncubatorCommonUncommon,
            Rare = DevProductIds.SkipIncubatorRareMythical,
            Legendary = DevProductIds.SkipIncubatorRareMythical,
            Mythical = DevProductIds.SkipIncubatorRareMythical,
            Divine = DevProductIds.SkipIncubatorDivineTranscendent,
            Prismatic = DevProductIds.SkipIncubatorDivineTranscendent,
            Transcendent = DevProductIds.SkipIncubatorDivineTranscendent
        };
        local CurrentSeed = HoneyIncubatorData.CurrentSeed;
        local v24 = SeedData[CurrentSeed] or (EventShopData["Honey Seed Shop"][CurrentSeed] or EventShopData["Honey Coin Shop"][CurrentSeed]);

        if v24 then
            v24 = v24.SeedRarity;
        end;

        MarketController:PromptPurchase((v24 and v23[v24] or DevProductIds.SkipIncubatorCommonUncommon).PurchaseID, Enum.InfoType.Product);
    end);
    StartPrompt.Triggered:Connect(function(p25) -- Line: 271
        -- upvalues: DataService (ref), BeeQueenHiveRemote (ref), ConfirmationPromptController (ref)
        local v26 = {
            ConfirmEvent = BeeQueenHiveRemote,
            ConfirmEventData = { "StartIncubator" },

            ConfirmCallback = function() -- Line: 277, Name: ConfirmCallback
            end,

            RejectCallback = function() -- Line: 278, Name: RejectCallback
            end
        };
        ConfirmationPromptController:Open({
            Title = "Incubate...",
            Header = "Are you sure you want to incubate?",
            Middle = `{DataService:GetData().BeeEventData.HoneyIncubatorData.CurrentSeed}`
        }, v26);
    end);
    task.spawn(function() -- Line: 290
        -- upvalues: DataService (ref), u13 (ref)
        while true do
            while true do
                local HoneyIncubatorData = DataService:GetData().BeeEventData.HoneyIncubatorData;

                if not HoneyIncubatorData then
                    break;
                end;

                if HoneyIncubatorData.Running then
                    u13:ShakeMachine(0.025);
                    task.wait(0.02);
                else
                    task.wait(1);
                end;
            end;

            task.wait(1);
        end;
    end);
    DataService:GetPathSignal("BeeEventData/HoneyIncubatorData/CurrentSeed"):Connect(function() -- Line: 309
        -- upvalues: u13 (ref)
        u13:UpdateFloatingSeedModel();
    end);
    DataService:GetPathSignal("BeeEventData/HoneyIncubatorData/Running"):Connect(function() -- Line: 313
        -- upvalues: DataService (ref), SoundLoop1 (ref), SoundLoop2 (ref)
        if DataService:GetData().BeeEventData.HoneyIncubatorData.Running then
            SoundLoop1:Play();
            SoundLoop2:Play();

            return;
        end;

        SoundLoop1:Stop();
        SoundLoop2:Stop();
    end);
    DataService:GetPathSignal("BeeEventData/HoneyIncubatorData/Claimable"):Connect(function() -- Line: 325
        -- upvalues: u13 (ref)
        u13:UpdatePourAnimations();
    end);
    DataService:GetPathSignal("BeeEventData/HoneyIncubatorData/*"):Connect(function() -- Line: 329
        -- upvalues: u13 (ref)
        u13:UpdatePrompts();
    end);
    task.spawn(function() -- Line: 333
        -- upvalues: DataService (ref), QueenHiveConfig (ref), TimeHelper (ref), TimerGui (ref)
        while true do
            local v27;

            while true do
                v27 = DataService:GetData().BeeEventData.HoneyIncubatorData;

                if v27 and v27.Running then
                    break;
                end;

                task.wait(1);
            end;

            local v28 = workspace:GetServerTimeNow() - v27.StartTime;
            local v29 = TimeHelper:GenerateColonFormatFromTime((math.max(QueenHiveConfig.SeedConversionTimes[v27.CurrentSeed] - v28, 0)));
            TimerGui.Holder.Timer.Text = `Timer:\n{v29}`;
            task.wait(1);
        end;
    end);
    u13:UpdatePrompts();
    u13:UpdateFloatingSeedModel();
    u13:UpdatePourAnimations();
    local u30 = 0;
    RunService.PreRender:Connect(function(p31) -- Line: 358
        -- upvalues: u2 (ref), u30 (ref), SeedSpawn (ref)
        if not u2 then
            u30 = 0;

            return;
        end;

        u30 = u30 + p31;
        local v32 = math.sin(u30 * 1) * 0.5;
        u2.Seed.CFrame = SeedSpawn.CFrame + Vector3.new(0, v32, 0);
    end);
end;

task.spawn(u13.Start, u13);

return u13;