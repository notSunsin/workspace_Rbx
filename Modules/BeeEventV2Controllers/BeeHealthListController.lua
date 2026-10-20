-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local BeeColonyStateController = require(ReplicatedStorage.Modules.BeeEventV2Controllers.BeeColonyStateController);
local BeeRegistry = require(ReplicatedStorage.Data.BeeEvent.BeeRegistry);
local TimeHelper = require(ReplicatedStorage.Modules.TimeHelper);
local GetFarm = require(ReplicatedStorage.Modules.GetFarm);
local BeeEventConfig = require(ReplicatedStorage.Data.BeeEvent.BeeEventConfig);
local BeeEnchantmentRegistry = require(ReplicatedStorage.Data.BeeEvent.BeeEnchantmentRegistry);
local MarketController = require(ReplicatedStorage.Modules.MarketController);
local DevProductIds = require(ReplicatedStorage.Data.DevProductIds);
local LocalPlayer = Players.LocalPlayer;
local Container = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("BeeHealth_UI"):WaitForChild("Container");
local Frame = Container.ScrollingFrame.Frame;
local InfoTemplate = Frame.InfoTemplate;
local u1 = `Player_{LocalPlayer.UserId}`;
local TweenInfo_new_ret = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
local ExitRange = BeeEventConfig.Nesting.ExitRange;
local Color3_fromRGB_ret = Color3.fromRGB(255, 0, 0);
local Color3_fromRGB_ret2 = Color3.fromRGB(0, 255, 0);

local function GetMaxHealth(p2) -- Line: 47
    -- upvalues: BeeRegistry (copy), BeeEnchantmentRegistry (copy), LocalPlayer (copy)
    local v3 = BeeRegistry[p2.Server.BeeName];

    if not v3 then
        return 1;
    end;

    local MaxHealth = v3.Stats.MaxHealth;
    local Enchantment = p2.Server.Enchantment;

    if Enchantment then
        Enchantment = BeeEnchantmentRegistry.Entries[Enchantment];
    end;

    if Enchantment then
        Enchantment = Enchantment.Modifiers;
    end;

    if Enchantment then
        MaxHealth = MaxHealth * (Enchantment.MaxHealthMult or 1);
    end;

    return MaxHealth + (LocalPlayer:GetAttribute("BeeHealthBonus") or 0);
end;

local u4 = {};

local function GetSecondsRemaining(p5) -- Line: 79
    -- upvalues: BeeRegistry (copy), BeeEnchantmentRegistry (copy), LocalPlayer (copy)
    local Server = p5.Server;
    local v6 = BeeRegistry[Server.BeeName];

    if not v6 then
        return 0;
    end;

    local v7 = BeeRegistry[p5.Server.BeeName];
    local v8;

    if v7 then
        local MaxHealth = v7.Stats.MaxHealth;
        local Enchantment = p5.Server.Enchantment;

        if Enchantment then
            Enchantment = BeeEnchantmentRegistry.Entries[Enchantment];
        end;

        if Enchantment then
            Enchantment = Enchantment.Modifiers;
        end;

        if Enchantment then
            MaxHealth = MaxHealth * (Enchantment.MaxHealthMult or 1);
        end;

        v8 = MaxHealth + (LocalPlayer:GetAttribute("BeeHealthBonus") or 0);
    else
        v8 = 1;
    end;

    local HealRate = v6.Stats.HealRate;

    if not HealRate or HealRate <= 0 then
        return 0;
    end;

    local v9 = LocalPlayer:GetAttribute("BeeRespawnReduction") or 0;
    local v10 = v8 * (HealRate / 100) * (1 + v9) * (Server.State == "Nesting" and 1 or 0.5);

    return v10 <= 0 and 0 or math.ceil((v8 - Server.Health) / v10);
end;

local function IsNearHive() -- Line: 98
    -- upvalues: LocalPlayer (copy), GetFarm (copy), ExitRange (copy)
    local Character = LocalPlayer.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not Character then
        return false;
    end;

    local v11 = GetFarm(LocalPlayer);

    if not v11 then
        return false;
    end;

    local CurrentExpansion = v11:FindFirstChild("CurrentExpansion");

    if CurrentExpansion then
        CurrentExpansion = CurrentExpansion:FindFirstChild("Custom");
    end;

    if CurrentExpansion then
        CurrentExpansion = CurrentExpansion:FindFirstChild("Hive");
    end;

    if not CurrentExpansion then
        return false;
    end;

    local Position = CurrentExpansion:GetPivot().Position;

    return Vector3.new(Character.Position.X - Position.X, 0, Character.Position.Z - Position.Z).Magnitude <= ExitRange;
end;

local u12 = false;

local function UpdateContainerVisibility() -- Line: 118
    -- upvalues: Container (copy), u4 (copy), u12 (ref)
    local v13;

    if next(u4) == nil then
        v13 = false;
    else
        v13 = u12;
    end;

    Container.Visible = v13;
end;

local function ResortList() -- Line: 123
    RefreshAll();
end;

local function RefreshInfo(p14: table) -- Line: 131
    -- upvalues: BeeRegistry (copy), BeeEnchantmentRegistry (copy), LocalPlayer (copy), TweenService (copy), TweenInfo_new_ret (copy), Color3_fromRGB_ret (copy), Color3_fromRGB_ret2 (copy), TimeHelper (copy), GetSecondsRemaining (copy)
    local Server = p14.entry.Server;

    if not BeeRegistry[Server.BeeName] then
        return;
    end;

    local entry = p14.entry;
    local v15 = BeeRegistry[entry.Server.BeeName];
    local v16;

    if v15 then
        local MaxHealth = v15.Stats.MaxHealth;
        local Enchantment = entry.Server.Enchantment;

        if Enchantment then
            Enchantment = BeeEnchantmentRegistry.Entries[Enchantment];
        end;

        if Enchantment then
            Enchantment = Enchantment.Modifiers;
        end;

        if Enchantment then
            MaxHealth = MaxHealth * (Enchantment.MaxHealthMult or 1);
        end;

        v16 = MaxHealth + (LocalPlayer:GetAttribute("BeeHealthBonus") or 0);
    else
        v16 = 1;
    end;

    local math_clamp_ret = math.clamp(Server.Health / v16, 0, 1);
    local v17;

    if Server.LastHealTime == nil or Server.LastHealTime <= 0 then
        v17 = false;
    else
        v17 = not Server.IsInCombat;
    end;

    TweenService:Create(p14.frame.Details.Bar.Inner, TweenInfo_new_ret, {
        Size = UDim2.fromScale(math_clamp_ret, 1),
        BackgroundColor3 = Color3_fromRGB_ret:Lerp(Color3_fromRGB_ret2, math_clamp_ret)
    }):Play();
    local Timer = p14.frame.Details.Bar:FindFirstChild("Timer");

    if Timer then
        if v17 then
            Timer.Text = TimeHelper:GenerateColonFormatFromTime((GetSecondsRemaining(p14.entry)));
            Timer.Visible = true;
        else
            Timer.Visible = false;
        end;
    end;

    if not v17 then
        p14.frame.LayoutOrder = math.floor(math_clamp_ret * 100) + 10000;

        return;
    end;

    local frame = p14.frame;
    local v18 = GetSecondsRemaining(p14.entry);
    frame.LayoutOrder = math.clamp(v18, 0, 9999);
end;

local function RemoveInfo(p19: string) -- Line: 170
    -- upvalues: u4 (copy), Container (copy), u12 (ref)
    local v20 = u4[p19];

    if not v20 then
        return;
    end;

    v20.frame:Destroy();
    u4[p19] = nil;
    local v21;

    if next(u4) == nil then
        v21 = false;
    else
        v21 = u12;
    end;

    Container.Visible = v21;
end;

local function u26() -- Line: 181
    -- upvalues: u4 (copy), BeeRegistry (copy), BeeEnchantmentRegistry (copy), LocalPlayer (copy), Container (copy), u12 (ref), RefreshInfo (copy)
    for i, v in u4 do
        local Server = v.entry.Server;
        local entry = v.entry;
        local v22 = BeeRegistry[entry.Server.BeeName];
        local v23;

        if v22 then
            local MaxHealth = v22.Stats.MaxHealth;
            local Enchantment = entry.Server.Enchantment;

            if Enchantment then
                Enchantment = BeeEnchantmentRegistry.Entries[Enchantment];
            end;

            if Enchantment then
                Enchantment = Enchantment.Modifiers;
            end;

            if Enchantment then
                MaxHealth = MaxHealth * (Enchantment.MaxHealthMult or 1);
            end;

            v23 = MaxHealth + (LocalPlayer:GetAttribute("BeeHealthBonus") or 0);
        else
            v23 = 1;
        end;

        if v23 <= Server.Health then
            local v24 = u4[i];

            if v24 then
                v24.frame:Destroy();
                u4[i] = nil;
                local v25;

                if next(u4) == nil then
                    v25 = false;
                else
                    v25 = u12;
                end;

                Container.Visible = v25;
            end;
        else
            RefreshInfo(v);
        end;
    end;
end;

local function UpdateInfoTimer(p27: table) -- Line: 195
    -- upvalues: RefreshInfo (copy)
    RefreshInfo(p27);
end;

local function UpdateInfo(p28: string, p29: any, p30: string, p31: any) -- Line: 204
    -- upvalues: BeeRegistry (copy), u4 (copy), Container (copy), u12 (ref), BeeEnchantmentRegistry (copy), LocalPlayer (copy), InfoTemplate (copy), Frame (copy), RefreshInfo (copy)
    local Server = p29.Server;
    local v32 = BeeRegistry[Server.BeeName];

    if not v32 then
        return;
    end;

    if Server.BeeName == "Skeleton Bee" then
        local v33 = u4[p28];

        if not v33 then
            return;
        end;

        v33.frame:Destroy();
        u4[p28] = nil;
        local v34;

        if next(u4) == nil then
            v34 = false;
        else
            v34 = u12;
        end;

        Container.Visible = v34;

        return;
    end;

    local v35 = BeeRegistry[p29.Server.BeeName];
    local v36;

    if v35 then
        local MaxHealth = v35.Stats.MaxHealth;
        local Enchantment = p29.Server.Enchantment;

        if Enchantment then
            Enchantment = BeeEnchantmentRegistry.Entries[Enchantment];
        end;

        if Enchantment then
            Enchantment = Enchantment.Modifiers;
        end;

        if Enchantment then
            MaxHealth = MaxHealth * (Enchantment.MaxHealthMult or 1);
        end;

        v36 = MaxHealth + (LocalPlayer:GetAttribute("BeeHealthBonus") or 0);
    else
        v36 = 1;
    end;

    if p30 ~= "Health" then
        p31 = Server.Health;
    end;

    if v36 > p31 then
        local v37 = u4[p28];

        if not v37 then
            local v38 = InfoTemplate:Clone();
            v38.Visible = true;
            v38.BeeIcon.Image = v32.Icon;
            v38.Details.BeeName.Text = v32.DisplayName or Server.BeeName;
            v38.Parent = Frame;
            v37 = {
                frame = v38,
                entry = p29
            };
            u4[p28] = v37;
        end;

        RefreshInfo(v37);
        local v39;

        if next(u4) == nil then
            v39 = false;
        else
            v39 = u12;
        end;

        Container.Visible = v39;

        return;
    end;

    local v40 = u4[p28];

    if not v40 then
        return;
    end;

    v40.frame:Destroy();
    u4[p28] = nil;
    local v41;

    if next(u4) == nil then
        v41 = false;
    else
        v41 = u12;
    end;

    Container.Visible = v41;
end;

BeeColonyStateController.OnBeeStateUpdate:Connect(function(p42: string, p43: any, p44: string, p45: any) -- Line: 256
    -- upvalues: u1 (copy), UpdateInfo (copy)
    if p43.Server.Player ~= u1 then
        return;
    end;

    if p44 == "LastHealTime" then
        return;
    end;

    UpdateInfo(p42, p43, p44, p45);
end);
BeeColonyStateController.OnBeeDestroyed:Connect(function(p46: string, p47: any) -- Line: 264
    -- upvalues: u4 (copy), Container (copy), u12 (ref)
    if u4[p46] then
        local v48 = u4[p46];

        if not v48 then
            return;
        end;

        v48.frame:Destroy();
        u4[p46] = nil;
        local v49;

        if next(u4) == nil then
            v49 = false;
        else
            v49 = u12;
        end;

        Container.Visible = v49;
    end;
end);
task.spawn(function() -- Line: 244, Name: SetUpHealAllButton
    -- upvalues: Container (copy), MarketController (copy), DevProductIds (copy)
    Container:FindFirstChild("HealAll"):FindFirstChild("TextButton").Activated:Connect(function() -- Line: 248
        -- upvalues: MarketController (ref), DevProductIds (ref)
        MarketController:PromptPurchase(DevProductIds.HealAllBees.PurchaseID, Enum.InfoType.Product);
    end);
end);
task.spawn(function() -- Line: 274
    -- upvalues: u4 (copy), u26 (copy)
    while true do
        repeat
            task.wait(0.5);
        until next(u4);

        u26();
    end;
end);
Container.Visible = false;
InfoTemplate.Visible = false;
RunService.Heartbeat:Connect(function() -- Line: 288
    -- upvalues: u12 (ref), IsNearHive (copy), Container (copy), u4 (copy)
    local v50 = u12;
    u12 = IsNearHive();

    if u12 ~= v50 then
        local v51;

        if next(u4) == nil then
            v51 = false;
        else
            v51 = u12;
        end;

        Container.Visible = v51;
    end;
end);

return {};