-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local SoundService = game:GetService("SoundService");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local WeightRandom = require(ReplicatedStorage.Modules.WeightRandom);
local SeedPackData = require(ReplicatedStorage.Data.SeedPackData);
local Item_Module = require(ReplicatedStorage.Item_Module);
local SeedData = require(ReplicatedStorage.Data.SeedData);
require(ReplicatedStorage.Modules.Notification);
local PetRegistry = require(ReplicatedStorage.Data.PetRegistry);
local PetEggs = require(ReplicatedStorage.Data.PetRegistry.PetEggs);
local FastTween = require(ReplicatedStorage.Modules.FastTween);
local Shake = require(ReplicatedStorage.Modules.Shake);
local GearData = require(ReplicatedStorage.Data.GearData);
local GiveServiceCommon = require(ReplicatedStorage.Modules.GiveServiceCommon);
local ItemImageFinder = require(ReplicatedStorage.Modules.ItemImageFinder);
local TradeBoothSkinRegistry = require(ReplicatedStorage.Data.TradeBoothSkinRegistry);
local CosmeticList = require(ReplicatedStorage.Data.CosmeticRegistry.CosmeticList);
local RollCrate_UI = Players.LocalPlayer.PlayerGui:WaitForChild("RollCrate_UI");
local Frame = RollCrate_UI.Frame;
local Rolled = Frame.Rolled;
local Spinner = Frame.Section.Spinner;
local table_create_ret = table.create(150);
local u1 = false;
local v2 = {};
local u3 = false;
local u4 = false;

local function isRainbow(p5: string) -- Line: 50
    return string.find(p5, "Rainbow", 1, true);
end;

local function tweenHolder(p6: boolean, p7: boolean?) -- Line: 54
    -- upvalues: Frame (copy), FastTween (copy)
    if p6 then
        if p7 then
            Frame.Position = UDim2.fromScale(0.5, 0.5);

            return;
        end;

        Frame.Position = UDim2.fromScale(0.5, 1.5);
        FastTween(Frame, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
            Position = UDim2.fromScale(0.5, 0.5)
        });

        return;
    end;

    if p7 then
        Frame.Position = UDim2.fromScale(0.5, 1.5);

        return;
    end;

    Frame.Position = UDim2.fromScale(0.5, 0.5);
    FastTween(Frame, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
        Position = UDim2.fromScale(0.5, 1.5)
    });
end;

local function tweenRolled(p8: boolean, p9: boolean?) -- Line: 76
    -- upvalues: Rolled (copy), FastTween (copy)
    if p8 then
        if p9 then
            Rolled.ImageTransparency = 0;
            Rolled.Label.TextTransparency = 0;
            Rolled.Label.UIStroke.Transparency = 0;

            return;
        end;

        local TweenInfo_new_ret = TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out);
        Rolled.ImageTransparency = 1;
        Rolled.Label.TextTransparency = 1;
        Rolled.Label.UIStroke.Transparency = 1;
        FastTween(Rolled, TweenInfo_new_ret, {
            ImageTransparency = 0
        });
        FastTween(Rolled.Label, TweenInfo_new_ret, {
            TextTransparency = 0
        });
        FastTween(Rolled.Label.UIStroke, TweenInfo_new_ret, {
            Transparency = 0
        });

        return;
    end;

    if p9 then
        Rolled.ImageTransparency = 1;
        Rolled.Label.TextTransparency = 1;
        Rolled.Label.UIStroke.Transparency = 1;

        return;
    end;

    local TweenInfo_new_ret = TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out);
    Rolled.ImageTransparency = 0;
    Rolled.Label.TextTransparency = 0;
    Rolled.Label.UIStroke.Transparency = 0;
    FastTween(Rolled, TweenInfo_new_ret, {
        ImageTransparency = 1
    });
    FastTween(Rolled.Label, TweenInfo_new_ret, {
        TextTransparency = 1
    });
    FastTween(Rolled.Label.UIStroke, TweenInfo_new_ret, {
        Transparency = 1
    });
end;

local function spinAction(p10: table) -- Line: 128
    -- upvalues: u4 (ref), RollCrate_UI (copy), Frame (copy), FastTween (copy), SeedPackData (copy), Rolled (copy), WeightRandom (copy), table_create_ret (copy), SeedData (copy), Item_Module (copy), PetRegistry (copy), TradeBoothSkinRegistry (copy), CosmeticList (copy), GearData (copy), GiveServiceCommon (copy), ItemImageFinder (copy), PetEggs (copy), SoundService (copy), Spinner (copy), TweenService (copy), Shake (copy), RunService (copy), tweenRolled (copy)
    local v11 = u4;
    RollCrate_UI.Enabled = true;

    if v11 then
        Frame.Position = UDim2.fromScale(0.5, 0.5);
    else
        Frame.Position = UDim2.fromScale(0.5, 1.5);
        FastTween(Frame, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
            Position = UDim2.fromScale(0.5, 0.5)
        });
    end;

    Frame.Visible = true;
    local Random_new_ret = Random.new();
    local v12 = SeedPackData.Packs[p10.seedPackType];
    local v13 = string.find(p10.seedPackType, "Rainbow", 1, true) and "Rainbow" or (string.find(p10.seedPackType, "Night") and "Night" or "Normal");
    local Items = v12.Items;
    local v14 = Items[p10.resultIndex];
    local v15 = 140;

    for _, child in Frame.Decorations:GetChildren() do
        child.Visible = child.Name == v13;
    end;

    for _, child in Rolled.Decorations:GetChildren() do
        child.Visible = child.Name == v13;
    end;

    local v16 = v14.Type == "Pack" and (string.find(v14.RewardId, "Rainbow", 1, true) or string.find(v14.RewardId, "Special", 1, true)) and true or false;
    local v17 = nil;

    for i = 1, 150 do
        local v18;

        if i == v15 then
            v18 = v14;
        else
            v18 = WeightRandom.array(Items, Random_new_ret);
        end;

        local v19;

        if v18 then
            local v20 = table_create_ret[i];
            local v21 = v18.Type == "Pack" and string.find(v18.RewardId, "Rainbow", 1, true) and "Custom_RainbowCrate" or v13;
            v19 = i;
            local v22 = nil;

            for _, child in v20:GetChildren() do
                local v23 = child.Name == v21;
                child.Visible = v23;

                if v23 then
                    v22 = child;
                end;
            end;

            if v22 then
                if v19 == v15 then
                    v17 = v22;
                end;

                if (v18.Type == "Seed" or (v18.Type == "RainbowSeed" or v18.Type == "SilverSeed")) and SeedData[v18.RewardId] then
                    local v24 = SeedData[v18.RewardId];
                    local v25 = Item_Module.Return_Rarity_Data(v24.SeedRarity);

                    if v25 then
                        v22.Rarity.Text = v25[1];
                        v22.Rarity.TextColor3 = v25[2];
                    end;

                    v22.Vector.Visible = true;
                    v22.Vector.Image = v24.Asset;
                elseif v18.Type == "Pack" then
                    v22.Vector.Image = v18.Icon or "";
                    v22.Vector.Visible = true;
                elseif v18.Type == "Pet" then
                    local v26 = PetRegistry.PetList[v18.RewardId];
                    local v27 = Item_Module.Return_Rarity_Data(v26.Rarity);

                    if v27 then
                        v22.Rarity.Text = v27[1];
                        v22.Rarity.TextColor3 = v27[2];
                    else
                        v22.Rarity.Text = v26.Rarity;
                        v22.Rarity.TextColor3 = PetRegistry.PetRarities[v26.Rarity].Color;
                    end;

                    v22.Vector.Image = v18.Icon or (v26.Icon or "");
                    v22.Vector.Visible = true;
                elseif v18.Type == "TradeBoothSkin" then
                    local v28 = TradeBoothSkinRegistry[v18.RewardId];
                    local v29 = Item_Module.Return_Rarity_Data(v28.Rarity);

                    if v29 then
                        v22.Rarity.Text = v29[1];
                        v22.Rarity.TextColor3 = v29[2];
                    end;

                    v22.Vector.Image = v18.Icon or (v28.Icon or "");
                    v22.Vector.Visible = true;
                elseif v18.Type == "Cosmetic" then
                    local v30 = CosmeticList[v18.RewardId];
                    local v31 = Item_Module.Return_Rarity_Data(v30.Rarity);

                    if v31 then
                        v22.Rarity.Text = v31[1];
                        v22.Rarity.TextColor3 = v31[2];
                    end;

                    v22.Vector.Image = v18.Icon or (v30.Icon or "");
                    v22.Vector.Visible = true;
                elseif v18.Type == "Gear" then
                    local v32 = GearData[v18.RewardId];
                    local v33 = Item_Module.Return_Rarity_Data(v32.GearRarity);

                    if v33 then
                        v22.Rarity.Text = v33[1];
                        v22.Rarity.TextColor3 = v33[2];
                    else
                        v22.Rarity.Text = v32.GearRarity;
                        v22.Rarity.TextColor3 = GiveServiceCommon:GetRarityColor({
                            Type = "Gear",
                            Quantity = 1,
                            Value = v18.RewardId
                        });
                    end;

                    v22.Vector.Image = ItemImageFinder(v18.RewardId, v18.Type) or "rbxassetid://6937742258";
                    v22.Vector.Visible = true;
                elseif v18.Type == "Egg" then
                    local v34 = PetEggs[v18.RewardId];
                    print(v18.RewardId);
                    local v35 = Item_Module.Return_Rarity_Data(v34.EggRarity);

                    if v35 then
                        v22.Rarity.Text = v35[1];
                        v22.Rarity.TextColor3 = v35[2];
                    else
                        v22.Rarity.Text = v34.EggRarity;
                        v22.Rarity.TextColor3 = GiveServiceCommon:GetRarityColor({
                            Type = "Egg",
                            Quantity = 1,
                            Value = v18.RewardId
                        });
                    end;

                    v22.Vector.Image = ItemImageFinder(v18.RewardId, v18.Type) or "rbxassetid://6937742258";
                    v22.Vector.Visible = true;
                elseif v18.Type == "Currency" then
                    v22.Rarity.Text = "";
                    v22.Vector.Image = ItemImageFinder(v18.RewardId, v18.Type) or "rbxassetid://6937742258";
                    v22.Vector.Visible = true;
                else
                    warn((`Seed data not found for {v18.RewardId}`));
                end;

                v22.Label.Text = SeedPackData:GetTextDisplayForItem(v18);
            end;
        else
            v15 = v15 - 1;
            v19 = i;
        end;
    end;

    local NumberValue = Instance.new("NumberValue");
    NumberValue.Value = 5;
    local u36 = nil;
    local u37 = nil;

    local function updatePosition() -- Line: 297
        -- upvalues: NumberValue (copy), u36 (ref), u37 (ref), SoundService (ref), u4 (ref), Spinner (ref)
        local Value = NumberValue.Value;
        local v38 = Value // 1;

        if v38 ~= u36 then
            if u36 and (not u37 or os.clock() - u37 > 0.05) then
                local v39;

                if u4 then
                    v39 = SoundService["Seed Pack"].RainbowTick;
                else
                    v39 = SoundService["Seed Pack"].NormalTick;
                end;

                SoundService:PlayLocalSound(v39);
                u37 = os.clock();
            end;

            u36 = v38;
        end;

        Spinner.Position = UDim2.new(0.5, -Value * Spinner.AbsoluteSize.Y, 0.5, 0);
    end;

    local v40 = Spinner:GetPropertyChangedSignal("AbsoluteSize"):Connect(updatePosition);
    local v41 = NumberValue.Changed:Connect(updatePosition);
    task.spawn(updatePosition);
    local u42 = v15 - 0.5 + (math.random() - 0.5) * 0.5;
    local v43 = TweenService:Create(NumberValue, TweenInfo.new(5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
        Value = u42
    });
    v43:Play();
    local u44 = false;
    local coroutine_running_ret = coroutine.running();

    local function resume() -- Line: 327
        -- upvalues: u44 (ref), coroutine_running_ret (copy)
        if u44 then
            return;
        end;

        u44 = true;

        if coroutine.status(coroutine_running_ret) == "suspended" then
            task.spawn(coroutine_running_ret);
        end;
    end;

    local v45 = Frame.Skip.Activated:Once(resume);
    local v46 = v43.Completed:Once(resume);

    if not u44 then
        coroutine.yield();
    end;

    v45:Disconnect();
    v46:Disconnect();
    v43:Cancel();
    v43:Destroy();
    v41:Disconnect();
    v40:Disconnect();
    task.defer(function() -- Line: 355
        -- upvalues: NumberValue (copy), u42 (copy), updatePosition (copy)
        NumberValue.Value = u42;
        updatePosition();
        NumberValue:Destroy();
    end);

    if v16 and v17 then
        SoundService["Seed Pack"].RainbowReward:Play();
        local v47 = FastTween(v17.Vector, TweenInfo.new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
            ImageColor3 = Color3.new(1, 1, 1)
        });
        local v48 = FastTween(v17, TweenInfo.new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
            ImageColor3 = Color3.new(1, 1, 1)
        });
        task.wait(0.3);
        local u49 = Shake.new();
        u49.FadeInTime = 0.5;
        u49.FadeOutTime = 1.5;
        u49.Frequency = 0.08;
        u49.Amplitude = 15;
        u49.Sustain = true;
        u49.PositionInfluence = Vector3.new(1, 1, 0);
        u49.RotationInfluence = Vector3.new(0, 0, 0);
        local u50 = nil;
        u50 = RunService.PostSimulation:Connect(function() -- Line: 386
            -- upvalues: u49 (copy), Frame (ref), u50 (ref)
            local v51, _, v52 = u49:Update();
            Frame.Position = UDim2.fromScale(0.5, 0.5) + UDim2.fromOffset(v51.X, v51.Y);

            if v52 then
                u50:Disconnect();
            end;
        end);
        task.wait(1.2);
        RollCrate_UI.Fade.BackgroundTransparency = 0;
        FastTween(RollCrate_UI.Fade, TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0.2), {
            BackgroundTransparency = 1
        });
        v47:Cancel();
        v48:Cancel();
        task.delay(0.3, function() -- Line: 405
            -- upvalues: u49 (copy)
            u49:StopSustain();
        end);
    else
        SoundService["Seed Pack"].Reward:Play();
        Rolled.Label.Text = `x1 {SeedPackData:GetTextDisplayForItem(v14)}`;
        tweenRolled(true);
        task.wait(2);
        Frame.Position = UDim2.fromScale(0.5, 0.5);
        FastTween(Frame, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
            Position = UDim2.fromScale(0.5, 1.5)
        });
        task.wait(0.5);
        tweenRolled(false);
    end;

    Frame.Visible = false;
    RollCrate_UI.Enabled = false;

    if v11 then
        u4 = false;
    end;

    if v16 then
        u4 = true;
    end;
end;

function v2.Spin(p53, p54) -- Line: 436
    -- upvalues: u1 (ref), u3 (ref), spinAction (copy), ReplicatedStorage (copy)
    while not u1 do
        task.wait();
    end;

    while u3 do
        task.wait();
    end;

    u3 = true;
    xpcall(spinAction, warn, p54);
    u3 = false;
    ReplicatedStorage.GameEvents.SeedPack.SpinFinished:FireServer();
end;

function v2.Start(u55) -- Line: 452
    -- upvalues: RollCrate_UI (copy), ReplicatedStorage (copy), Spinner (copy), table_create_ret (copy), u1 (ref)
    RollCrate_UI.Frame.Visible = false;
    RollCrate_UI.Frame.Position = UDim2.fromScale(0.5, 1.5);
    RollCrate_UI.Frame.Rolled.ImageTransparency = 1;
    RollCrate_UI.Frame.Rolled.Label.TextTransparency = 1;
    RollCrate_UI.Frame.Rolled.Label.UIStroke.Transparency = 1;

    for _, child in RollCrate_UI.Frame.Rolled.Decorations:GetChildren() do
        child.ImageTransparency = RollCrate_UI.Frame.Rolled.ImageTransparency;
        RollCrate_UI.Frame.Rolled:GetPropertyChangedSignal("ImageTransparency"):Connect(function() -- Line: 463
            -- upvalues: child (copy), RollCrate_UI (ref)
            child.ImageTransparency = RollCrate_UI.Frame.Rolled.ImageTransparency;
        end);
    end;

    ReplicatedStorage.GameEvents.SeedPack.Result.OnClientEvent:Connect(function(p56) -- Line: 468
        -- upvalues: u55 (copy)
        u55:Spin(p56);
    end);

    for i = 1, 150 do
        local v57 = Spinner.UIListLayout.Template:Clone();
        v57.Name = tostring(i);
        v57.LayoutOrder = i;
        v57.Parent = Spinner;
        table_create_ret[i] = v57;
        local v58;

        if i % 10 == 0 then
            task.wait(0.1);
            v58 = i;
        else
            v58 = i;
        end;
    end;

    u1 = true;
end;

task.spawn(v2.Start, v2);

return v2;