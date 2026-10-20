-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("CollectionService");
game:GetService("Players");
require(ReplicatedStorage.Modules.GiveServiceCommon.RewardDataTypes);
local CountDictionary = require(ReplicatedStorage.Modules.CountDictionary);
local Trove = require(ReplicatedStorage.Modules.Trove);
require(ReplicatedStorage.Modules.GuiController);
require(ReplicatedStorage.Comma_Module);
require(ReplicatedStorage.Modules.ItemImageFinder);
local EventRotationUtils = require(ReplicatedStorage.Modules.EventRotation.EventRotationUtils);
local EventRotationController = require(ReplicatedStorage.Modules.EventRotation.EventRotationController);
local GameConfigController = require(ReplicatedStorage.Modules.GameConfigController);
local Config = GameConfigController:GetConfig("SummerHarvestEventConfig");
workspace:GetAttributeChangedSignal("SummerHarvestEventConfig"):Connect(function() -- Line: 18
    -- upvalues: Config (ref), GameConfigController (copy)
    Config = GameConfigController:GetConfig("SummerHarvestEventConfig");
end);
local u1 = Trove.new();
local GameEvents = ReplicatedStorage:WaitForChild("GameEvents");
local ResetRewardSign = GameEvents.Events.SummerHarvestEvent.ResetRewardSign;
local UpdateRewardSign = GameEvents.Events.SummerHarvestEvent.UpdateRewardSign;
local SubmitHeldSummerPlant = GameEvents.Events.SummerHarvestEvent.SubmitHeldSummerPlant;
local u2 = Vector3.new(0, 0, 0);
local u3 = false;
local u4 = {};

local function PlayResetRewardsVisual(u5: number, u6: table) -- Line: 34
    -- upvalues: EventRotationUtils (copy), u3 (ref), CountDictionary (copy)
    local v7 = EventRotationUtils:GetEventIDModels("SummerHarvestEvent")[1];
    u3 = true;
    task.spawn(function() -- Line: 38
        -- upvalues: u5 (copy), CountDictionary (ref), u6 (copy)
        local v8 = u5 / CountDictionary(u6);

        for i = CountDictionary(u6), 1, -1 do
            local v9 = u6[`{i}`];
            local v10;

            if v9 then
                v10 = i;
                local v11 = false;

                for _, descendant in v9:GetDescendants() do
                    if (descendant:IsA("BasePart") or descendant:IsA("UnionOperation")) and descendant.Transparency ~= 1 then
                        descendant.Transparency = 1;
                        descendant.CanCollide = false;
                        v11 = true;
                    end;
                end;

                if v11 then
                    local v12 = workspace:FindFirstChild("Terrain"):FindFirstChild("PopEffect"):Clone();
                    v12.CFrame = CFrame.new(v9:GetPivot().Position);
                    v12.Parent = workspace.Terrain;

                    for _, child in v12:GetChildren() do
                        child:Emit(1);
                    end;

                    game.Debris:AddItem(v12, 2);
                    task.wait(v8);
                end;
            else
                v10 = i;
            end;
        end;
    end);
    task.wait(u5);
    u3 = false;
    local RewardSign = v7:FindFirstChild("RewardSign");
    local PointTextLabel = RewardSign:FindFirstChild("PointTextLabel", true);
    local RewardTextLabel = RewardSign:FindFirstChild("RewardTextLabel", true);
    PointTextLabel.Text = `Harvest Points {0}`;
    RewardTextLabel.Text = "NO REWARDS";
end;

local function u17(p13: number, p14: table) -- Line: 88
    -- upvalues: CountDictionary (copy), EventRotationUtils (copy)
    for i = 1, math.floor(p13) do
        if CountDictionary(p14) < i then
            break;
        end;

        local v15 = p14[`{i}`];
        local v16;

        if v15 then
            v16 = i;

            for _, descendant in v15:GetDescendants() do
                if descendant:IsA("BasePart") or descendant:IsA("UnionOperation") then
                    descendant.Transparency = 0;
                    descendant.CanCollide = true;
                end;
            end;
        else
            v16 = i;
        end;
    end;

    local RewardSign = EventRotationUtils:GetEventIDModels("SummerHarvestEvent")[1]:FindFirstChild("RewardSign");
    local PointTextLabel = RewardSign:FindFirstChild("PointTextLabel", true);
    local RewardTextLabel = RewardSign:FindFirstChild("RewardTextLabel", true);
    PointTextLabel.Text = `Harvest Points {math.floor(p13)}`;

    if p13 < 1 then
        RewardTextLabel.Text = "N0 REWARDS";

        return;
    end;

    if p13 >= 10 then
        RewardTextLabel.Text = "COMMON REWARDS";

        return;
    end;

    if p13 > 500 then
        RewardTextLabel.Text = "UNCOMMON REWARDS";

        return;
    end;

    if p13 > 2000 then
        RewardTextLabel.Text = "RARE REWARDS";

        return;
    end;

    if p13 > 5000 then
        RewardTextLabel.Text = "LEGENDARY REWARDS";

        return;
    end;

    if p13 > 8500 then
        RewardTextLabel.Text = "MYTHICAL REWARDS";

        return;
    end;

    if p13 > 11000 then
        RewardTextLabel.Text = "DIVINE REWARDS";

        return;
    end;

    if p13 > 14000 then
        RewardTextLabel.Text = "PRISMATIC REWARDS";
    end;
end;

function u4.Start(p18) -- Line: 130
    -- upvalues: EventRotationUtils (copy), u2 (ref), u1 (copy), ResetRewardSign (copy), PlayResetRewardsVisual (copy), UpdateRewardSign (copy), u17 (copy), u3 (ref), SubmitHeldSummerPlant (copy)
    local u19 = EventRotationUtils:GetEventIDModels("SummerHarvestEvent")[1]:QueryDescendants(".SummerHarvestCart")[1];
    local Pivot = u19:GetPivot();

    local function ShakeCart(p20: number) -- Line: 136
        -- upvalues: u2 (ref), u19 (copy), Pivot (copy)
        local v21 = p20 or 0.2;
        local v22 = math.random(-100, 100) / 100 * v21;
        local v23 = math.random(-100, 100) / 100 * v21;
        u2 = Vector3.new(v22, v23);
        u19:PivotTo(Pivot + u2);
    end;

    local u24 = {};

    for _, descendant in u19:WaitForChild("FruitLoad"):GetDescendants() do
        if descendant:IsA("Model") then
            u24[descendant.Name] = descendant;
        end;
    end;

    for _, v in u24 do
        for _, descendant in v:GetDescendants() do
            if descendant:IsA("BasePart") or descendant:IsA("UnionOperation") then
                descendant.Transparency = 1;
                descendant.CanCollide = false;
            end;
        end;
    end;

    u1:Add(ResetRewardSign.OnClientEvent:Connect(function(p25: number) -- Line: 163
        -- upvalues: PlayResetRewardsVisual (ref), u24 (copy)
        PlayResetRewardsVisual(p25, u24);
    end));
    u1:Add(UpdateRewardSign.OnClientEvent:Connect(function(p26: number) -- Line: 167
        -- upvalues: u17 (ref), u24 (copy)
        u17(p26, u24);
    end));
    u1:Add(task.spawn(function() -- Line: 171
        -- upvalues: u3 (ref), u2 (ref), u19 (copy), Pivot (copy)
        while true do
            repeat
                task.wait(0.02);
            until u3;

            local v27 = 0.1 or 0.2;
            local v28 = math.random(-100, 100) / 100 * v27;
            local v29 = math.random(-100, 100) / 100 * v27;
            u2 = Vector3.new(v28, v29);
            u19:PivotTo(Pivot + u2);
        end;
    end));
    u1:Add(u19:FindFirstChild("PromptPart"):FindFirstChild("SummerHarvestProxPrompt").Triggered:Connect(function() -- Line: 183
        -- upvalues: SubmitHeldSummerPlant (ref)
        SubmitHeldSummerPlant:FireServer();
    end));
end;

local u30 = false;
EventRotationController.EventUpdated:Connect(function(p31: string, p32: string) -- Line: 189, Name: OnEventUpdated
    -- upvalues: u1 (copy), u30 (ref), u4 (copy)
    if p32 ~= "SummerHarvestEvent" then
        u1:Clean();
        u30 = false;

        return;
    end;

    if u30 then
        return;
    end;

    u30 = true;
    u1:Clean();
    task.spawn(u4.Start, u4);
end);

return u4;