-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CollectionService = game:GetService("CollectionService");
local TweenService = game:GetService("TweenService");
local Players = game:GetService("Players");
local EventRotationUtils = require(ReplicatedStorage.Modules.EventRotation.EventRotationUtils);
local EventRotationController = require(ReplicatedStorage.Modules.EventRotation.EventRotationController);
local GameConfigController = require(ReplicatedStorage.Modules.GameConfigController);
require(ReplicatedStorage.Modules.UpdateService);
local DataService = require(ReplicatedStorage.Modules.DataService);
require(ReplicatedStorage.Modules.Notification);
require(ReplicatedStorage.Modules.CountDictionary);
local FastTween = require(ReplicatedStorage.Modules.FastTween);
local Observers = require(ReplicatedStorage.Modules.Observers);
local Comma_Module = require(ReplicatedStorage.Comma_Module);
require(ReplicatedStorage.Code.Spr);
local Bezier_2 = require(ReplicatedStorage.Code.Bezier_2);
require(ReplicatedStorage.Data.DefaultData);
local Trove = require(ReplicatedStorage.Modules.Trove);
local ZenEventTreeController = require(ReplicatedStorage.Modules.Events.ZenEvent.ZenEventTreeController);
local u1 = Trove.new();
local Config = GameConfigController:GetConfig("ZenEventConfig");
local ZenProgressData = Config.ZenProgressData;
local CorruptZenQuestData = Config.CorruptZenQuestData;
local ZenTreeData = Config.ZenTreeData;
workspace:GetAttributeChangedSignal("ZenEventConfig"):Connect(function() -- Line: 30
    -- upvalues: Config (ref), GameConfigController (copy), ZenProgressData (ref), CorruptZenQuestData (ref), ZenTreeData (ref)
    Config = GameConfigController:GetConfig("ZenEventConfig");
    ZenProgressData = Config.ZenProgressData;
    CorruptZenQuestData = Config.CorruptZenQuestData;
    ZenTreeData = Config.ZenTreeData;
end);
local GameEvents = ReplicatedStorage:WaitForChild("GameEvents");
local _ = GameEvents.Events.ZenEvent.ClaimZenReward;
local FoxRewardEffect = GameEvents.Events.ZenEvent.FoxRewardEffect;
local LocalPlayer = Players.LocalPlayer;
local u2 = {};
local u3 = {};

local function UpdateCorruptUI() -- Line: 51
    -- upvalues: DataService (copy), LocalPlayer (copy), CorruptZenQuestData (ref), CollectionService (copy), Comma_Module (copy), u2 (copy), FastTween (copy)
    local Data = DataService:GetData();

    if not Data then
        return warn((`No PlayerData for {LocalPlayer}!`));
    end;

    local ZenEventData = Data.ZenEventData;

    if not ZenEventData then
        return warn((`No ZenEventData data for {LocalPlayer.Name}!`));
    end;

    local CurrentQuest = Data.ZenEventData.CurrentQuest;

    if CurrentQuest == nil then
        return;
    end;

    local v4 = CorruptZenQuestData[CurrentQuest.Difficulty];

    if not v4 then
        warn((`Invalid quest difficulty {CurrentQuest.Difficulty}`));

        return;
    end;

    local v5 = v4[CurrentQuest.Index];

    if not v5 then
        warn((`Invalid quest index {CurrentQuest.Index}`));

        return;
    end;

    local v6 = CollectionService:GetTagged("CorruptZenPlatform")[1];
    local ShecklesAmountLabel = v6:FindFirstChild("ShecklesAmountLabel", true);
    v6:FindFirstChild("ShecklesRequiredLabel", true).Text = `{v5.Type} Required:`;
    local v7 = "";

    if v5.Type == "Sheckles" then
        local v8;

        if v5.Method == "Percent" then
            local math_floor_ret = math.floor((CurrentQuest.CurrentSheckles or Data.Sheckles) * (v5.Value / 100));
            v8 = math.max(math_floor_ret, v5.Minimum or 0);
        else
            if v5.Method ~= "Amount" then
                warn((`Quest for Sheckles: Method "{v5.Method}" not supported`));

                return;
            end;

            v8 = v5.Value;
        end;

        v7 = Comma_Module.Comma(v8) .. "¢";
    elseif v5.Type == "Fruit" or v5.Type == "Plant" then
        v7 = `Tranquil {v5.Value} [{v5.Weight}kg]`;
    end;

    ShecklesAmountLabel.Text = v7;

    for _, v in { "Corruption", "Tranquil" } do
        local v9;

        if v == "Corruption" then
            v9 = Color3.fromRGB(68, 26, 25);
        else
            v9 = Color3.fromRGB(21, 64, 72);
        end;

        local v10;

        if v == "Corruption" then
            v10 = Color3.fromRGB(170, 65, 61);
        else
            v10 = Color3.fromRGB(86, 169, 188);
        end;

        local v11;

        if v == "Corruption" then
            v11 = ZenEventData.CorruptionLevel;
        else
            v11 = ZenEventData.TranquilLevel;
        end;

        for _, v2 in CollectionService:GetTagged((`{v}LevelPart`)) do
            if v2:IsA("BasePart") and not v2:GetAttribute("InAnimation") then
                local v12 = tonumber(v2.Name) or 0;
                local v13 = v12 <= v11;
                local v14;

                if v13 then
                    v14 = v10;
                else
                    v14 = v9;
                end;

                if v2.Color ~= v14 then
                    u2[v2] = FastTween(v2, TweenInfo.new(v13 and 1 or 0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0, false, v13 and 0 or (5 - v12) * 0.5), {
                        Color = v14
                    });
                end;
            end;
        end;
    end;

    local v15 = CollectionService:GetTagged("CorruptionLevelTextLabel")[1];
    local v16 = CollectionService:GetTagged("TranquilLevelTextLabel")[1];
    local v17 = CollectionService:GetTagged("CorruptStageSignText")[1];

    if v15 and (v16 and v17) then
        v15.Text = `{ZenEventData.CorruptionLevel}`;
        v16.Text = `{ZenEventData.TranquilLevel}`;
        v17.Text = `Corruption: {ZenEventData.CorruptionZenSpawn}`;
    end;
end;

local function PlayFoxRewardEffect() -- Line: 119
    -- upvalues: CollectionService (copy), FastTween (copy), u2 (copy), UpdateCorruptUI (copy), GameEvents (copy), LocalPlayer (copy), Bezier_2 (copy), TweenService (copy)
    local u18 = CollectionService:GetTagged("ZenKitsune")[1];

    if not u18 then
        return;
    end;

    local v19 = CollectionService:GetTagged("TranquilCenterPart")[1];
    local v20 = CollectionService:GetTagged("CorruptionCenterPart")[1];

    if not (v19 and v20) then
        return;
    end;

    for _, v in CollectionService:GetTagged("CorruptionLevelRotateEffect") do
        FastTween(v, TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
            Rotation = -360
        });
    end;

    local u21 = false;

    for _, v in { "Corruption", "Tranquil" } do
        local u22;

        if v == "Corruption" then
            u22 = Color3.fromRGB(68, 26, 25);
        else
            u22 = Color3.fromRGB(21, 64, 72);
        end;

        local u23;

        if v == "Corruption" then
            u23 = Color3.fromRGB(170, 65, 61);
        else
            u23 = Color3.fromRGB(86, 169, 188);
        end;

        for _, v2 in CollectionService:GetTagged((`{v}LevelPart`)) do
            if v2:IsA("Part") then
                v2:SetAttribute("InAnimation", true);

                if u2[v2] then
                    u2[v2]:Cancel();
                    u2[v2] = nil;
                end;

                task.spawn(function() -- Line: 151
                    -- upvalues: FastTween (ref), v2 (copy), u23 (copy), u22 (copy), u21 (ref), UpdateCorruptUI (ref)
                    FastTween(v2, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                        Color = u23
                    }).Completed:Wait();
                    local v24 = ((tonumber(v2.Name) or 1) - 1) * 0.25;
                    FastTween(v2, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out, 0, false, v24), {
                        Color = u22
                    }).Completed:Wait();
                    task.wait(2 - v24);
                    v2:SetAttribute("InAnimation", nil);

                    if not u21 then
                        u21 = true;
                        task.delay(0.1, function() -- Line: 168
                            -- upvalues: UpdateCorruptUI (ref)
                            UpdateCorruptUI();
                        end);
                    end;
                end);
            end;
        end;
    end;

    task.wait(0.5);
    task.delay(3.25, function() -- Line: 178
        -- upvalues: u18 (copy), GameEvents (ref), LocalPlayer (ref)
        GameEvents.FireDropBindable:Fire({
            Owner = LocalPlayer.Name
        }, u18.PrimaryPart.CFrame * CFrame.new(0, -5, 5));
    end);

    for i, v in { v19, v20 } do
        task.spawn(function() -- Line: 184
            -- upvalues: i (copy), v (copy), u18 (copy), Bezier_2 (ref), TweenService (ref)
            local v25 = i == 2;
            local v26 = (i - 1) * 2 - 1;
            local Position = (v:GetPivot() * CFrame.new(0, 0, -5)).Position;
            local Position2 = u18:GetPivot().Position;

            for i2 = 1, 5 do
                local u27 = script.Wisp:Clone();
                u27.Position = Position;
                u27.Parent = workspace;

                if v25 then
                    u27.Color = Color3.fromRGB(255, 75, 75);
                    u27.Attachment.Chakra.Color = ColorSequence.new(Color3.fromRGB(60, 15, 15));
                    u27.Attachment.Glow.Color = ColorSequence.new(Color3.fromRGB(135, 40, 40));
                    u27.Trail.Color = ColorSequence.new(Color3.fromRGB(150, 0, 0));
                    u27.Trail2.Color = ColorSequence.new(Color3.fromRGB(150, 0, 0));
                    u27.Emit.Cubes.Color = ColorSequence.new(Color3.fromRGB(255, 25, 25));
                    u27.Emit["Little Stars"].Color = ColorSequence.new(Color3.fromRGB(255, 25, 25));
                end;

                local v28 = Position:Lerp(Position2, 0.33) + Vector3.new(0, 1, 0) * math.random(5, 15);
                local v29 = math.random(15, 25) * v26;
                local v30 = v28 + Vector3.new(v29, 0, 10);
                local v31 = Position:Lerp(Position2, 0.66) + Vector3.new(0, 1, 0) * math.random(0, 5);
                local v32 = math.random(15, 25) * v26;
                local v33 = v31 + Vector3.new(v32, 0, 10);
                local v34 = Bezier_2.new(Position, v30, v33, Position2):CreateCFrameTween(u27, { "CFrame" }, (TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.In)));
                game:GetService("Debris"):AddItem(u27, 5);
                v34:Play();
                v34.Completed:Once(function() -- Line: 220
                    -- upvalues: TweenService (ref), u27 (copy)
                    TweenService:Create(u27, TweenInfo.new(0.5), {
                        Transparency = 1,
                        Size = u27.Size * 1.5
                    }):Play();

                    for _, descendant in u27:GetDescendants() do
                        if descendant:IsA("ParticleEmitter") then
                            if descendant.Enabled then
                                descendant.Enabled = false;
                            else
                                descendant:Emit(descendant:GetAttribute("EmitCount") or 1);
                            end;
                        end;
                    end;
                end);
                task.wait(0.25);
                local _ = i2;
            end;
        end);
    end;
end;

function u3.Start(p35) -- Line: 238
    -- upvalues: CollectionService (copy), u1 (copy), DataService (copy), UpdateCorruptUI (copy), FoxRewardEffect (copy), PlayFoxRewardEffect (copy), LocalPlayer (copy), ZenEventTreeController (copy), Observers (copy), FastTween (copy)
    local u36 = CollectionService:GetTagged("CorruptZenTree")[1];

    if not u36 then
        warn("Missing CorruptZenTree. Looping search for 10s");
        local v37 = 0;

        repeat
            v37 = v37 + task.wait();
            u36 = CollectionService:GetTagged("CorruptZenTree")[1];
        until v37 > 10 or u36 ~= nil;

        if not u36 then
            warn("No CorruptZenTree found!");

            return;
        end;
    end;

    local PathSignal = DataService:GetPathSignal("ZenEventData/@");
    u1:Add(assert(PathSignal, "Failed to listen for Zen Event Data Changes"):Connect(function() -- Line: 253
        -- upvalues: UpdateCorruptUI (ref)
        UpdateCorruptUI();
    end));
    u1:Add(CollectionService:GetInstanceAddedSignal("CorruptionLevelPart"):Connect(function() -- Line: 257
        -- upvalues: UpdateCorruptUI (ref)
        UpdateCorruptUI();
    end));
    u1:Add(FoxRewardEffect.OnClientEvent:Connect(function() -- Line: 261
        -- upvalues: PlayFoxRewardEffect (ref)
        PlayFoxRewardEffect();
    end));
    local PathSignal2 = DataService:GetPathSignal("ZenEventData/CorruptionZenSpawn");
    u1:Add(assert(PathSignal2, "Failed to listen for Quest Containers"):Connect(function() -- Line: 265
        -- upvalues: LocalPlayer (ref), DataService (ref), u36 (ref), ZenEventTreeController (ref)
        if not LocalPlayer then
            return warn("No LocalPlayer!");
        end;

        local Data = DataService:GetData();

        if not Data then
            return warn((`No PlayerData for {LocalPlayer}!`));
        end;

        if Data.ZenEventData.CorruptionZenSpawn <= 0 then
            u36.Parent = script;
        end;

        ZenEventTreeController:Run(true);
    end));
    u1:Add(u36.AncestryChanged:Connect(function() -- Line: 278
        -- upvalues: ZenEventTreeController (ref)
        ZenEventTreeController:Run(true);
    end));
    Observers.observeTag("CorruptionLevelRotateEffect", function(p38: userdata) -- Line: 282
        -- upvalues: FastTween (ref)
        local u39 = FastTween(p38, TweenInfo.new(15, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, -1, false, 0), {
            Rotation = -360
        });

        return function() -- Line: 287
            -- upvalues: u39 (copy)
            u39:Cancel();
            u39:Destroy();
        end;
    end);
    task.wait(1);
    task.spawn(function() -- Line: 295
        -- upvalues: ZenEventTreeController (ref)
        ZenEventTreeController:SetupCorruptTree();
        ZenEventTreeController:Run(true);
    end);
    task.spawn(UpdateCorruptUI);
end;

local u40 = false;

local function OnEventUpdated(p41: string, p42: string) -- Line: 304
    -- upvalues: u1 (copy), u40 (ref), EventRotationUtils (copy), u3 (copy)
    if p42 ~= "ZenEvent" then
        u1:Clean();
        u40 = false;

        return;
    end;

    local EventInSetIndex = EventRotationUtils:GetEventInSetIndex(p41, p42);

    if not EventInSetIndex then
        return;
    end;

    if EventInSetIndex < 2 then
        return;
    end;

    if u40 then
        return;
    end;

    u40 = true;
    u1:Clean();
    task.spawn(u3.Start, u3);
end;

EventRotationController.EventUpdated:Connect(OnEventUpdated);
local LoadedEvent = EventRotationController:GetLoadedEvent();

if LoadedEvent and LoadedEvent.EventSet == "ZenEvent" then
    OnEventUpdated(LoadedEvent.EventID, LoadedEvent.EventSet);
end;

return u3;