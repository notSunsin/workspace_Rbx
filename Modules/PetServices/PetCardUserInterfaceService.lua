-- Decompiled with Potassium's decompiler.

game:GetService("Selection");
local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("CollectionService");
local RunService = game:GetService("RunService");
game:GetService("UserInputService");
game:GetService("GuiService");
local workspace_CurrentCamera = workspace.CurrentCamera;
workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function() -- Line: 12
    -- upvalues: workspace_CurrentCamera (ref)
    workspace_CurrentCamera = workspace.CurrentCamera;
end);
local ActivePetsService = require(ReplicatedStorage.Modules.PetServices.ActivePetsService);
local WaitForDescendant = require(ReplicatedStorage.Modules.WaitForDescendant);
local PetRegistry = require(ReplicatedStorage.Data.PetRegistry);
local PetUtilities = require(ReplicatedStorage.Modules.PetServices.PetUtilities);
local PlayClickSound = require(ReplicatedStorage.Modules.PlayClickSound);
local Chalk = require(ReplicatedStorage.Modules.Chalk);
local PlayHoverSound = require(ReplicatedStorage.Modules.PlayHoverSound);
local PetMutationRegistry = require(ReplicatedStorage.Data.PetRegistry.PetMutationRegistry);
require(ReplicatedStorage.Data.PetRegistry.PassiveRegistry);
local PetList = PetRegistry.PetList;
local MAX_LEVEL = PetRegistry.PetConfig.XP_CONFIG.MAX_LEVEL;
local LocalPlayer = Players.LocalPlayer;
local PetCard = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("PetUI"):WaitForChild("PetCard");
local DropShadowHolder = PetCard:WaitForChild("DropShadowHolder");
local Main = PetCard:WaitForChild("Main");
local u1 = WaitForDescendant(PetCard, "PET_TEXT");
local u2 = WaitForDescendant(PetCard, "PET_NAME_CONFIG");
local u3 = WaitForDescendant(PetCard, "PET_LEVEL");
local u4 = WaitForDescendant(PetCard, "PET_WEIGHT");
local u5 = WaitForDescendant(PetCard, "XP_TEXT");
local u6 = WaitForDescendant(PetCard, "HUNGER_TEXT");
local u7 = WaitForDescendant(PetCard, "EXP_BAR");
local u8 = WaitForDescendant(PetCard, "HUNGER_BAR");
WaitForDescendant(PetCard, "PASSIVE_INSERTION_POINT");
local u9 = WaitForDescendant(PetCard, "PET_DESCRIPTION");
WaitForDescendant(PetCard, "PASSIVE_TEMPLATE");
local u10 = WaitForDescendant(PetCard, "PET_IMAGE");
local u11 = WaitForDescendant(PetCard, "EXIT_BUTTON");
local v12 = require(ReplicatedStorage.Modules.SetupBrightnessAnimationFrame)(u11);

local function BrightenColorHSV(p13, p14: number) -- Line: 63
    local v15, v16, v17 = p13:ToHSV();
    local math_clamp_ret = math.clamp(v17 + p14, 0, 1);

    return Color3.fromHSV(v15, v16, math_clamp_ret);
end;

local UDim2_fromScale_ret = UDim2.fromScale(0.875, 0.5);
local u18 = UDim2_fromScale_ret + UDim2.fromScale(2, 0);
local u19 = {
    Active = false,
    Target = nil
};
local u20 = {};
local u21 = {};

local function Color3ToHex(p22) -- Line: 86
    return string.format("%02X%02X%02X", p22.R * 255, p22.G * 255, p22.B * 255);
end;

local function StartRainbowTween(u23: userdata, u24: string, u25: string) -- Line: 90
    -- upvalues: u21 (copy), RunService (copy)
    if u21[u23] then
        u21[u23]:Disconnect();
    end;

    local u26 = 0;
    u21[u23] = RunService.RenderStepped:Connect(function(p27) -- Line: 96
        -- upvalues: u26 (ref), u25 (copy), u23 (copy), u24 (copy)
        u26 = (u26 + p27 * 0.2) % 1;
        local Color3_fromHSV_ret = Color3.fromHSV(u26, 1, 1);
        local string_format_ret = string.format("%02X%02X%02X", Color3_fromHSV_ret.R * 255, Color3_fromHSV_ret.G * 255, Color3_fromHSV_ret.B * 255);
        local string_format_ret2 = string.format("<font color=\"#%s\">[%s]</font>", string_format_ret, u25);
        u23.Text = string.format("%s %s", u24, string_format_ret2);
    end);
end;

local function StopRainbowTween(p28: userdata) -- Line: 105
    -- upvalues: u21 (copy)
    if u21[p28] then
        u21[p28]:Disconnect();
        u21[p28] = nil;
    end;
end;

function u19.SetTarget(p29: table, p30: userdata) -- Line: 112
    -- upvalues: u19 (copy), ActivePetsService (copy), PetList (copy), PetRegistry (copy), Chalk (copy), PetMutationRegistry (copy), u9 (copy), u1 (copy), u21 (copy), RunService (copy), u10 (copy), u20 (copy)
    u19.Target = p30;

    if not p30 then
        return;
    end;

    local PetDataFromPetObject = ActivePetsService:GetPetDataFromPetObject(p30);

    if not PetDataFromPetObject then
        return;
    end;

    local PetType = PetDataFromPetObject.PetType;
    local PetData = PetDataFromPetObject.PetData;
    local v31 = PetList[PetType];
    local u32 = v31.Rarity or "Common";
    local Color = PetRegistry.PetRarities[u32].Color;
    local v33, v34, v35 = Color:ToHSV();
    local math_clamp_ret = math.clamp(v35 + -0.4, 0, 1);
    local Color3_fromHSV_ret = Color3.fromHSV(v33, v34, math_clamp_ret);
    local v36 = Chalk.color(Color).stroke({
        Joins = "Round",
        Thickness = 2,
        Color = Color3_fromHSV_ret
    });
    local v37 = Chalk.color(Color3.fromRGB(255, 255, 255)).stroke({
        Joins = "Round",
        Thickness = 2,
        Color = Color3.fromRGB(35, 35, 35)
    });
    v36((`[{u32}]`));
    local v38 = PetMutationRegistry.EnumToPetMutation[PetData.MutationType];
    local u39;

    if v38 and v38 ~= "Normal" then
        u39 = `{v38} {PetType}` or PetType;
    else
        u39 = PetType;
    end;

    v37(u39);
    u9.Text = v31.Description;
    local v40 = u1;

    if u21[v40] then
        u21[v40]:Disconnect();
        u21[v40] = nil;
    end;

    if u32 == "Prismatic" then
        local u41 = u1;

        if u21[u41] then
            u21[u41]:Disconnect();
        end;

        local u42 = 0;
        u21[u41] = RunService.RenderStepped:Connect(function(p43) -- Line: 96
            -- upvalues: u42 (ref), u32 (copy), u41 (copy), u39 (copy)
            u42 = (u42 + p43 * 0.2) % 1;
            local Color3_fromHSV_ret2 = Color3.fromHSV(u42, 1, 1);
            local string_format_ret = string.format("%02X%02X%02X", Color3_fromHSV_ret2.R * 255, Color3_fromHSV_ret2.G * 255, Color3_fromHSV_ret2.B * 255);
            local string_format_ret2 = string.format("<font color=\"#%s\">[%s]</font>", string_format_ret, u32);
            u41.Text = string.format("%s %s", u39, string_format_ret2);
        end);
    else
        local v44 = Chalk.color(Color).stroke({
            Joins = "Round",
            Thickness = 2,
            Color = Color3_fromHSV_ret
        });
        local v45 = Chalk.color(Color3.fromRGB(255, 255, 255)).stroke({
            Joins = "Round",
            Thickness = 2,
            Color = Color3.fromRGB(35, 35, 35)
        });
        local v46 = v44((`[{u32}]`));
        u1.Text = `{v45(u39)} {v46}`;
    end;

    u10.Image = v31.Icon;
    local v47 = PetList[PetType];

    for _, v in u20 do
        v:Destroy();
    end;

    local _ = PetData.Level;

    for _, _ in v47.Passives do

    end;

    u19:Update();
end;

function u19.SetTargetFromUUID(p48: table, p49: string) -- Line: 241
    -- upvalues: LocalPlayer (copy), ActivePetsService (copy), PetList (copy), PetRegistry (copy), Chalk (copy), PetMutationRegistry (copy), u1 (copy), u21 (copy), RunService (copy), u10 (copy), u9 (copy), u20 (copy)
    p48.Target = nil;
    p48.TargetUUID = p49;
    p48.TargetPlayer = LocalPlayer.Name;
    local PetData = ActivePetsService:GetPetData(LocalPlayer.Name, p49);

    if not PetData then
        warn((`Pet data not found for UUID: {p49}`));

        return;
    end;

    local PetType = PetData.PetType;
    local v50 = PetList[PetType];

    if not v50 then
        return;
    end;

    local u51 = v50.Rarity or "Common";
    local Color = PetRegistry.PetRarities[u51].Color;
    local v52, v53, v54 = Color:ToHSV();
    local math_clamp_ret = math.clamp(v54 + -0.4, 0, 1);
    local Color3_fromHSV_ret = Color3.fromHSV(v52, v53, math_clamp_ret);
    local v55 = Chalk.color(Color).stroke({
        Joins = "Round",
        Thickness = 2,
        Color = Color3_fromHSV_ret
    });
    local v56 = Chalk.color(Color3.fromRGB(255, 255, 255)).stroke({
        Joins = "Round",
        Thickness = 2,
        Color = Color3.fromRGB(35, 35, 35)
    });
    v55((`[{u51}]`));
    local v57 = PetMutationRegistry.EnumToPetMutation[PetData.PetData.MutationType];

    if v57 and v57 ~= "Normal" then
        PetType = `{v57} {PetType}` or PetType;
    end;

    v56(PetType);
    local v58 = u1;

    if u21[v58] then
        u21[v58]:Disconnect();
        u21[v58] = nil;
    end;

    if u51 == "Prismatic" then
        local u59 = u1;

        if u21[u59] then
            u21[u59]:Disconnect();
        end;

        local u60 = 0;
        u21[u59] = RunService.RenderStepped:Connect(function(p61) -- Line: 96
            -- upvalues: u60 (ref), u51 (copy), u59 (copy), PetType (copy)
            u60 = (u60 + p61 * 0.2) % 1;
            local Color3_fromHSV_ret2 = Color3.fromHSV(u60, 1, 1);
            local string_format_ret = string.format("%02X%02X%02X", Color3_fromHSV_ret2.R * 255, Color3_fromHSV_ret2.G * 255, Color3_fromHSV_ret2.B * 255);
            local string_format_ret2 = string.format("<font color=\"#%s\">[%s]</font>", string_format_ret, u51);
            u59.Text = string.format("%s %s", PetType, string_format_ret2);
        end);
    else
        local v62 = Chalk.color(Color).stroke({
            Joins = "Round",
            Thickness = 2,
            Color = Color3_fromHSV_ret
        });
        u1.Text = `{Chalk.color(Color3.fromRGB(255, 255, 255)).stroke({
            Joins = "Round",
            Thickness = 2,
            Color = Color3.fromRGB(35, 35, 35)
        })(PetType)} {v62((`[{u51}]`))}`;
    end;

    u10.Image = v50.Icon;
    u9.Text = "";

    for _, v in u20 do
        v:Destroy();
    end;
end;

local DecimalNumberFormat = require(ReplicatedStorage.Data.DecimalNumberFormat);

function u19.Update(p63) -- Line: 301
    -- upvalues: ActivePetsService (copy), Players (copy), LocalPlayer (copy), PetList (copy), PetUtilities (copy), u4 (copy), DecimalNumberFormat (copy), u2 (copy), MAX_LEVEL (copy), TweenService (copy), u7 (copy), u8 (copy), u6 (copy), u3 (copy), u5 (copy), PetMutationRegistry (copy), u9 (copy)
    local v64 = nil;
    local v65 = nil;

    if p63.Target then
        v64 = ActivePetsService:GetPetDataFromPetObject(p63.Target);
        v65 = Players:FindFirstChild((p63.Target:GetAttribute("OWNER")));
        p63.TargetUUID = p63.Target:GetAttribute("UUID");
        p63.TargetPlayer = v65;
    elseif p63.TargetUUID then
        v64 = ActivePetsService:GetPetData(LocalPlayer.Name, p63.TargetUUID);
        p63.TargetPlayer = LocalPlayer;
    end;

    if not v64 then
        return;
    end;

    local PetData = v64.PetData;
    local v66 = PetList[v64.PetType];

    if not v66 then
        return;
    end;

    local DefaultHunger = v66.DefaultHunger;
    local v67 = PetUtilities:CalculateWeight(PetData.BaseWeight, PetData.Level, v64.PetType);
    u4.Text = `Weight: {DecimalNumberFormat(v67)} KG`;
    local Name = PetData.Name;
    u2.Text = (Name == "" or not Name) and "Unnamed" or Name;
    local Level = PetData.Level;
    local CurrentLevelXPCost = PetUtilities:GetCurrentLevelXPCost(Level);
    local v68 = MAX_LEVEL <= Level;
    local v69 = PetData.LevelProgress or 0;
    TweenService:Create(u7.ACTUAL_BAR, TweenInfo.new(0.2), {
        Size = UDim2.fromScale(v68 and 1 or v69 / CurrentLevelXPCost, 1)
    }):Play();
    local v70 = PetData.Hunger / DefaultHunger;
    TweenService:Create(u8.ACTUAL_BAR, TweenInfo.new(0.2), {
        Size = UDim2.fromScale(v70, 1)
    }):Play();
    u6.Text = `{DecimalNumberFormat(PetData.Hunger)} / {DefaultHunger} HGR`;
    u7.ACTUAL_BAR.BAR_END.Visible = not v68;
    u3.Text = `Age: {Level}`;
    u5.Text = v68 and "MAXED" or `{DecimalNumberFormat(v69)} / {math.round(CurrentLevelXPCost)} EXP`;
    local TargetUUID = p63.TargetUUID;
    local v71 = "";

    for _, v in v66.Passives do
        local PassiveString = PetUtilities:GetPassiveString(v67, v, v65, TargetUUID);

        if PassiveString ~= "" then
            v71 = v71 .. `{PassiveString}\n`;
        end;
    end;

    for _, v in (PetMutationRegistry.PetMutationRegistry[PetMutationRegistry.EnumToPetMutation[v64.PetData.MutationType]] or {
        Passives = {}
    }).Passives do
        local PassiveString = PetUtilities:GetPassiveString(v67, v, v65, TargetUUID);

        if PassiveString ~= "" then
            v71 = v71 .. `{PassiveString}\n`;
        end;
    end;

    u9.Text = string.sub(v71, 1, #v71 - 1);
end;

function u19.UpdateFromStatic(p72) -- Line: 386
    -- upvalues: u19 (copy), PetList (copy), PetUtilities (copy), u4 (copy), DecimalNumberFormat (copy), u2 (copy), MAX_LEVEL (copy), TweenService (copy), u7 (copy), u8 (copy), u6 (copy), u3 (copy), u5 (copy), PetMutationRegistry (copy), u9 (copy)
    local LastStaticData = u19.LastStaticData;

    if not LastStaticData then
        return;
    end;

    local PetData = LastStaticData.PetData;
    local v73 = PetList[LastStaticData.PetType];

    if not v73 then
        return;
    end;

    local DefaultHunger = v73.DefaultHunger;
    local v74 = PetUtilities:CalculateWeight(PetData.BaseWeight, PetData.Level, Data.PetType);
    u4.Text = `Weight: {DecimalNumberFormat(v74)} KG`;
    u2.Text = PetData.Name == "" and "Unnamed" or (PetData.Name or "Unnamed");
    local Level = PetData.Level;
    local CurrentLevelXPCost = PetUtilities:GetCurrentLevelXPCost(Level);
    local v75 = MAX_LEVEL <= Level;
    local v76 = PetData.LevelProgress or 0;
    TweenService:Create(u7.ACTUAL_BAR, TweenInfo.new(0.2), {
        Size = UDim2.fromScale(v75 and 1 or v76 / CurrentLevelXPCost, 1)
    }):Play();
    TweenService:Create(u8.ACTUAL_BAR, TweenInfo.new(0.2), {
        Size = UDim2.fromScale(PetData.Hunger / DefaultHunger, 1)
    }):Play();
    u6.Text = `{DecimalNumberFormat(PetData.Hunger)} / {DefaultHunger} HGR`;
    u7.ACTUAL_BAR.BAR_END.Visible = not v75;
    u3.Text = `Age: {Level}`;
    u5.Text = v75 and "MAXED" or `{DecimalNumberFormat(v76)} / {math.round(CurrentLevelXPCost)} EXP`;
    local v77 = "";

    for _, v in v73.Passives do
        local PassiveString = PetUtilities:GetPassiveString(v74, v);

        if PassiveString ~= "" then
            v77 = v77 .. `{PassiveString}\n`;
        end;
    end;

    for _, v in (PetMutationRegistry.PetMutationRegistry[PetMutationRegistry.EnumToPetMutation[LastStaticData.PetData.MutationType]] or {
        Passives = {}
    }).Passives do
        local PassiveString = PetUtilities:GetPassiveString(v74, v);

        if PassiveString ~= "" then
            v77 = v77 .. `{PassiveString}\n`;
        end;
    end;

    u9.Text = string.sub(v77, 1, #v77 - 1);
end;

function u19.Toggle(p78, u79, p80) -- Line: 448
    -- upvalues: PetCard (copy), u19 (copy), TweenService (copy), DropShadowHolder (copy), UDim2_fromScale_ret (copy), u18 (copy), Main (copy), u11 (copy)
    if u79 then
        PetCard.Visible = true;
    end;

    u19.Active = u79;

    if u79 then
        u19.BreadcrumbFunction = p80;
    elseif u19.BreadcrumbFunction then
        task.spawn(u19.BreadcrumbFunction);
        u19.BreadcrumbFunction = nil;
    end;

    TweenService:Create(DropShadowHolder, TweenInfo.new(0.5), {
        Position = u79 and UDim2_fromScale_ret or u18
    }):Play();
    local v81 = TweenService:Create(Main, TweenInfo.new(0.5), {
        Position = u79 and UDim2_fromScale_ret or u18
    });
    v81:Play();
    v81.Completed:Connect(function() -- Line: 473
        -- upvalues: u79 (copy), PetCard (ref)
        if not u79 then
            PetCard.Visible = false;
        end;
    end);

    if u79 then
        game:GetService("GamepadService"):EnableGamepadCursor(u11);

        return;
    end;

    game:GetService("GamepadService"):DisableGamepadCursor();
end;

v12.MouseEnter:Connect(function() -- Line: 486
    -- upvalues: PlayHoverSound (copy)
    PlayHoverSound();
end);
v12.MouseButton1Click:Connect(function() -- Line: 490
    -- upvalues: PlayClickSound (copy), u19 (copy)
    PlayClickSound();
    u19:Toggle(false);
end);
task.spawn(function() -- Line: 495
    -- upvalues: u19 (copy)
    while true do
        task.wait(1);
        u19:Update();
    end;
end);

return u19;