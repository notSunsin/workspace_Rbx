-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local ConfirmationPromptController = require(ReplicatedStorage.Modules.ConfirmationPromptController);
local SelectiveAssetReplication = require(ReplicatedStorage.Modules.SelectiveAssetReplication);
local CreateTagHandler = require(ReplicatedStorage.Modules.CreateTagHandler);
local MarketController = require(ReplicatedStorage.Modules.MarketController);
local Notification = require(ReplicatedStorage.Modules.Notification);
local DataService = require(ReplicatedStorage.Modules.DataService);
local Trove = require(ReplicatedStorage.Modules.Trove);
local Chalk = require(ReplicatedStorage.Modules.Chalk);
local PetRegistry = require(ReplicatedStorage.Data.PetRegistry);
local SoundPlayer = require(ReplicatedStorage.Modules.SoundPlayer);
local SoundData = require(ReplicatedStorage.Data.SoundData);
local EventRotationClientBinder = require(ReplicatedStorage.Modules.EventRotation.EventRotationClientBinder);
local u1 = require(ReplicatedStorage.Modules.Trove).new();
local GameConfigController = require(ReplicatedStorage.Modules.GameConfigController);
local Config = GameConfigController:GetConfig("HarvestMoonPetConfig");
workspace:GetAttributeChangedSignal("HarvestMoonPetConfig"):Connect(function() -- Line: 38
    -- upvalues: Config (ref), GameConfigController (copy)
    Config = GameConfigController:GetConfig("HarvestMoonPetConfig");
end);
local LocalPlayer = Players.LocalPlayer;
local HarvestMoonPet = ReplicatedStorage.GameEvents:WaitForChild("HarvestMoonPet");
local u2 = {
    States = {}
};

local function Now() -- Line: 53
    return workspace:GetServerTimeNow();
end;

local function FormatTime(p3: number) -- Line: 57
    local math_floor_ret = math.floor(p3);
    local math_max_ret = math.max(0, math_floor_ret);

    if math_max_ret < 60 then
        return `{math_max_ret}s`;
    end;

    if math_max_ret < 3600 then
        return string.format("%d:%02d", math_max_ret // 60, math_max_ret % 60);
    end;

    return string.format("%d:%02d:%02d", math_max_ret // 3600, math_max_ret % 3600 // 60, math_max_ret % 60);
end;

local function ToColor3(p4) -- Line: 71
    if typeof(p4) == "Color3" then
        return p4;
    end;

    if type(p4) == "table" then
        return Color3.fromRGB(p4[1] or 255, p4[2] or 255, p4[3] or 255);
    end;

    return Color3.fromRGB(255, 255, 255);
end;

local function Notify(p5: string) -- Line: 79
    -- upvalues: Notification (copy), Config (ref), Chalk (copy), ToColor3 (copy)
    if Config.NOTIFICATION_COLOR then
        p5 = Chalk.color(ToColor3(Config.NOTIFICATION_COLOR))(p5) or p5;
    end;

    Notification:CreateNotification(p5);
end;

local function GetMachineData() -- Line: 83
    -- upvalues: DataService (copy)
    local Data = DataService:GetData();

    if Data then
        Data = Data.HarvestMoonPet;
    end;

    return Data;
end;

local function GetDuration(p6: string?) -- Line: 88
    -- upvalues: Config (ref)
    return p6 and Config.DURATION_BY_RARITY[p6] or Config.DURATION_BY_RARITY.FallBack;
end;

local function GetCost(p7: string?) -- Line: 92
    -- upvalues: Config (ref)
    return p7 and Config.COST_BY_RARITY[p7] or Config.COST_BY_RARITY.FallBack;
end;

local function GetSkipProduct(p8: string?) -- Line: 96
    -- upvalues: Config (ref)
    return p8 and Config.SKIP_PRODUCTS[p8] or Config.SKIP_PRODUCTS.FallBack;
end;

local function GetPhase(p9) -- Line: 105
    -- upvalues: Config (ref)
    if not (p9 and p9.StoredPetType) then
        return "Empty", 0;
    end;

    if p9.StartTime == 0 then
        return "Stored", 0;
    end;

    local StoredPetRarity = p9.StoredPetRarity;
    local v10 = (StoredPetRarity and Config.DURATION_BY_RARITY[StoredPetRarity] or Config.DURATION_BY_RARITY.FallBack) - (workspace:GetServerTimeNow() - p9.StartTime);

    if v10 > 0 then
        return "Running", v10;
    end;

    return "Complete", 0;
end;

local function HeldPetTool() -- Line: 121
    -- upvalues: LocalPlayer (copy)
    local Character = LocalPlayer.Character;

    if not Character then
        return nil;
    end;

    for _, child in Character:GetChildren() do
        if child:IsA("Tool") and child:GetAttribute("PET_UUID") then
            return child;
        end;
    end;

    return nil;
end;

local function RenderPet(p11: string, p12: userdata, p13: userdata) -- Line: 135
    -- upvalues: SelectiveAssetReplication (copy), PetRegistry (copy)
    local AssetAsync = SelectiveAssetReplication:GetAssetAsync("PetAssets", p11, 30);

    if not (AssetAsync and AssetAsync.PrimaryPart) then
        warn((`[HarvestMoonPetController] No pet asset for "{p11}"`));

        return nil;
    end;

    local u14 = PetRegistry.PetList[p11];
    local v15 = AssetAsync:Clone();

    for _, descendant in v15:GetDescendants() do
        if descendant:IsA("BasePart") then
            descendant.CanCollide = false;
            descendant.CanQuery = false;
            descendant.CanTouch = false;
            descendant.Anchored = false;
        end;
    end;

    v15.PrimaryPart.Anchored = true;
    local ExtentsSize = v15:GetExtentsSize();
    local Size = p12.Size;

    if ExtentsSize.X > 0 and (ExtentsSize.Y > 0 and ExtentsSize.Z > 0) then
        local math_min_ret = math.min(Size.X / ExtentsSize.X, Size.Y / ExtentsSize.Y, Size.Z / ExtentsSize.Z);

        if math_min_ret > 0 and math_min_ret < (1 / 0) then
            v15:ScaleTo(math_min_ret);
        end;
    end;

    local v16 = u14 and u14.WeldOffset or CFrame.new();
    v15:PivotTo(CFrame.new(p12.Position) * v16);
    v15.Parent = p13;
    local AnimationController = v15:FindFirstChild("AnimationController");

    if AnimationController then
        AnimationController = AnimationController:FindFirstChild("Animator");
    end;

    if AnimationController and (u14 and (u14.Animations and u14.Animations.Idle)) then
        local success, result = pcall(function() -- Line: 176
            -- upvalues: AnimationController (copy), u14 (copy)
            return AnimationController:LoadAnimation(u14.Animations.Idle);
        end);

        if success and result then
            result.Looped = true;
            result:Play();
        end;
    end;

    return v15;
end;

local function ClearPetVisual(p17) -- Line: 188
    p17.PetRenderToken = p17.PetRenderToken + 1;
    p17.CurrentPetKey = nil;

    if p17.PetModel then
        p17.PetModel:Destroy();
        p17.PetModel = nil;
    end;
end;

local function UpdatePetVisual(u18, u19) -- Line: 197
    -- upvalues: Config (ref), RenderPet (copy)
    local u20 = u18.Machine:FindFirstChild(Config.PLACE_PET_PART);

    if not u20 then
        return;
    end;

    if u19 then
        u19 = u19.StoredPetType;
    end;

    if not u19 then
        u18.PetRenderToken = u18.PetRenderToken + 1;
        u18.CurrentPetKey = nil;

        if u18.PetModel then
            u18.PetModel:Destroy();
            u18.PetModel = nil;
        end;

        return;
    end;

    if u19 == u18.CurrentPetKey and u18.PetModel then
        return;
    end;

    u18.PetRenderToken = u18.PetRenderToken + 1;
    u18.CurrentPetKey = nil;

    if u18.PetModel then
        u18.PetModel:Destroy();
        u18.PetModel = nil;
    end;

    u18.CurrentPetKey = u19;
    local PetRenderToken = u18.PetRenderToken;
    task.spawn(function() -- Line: 215
        -- upvalues: RenderPet (ref), u19 (copy), u20 (copy), u18 (copy), PetRenderToken (copy)
        local v21 = RenderPet(u19, u20, u18.Machine);

        if PetRenderToken == u18.PetRenderToken then
            u18.PetModel = v21;

            return;
        end;

        if v21 then
            v21:Destroy();
        end;
    end);
end;

local u22 = 0;

local function AnimatePet(p23: userdata) -- Line: 229
    -- upvalues: u22 (ref)
    local v24 = math.sin(u22) * 0.01;
    local CFrame_Angles_ret = CFrame.Angles(0, 0.008726646259971648, 0);
    p23:PivotTo((p23:GetPivot() + Vector3.new(0, v24, 0)) * CFrame_Angles_ret);
end;

local function GetTimerLabel(p25) -- Line: 238
    local Holder = p25.Machine:FindFirstChild("Holder");

    if Holder then
        Holder = Holder:FindFirstChild("GUI");
    end;

    if Holder then
        Holder = Holder:FindFirstChild("Timer");
    end;

    if not (Holder and (Holder:IsA("TextLabel") and Holder)) then
        Holder = nil;
    end;

    return Holder;
end;

local function SetTimerText(p26: any, p27: string) -- Line: 245
    local Holder = p26.Machine:FindFirstChild("Holder");

    if Holder then
        Holder = Holder:FindFirstChild("GUI");
    end;

    if Holder then
        Holder = Holder:FindFirstChild("Timer");
    end;

    if not (Holder and (Holder:IsA("TextLabel") and Holder)) then
        Holder = nil;
    end;

    if Holder then
        Holder.Text = p27;
    end;
end;

local function RefreshPrompts(p28, p29) -- Line: 250
    -- upvalues: Config (ref)
    local v30, v31;

    if p29 and p29.StoredPetType then
        if p29.StartTime == 0 then
            v30 = "Stored";
            v31 = 0;
        else
            local StoredPetRarity = p29.StoredPetRarity;
            v31 = (StoredPetRarity and Config.DURATION_BY_RARITY[StoredPetRarity] or Config.DURATION_BY_RARITY.FallBack) - (workspace:GetServerTimeNow() - p29.StartTime);

            if v31 > 0 then
                v30 = "Running";
            else
                v30 = "Complete";
                v31 = 0;
            end;
        end;
    else
        v30 = "Empty";
        v31 = 0;
    end;

    if p28.MainPrompt then
        if v30 == "Empty" then
            p28.MainPrompt.Enabled = true;
            p28.MainPrompt.ActionText = "Submit Pet";
        elseif v30 == "Stored" then
            p28.MainPrompt.Enabled = false;
        elseif v30 == "Running" then
            p28.MainPrompt.Enabled = true;
            p28.MainPrompt.ActionText = "Skip";
        elseif v30 == "Complete" then
            p28.MainPrompt.Enabled = true;
            p28.MainPrompt.ActionText = "Claim";
        end;
    end;

    if p28.StartPrompt then
        p28.StartPrompt.Enabled = v30 == "Stored";

        if v30 == "Stored" then
            local StoredPetRarity = p29.StoredPetRarity;
            p28.StartPrompt.ObjectText = `Cost: {StoredPetRarity and Config.COST_BY_RARITY[StoredPetRarity] or Config.COST_BY_RARITY.FallBack} Moon Coins`;
        else
            p28.StartPrompt.ObjectText = "Moon Machine";
        end;
    end;

    if p28.RemovePrompt then
        p28.RemovePrompt.Enabled = v30 == "Stored";
    end;

    return v30, v31;
end;

local function StopTick(p32) -- Line: 286
    if p32.TickThread then
        pcall(task.cancel, p32.TickThread);
        p32.TickThread = nil;
    end;
end;

local function StartTick(u33) -- Line: 293
    -- upvalues: DataService (copy), Config (ref), u2 (copy), FormatTime (copy), RefreshPrompts (copy)
    if u33.TickThread then
        pcall(task.cancel, u33.TickThread);
        u33.TickThread = nil;
    end;

    u33.TickThread = task.spawn(function() -- Line: 295
        -- upvalues: DataService (ref), Config (ref), u2 (ref), u33 (copy), FormatTime (ref), RefreshPrompts (ref)
        while true do
            local Data = DataService:GetData();

            if Data then
                Data = Data.HarvestMoonPet;
            end;

            local v34, v35;

            if Data and Data.StoredPetType then
                if Data.StartTime == 0 then
                    v34 = "Stored";
                    v35 = 0;
                else
                    local StoredPetRarity = Data.StoredPetRarity;
                    v35 = (StoredPetRarity and Config.DURATION_BY_RARITY[StoredPetRarity] or Config.DURATION_BY_RARITY.FallBack) - (workspace:GetServerTimeNow() - Data.StartTime);

                    if v35 > 0 then
                        v34 = "Running";
                    else
                        v34 = "Complete";
                        v35 = 0;
                    end;
                end;
            else
                v34 = "Empty";
                v35 = 0;
            end;

            if v34 ~= "Running" then
                u2.Recompute(u33);

                return;
            end;

            local v36 = FormatTime(v35);
            local Holder = u33.Machine:FindFirstChild("Holder");

            if Holder then
                Holder = Holder:FindFirstChild("GUI");
            end;

            if Holder then
                Holder = Holder:FindFirstChild("Timer");
            end;

            if not (Holder and (Holder:IsA("TextLabel") and Holder)) then
                Holder = nil;
            end;

            if Holder then
                Holder.Text = v36;
            end;

            RefreshPrompts(u33, Data);
            task.wait(1);
        end;
    end);
end;

local function GetSoundsPart(p37) -- Line: 313
    return p37.Machine:FindFirstChild("Sounds") or p37.Machine;
end;

local function PlayMachineSound(u38: any, p39: string) -- Line: 317
    -- upvalues: SoundData (copy), SoundPlayer (copy)
    local u40 = SoundData.MachineSounds[p39];

    if not u40 or u40 == "" then
        return;
    end;

    task.spawn(function() -- Line: 320
        -- upvalues: SoundPlayer (ref), u40 (copy), u38 (copy)
        local v41 = u38;
        SoundPlayer:PlaySound(u40, {}, nil, v41.Machine:FindFirstChild("Sounds") or v41.Machine);
    end);
end;

local function SetMachineLoops(p42: any, p43: boolean) -- Line: 328
    local Sounds = p42.Machine:FindFirstChild("Sounds");

    if not Sounds then
        return;
    end;

    for _, child in Sounds:GetChildren() do
        if child:IsA("Sound") and child.Looped then
            if p43 then
                if not child.Playing then
                    child:Play();
                end;
            elseif child.Playing then
                child:Stop();
            end;
        end;
    end;
end;

local function OnPhaseTransition(u44: any, p45: string, p46: string) -- Line: 344
    -- upvalues: SoundData (copy), SoundPlayer (copy), Config (ref), Notification (copy), Chalk (copy), ToColor3 (copy)
    if p46 == "Stored" and p45 == "Empty" then
        local Insert = SoundData.MachineSounds.Insert;

        if Insert then
            if Insert == "" then
                return;
            end;

            task.spawn(function() -- Line: 320
                -- upvalues: SoundPlayer (ref), Insert (copy), u44 (copy)
                local v47 = u44;
                SoundPlayer:PlaySound(Insert, {}, nil, v47.Machine:FindFirstChild("Sounds") or v47.Machine);
            end);
        end;
    elseif p46 == "Running" and p45 == "Stored" then
        local Start = SoundData.MachineSounds.Start;

        if Start then
            if Start == "" then
                return;
            end;

            task.spawn(function() -- Line: 320
                -- upvalues: SoundPlayer (ref), Start (copy), u44 (copy)
                local v48 = u44;
                SoundPlayer:PlaySound(Start, {}, nil, v48.Machine:FindFirstChild("Sounds") or v48.Machine);
            end);
        end;
    else
        if p46 == "Complete" and p45 == "Running" then
            local Finished = SoundData.MachineSounds.Finished;

            if Finished and Finished ~= "" then
                task.spawn(function() -- Line: 320
                    -- upvalues: SoundPlayer (ref), Finished (copy), u44 (copy)
                    local v49 = u44;
                    SoundPlayer:PlaySound(Finished, {}, nil, v49.Machine:FindFirstChild("Sounds") or v49.Machine);
                end);
            end;

            local v50 = Config.MESSAGES.READY or "Your Pet is ready to be claimed from the Moon Machine!";

            if Config.NOTIFICATION_COLOR then
                v50 = Chalk.color(ToColor3(Config.NOTIFICATION_COLOR))(v50) or v50;
            end;

            Notification:CreateNotification(v50);

            return;
        end;

        local u51 = p46 == "Empty" and (p45 == "Complete" and SoundData.MachineSounds.Retrieve);

        if u51 then
            if u51 == "" then
                return;
            end;

            task.spawn(function() -- Line: 320
                -- upvalues: SoundPlayer (ref), u51 (copy), u44 (copy)
                local v52 = u44;
                SoundPlayer:PlaySound(u51, {}, nil, v52.Machine:FindFirstChild("Sounds") or v52.Machine);
            end);
        end;
    end;
end;

function u2.Recompute(u53) -- Line: 357
    -- upvalues: DataService (copy), RefreshPrompts (copy), UpdatePetVisual (copy), SetMachineLoops (copy), OnPhaseTransition (copy), Config (ref), u2 (copy), FormatTime (copy)
    local Data = DataService:GetData();

    if Data then
        Data = Data.HarvestMoonPet;
    end;

    local v54 = RefreshPrompts(u53, Data);
    UpdatePetVisual(u53, Data);
    local Moon = u53.Machine:FindFirstChild("Moon");

    if Moon then
        for _, descendant in Moon:GetDescendants() do
            if descendant:IsA("Beam") then
                descendant.Enabled = v54 == "Running";
            end;
        end;
    end;

    u53.Running = v54 == "Running";
    SetMachineLoops(u53, u53.Running);

    if u53.PrevPhase ~= nil and v54 ~= u53.PrevPhase then
        OnPhaseTransition(u53, u53.PrevPhase, v54);
    end;

    u53.PrevPhase = v54;

    if v54 ~= "Running" then
        if v54 == "Complete" then
            if u53.TickThread then
                pcall(task.cancel, u53.TickThread);
                u53.TickThread = nil;
            end;

            local Holder = u53.Machine:FindFirstChild("Holder");

            if Holder then
                Holder = Holder:FindFirstChild("GUI");
            end;

            if Holder then
                Holder = Holder:FindFirstChild("Timer");
            end;

            if not (Holder and (Holder:IsA("TextLabel") and Holder)) then
                Holder = nil;
            end;

            if Holder then
                Holder.Text = "Ready to claim!";

                return;
            end;
        else
            if u53.TickThread then
                pcall(task.cancel, u53.TickThread);
                u53.TickThread = nil;
            end;

            local Holder = u53.Machine:FindFirstChild("Holder");

            if Holder then
                Holder = Holder:FindFirstChild("GUI");
            end;

            if Holder then
                Holder = Holder:FindFirstChild("Timer");
            end;

            if not (Holder and (Holder:IsA("TextLabel") and Holder)) then
                Holder = nil;
            end;

            if Holder then
                Holder.Text = "";
            end;
        end;

        return;
    end;

    if u53.TickThread then
        pcall(task.cancel, u53.TickThread);
        u53.TickThread = nil;
    end;

    u53.TickThread = task.spawn(function() -- Line: 295
        -- upvalues: DataService (ref), Config (ref), u2 (ref), u53 (copy), FormatTime (ref), RefreshPrompts (ref)
        while true do
            local Data2 = DataService:GetData();

            if Data2 then
                Data2 = Data2.HarvestMoonPet;
            end;

            local v55, v56;

            if Data2 and Data2.StoredPetType then
                if Data2.StartTime == 0 then
                    v55 = "Stored";
                    v56 = 0;
                else
                    local StoredPetRarity = Data2.StoredPetRarity;
                    v56 = (StoredPetRarity and Config.DURATION_BY_RARITY[StoredPetRarity] or Config.DURATION_BY_RARITY.FallBack) - (workspace:GetServerTimeNow() - Data2.StartTime);

                    if v56 > 0 then
                        v55 = "Running";
                    else
                        v55 = "Complete";
                        v56 = 0;
                    end;
                end;
            else
                v55 = "Empty";
                v56 = 0;
            end;

            if v55 ~= "Running" then
                u2.Recompute(u53);

                return;
            end;

            local v57 = FormatTime(v56);
            local Holder = u53.Machine:FindFirstChild("Holder");

            if Holder then
                Holder = Holder:FindFirstChild("GUI");
            end;

            if Holder then
                Holder = Holder:FindFirstChild("Timer");
            end;

            if not (Holder and (Holder:IsA("TextLabel") and Holder)) then
                Holder = nil;
            end;

            if Holder then
                Holder.Text = v57;
            end;

            RefreshPrompts(u53, Data2);
            task.wait(1);
        end;
    end);
end;

function u2.RecomputeAll() -- Line: 392
    -- upvalues: u2 (copy)
    for _, v in u2.States do
        u2.Recompute(v);
    end;
end;

local function OnMainTriggered(p58) -- Line: 400
    -- upvalues: DataService (copy), Config (ref), HeldPetTool (copy), Notify (copy), HarvestMoonPet (copy), MarketController (copy)
    local Data = DataService:GetData();

    if Data then
        Data = Data.HarvestMoonPet;
    end;

    local v59;

    if Data and Data.StoredPetType then
        if Data.StartTime == 0 then
            v59 = "Stored";
        else
            local StoredPetRarity = Data.StoredPetRarity;
            v59 = (StoredPetRarity and Config.DURATION_BY_RARITY[StoredPetRarity] or Config.DURATION_BY_RARITY.FallBack) - (workspace:GetServerTimeNow() - Data.StartTime) > 0 and "Running" or "Complete";
        end;
    else
        v59 = "Empty";
    end;

    if v59 ~= "Empty" then
        if v59 == "Running" then
            local StoredPetRarity = Data.StoredPetRarity;
            local v60 = StoredPetRarity and Config.SKIP_PRODUCTS[StoredPetRarity] or Config.SKIP_PRODUCTS.FallBack;

            if v60 and v60 > 0 then
                MarketController:PromptPurchase(v60, Enum.InfoType.Product);

                return;
            end;
        elseif v59 == "Complete" then
            HarvestMoonPet.Claim:FireServer();
        end;

        return;
    end;

    if not HeldPetTool() then
        return Notify(Config.MESSAGES.NO_PET_HELD);
    end;

    HarvestMoonPet.Submit:FireServer();
end;

local function OnStartTriggered(p61) -- Line: 420
    -- upvalues: DataService (copy), ConfirmationPromptController (copy), Chalk (copy), ToColor3 (copy), Config (ref), HarvestMoonPet (copy)
    local Data = DataService:GetData();

    if Data then
        Data = Data.HarvestMoonPet;
    end;

    if not (Data and (Data.StoredPetType and Data.StartTime == 0)) then
        return;
    end;

    local v62 = {
        Title = "Start the Moon Machine?",
        Footer = "This cannot be undone once started.",
        ConfirmText = "Start",
        RejectText = "Cancel",
        Header = Data.StoredPetType
    };
    local v63 = Chalk.color(ToColor3(Config.NOTIFICATION_COLOR3));
    local StoredPetRarity = Data.StoredPetRarity;
    v62.Middle = `This will cost {v63((`{StoredPetRarity and Config.COST_BY_RARITY[StoredPetRarity] or Config.COST_BY_RARITY.FallBack} Moon Coins`))}. Your Pet's LEVEL and existing MUTATIONS will be reset!`;
    ConfirmationPromptController:Open(v62, {
        ConfirmCallback = function() -- Line: 432, Name: ConfirmCallback
            -- upvalues: HarvestMoonPet (ref)
            HarvestMoonPet.Start:FireServer();
        end
    });
end;

local function OnRemoveTriggered(p64) -- Line: 438
    -- upvalues: HarvestMoonPet (copy)
    HarvestMoonPet.RemovePet:FireServer();
end;

local function BuildPrompts(u65) -- Line: 444
    -- upvalues: OnMainTriggered (copy), OnStartTriggered (copy), HarvestMoonPet (copy)
    local Trove2 = u65.Trove;
    local u66 = Trove2:Add(Instance.new("Part"));
    u66.Name = "HMP_PromptHolder";
    u66.Transparency = 1;
    u66.CanCollide = false;
    u66.CanQuery = false;
    u66.CanTouch = false;
    u66.Anchored = true;
    u66.Size = Vector3.new(0.5, 0.5, 0.5);
    u66:PivotTo(u65.Machine:GetPivot());
    u66.Parent = u65.Machine;

    local function makePrompt(p67: string, p68: any, p69: any, p70: number) -- Line: 458
        -- upvalues: u66 (copy)
        local ProximityPrompt = Instance.new("ProximityPrompt");
        ProximityPrompt:SetAttribute("Theme", "ShadowedPrompt");
        ProximityPrompt.Style = Enum.ProximityPromptStyle.Custom;
        ProximityPrompt.RequiresLineOfSight = false;
        ProximityPrompt.ActionText = p67;
        ProximityPrompt.ObjectText = "Moon Machine";
        ProximityPrompt.UIOffset = Vector2.new(0, p70);

        if p68 then
            ProximityPrompt.KeyboardKeyCode = p68;
        end;

        if p69 then
            ProximityPrompt.GamepadKeyCode = p69;
        end;

        ProximityPrompt.Parent = u66;

        return ProximityPrompt;
    end;

    u65.MainPrompt = makePrompt("Submit Pet", nil, Enum.KeyCode.ButtonY, 0);
    u65.StartPrompt = makePrompt("Start", nil, Enum.KeyCode.ButtonA, 40);
    u65.StartPrompt.Enabled = false;
    u65.RemovePrompt = makePrompt("Remove", Enum.KeyCode.R, Enum.KeyCode.ButtonX, -40);
    u65.RemovePrompt.Enabled = false;
    Trove2:Add(u65.MainPrompt.Triggered:Connect(function() -- Line: 478
        -- upvalues: OnMainTriggered (ref), u65 (copy)
        OnMainTriggered(u65);
    end));
    Trove2:Add(u65.StartPrompt.Triggered:Connect(function() -- Line: 479
        -- upvalues: OnStartTriggered (ref), u65 (copy)
        OnStartTriggered(u65);
    end));
    Trove2:Add(u65.RemovePrompt.Triggered:Connect(function() -- Line: 480
        -- upvalues: u65 (copy), HarvestMoonPet (ref)
        HarvestMoonPet.RemovePet:FireServer();
    end));
end;

function u2.Start() -- Line: 492
    -- upvalues: CreateTagHandler (copy), Config (ref), Trove (copy), u2 (copy), SetMachineLoops (copy), BuildPrompts (copy), u1 (copy), DataService (copy), RunService (copy), u22 (ref)
    CreateTagHandler({
        Tag = Config.MODEL_TAG,

        OnInstanceAdded = function(u71: userdata) -- Line: 495, Name: OnInstanceAdded
            -- upvalues: Trove (ref), u2 (ref), SetMachineLoops (ref), BuildPrompts (ref)
            local u72 = {
                Running = false,
                PetModel = nil,
                CurrentPetKey = nil,
                PetRenderToken = 0,
                SpinAngle = 0,
                TickThread = nil,
                Trove = Trove.new(),
                Machine = u71
            };
            u2.States[u71] = u72;
            u72.Trove:Add(function() -- Line: 508
                -- upvalues: u72 (copy), SetMachineLoops (ref), u2 (ref), u71 (copy)
                local v73 = u72;

                if v73.TickThread then
                    pcall(task.cancel, v73.TickThread);
                    v73.TickThread = nil;
                end;

                SetMachineLoops(u72, false);
                local v74 = u72;
                v74.PetRenderToken = v74.PetRenderToken + 1;
                v74.CurrentPetKey = nil;

                if v74.PetModel then
                    v74.PetModel:Destroy();
                    v74.PetModel = nil;
                end;

                u2.States[u71] = nil;
            end);
            BuildPrompts(u72);
            u2.Recompute(u72);
        end,

        OnInstanceRemoved = function(p75: userdata) -- Line: 523, Name: OnInstanceRemoved
            -- upvalues: u2 (ref)
            local v76 = u2.States[p75];

            if v76 and v76.Trove then
                v76.Trove:Clean();
            end;
        end
    });
    u1:Add(DataService:GetPathSignal("HarvestMoonPet/StoredPetType"):Connect(u2.RecomputeAll));
    u1:Add(DataService:GetPathSignal("HarvestMoonPet/StartTime"):Connect(u2.RecomputeAll));
    task.spawn(function() -- Line: 536
        -- upvalues: DataService (ref), u2 (ref)
        if not DataService:GetData() then
            DataService:GetPathSignal("HarvestMoonPet/StoredPetType");
        end;

        u2.RecomputeAll();
    end);
    u1:Add(RunService.PreRender:Connect(function(p77) -- Line: 544
        -- upvalues: u22 (ref), u2 (ref)
        u22 = u22 + p77;

        for _, v in u2.States do
            if v.PetModel and v.PetModel.PrimaryPart then
                local PetModel = v.PetModel;
                local v78 = math.sin(u22) * 0.01;
                local CFrame_Angles_ret = CFrame.Angles(0, 0.008726646259971648, 0);
                PetModel:PivotTo((PetModel:GetPivot() + Vector3.new(0, v78, 0)) * CFrame_Angles_ret);
            end;
        end;
    end));
end;

EventRotationClientBinder:Bind({
    EventSet = "HarvestMoonEvent",
    Script = script,

    OnStart = function() -- Line: 565, Name: OnStart
        -- upvalues: u2 (copy)
        task.spawn(u2.Start);
    end,

    OnStop = function() -- Line: 566, Name: OnStop
        -- upvalues: u1 (copy)
        u1:Clean();
    end
});

return u2;