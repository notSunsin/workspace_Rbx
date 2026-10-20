-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("UserInputService");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local SeedPackOddsController = require(ReplicatedStorage.Modules.SeedPackOddsController);
local PetEggOddsController = require(ReplicatedStorage.Modules.PetEggOddsController);
local CosmeticCrateOddsController = require(ReplicatedStorage.Modules.CosmeticCrateOddsController);
local CosmeticPool = require(ReplicatedStorage.Modules.CosmeticServices.CosmeticPool);
local InventoryServiceEnums = require(ReplicatedStorage.Data.EnumRegistry.InventoryServiceEnums);
local ItemDescriptionFinder = require(ReplicatedStorage.Modules.ItemDescriptionFinder);
local GameConfigController = require(ReplicatedStorage.Modules.GameConfigController);
local Config = GameConfigController:GetConfig("SummerFireConfig");
local ItemInfoHover = require(ReplicatedStorage.Modules.UIComponents.ItemInfoHover);
local CalculatePlantValue = require(ReplicatedStorage.Modules.CalculatePlantValue);
local ItemRarityFinder = require(ReplicatedStorage.Modules.ItemRarityFinder);
local MarketController = require(ReplicatedStorage.Modules.MarketController);
local MutationHandler = require(ReplicatedStorage.Modules.MutationHandler);
local ItemImageFinder = require(ReplicatedStorage.Modules.ItemImageFinder);
local GuiController = require(ReplicatedStorage.Modules.GuiController);
require(ReplicatedStorage.Modules.Notification);
local DataService = require(ReplicatedStorage.Modules.DataService);
local Calculate_Weight = require(ReplicatedStorage.Calculate_Weight);
local VariantColors = require(ReplicatedStorage.Data.VariantColors);
local ConfirmationPromptController = require(ReplicatedStorage.Modules.ConfirmationPromptController);
local SetupButton = require(ReplicatedStorage.Modules.SetupButton);
local NumberUtil = require(ReplicatedStorage.Modules.NumberUtil);
local Shime = require(ReplicatedStorage.Modules.Shime);
local Config2 = GameConfigController:GetConfig("SummerCraftingConfig");
local TimeHelper = require(ReplicatedStorage.Modules.TimeHelper);
local PlaySound = require(ReplicatedStorage.Modules.PlaySound);
local Spring = require(ReplicatedStorage.Modules.Spring);
local Chalk = require(ReplicatedStorage.Modules.Chalk);
local UpdateService = require(ReplicatedStorage.Modules.UpdateService);
local Trove = require(ReplicatedStorage.Modules.Trove);
local EventRotationController = require(ReplicatedStorage.Modules.EventRotation.EventRotationController);
local u1 = Trove.new();
local u2 = {
    Open = "rbxassetid://135863675900042",
    Close = "rbxassetid://80268833036765",
    Hover = "rbxassetid://72189990667457",
    Click = "rbxassetid://138819210811808",
    StartCraft = "rbxassetid://132025912670429",
    Claim = "rbxassetid://83163622219903"
};
local PlayerGui = Players.LocalPlayer.PlayerGui;
local SummerCrafting = PlayerGui.SummerCrafting;
local CampfireSprite = SummerCrafting.Crafting.Main.Campfire.Campfire.CampfireSprite;
local CraftableTemplate = script.Templates.CraftableTemplate;
local RecipeItemTemplate = CraftableTemplate.Inner.Requirements.RecipeItemTemplate;
local RequirementTemplate = script.Templates.RequirementTemplate;
local TierTemplate = script.Templates.TierTemplate;
local TierProgressTemplate = script.Templates.TierProgressTemplate;
local Scroller = SummerCrafting.Crafting.Main.Clipper.Scroller;
local u3 = { 0, 256, 512, 768 };
local u4 = 0;
local u5 = 1;
local u6 = 0;
local Color3_fromRGB_ret = Color3.fromRGB(0, 255, 21);
local Color3_fromRGB_ret2 = Color3.fromRGB(191, 107, 70);
local Crafting = SummerCrafting.Crafting.Main.Campfire.Crafting;
local u7 = { Crafting.Craft1, Crafting.Craft2, Crafting.Craft3 };
local u8 = { 0, 3, 4 };
local u9 = {};

local function toRoman(p10: number) -- Line: 91
    return p10 or (({ "I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX", "X" })[p10] or tostring(p10));
end;

local function EnsureDescription(p11: string?, p12: string) -- Line: 96
    if not p11 or #p11 <= 0 then
        p11 = `A summer-crafted {p12}.`;
    end;

    if #p11 < 60 then
        p11 = `{p11} A coveted treasure forged at the Summer Campfire, prized by gardeners all season long.`;
    end;

    return p11;
end;

local function SeedAwareName(p13: string, p14: string) -- Line: 105
    if p14 == "Seed" and not string.match(p13, "%sSeed$") then
        return `{p13} Seed`;
    end;

    return p13;
end;

local function BuildResultHoverData(p15: string, p16: string, p17: string) -- Line: 115
    -- upvalues: ItemDescriptionFinder (copy), ItemRarityFinder (copy)
    local v18;

    if p15 == "Campfire Egg" then
        v18 = "Forged in the heart of the campfire - the ONLY egg that can hatch the ULTRA-rare Fire Wisp.";
    else
        v18 = ItemDescriptionFinder(p15, p16);
        local v19;

        if p16 == "Seed" and not string.match(p15, "%sSeed$") then
            v19 = `{p15} Seed`;
        else
            v19 = p15;
        end;

        if not v18 or #v18 <= 0 then
            v18 = `A summer-crafted {v19}.`;
        end;

        if #v18 < 60 then
            v18 = `{v18} A coveted treasure forged at the Summer Campfire, prized by gardeners all season long.`;
        end;
    end;

    local v20 = {
        DescriptionOnly = true
    };
    local v21;

    if p16 == "Seed" and not string.match(p15, "%sSeed$") then
        v21 = `{p15} Seed`;
    else
        v21 = p15;
    end;

    v20.DisplayName = v21;
    v20.Description = v18;
    v20.ItemImage = p17;
    v20.Properties = {
        Rarity = ItemRarityFinder(p15, p16)
    };

    return v20;
end;

local function SetupCampfireEggText(p22: userdata) -- Line: 134
    -- upvalues: TweenService (copy)
    local UIGradient = Instance.new("UIGradient");
    UIGradient.Name = "CampfireEggWave";
    UIGradient.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 240, 130)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 140, 40)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 70, 30)) });
    UIGradient.Offset = Vector2.new(-0.35, 0);
    UIGradient.Parent = p22;
    TweenService:Create(UIGradient, TweenInfo.new(1.6, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
        Offset = Vector2.new(0.35, 0)
    }):Play();
end;

local function SetupCampfireEggFrame(p23: userdata) -- Line: 149
    -- upvalues: SetupCampfireEggText (copy), u1 (copy), RunService (copy)
    SetupCampfireEggText(p23.Inner.ItemName);
    local Sunrays = p23.Inner.Craft.Sunrays;
    Sunrays.Visible = true;
    u1:Add(RunService.RenderStepped:Connect(function(p24) -- Line: 155
        -- upvalues: Sunrays (copy)
        local v25 = Sunrays;
        v25.Rotation = v25.Rotation + 20 * p24;
    end));
    local SpecialImage = p23.Inner.SpecialImage;
    SpecialImage.Visible = true;
    local SpecialImageShadow = p23.Inner.SpecialImageShadow;
    SpecialImageShadow.Visible = true;
    local u26 = 0;
    u1:Add(RunService.RenderStepped:Connect(function(p27) -- Line: 169
        -- upvalues: u26 (ref), SpecialImage (copy), SpecialImageShadow (copy)
        u26 = u26 + p27;
        local v28 = math.sin(u26 * 2.2) * 7;
        SpecialImage.Rotation = v28;
        SpecialImageShadow.Rotation = v28;
    end));
    p23.Inner.InletTexture.Size = UDim2.fromScale(1, 0.8);
    p23.Inner.ClipsDescendants = false;
end;

local function AddEggGlow(p29: userdata) -- Line: 182
    -- upvalues: TweenService (copy)
    local UIStroke = Instance.new("UIStroke");
    UIStroke.Name = "EggGlow";
    UIStroke.Color = Color3.fromRGB(255, 190, 70);
    UIStroke.Thickness = 2.5;
    UIStroke.Transparency = 0.2;
    UIStroke.Parent = p29;
    TweenService:Create(UIStroke, TweenInfo.new(0.9, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
        Transparency = 0.75
    }):Play();
end;

local function FitSlots(p30: table, p31: userdata?) -- Line: 196
    local v32 = #p30;

    if v32 == 0 then
        return;
    end;

    local Scale = p30[1].Size.X.Scale;

    if Scale <= 0 then
        return;
    end;

    local v33 = not p31 and 0 or p31.Padding.Scale;

    if v32 * Scale + (v32 - 1) * v33 <= 1 then
        return;
    end;

    local math_clamp_ret = math.clamp((1 - (v32 - 1) * v33) / (v32 * Scale), 0, 1);

    for _, v in p30 do
        local Size = v.Size;
        v.Size = UDim2.new(Size.X.Scale * math_clamp_ret, Size.X.Offset * math_clamp_ret, Size.Y.Scale * math_clamp_ret, Size.Y.Offset * math_clamp_ret);
    end;
end;

local function GetCampfireSpriteRowY(p34: number, p35: boolean) -- Line: 217
    if p35 then
        return 768, true;
    end;

    if p34 <= 0 then
        return 0, false;
    end;

    if p34 <= 5 then
        return 256, true;
    end;

    return 512, true;
end;

local function SetCampfireSpriteState(p36: number, p37: boolean) -- Line: 233
    -- upvalues: u4 (ref), u5 (ref), u6 (ref), CampfireSprite (copy)
    local v38, v39;

    if p37 then
        v38 = true;
        v39 = 768;
    elseif p36 <= 0 then
        v38 = false;
        v39 = 0;
    elseif p36 <= 5 then
        v38 = true;
        v39 = 256;
    else
        v38 = true;
        v39 = 512;
    end;

    if v38 then
        if u4 ~= v39 then
            u4 = v39;
            u5 = 1;
            u6 = 0;
            CampfireSprite.ImageRectOffset = Vector2.new(0, v39);
        end;

        return;
    end;

    u4 = 0;
    u5 = 1;
    u6 = 0;
    CampfireSprite.ImageRectOffset = Vector2.new(0, 0);
end;

local function SetVisibility(p40: userdata, p41: string, p42: boolean) -- Line: 252
    local v43 = p40:FindFirstChild(p41);

    if v43 and v43:IsA("GuiObject") then
        v43.Visible = p42;
    end;
end;

local function GetEffectiveCampfireTier() -- Line: 259
    -- upvalues: Config (ref)
    local v44 = tonumber(workspace:GetAttribute(Config.WORKSPACE_ATTRIBUTE)) or 0;

    if workspace:GetAttribute(Config.WORKSPACE_SUPER_ATTRIBUTE) == true then
        return Config.MAX_TIERS;
    end;

    return v44;
end;

local function IsSlotUnlocked(p45: number) -- Line: 270
    -- upvalues: Config (ref), u8 (copy)
    local v46 = tonumber(workspace:GetAttribute(Config.WORKSPACE_ATTRIBUTE)) or 0;

    if workspace:GetAttribute(Config.WORKSPACE_SUPER_ATTRIBUTE) == true then
        v46 = Config.MAX_TIERS;
    end;

    return (u8[p45] or 1) <= v46;
end;

local function SetSlotEmpty(p47: userdata, p48: number) -- Line: 276
    -- upvalues: Config (ref), u8 (copy), Spring (copy)
    local Duration = p47:FindFirstChild("Duration");

    if Duration and Duration:IsA("GuiObject") then
        Duration.Visible = false;
    end;

    local Shadow = p47:FindFirstChild("Shadow");

    if Shadow and Shadow:IsA("GuiObject") then
        Shadow.Visible = false;
    end;

    local Icon = p47:FindFirstChild("Icon");

    if Icon and Icon:IsA("GuiObject") then
        Icon.Visible = false;
    end;

    local TimeLeft = p47:FindFirstChild("TimeLeft");

    if TimeLeft and TimeLeft:IsA("GuiObject") then
        TimeLeft.Visible = false;
    end;

    local Skip = p47:FindFirstChild("Skip");

    if Skip and Skip:IsA("GuiObject") then
        Skip.Visible = false;
    end;

    local v49 = tonumber(workspace:GetAttribute(Config.WORKSPACE_ATTRIBUTE)) or 0;

    if workspace:GetAttribute(Config.WORKSPACE_SUPER_ATTRIBUTE) == true then
        v49 = Config.MAX_TIERS;
    end;

    local v50 = (u8[p48] or 1) <= v49;
    local v51 = not v50;
    local TierName = p47:FindFirstChild("TierName");

    if TierName and TierName:IsA("GuiObject") then
        TierName.Visible = v51;
    end;

    local TierValue = p47:FindFirstChild("TierValue");

    if TierValue and TierValue:IsA("GuiObject") then
        TierValue.Visible = true;
    end;

    local TierValue2 = p47:FindFirstChild("TierValue");

    if TierValue2 and TierValue2:IsA("TextLabel") then
        if v50 then
            TierValue2.Text = "EMPTY";
            p47:RemoveTag("TextHoverTag");
        else
            local v52 = u8[p48] or 1;
            TierValue2.Text = v52 or (({ "I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX", "X" })[v52] or tostring(v52));
            p47:AddTag("TextHoverTag");
        end;

        p47:SetAttribute("HoverText", (`This Slot will be unlocked when your Campfire reaches Tier {u8[p48] or 1}`));
    end;

    local Duration2 = p47:FindFirstChild("Duration");

    if Duration2 then
        local Filler = Duration2:FindFirstChild("Filler");

        if Filler and Filler:IsA("GuiObject") then
            Spring.target(Filler, 1, 4, {
                Size = UDim2.fromScale(0, 1)
            });
        end;
    end;
end;

local function GetCurrentCraftSpeedMultiplier() -- Line: 311
    -- upvalues: Config (ref), Config2 (ref)
    local v53 = tonumber(workspace:GetAttribute(Config.WORKSPACE_ATTRIBUTE)) or 0;

    if workspace:GetAttribute(Config.WORKSPACE_SUPER_ATTRIBUTE) == true then
        v53 = Config.MAX_TIERS;
    end;

    return v53 <= 0 and 1 or math.max(1, v53 * Config2.BoostPerTier / 100);
end;

local function IsCraftSlotPaused(p54) -- Line: 326
    -- upvalues: Config (ref)
    if type(p54) ~= "table" then
        return false;
    end;

    local v55 = tonumber(workspace:GetAttribute(Config.WORKSPACE_ATTRIBUTE)) or 0;

    if workspace:GetAttribute(Config.WORKSPACE_SUPER_ATTRIBUTE) == true then
        v55 = Config.MAX_TIERS;
    end;

    local v56 = tonumber(p54.Tier) or 0;

    return p54.Paused == true and true or (v55 <= 0 and true or v56 > 0 and v55 < v56);
end;

local function GetRequirementHoverUUID(p57: string, p58: number, p59: any) -- Line: 349
    return `{p57}_REQ_{p58}_{p59.Type}_{p59.Value}_{tonumber(p59.Quantity) or 1}`;
end;

local function GetServerRemainingTime(p60) -- Line: 353
    local v61 = tonumber(p60.RemainingTime);

    if v61 ~= nil then
        return math.max(0, v61);
    end;

    local v62 = (tonumber(p60.EndTime) or 0) - workspace:GetServerTimeNow();

    return math.max(0, v62);
end;

local function GetCraftNow() -- Line: 364
    return workspace:GetServerTimeNow();
end;

local function GetCraftInstanceKey(p63) -- Line: 368
    local v64 = p63.CraftInstanceId or `{p63.CraftKey}:{p63.StartTime or ""}`;

    return tostring(v64);
end;

local function GetBaseDuration(p65) -- Line: 372
    local v66 = tonumber(p65.BaseDuration) or tonumber(p65.Duration) or (tonumber(p65.RemainingTime) or 1);

    return math.max(1, v66);
end;

function u9.Start() -- Line: 383
    -- upvalues: TweenService (copy), SummerCrafting (copy), Config (ref), Config2 (ref), ItemImageFinder (copy), TimeHelper (copy), Spring (copy), u7 (copy), SetSlotEmpty (copy), DataService (copy), SetupButton (copy), ReplicatedStorage (copy), PlaySound (copy), PlayerGui (copy), GuiController (copy), u1 (copy), u8 (copy), MarketController (copy), Calculate_Weight (copy), InventoryServiceEnums (copy), MutationHandler (copy), CalculatePlantValue (copy), CosmeticPool (copy), VariantColors (copy), ItemDescriptionFinder (copy), ItemRarityFinder (copy), ItemInfoHover (copy), NumberUtil (copy), u2 (copy), ConfirmationPromptController (copy), PetEggOddsController (copy), CosmeticCrateOddsController (copy), SeedPackOddsController (copy), Scroller (copy), Color3_fromRGB_ret (copy), Color3_fromRGB_ret2 (copy), Chalk (copy), RunService (copy), UpdateService (copy), TierTemplate (copy), TierProgressTemplate (copy), CraftableTemplate (copy), SetupCampfireEggFrame (copy), Shime (copy), AddEggGlow (copy), BuildResultHoverData (copy), RequirementTemplate (copy), FitSlots (copy), RecipeItemTemplate (copy), GameConfigController (copy), SetCampfireSpriteState (copy), u4 (ref), u6 (ref), u5 (ref), u3 (copy), CampfireSprite (copy)
    TweenService:Create(SummerCrafting.Crafting.Main.Crafting.Craft.Icon, TweenInfo.new(1.25, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
        Position = SummerCrafting.Crafting.Main.Crafting.Craft.Icon.Position + UDim2.fromOffset(0, -10)
    }):Play();
    local u67 = {};
    local u68 = {};
    local u69 = nil;
    local u70 = nil;
    local u71 = nil;
    local u72 = {};
    local u73 = {};

    local function ClearDisplayedCraft() -- Line: 400
        -- upvalues: u69 (ref), u70 (ref), u71 (ref), u72 (ref), u73 (ref), SummerCrafting (ref)
        u69 = nil;
        u70 = nil;
        u71 = nil;
        u72 = {};
        u73 = {};
        SummerCrafting.Crafting.Main.Crafting.Visible = false;
        SummerCrafting.Crafting.Main.Campfire.Visible = true;
    end;

    local function SyncLocalSlotState(p74: number, p75: any) -- Line: 411
        -- upvalues: u68 (copy)
        if type(p75) ~= "table" then
            u68[p74] = nil;

            return nil;
        end;

        local v76 = tonumber(p75.RemainingTime);
        local v77;

        if v76 == nil then
            local v78 = (tonumber(p75.EndTime) or 0) - workspace:GetServerTimeNow();
            v77 = math.max(0, v78);
        else
            v77 = math.max(0, v76);
        end;

        local v79 = tonumber(p75.LastUpdateTime) or workspace:GetServerTimeNow();
        local v80 = p75.CraftInstanceId or `{p75.CraftKey}:{p75.StartTime or ""}`;
        local v81 = tostring(v80);
        local CraftKey = p75.CraftKey;
        local v82 = u68[p74];

        if v82 and v82.CraftInstanceKey == v81 then
            v82.ServerRemainingTime = v77;
            v82.ServerLastUpdateTime = v79;

            return v82;
        end;

        local v83 = {
            LastDisplayedRemainingTime = nil,
            CraftInstanceKey = v81,
            CraftKey = CraftKey,
            ServerRemainingTime = v77,
            ServerLastUpdateTime = v79
        };
        u68[p74] = v83;

        return v83;
    end;

    local function GetDisplayedRemainingTime(p84: number, p85: any) -- Line: 445
        -- upvalues: SyncLocalSlotState (copy), Config (ref), Config2 (ref)
        local v86 = SyncLocalSlotState(p84, p85);

        if not v86 then
            return 0;
        end;

        local v87;

        if type(p85) == "table" then
            local v88 = tonumber(workspace:GetAttribute(Config.WORKSPACE_ATTRIBUTE)) or 0;

            if workspace:GetAttribute(Config.WORKSPACE_SUPER_ATTRIBUTE) == true then
                v88 = Config.MAX_TIERS;
            end;

            local v89 = tonumber(p85.Tier) or 0;
            v87 = p85.Paused == true and true or (v88 <= 0 and true or v89 > 0 and v88 < v89);
        else
            v87 = false;
        end;

        if v87 then
            v86.LastDisplayedRemainingTime = v86.ServerRemainingTime;

            return v86.ServerRemainingTime;
        end;

        local v90 = tonumber(workspace:GetAttribute(Config.WORKSPACE_ATTRIBUTE)) or 0;

        if workspace:GetAttribute(Config.WORKSPACE_SUPER_ATTRIBUTE) == true then
            v90 = Config.MAX_TIERS;
        end;

        local v91 = v90 <= 0 and 1 or math.max(1, v90 * Config2.BoostPerTier / 100);
        local v92 = workspace:GetServerTimeNow() - v86.ServerLastUpdateTime;
        local math_clamp_ret = math.clamp(v92, 0, 3);
        local math_max_ret = math.max(0, v86.ServerRemainingTime - math_clamp_ret * v91);

        if v86.LastDisplayedRemainingTime ~= nil and math_max_ret <= v86.LastDisplayedRemainingTime + v91 * 5 then
            math_max_ret = math.min(v86.LastDisplayedRemainingTime, math_max_ret);
        end;

        v86.LastDisplayedRemainingTime = math_max_ret;

        return math_max_ret;
    end;

    local function SetSlotCrafting(p93: number, p94: userdata, p95: any) -- Line: 487
        -- upvalues: GetDisplayedRemainingTime (copy), ItemImageFinder (ref), Config (ref), TimeHelper (ref), Spring (ref)
        local Duration = p94:FindFirstChild("Duration");

        if Duration and Duration:IsA("GuiObject") then
            Duration.Visible = true;
        end;

        local Shadow = p94:FindFirstChild("Shadow");

        if Shadow and Shadow:IsA("GuiObject") then
            Shadow.Visible = true;
        end;

        local Icon = p94:FindFirstChild("Icon");

        if Icon and Icon:IsA("GuiObject") then
            Icon.Visible = true;
        end;

        local TimeLeft = p94:FindFirstChild("TimeLeft");

        if TimeLeft and TimeLeft:IsA("GuiObject") then
            TimeLeft.Visible = true;
        end;

        local Skip = p94:FindFirstChild("Skip");

        if Skip and Skip:IsA("GuiObject") then
            Skip.Visible = true;
        end;

        local TierName = p94:FindFirstChild("TierName");

        if TierName and TierName:IsA("GuiObject") then
            TierName.Visible = false;
        end;

        local TierValue = p94:FindFirstChild("TierValue");

        if TierValue and TierValue:IsA("GuiObject") then
            TierValue.Visible = false;
        end;

        local Result = p95.Result;
        local v96 = GetDisplayedRemainingTime(p93, p95);
        local v97 = tonumber(p95.BaseDuration) or tonumber(p95.Duration) or (tonumber(p95.RemainingTime) or 1);
        local v98 = v96 / math.max(1, v97);
        local v99 = 1 - math.clamp(v98, 0, 1);
        local Icon2 = p94:FindFirstChild("Icon");

        if Icon2 and (Icon2:IsA("ImageLabel") and type(Result) == "table") then
            Icon2.Image = ItemImageFinder(Result.Value, Result.Type);
        end;

        local TimeLeft2 = p94:FindFirstChild("TimeLeft");

        if TimeLeft2 and TimeLeft2:IsA("TextLabel") then
            TimeLeft2.RichText = true;
            local v100;

            if type(p95) == "table" then
                local v101 = tonumber(workspace:GetAttribute(Config.WORKSPACE_ATTRIBUTE)) or 0;

                if workspace:GetAttribute(Config.WORKSPACE_SUPER_ATTRIBUTE) == true then
                    v101 = Config.MAX_TIERS;
                end;

                local v102 = tonumber(p95.Tier) or 0;
                v100 = (p95.Paused == true or v101 <= 0) and true or v102 > 0 and v101 < v102;
            else
                v100 = false;
            end;

            if v100 then
                local v103 = tonumber(p95.Tier) or 1;
                TimeLeft2.Text = `<font color="#FF2727"><b>PAUSED: TIER {v103 or (({ "I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX", "X" })[v103] or tostring(v103))}</b></font>`;
            else
                TimeLeft2.Text = TimeHelper:GenerateColonFormatFromTime((math.ceil(v96)));
            end;
        end;

        local Duration2 = p94:FindFirstChild("Duration");

        if Duration2 then
            local Filler = Duration2:FindFirstChild("Filler");

            if Filler and Filler:IsA("GuiObject") then
                Spring.target(Filler, 1, 4, {
                    Size = UDim2.fromScale(v99, 1)
                });
            end;
        end;
    end;

    local function SetSlotReady(p104: userdata, p105: any) -- Line: 531
        -- upvalues: ItemImageFinder (ref)
        local Duration = p104:FindFirstChild("Duration");

        if Duration and Duration:IsA("GuiObject") then
            Duration.Visible = false;
        end;

        local Shadow = p104:FindFirstChild("Shadow");

        if Shadow and Shadow:IsA("GuiObject") then
            Shadow.Visible = false;
        end;

        local Icon = p104:FindFirstChild("Icon");

        if Icon and Icon:IsA("GuiObject") then
            Icon.Visible = true;
        end;

        local TimeLeft = p104:FindFirstChild("TimeLeft");

        if TimeLeft and TimeLeft:IsA("GuiObject") then
            TimeLeft.Visible = true;
        end;

        local Skip = p104:FindFirstChild("Skip");

        if Skip and Skip:IsA("GuiObject") then
            Skip.Visible = false;
        end;

        local TierName = p104:FindFirstChild("TierName");

        if TierName and TierName:IsA("GuiObject") then
            TierName.Visible = false;
        end;

        local TierValue = p104:FindFirstChild("TierValue");

        if TierValue and TierValue:IsA("GuiObject") then
            TierValue.Visible = false;
        end;

        local Result = p105.Result;
        local Icon2 = p104:FindFirstChild("Icon");

        if Icon2 and (Icon2:IsA("ImageLabel") and type(Result) == "table") then
            Icon2.Image = ItemImageFinder(Result.Value, Result.Type);
        end;

        local TimeLeft2 = p104:FindFirstChild("TimeLeft");

        if TimeLeft2 and TimeLeft2:IsA("TextLabel") then
            TimeLeft2.RichText = true;
            TimeLeft2.Text = "CLAIM!";
        end;
    end;

    local function UpdateCraftingSlot(p106: number, p107: any) -- Line: 556
        -- upvalues: u7 (ref), u68 (copy), SetSlotEmpty (ref), GetDisplayedRemainingTime (copy), SetSlotReady (copy), SetSlotCrafting (copy)
        local v108 = u7[p106];

        if not v108 then
            return;
        end;

        if type(p107) ~= "table" then
            u68[p106] = nil;
            SetSlotEmpty(v108, p106);

            return;
        end;

        v108:RemoveTag("TextHoverTag");

        if GetDisplayedRemainingTime(p106, p107) <= 0 then
            SetSlotReady(v108, p107);

            return;
        end;

        SetSlotCrafting(p106, v108, p107);
    end;

    local function UpdateCraftingSlots() -- Line: 579
        -- upvalues: DataService (ref), UpdateCraftingSlot (copy), u70 (ref), ClearDisplayedCraft (copy)
        local SummerCraftingEventData = DataService:GetData().SummerCraftingEventData;

        if SummerCraftingEventData then
            SummerCraftingEventData = SummerCraftingEventData.Slots;
        end;

        for i = 1, 3 do
            local v109;

            if SummerCraftingEventData then
                v109 = SummerCraftingEventData[i];
            else
                v109 = SummerCraftingEventData;
            end;

            UpdateCraftingSlot(i, v109);
            local v110;

            if u70 and (type(v109) == "table" and v109.CraftKey == u70) then
                ClearDisplayedCraft();
                v110 = i;
            else
                v110 = i;
            end;
        end;
    end;

    local u111 = {};
    local u112 = nil;
    local u113 = false;

    for i, v in u7 do
        local SENSOR = v:FindFirstChild("SENSOR");

        if SENSOR and SENSOR:IsA("TextButton") then
            SetupButton({
                legacy = true,
                offset = 0.125,
                instance = SENSOR,
                scale = v.Icon.UIScale,

                onclick = function() -- Line: 602, Name: onclick
                    -- upvalues: v (copy), DataService (ref), i (copy), GetDisplayedRemainingTime (copy), ReplicatedStorage (ref), u111 (copy), PlaySound (ref), PlayerGui (ref), TweenService (ref)
                    local Icon = v:FindFirstChild("Icon");
                    local v114 = Icon and Icon:IsA("ImageLabel") and (Icon.Image or "") or "";
                    local v115, v116, u117, u118;

                    if Icon then
                        v115 = Icon.AbsolutePosition.X + Icon.AbsoluteSize.X / 2;
                        v116 = Icon.AbsolutePosition.Y + Icon.AbsoluteSize.Y / 2;
                        u117 = Icon.AbsoluteSize.X;
                        u118 = Icon.AbsoluteSize.Y;
                    else
                        u117 = 0;
                        u118 = 0;
                        v115 = 0;
                        v116 = 0;
                    end;

                    local Data = DataService:GetData();

                    if Data then
                        Data = Data.SummerCraftingEventData;
                    end;

                    local v119 = Data and Data.Slots and Data.Slots[i];
                    local v120;

                    if type(v119) == "table" then
                        v120 = GetDisplayedRemainingTime(i, v119) > 0;
                    else
                        v120 = false;
                    end;

                    if v120 then
                        ReplicatedStorage.GameEvents.SummerCraftingService.SkipCraft:FireServer(i);

                        return;
                    end;

                    local v121;

                    if type(v119) == "table" then
                        v121 = GetDisplayedRemainingTime(i, v119) <= 0;
                    else
                        v121 = false;
                    end;

                    if v121 then
                        if u111[i] then
                            return;
                        end;

                        u111[i] = true;
                        task.delay(1, function() -- Line: 635
                            -- upvalues: u111 (ref), i (ref)
                            u111[i] = nil;
                        end);
                    end;

                    ReplicatedStorage.GameEvents.SummerCraftingService.ClaimCraft:FireServer(i);

                    if v121 then
                        PlaySound("rbxassetid://83163622219903");
                    end;

                    if v121 and (Icon and v114 ~= "") then
                        local SummerCraftingFX = PlayerGui:FindFirstChild("SummerCraftingFX");

                        if not SummerCraftingFX then
                            SummerCraftingFX = Instance.new("ScreenGui");
                            SummerCraftingFX.Name = "SummerCraftingFX";
                            SummerCraftingFX.ResetOnSpawn = false;
                            SummerCraftingFX.IgnoreGuiInset = true;
                            SummerCraftingFX.DisplayOrder = 5000;
                            SummerCraftingFX.Parent = PlayerGui;
                        end;

                        local workspace_CurrentCamera = workspace.CurrentCamera;
                        local u122 = workspace_CurrentCamera and (workspace_CurrentCamera.ViewportSize.X or 1920) or 1920;
                        local u123 = workspace_CurrentCamera and workspace_CurrentCamera.ViewportSize.Y or 1080;
                        local ImageLabel = Instance.new("ImageLabel");
                        ImageLabel.BackgroundTransparency = 1;
                        ImageLabel.Image = v114;
                        ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5);
                        ImageLabel.Size = UDim2.fromOffset(u117, u118);
                        ImageLabel.Position = UDim2.fromOffset(v115, v116);
                        ImageLabel.ZIndex = 50;
                        ImageLabel.Parent = SummerCraftingFX;
                        local v124 = TweenService:Create(ImageLabel, TweenInfo.new(0.16, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                            Size = UDim2.fromOffset(u117 * 1.5, u118 * 1.5),
                            Position = UDim2.fromOffset(v115, v116 - 35)
                        });
                        v124:Play();
                        v124.Completed:Connect(function() -- Line: 676
                            -- upvalues: TweenService (ref), ImageLabel (copy), u122 (copy), u123 (copy), u117 (ref), u118 (ref)
                            local v125 = TweenService:Create(ImageLabel, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                                ImageTransparency = 1,
                                Rotation = 20,
                                Position = UDim2.fromOffset(u122 / 2, u123 - 30),
                                Size = UDim2.fromOffset(u117 * 0.55, u118 * 0.55)
                            });
                            v125:Play();
                            v125.Completed:Connect(function() -- Line: 685
                                -- upvalues: ImageLabel (ref)
                                ImageLabel:Destroy();
                            end);
                        end);
                    end;
                end
            });
        end;

        SetSlotEmpty(v, i);
    end;

    GuiController:UsePopupAnims(SummerCrafting);
    local StateForGui = GuiController:GetStateForGui(SummerCrafting);
    local u126 = true;
    StateForGui.Visible:Observe(function(p127: boolean) -- Line: 700
        -- upvalues: Spring (ref), SummerCrafting (ref), ClearDisplayedCraft (copy), u126 (ref), PlaySound (ref)
        if p127 then
            Spring.target(SummerCrafting.Crafting, 0.6, 4, {
                Position = UDim2.fromScale(0.5, 0.5)
            });
            ClearDisplayedCraft();

            if not u126 then
                PlaySound("rbxassetid://135863675900042");
            end;
        else
            Spring.stop(SummerCrafting.Crafting, "Position");
            SummerCrafting.Crafting.Position = UDim2.fromScale(0.5, 0.55);

            if not u126 then
                PlaySound("rbxassetid://80268833036765");
            end;
        end;

        u126 = false;
    end);
    u1:Add(SummerCrafting.Crafting.Header.Close.Activated:Connect(function() -- Line: 713
        -- upvalues: GuiController (ref), SummerCrafting (ref)
        GuiController:Close(SummerCrafting);
    end));

    local function hookButtonSounds(p128: userdata) -- Line: 719
        -- upvalues: u1 (ref), PlaySound (ref)
        if not p128:IsA("GuiButton") then
            return;
        end;

        if p128:GetAttribute("_CraftSoundHooked") then
            return;
        end;

        p128:SetAttribute("_CraftSoundHooked", true);
        u1:Add(p128.MouseEnter:Connect(function() -- Line: 724
            -- upvalues: PlaySound (ref)
            PlaySound("rbxassetid://72189990667457");
        end));
        u1:Add(p128.Activated:Connect(function() -- Line: 729
            -- upvalues: PlaySound (ref)
            PlaySound("rbxassetid://138819210811808");
        end));
    end;

    for _, descendant in SummerCrafting:GetDescendants() do
        hookButtonSounds(descendant);
    end;

    u1:Add(SummerCrafting.DescendantAdded:Connect(hookButtonSounds));
    local u129 = 0;
    local u130 = 0;
    local Rotation = SummerCrafting.Crafting.Main.Crafting.ButtonHolder.CRAFT.SENSOR.Rotation;
    local TextColor3 = SummerCrafting.Crafting.Main.Crafting.Tier.TierName.TextColor3;
    local Color3_fromRGB_ret3 = Color3.fromRGB(255, 39, 39);

    local function GetCraftBlockReason() -- Line: 750
        -- upvalues: u69 (ref), Config (ref), DataService (ref), u8 (ref), u73 (ref)
        local v131 = tonumber(string.match(u69 or "", "^(%d+):")) or 0;

        if v131 > 0 then
            local v132 = tonumber(workspace:GetAttribute(Config.WORKSPACE_ATTRIBUTE)) or 0;

            if workspace:GetAttribute(Config.WORKSPACE_SUPER_ATTRIBUTE) == true then
                v132 = Config.MAX_TIERS;
            end;

            if v132 < v131 then
                return `TIER {v131} REQUIRED`;
            end;
        end;

        local Data = DataService:GetData();
        local v133 = Data.SummerCraftingEventData and Data.SummerCraftingEventData.Slots;
        local v134 = false;

        for i = 1, 3 do
            local v135 = tonumber(workspace:GetAttribute(Config.WORKSPACE_ATTRIBUTE)) or 0;

            if workspace:GetAttribute(Config.WORKSPACE_SUPER_ATTRIBUTE) == true then
                v135 = Config.MAX_TIERS;
            end;

            local v136;

            if (u8[i] or 1) <= v135 then
                local v137;

                if v133 then
                    v137 = v133[i];
                else
                    v137 = v133;
                end;

                if type(v137) ~= "table" then
                    v134 = true;
                    break;
                end;

                v136 = i;
            else
                v136 = i;
            end;
        end;

        if not v134 then
            return "ALL SLOTS BUSY";
        end;

        for _, v in u73 do
            if v.Selectable then
                local v138 = v.Choices and v.Choices[v.ChoiceIndex];

                if (v138 and v138.Owned or 0) < (v.RequiredAmount or 0) then
                    return "NOT ENOUGH ITEMS";
                end;
            end;
        end;

        return nil;
    end;

    local function ShakeCraftButton() -- Line: 782
        -- upvalues: SummerCrafting (ref), u129 (ref), TweenService (ref), Rotation (copy)
        local SENSOR = SummerCrafting.Crafting.Main.Crafting.ButtonHolder.CRAFT.SENSOR;
        u129 = u129 + 1;
        local v139 = u129;

        for _, v in { 7, -6, 5, -4, 3, -2, 1, 0 } do
            if u129 ~= v139 then
                return;
            end;

            TweenService:Create(SENSOR, TweenInfo.new(0.04, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                Rotation = Rotation + v
            }):Play();
            task.wait(0.04);
        end;

        if u129 == v139 then
            SENSOR.Rotation = Rotation;
        end;
    end;

    local function CancelTierFlash() -- Line: 800
        -- upvalues: u130 (ref), SummerCrafting (ref), TextColor3 (copy)
        u130 = u130 + 1;
        SummerCrafting.Crafting.Main.Crafting.Tier.TierName.TextColor3 = TextColor3;
    end;

    local function FlashTierText(p140: string) -- Line: 805
        -- upvalues: SummerCrafting (ref), u130 (ref), Color3_fromRGB_ret3 (copy), TextColor3 (copy), u69 (ref)
        local TierName = SummerCrafting.Crafting.Main.Crafting.Tier.TierName;
        u130 = u130 + 1;
        local u141 = u130;
        TierName.Text = p140;
        TierName.TextColor3 = Color3_fromRGB_ret3;
        task.delay(1.25, function() -- Line: 811
            -- upvalues: u130 (ref), u141 (copy), TierName (copy), TextColor3 (ref), u69 (ref)
            if u130 ~= u141 then
                return;
            end;

            TierName.TextColor3 = TextColor3;
            local v142 = tonumber(string.match(u69 or "", "^(%d+):"));

            if v142 then
                TierName.Text = `Campfire {v142 or (({ "I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX", "X" })[v142] or tostring(v142))}`;
            end;
        end);
    end;

    SetupButton({
        legacy = true,
        offset = 0.05,
        instance = SummerCrafting.Crafting.Main.Crafting.ButtonHolder.CRAFT.SENSOR,
        scale = SummerCrafting.Crafting.Main.Crafting.ButtonHolder.CRAFT.SENSOR.UIScale,

        onclick = function() -- Line: 828, Name: onclick
            -- upvalues: u69 (ref), GetCraftBlockReason (copy), ShakeCraftButton (copy), SummerCrafting (ref), u130 (ref), Color3_fromRGB_ret3 (copy), TextColor3 (copy), u112 (ref)
            if not u69 then
                return;
            end;

            local v143 = GetCraftBlockReason();

            if not v143 then
                u112();

                return;
            end;

            task.spawn(ShakeCraftButton);
            local TierName = SummerCrafting.Crafting.Main.Crafting.Tier.TierName;
            u130 = u130 + 1;
            local u144 = u130;
            TierName.Text = v143;
            TierName.TextColor3 = Color3_fromRGB_ret3;
            task.delay(1.25, function() -- Line: 811
                -- upvalues: u130 (ref), u144 (copy), TierName (copy), TextColor3 (ref), u69 (ref)
                if u130 ~= u144 then
                    return;
                end;

                TierName.TextColor3 = TextColor3;
                local v145 = tonumber(string.match(u69 or "", "^(%d+):"));

                if v145 then
                    TierName.Text = `Campfire {v145 or (({ "I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX", "X" })[v145] or tostring(v145))}`;
                end;
            end);
        end
    });
    SetupButton({
        legacy = true,
        offset = 0.05,
        instance = SummerCrafting.Crafting.Main.Crafting.ButtonHolder.BUY.SENSOR,
        scale = SummerCrafting.Crafting.Main.Crafting.ButtonHolder.BUY.SENSOR.UIScale,

        onclick = function() -- Line: 847, Name: onclick
            -- upvalues: u71 (ref), MarketController (ref)
            if not u71 then
                return warn("No ProductId for currently displayed craft.");
            end;

            MarketController:PromptPurchase(u71, Enum.InfoType.Product);
        end
    });
    local u146 = {
        Result = "table",
        Recipe = "table",
        Tier = "number"
    };
    local u147 = {};
    local u148 = 1;

    local function GetLayoutOrder() -- Line: 879
        -- upvalues: u148 (ref)
        local v149 = u148;
        u148 = u148 + 1;

        return v149;
    end;

    local u150 = {};

    for i in u147 do
        table.insert(u150, i);
    end;

    table.sort(u150);
    local Color3_fromRGB_ret4 = Color3.fromRGB(255, 39, 39);
    local Color3_fromRGB_ret5 = Color3.fromRGB(0, 255, 0);

    local function GetRequirementQuantity(p151) -- Line: 894
        local v152 = tonumber(p151.Quantity) or 1;

        return math.max(1, v152);
    end;

    local function GetItemVariant(p153) -- Line: 898
        return p153.Variant or (p153.VariantName or p153.SeedVariant or "Normal");
    end;

    local function GetItemNameFromData(p154) -- Line: 905
        return p154.ItemName or (p154.SeedName or p154.FruitName) or (p154.GearName or p154.Name or (p154.Type or p154.Seed));
    end;

    local function EntryNameMatchesClient(p155: any, p156: string) -- Line: 915
        return (p155.ItemName == p156 or (p155.SeedName == p156 or (p155.FruitName == p156 or (p155.GearName == p156 or (p155.Name == p156 or p155.Type == p156))))) and true or p155.Seed == p156;
    end;

    local function NormalizeType(p157: string?) -- Line: 925
        local v158 = tostring(p157 or "");

        return (v158 == "Pet Egg" or (v158 == "PetEgg" or v158 == "Egg")) and "Egg" or v158;
    end;

    local function FormatCompactNumber(p159: number) -- Line: 935
        local v160 = tonumber(p159) or 0;
        local math_abs_ret = math.abs(v160);

        for _, v in { {
                Value = 1000000000000,
                Suffix = "T"
            }, {
                Value = 1000000000,
                Suffix = "B"
            }, {
                Value = 1000000,
                Suffix = "M"
            }, {
                Value = 1000,
                Suffix = "K"
            } } do
            if v.Value <= math_abs_ret then
                local v161 = v160 / v.Value;
                local v162 = math.abs(v161) * 10;
                local v163 = math.floor(v162) / 10;

                if v161 < 0 then
                    v163 = v163 * -1;
                end;

                return `{tostring(v163):gsub("%.0$", "")}{v.Suffix}`;
            end;
        end;

        local math_floor_ret = math.floor(v160);

        return tostring(math_floor_ret);
    end;

    local function FormatRequirementQuantity(p164: any, p165: number) -- Line: 966
        -- upvalues: FormatCompactNumber (copy)
        local v166 = tostring(p164.Type or "");

        if ((v166 == "Pet Egg" or (v166 == "PetEgg" or v166 == "Egg")) and "Egg" or v166) == "Currency" then
            return FormatCompactNumber(p165);
        end;

        return `x{p165}`;
    end;

    local function GetEggNameFromItemDataClient(p167) -- Line: 977
        if type(p167) == "table" then
            return p167.EggName or p167.PetEggName or (p167.PetEggType or p167.BeeEggType) or (p167.ItemName or p167.Name or (p167.Type or p167.Seed));
        end;

        return nil;
    end;

    local function IsValidCampfireEggForRequirementClient(p168: string?, p169: string) -- Line: 992
        if p169 == "Campfire Egg" then
            return p168 == "Campfire Egg" and true or p168 == "Premium Campfire Egg";
        end;

        return false;
    end;

    local function GetCampfireEggChoiceLabel(p170: string?) -- Line: 1001
        return p170 == "Premium Campfire Egg" and "Premium" or (p170 == "Campfire Egg" and "Regular" or nil);
    end;

    local function EntryEggNameMatchesClient(p171: any, p172: string) -- Line: 1013
        local v173;

        if type(p171) == "table" then
            v173 = p171.EggName or p171.PetEggName or (p171.PetEggType or p171.BeeEggType) or (p171.ItemName or p171.Name or (p171.Type or p171.Seed));
        else
            v173 = nil;
        end;

        local v174;

        if p172 == "Campfire Egg" then
            v174 = v173 == "Campfire Egg" and true or v173 == "Premium Campfire Egg";
        else
            v174 = false;
        end;

        return v174 and true or ((p171.ItemName == p172 or (p171.SeedName == p172 or (p171.FruitName == p172 or (p171.GearName == p172 or (p171.Name == p172 or p171.Type == p172))))) and true or p171.Seed == p172 or ((p171.EggName == p172 or (p171.PetEggName == p172 or p171.PetEggType == p172)) and true or p171.BeeEggType == p172));
    end;

    local function GetSavedPetTypeClient(p175) -- Line: 1027
        if type(p175) ~= "table" then
            return nil;
        end;

        local PetData = p175.PetData;
        local v176 = p175.PetType or (p175.PetName or p175.Type or (p175.ItemName or p175.Name));

        if not v176 then
            if type(PetData) == "table" then
                v176 = PetData.PetType or PetData.PetName or (PetData.Type or PetData.ItemName);
            else
                v176 = false;
            end;
        end;

        return v176;
    end;

    local function EntryPetNameMatchesClient(p177: any, p178: string) -- Line: 1047
        local v179;

        if type(p177) == "table" then
            local PetData = p177.PetData;
            v179 = p177.PetType or (p177.PetName or p177.Type or (p177.ItemName or p177.Name));

            if not v179 then
                if type(PetData) == "table" then
                    v179 = PetData.PetType or PetData.PetName or (PetData.Type or PetData.ItemName);
                else
                    v179 = false;
                end;
            end;
        else
            v179 = nil;
        end;

        return v179 == p178;
    end;

    local function IsPetLockedOrFavoriteClient(p180) -- Line: 1051
        if type(p180) ~= "table" then
            return false;
        end;

        local PetData = p180.PetData;
        local v181;

        if p180.IsFavorite == true or (p180.Favorite == true or (p180.Locked == true or p180.IsLocked == true)) then
            v181 = true;
        elseif type(PetData) == "table" then
            v181 = (PetData.IsFavorite == true or (PetData.Favorite == true or PetData.Locked == true)) and true or PetData.IsLocked == true;
        else
            v181 = false;
        end;

        return v181;
    end;

    local function GetPetInventoryDataClient() -- Line: 1070
        -- upvalues: DataService (ref)
        local PetsData = DataService:GetData().PetsData;

        if type(PetsData) ~= "table" then
            return nil;
        end;

        local PetInventory = PetsData.PetInventory;

        if type(PetInventory) ~= "table" then
            return nil;
        end;

        if type(PetInventory.Data) == "table" then
            return PetInventory;
        end;

        return nil;
    end;

    local function GetCosmeticInventoryDataClient() -- Line: 1091
        -- upvalues: DataService (ref)
        local CosmeticData = DataService:GetData().CosmeticData;

        if type(CosmeticData) ~= "table" then
            return nil;
        end;

        local Inventory = CosmeticData.Inventory;

        if type(Inventory) == "table" then
            return Inventory;
        end;

        return nil;
    end;

    local function EntryCosmeticNameMatchesClient(p182: any, p183: string) -- Line: 1108
        if type(p182) == "table" then
            return (p182.Name == p183 or p182.CosmeticName == p183) and true or p182.ItemName == p183;
        end;

        return false;
    end;

    local function IsSelectableRequirement(p184) -- Line: 1118
        local v185 = tostring(p184.Type or "");
        local v186 = (v185 == "Pet Egg" or (v185 == "PetEgg" or v185 == "Egg")) and "Egg" or v185;

        return (v186 == "Fruit" or (v186 == "Seed" or (v186 == "Pet" or (v186 == "Gear" or v186 == "Egg")))) and true or v186 == "Cosmetic";
    end;

    local function DoesClientEntryMatchRequirement(p187, p188) -- Line: 1129
        if type(p187) ~= "table" then
            return false;
        end;

        local ItemData = p187.ItemData;

        if type(ItemData) ~= "table" then
            return false;
        end;

        local v189 = tostring(p188.Type or "");
        local v190 = (v189 == "Pet Egg" or (v189 == "PetEgg" or v189 == "Egg")) and "Egg" or v189;
        local v191 = tostring(p188.Value or "");

        if v190 == "Fruit" then
            if p187.ItemType ~= "Holdable" and p187.ItemType ~= "Fruit" then
                return false;
            end;

            if ItemData.IsFavorite then
                return false;
            end;

            return (ItemData.ItemName == v191 or (ItemData.SeedName == v191 or (ItemData.FruitName == v191 or (ItemData.GearName == v191 or (ItemData.Name == v191 or ItemData.Type == v191))))) and true or ItemData.Seed == v191;
        end;

        if v190 == "Seed" then
            if p187.ItemType ~= "Seed" then
                return false;
            end;

            if (ItemData.ItemName == v191 or (ItemData.SeedName == v191 or (ItemData.FruitName == v191 or (ItemData.GearName == v191 or (ItemData.Name == v191 or ItemData.Type == v191))))) and true or ItemData.Seed == v191 then
                return not p188.Variant and true or (ItemData.Variant or ItemData.VariantName or (ItemData.SeedVariant or "Normal")) == p188.Variant;
            end;

            return false;
        end;

        if v190 == "Gear" then
            return (p187.ItemType == v191 or (ItemData.ItemName == v191 or (ItemData.SeedName == v191 or (ItemData.FruitName == v191 or (ItemData.GearName == v191 or (ItemData.Name == v191 or ItemData.Type == v191)))))) and true or ItemData.Seed == v191;
        end;

        if v190 ~= "Egg" then
            return false;
        end;

        if p187.ItemType ~= "PetEgg" and (p187.ItemType ~= "Pet Egg" and (p187.ItemType ~= "Egg" and (p187.ItemType ~= "BeeEgg" and p187.ItemType ~= "Bee Egg"))) then
            return false;
        end;

        local v192;

        if type(ItemData) == "table" then
            v192 = ItemData.EggName or ItemData.PetEggName or (ItemData.PetEggType or ItemData.BeeEggType) or (ItemData.ItemName or ItemData.Name or (ItemData.Type or ItemData.Seed));
        else
            v192 = nil;
        end;

        local v193;

        if v191 == "Campfire Egg" then
            v193 = v192 == "Campfire Egg" and true or v192 == "Premium Campfire Egg";
        else
            v193 = false;
        end;

        return v193 and true or ((ItemData.ItemName == v191 or (ItemData.SeedName == v191 or (ItemData.FruitName == v191 or (ItemData.GearName == v191 or (ItemData.Name == v191 or ItemData.Type == v191))))) and true or ItemData.Seed == v191 or ((ItemData.EggName == v191 or (ItemData.PetEggName == v191 or ItemData.PetEggType == v191)) and true or ItemData.BeeEggType == v191));
    end;

    local function EscapeRichText(p194: string) -- Line: 1190
        return tostring(p194):gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;"):gsub("\"", "&quot;"):gsub("\'", "&apos;");
    end;

    local function GetClientInventoryRequirementAmount(p195, p196) -- Line: 1200
        -- upvalues: DoesClientEntryMatchRequirement (copy)
        if type(p195) ~= "table" then
            return 0;
        end;

        if not DoesClientEntryMatchRequirement(p195, p196) then
            return 0;
        end;

        local v197 = tostring(p196.Type or "");
        local v198 = (v197 == "Pet Egg" or (v197 == "PetEgg" or v197 == "Egg")) and "Egg" or v197;
        local ItemData = p195.ItemData;

        if v198 == "Gear" then
            local v199;

            if ItemData then
                v199 = ItemData.Uses;
            else
                v199 = ItemData;
            end;

            local v200 = tonumber(v199);

            if v200 then
                local math_floor_ret = math.floor(v200);

                return math.max(0, math_floor_ret);
            end;

            if ItemData then
                ItemData = ItemData.Quantity;
            end;

            local v201 = tonumber(ItemData);

            if not v201 then
                return 1;
            end;

            local math_floor_ret = math.floor(v201);

            return math.max(0, math_floor_ret);
        end;

        if v198 ~= "Seed" and v198 ~= "Egg" then
            return 1;
        end;

        local v202;

        if ItemData then
            v202 = ItemData.Quantity;
        else
            v202 = ItemData;
        end;

        local v203 = tonumber(v202);

        if v203 then
            local math_floor_ret = math.floor(v203);

            return math.max(0, math_floor_ret);
        end;

        if ItemData then
            ItemData = ItemData.Uses;
        end;

        local v204 = tonumber(ItemData);

        if not v204 then
            return 1;
        end;

        local math_floor_ret = math.floor(v204);

        return math.max(0, math_floor_ret);
    end;

    local function FormatKg(p205: number) -- Line: 1245
        return string.format("%.2fkg", tonumber(p205) or 0);
    end;

    local function GetPlantEntryWeight(p206) -- Line: 1249
        -- upvalues: Calculate_Weight (ref)
        local v207 = tonumber(p206.Weight);

        if v207 then
            return v207;
        end;

        local v208;

        if p206.Seed and p206.ItemName then
            local v209 = Calculate_Weight.Calculate_Weight(p206.Seed, p206.ItemName);
            v208 = tonumber(v209) or 1;
        else
            v208 = 1;
        end;

        return v208 * (tonumber(p206.WeightMultiplier) or 1);
    end;

    local function GetPlantEntryValue(p210) -- Line: 1266
        -- upvalues: InventoryServiceEnums (ref), Calculate_Weight (ref), MutationHandler (ref), CalculatePlantValue (ref)
        local v211 = p210.ItemName or (p210.SeedName or p210.FruitName) or (p210.GearName or p210.Name or (p210.Type or p210.Seed));

        if not v211 then
            return 0;
        end;

        local v212 = p210.Variant or p210.VariantName or (p210.SeedVariant or "Normal");
        local v213 = p210.FruitVersion or (p210[InventoryServiceEnums.FruitVersion] or 0);
        local v214 = tonumber(p210.Weight);

        if not v214 then
            local v215;

            if p210.Seed and p210.ItemName then
                local v216 = Calculate_Weight.Calculate_Weight(p210.Seed, p210.ItemName);
                v215 = tonumber(v216) or 1;
            else
                v215 = 1;
            end;

            v214 = v215 * (tonumber(p210.WeightMultiplier) or 1);
        end;

        return CalculatePlantValue({
            name = v211,
            variant = v212,
            weight = v214,
            mutationMultiplier = not (MutationHandler.ExtractMutationsFromString and MutationHandler.CalcValueMultiFromMuts) and 1 or MutationHandler:CalcValueMultiFromMuts(MutationHandler:ExtractMutationsFromString(p210.MutationString or "")),
            fruitVersion = v213
        });
    end;

    local function BuildRequirementChoices(p217) -- Line: 1294
        -- upvalues: DataService (ref), DoesClientEntryMatchRequirement (copy), Calculate_Weight (ref), GetPlantEntryValue (copy), IsPetLockedOrFavoriteClient (copy), CosmeticPool (ref), GetClientInventoryRequirementAmount (copy)
        local v218 = DataService:GetData().InventoryData or {};
        local v219 = tonumber(p217.Quantity) or 1;
        local math_max_ret = math.max(1, v219);
        local v220 = tostring(p217.Type or "");
        local v221 = (v220 == "Pet Egg" or (v220 == "PetEgg" or v220 == "Egg")) and "Egg" or v220;

        if v221 == "Fruit" then
            local v222 = {};

            for i, v in v218 do
                if DoesClientEntryMatchRequirement(v, p217) then
                    local ItemData = v.ItemData;
                    local v223 = ItemData.Variant or ItemData.VariantName or (ItemData.SeedVariant or "Normal");
                    local v224 = tonumber(ItemData.Weight);

                    if not v224 then
                        local v225;

                        if ItemData.Seed and ItemData.ItemName then
                            local v226 = Calculate_Weight.Calculate_Weight(ItemData.Seed, ItemData.ItemName);
                            v225 = tonumber(v226) or 1;
                        else
                            v225 = 1;
                        end;

                        v224 = v225 * (tonumber(ItemData.WeightMultiplier) or 1);
                    end;

                    local v227 = {
                        UUID = i,
                        Variant = v223,
                        Weight = v224,
                        Value = GetPlantEntryValue(ItemData)
                    };
                    table.insert(v222, v227);
                end;
            end;

            table.sort(v222, function(p228, p229) -- Line: 1322
                if p228.Value == p229.Value then
                    return p228.Weight < p229.Weight;
                end;

                return p228.Value < p229.Value;
            end);
            local v230 = #v222;
            local v231 = {};

            for _, v in v222 do
                local v232 = { v.UUID };
                local v233 = {
                    [v.UUID] = true
                };
                local v234 = v;

                for _, v2 in v222 do
                    if math_max_ret <= #v232 then
                        break;
                    end;

                    if not v233[v2.UUID] then
                        v233[v2.UUID] = true;
                        table.insert(v232, v2.UUID);
                    end;
                end;

                table.insert(v231, {
                    IsPlantChoice = true,
                    Variant = v234.Variant,
                    Weight = v234.Weight,
                    Owned = v230,
                    UUIDs = v232,
                    LowestValue = v234.Value
                });
            end;

            return v231;
        end;

        if v221 == "Pet" then
            local PetsData = DataService:GetData().PetsData;
            local v235;

            if type(PetsData) == "table" then
                v235 = PetsData.PetInventory;

                if type(v235) == "table" then
                    if type(v235.Data) ~= "table" then
                        v235 = nil;
                    end;
                else
                    v235 = nil;
                end;
            else
                v235 = nil;
            end;

            local v236 = {};

            if v235 then
                for i, v in v235.Data do
                    if not IsPetLockedOrFavoriteClient(v) then
                        local v237 = tostring(p217.Value or "");
                        local v238;

                        if type(v) == "table" then
                            local PetData = v.PetData;
                            v238 = v.PetType or (v.PetName or v.Type or (v.ItemName or v.Name));

                            if not v238 then
                                if type(PetData) == "table" then
                                    v238 = PetData.PetType or PetData.PetName or (PetData.Type or PetData.ItemName);
                                else
                                    v238 = false;
                                end;
                            end;
                        else
                            v238 = nil;
                        end;

                        if v238 == v237 then
                            local PetData = v.PetData;
                            local v239 = tonumber(v.Level) or tonumber(v.PetLevel) or (type(PetData) == "table" and (tonumber(PetData.Level) or 1) or 1);
                            local v240 = tonumber(v.BaseWeight) or (tonumber(v.Weight) or type(PetData) == "table" and tonumber(PetData.BaseWeight) or (type(PetData) == "table" and tonumber(PetData.Weight) or 0));
                            local v241 = {
                                UUID = i,
                                Token = `Pet:{i}`,
                                Level = v239,
                                Weight = v240
                            };
                            table.insert(v236, v241);
                        end;
                    end;
                end;
            end;

            table.sort(v236, function(p242, p243) -- Line: 1400
                if p242.Level == p243.Level then
                    return p242.Weight < p243.Weight;
                end;

                return p242.Level < p243.Level;
            end);
            local v244 = #v236;
            local v245 = {};

            for _, v in v236 do
                local v246 = { v.Token };
                local v247 = {
                    [v.Token] = true
                };

                for _, v2 in v236 do
                    if math_max_ret <= #v246 then
                        break;
                    end;

                    if not v247[v2.Token] then
                        v247[v2.Token] = true;
                        table.insert(v246, v2.Token);
                    end;
                end;

                local v248 = {
                    IsPetChoice = true,
                    Owned = v244,
                    UUIDs = v246,
                    LabelRichText = `Lvl {v.Level}`
                };
                table.insert(v245, v248);
            end;

            return v245;
        end;

        if v221 ~= "Cosmetic" then
            if v221 == "Egg" and tostring(p217.Value or "") == "Campfire Egg" then
                local u249 = {
                    Regular = {},
                    Premium = {}
                };
                local u250 = {
                    Regular = 0,
                    Premium = 0
                };

                for i, v in v218 do
                    if DoesClientEntryMatchRequirement(v, p217) then
                        local ItemData = v.ItemData;
                        local v251;

                        if type(ItemData) == "table" then
                            v251 = ItemData.EggName or ItemData.PetEggName or (ItemData.PetEggType or ItemData.BeeEggType) or (ItemData.ItemName or ItemData.Name or (ItemData.Type or ItemData.Seed));
                        else
                            v251 = nil;
                        end;

                        local v252 = v251 == "Premium Campfire Egg" and "Premium" or (v251 == "Campfire Egg" and "Regular" or nil);

                        if v252 then
                            local v253 = GetClientInventoryRequirementAmount(v, p217);

                            if v253 > 0 then
                                u250[v252] = u250[v252] + v253;
                                table.insert(u249[v252], {
                                    UUID = i,
                                    Amount = v253
                                });
                            end;
                        end;
                    end;
                end;

                local u254 = u250.Regular > 0;
                local u255 = u250.Premium > 0;

                if not (u254 or u255) then
                    return {};
                end;

                local u256 = {};

                local function AddCampfireEggChoice(p257: string) -- Line: 1538
                    -- upvalues: u250 (copy), math_max_ret (copy), u249 (copy), u254 (copy), u255 (copy), u256 (copy)
                    local v258 = u250[p257];

                    if v258 <= 0 then
                        return;
                    end;

                    local v259 = math_max_ret;
                    local v260 = {};

                    for _, v in u249[p257] do
                        if v259 <= 0 then
                            break;
                        end;

                        table.insert(v260, v.UUID);
                        v259 = v259 - v.Amount;
                    end;

                    local v261;

                    if p257 == "Premium" then
                        v261 = true;
                    else
                        v261 = u254 and u255;
                    end;

                    local v262 = {
                        IsCampfireEggChoice = true,
                        Owned = v258,
                        UUIDs = v260,
                        IsSimpleChoice = not v261
                    };

                    if not v261 then
                        p257 = nil;
                    end;

                    v262.LabelRichText = p257;
                    table.insert(u256, v262);
                end;

                AddCampfireEggChoice("Regular");
                AddCampfireEggChoice("Premium");

                return u256;
            end;

            if v221 == "Gear" or v221 == "Egg" then
                local v263 = 0;
                local v264 = {};

                for i, v in v218 do
                    if DoesClientEntryMatchRequirement(v, p217) then
                        local v265 = GetClientInventoryRequirementAmount(v, p217);

                        if v265 > 0 then
                            v263 = v263 + v265;
                            table.insert(v264, {
                                UUID = i,
                                Amount = v265
                            });
                        end;
                    end;
                end;

                local v266 = {};

                for _, v in v264 do
                    if math_max_ret <= 0 then
                        break;
                    end;

                    table.insert(v266, v.UUID);
                    math_max_ret = math_max_ret - v.Amount;
                end;

                return v263 <= 0 and {} or {
                    {
                        IsSimpleChoice = true,
                        Owned = v263,
                        UUIDs = v266
                    }
                };
            end;

            local v267 = {};

            for i, v in v218 do
                if DoesClientEntryMatchRequirement(v, p217) then
                    local ItemData = v.ItemData;
                    local v268 = ItemData.Variant or ItemData.VariantName or (ItemData.SeedVariant or "Normal");
                    local v269 = GetClientInventoryRequirementAmount(v, p217);

                    if v269 > 0 then
                        v267[v268] = v267[v268] or {
                            Owned = 0,
                            LowestValue = (1 / 0),
                            Variant = v268,
                            Items = {}
                        };
                        table.insert(v267[v268].Items, {
                            Value = 0,
                            UUID = i,
                            Amount = v269
                        });
                        local v270 = v267[v268];
                        v270.Owned = v270.Owned + v269;
                        v267[v268].LowestValue = 0;
                    end;
                end;
            end;

            local v271 = {};

            for _, v in v267 do
                local v272 = math_max_ret;
                local v273 = v;
                local v274 = {};

                for _, v2 in v.Items do
                    if math_max_ret <= 0 then
                        break;
                    end;

                    table.insert(v274, v2.UUID);
                    math_max_ret = math_max_ret - v2.Amount;
                end;

                table.insert(v271, {
                    IsPlantChoice = false,
                    Variant = v273.Variant,
                    Owned = v273.Owned,
                    UUIDs = v274,
                    LowestValue = v273.LowestValue
                });
                math_max_ret = v272;
            end;

            table.sort(v271, function(p275, p276) -- Line: 1679
                return tostring(p275.Variant) < tostring(p276.Variant);
            end);

            return v271;
        end;

        local CosmeticData = DataService:GetData().CosmeticData;
        local v277;

        if type(CosmeticData) == "table" then
            v277 = CosmeticData.Inventory;

            if type(v277) ~= "table" then
                v277 = nil;
            end;
        else
            v277 = nil;
        end;

        local v278 = {};
        local v279 = {};
        local v280 = tostring(p217.Value or "");
        local v281 = CosmeticPool.CollectKnownReferences(DataService:GetData()) or {};

        if v277 then
            for i, v in v277 do
                local v282;

                if type(v) == "table" then
                    v282 = (v.Name == v280 or v.CosmeticName == v280) and true or v.ItemName == v280;
                else
                    v282 = false;
                end;

                if v282 then
                    local v283;

                    if v281[i] then
                        v283 = v279;
                    else
                        v283 = v278;
                    end;

                    local v284 = {
                        UUID = i,
                        Token = `Cosmetic:{i}`
                    };
                    table.insert(v283, v284);
                end;
            end;
        end;

        table.move(v279, 1, #v279, #v278 + 1, v278);
        local v285 = #v278 + CosmeticPool.GetPooled(DataService:GetData(), v280);

        if v285 <= 0 then
            return {};
        end;

        local v286 = {};

        for _, v in v278 do
            if math_max_ret <= 0 then
                break;
            end;

            table.insert(v286, v.Token);
            math_max_ret = math_max_ret - 1;
        end;

        return {
            {
                IsSimpleChoice = true,
                Owned = v285,
                UUIDs = v286
            }
        };
    end;

    local function SetRequirementVariantLabel(p287: userdata, p288: any) -- Line: 1686
        -- upvalues: VariantColors (ref), EscapeRichText (copy)
        p287.RichText = true;

        if not p288 then
            p287.Text = "";
            p287.Size = UDim2.fromScale(1, 0.35);

            return;
        end;

        if p288.LabelRichText then
            p287.RichText = true;
            p287.Size = UDim2.fromScale(1, 0.35);
            p287.Text = p288.LabelRichText;

            return;
        end;

        if p288.IsSimpleChoice then
            p287.RichText = true;
            p287.Text = "";
            p287.Size = UDim2.fromScale(1, 0.35);

            return;
        end;

        local v289 = p288.Variant or "Normal";
        local v290 = v289 ~= "Normal";
        local v291;

        if v290 then
            v291 = UDim2.fromScale(1, 0.5);
        else
            v291 = UDim2.fromScale(1, 0.35);
        end;

        p287.Size = v291;

        if not p288.IsPlantChoice then
            if v290 then
                p287.Text = `<font color="{VariantColors:GetHex(v289) or "#FFFFFF"}">{EscapeRichText(v289)}</font>`;

                return;
            end;

            p287.Text = "";

            return;
        end;

        local string_format_ret = string.format("%.2fkg", tonumber(p288.Weight or 0) or 0);

        if v290 then
            p287.Text = `<font color="{VariantColors:GetHex(v289) or "#FFFFFF"}">{EscapeRichText(v289)}</font><br/>{EscapeRichText(string_format_ret)}`;

            return;
        end;

        p287.Text = string_format_ret;
    end;

    local function UpdateRequirementFrameFromState(u292) -- Line: 1736
        -- upvalues: FormatCompactNumber (copy), u72 (ref), SetRequirementVariantLabel (copy), Color3_fromRGB_ret5 (copy), Color3_fromRGB_ret4 (copy), DataService (ref), ItemDescriptionFinder (ref), ItemImageFinder (ref), ItemRarityFinder (ref), ItemInfoHover (ref), NumberUtil (ref)
        local Frame = u292.Frame;
        local Requirement = u292.Requirement;
        local RequiredAmount = u292.RequiredAmount;
        local Next = Frame:FindFirstChild("Next");
        local Previous = Frame:FindFirstChild("Previous");
        local Quantity = Frame:FindFirstChild("Quantity");
        local Variant = Frame:FindFirstChild("Variant");

        if not u292.Selectable then
            if Next and Next:IsA("GuiObject") then
                Next.Visible = false;
            end;

            if Previous and Previous:IsA("GuiObject") then
                Previous.Visible = false;
            end;

            if Variant and Variant:IsA("GuiObject") then
                Variant.Visible = false;
            end;

            if Quantity and Quantity:IsA("TextLabel") then
                local v293 = tostring(Requirement.Type or "");
                local v294;

                if ((v293 == "Pet Egg" or (v293 == "PetEgg" or v293 == "Egg")) and "Egg" or v293) == "Currency" then
                    v294 = FormatCompactNumber(RequiredAmount);
                else
                    v294 = `x{RequiredAmount}`;
                end;

                Quantity.Text = v294;
                Quantity.TextColor3 = Color3.fromRGB(255, 255, 255);
            end;

            u72[u292.RequirementIndex] = nil;

            return;
        end;

        local Choices = u292.Choices;
        local u295 = Choices[u292.ChoiceIndex];
        local v296 = #Choices > 1;

        if Next and Next:IsA("GuiObject") then
            Next.Visible = v296;
        end;

        if Previous and Previous:IsA("GuiObject") then
            Previous.Visible = v296;
        end;

        if Variant and Variant:IsA("TextLabel") then
            local v297;

            if u295 then
                v297 = u295.IsSimpleChoice;
            else
                v297 = u295;
            end;

            Variant.Visible = not v297;
            SetRequirementVariantLabel(Variant, u295);
        end;

        local v298 = u295 and (u295.Owned or 0) or 0;
        local v299 = RequiredAmount <= v298;

        if Quantity and Quantity:IsA("TextLabel") then
            if v299 then
                Quantity.Text = `{RequiredAmount}/{RequiredAmount}`;
                Quantity.TextColor3 = Color3_fromRGB_ret5;
            else
                Quantity.Text = `{v298}/{RequiredAmount}`;
                Quantity.TextColor3 = Color3_fromRGB_ret4;
            end;
        end;

        task.spawn(function() -- Line: 1799
            -- upvalues: u295 (copy), DataService (ref), ItemDescriptionFinder (ref), ItemImageFinder (ref), ItemRarityFinder (ref), u292 (copy), ItemInfoHover (ref), NumberUtil (ref), RequiredAmount (copy), Frame (copy)
            if not (u295 and (u295.UUIDs and u295.UUIDs[1])) then
                return;
            end;

            local v300 = tostring(u295.UUIDs[1]);

            if v300:sub(1, 4) == "Pet:" then
                return;
            end;

            if v300:sub(1, 9) == "Cosmetic:" then
                return;
            end;

            local Data = DataService:GetData();

            if not Data then
                return;
            end;

            local InventoryData = Data.InventoryData;

            if InventoryData then
                InventoryData = InventoryData[v300];
            end;

            if not InventoryData or type(InventoryData.ItemData) ~= "table" then
                return;
            end;

            local ItemData = InventoryData.ItemData;
            local ItemType = InventoryData.ItemType;
            local v301 = ItemData.ItemName or (ItemData.SeedName or ItemData.FruitName) or (ItemData.GearName or ItemData.Name or (ItemData.Type or ItemData.Seed));

            if not v301 then
                return;
            end;

            local v302 = ItemDescriptionFinder(v301, ItemType);
            local v303 = ItemImageFinder(v301, ItemType);
            local v304 = ItemRarityFinder(v301, ItemType);
            local MutationString = ItemData.MutationString;
            local v305 = (type(MutationString) ~= "string" or #MutationString <= 0) and {} or string.split(MutationString, ", ");
            local v306 = #v305 > 0;
            local v307 = ItemType == "Pet";

            if type(v302) ~= "string" or #v302 <= 0 then
                v302 = `An interesting {v301}.`;
            end;

            local v308 = tostring(u292.Requirement.Type or "");

            if ((v308 == "Pet Egg" or (v308 == "PetEgg" or v308 == "Egg")) and "Egg" or v308) == "Seed" and not string.match(v301, "%sSeed$") then
                v301 = `{v301} Seed`;
            end;

            local v309 = {
                DetailsOnly = true,
                DisplayName = v301,
                Description = v302,
                ItemImage = v303
            };
            local v310 = {
                Rarity = v304
            };
            local v311;

            if v307 and v306 then
                v311 = v305;
            else
                v311 = nil;
            end;

            v310.PetMutation = v311;

            if v307 or not v306 then
                v305 = nil;
            end;

            v310.PlantMutations = v305;
            v310.Weight = u295.Weight and `{NumberUtil.RoundToDP(u295.Weight, 2)}kg` or nil;
            v310.Variant = u295.Variant;
            v310.Quantity = `{RequiredAmount}x`;
            v309.Properties = v310;
            ItemInfoHover:AddItemToData(v300, v309);
            Frame:SetAttribute("UUID", v300);
        end);
        u72[u292.RequirementIndex] = u295 and u295.UUIDs or {};
    end;

    local function RefreshRequirementState(p312) -- Line: 1867
        -- upvalues: UpdateRequirementFrameFromState (copy), SummerCrafting (ref), BuildRequirementChoices (copy)
        if not p312.Selectable then
            UpdateRequirementFrameFromState(p312);

            return;
        end;

        if not (p312.Frame and p312.Frame:IsDescendantOf(SummerCrafting)) then
            return;
        end;

        local v313 = p312.Choices and p312.Choices[p312.ChoiceIndex];
        local v314 = v313 and v313.UUIDs and v313.UUIDs[1];
        p312.Choices = BuildRequirementChoices(p312.Requirement);
        p312.ChoiceIndex = 1;

        if v314 then
            for i, v in p312.Choices do
                if v.UUIDs and v.UUIDs[1] == v314 then
                    p312.ChoiceIndex = i;
                    break;
                end;
            end;
        end;

        UpdateRequirementFrameFromState(p312);
    end;

    local function RefreshActiveRequirementStates() -- Line: 1895
        -- upvalues: SummerCrafting (ref), u73 (ref), RefreshRequirementState (copy)
        if not SummerCrafting.Crafting.Main.Crafting.Visible then
            return;
        end;

        for _, v in u73 do
            RefreshRequirementState(v);
        end;
    end;

    local function GetChoiceMutations(p315) -- Line: 1905
        -- upvalues: DataService (ref)
        if not (p315 and (p315.UUIDs and p315.UUIDs[1])) then
            return nil;
        end;

        local v316 = tostring(p315.UUIDs[1]);
        local v317;

        if v316:sub(1, 4) == "Pet:" then
            local PetsData = DataService:GetData().PetsData;
            local v318;

            if type(PetsData) == "table" then
                v318 = PetsData.PetInventory;

                if type(v318) == "table" then
                    if type(v318.Data) ~= "table" then
                        v318 = nil;
                    end;
                else
                    v318 = nil;
                end;
            else
                v318 = nil;
            end;

            v317 = v318 and v318.Data and v318.Data[v316:sub(5)];

            if v317 then
                v317 = v317.MutationString or v317.Mutation;
            end;
        else
            if v316:sub(1, 9) == "Cosmetic:" then
                return nil;
            end;

            local Data = DataService:GetData();
            local v319 = Data and Data.InventoryData and Data.InventoryData[v316];
            v317 = v319 and v319.ItemData and v319.ItemData.MutationString;
        end;

        if type(v317) == "string" and #v317 > 0 then
            return string.split(v317, ", ");
        end;

        return nil;
    end;

    local function BuildCraftConsumptionSummary() -- Line: 1935
        -- upvalues: u73 (ref), FormatCompactNumber (copy), VariantColors (ref), NumberUtil (ref), GetChoiceMutations (copy)
        local v320 = {};
        local v321 = {};
        local v322 = {};
        local v323 = false;

        for i in u73 do
            table.insert(v320, i);
        end;

        table.sort(v320);

        for _, v in v320 do
            local v324 = u73[v];
            local Requirement = v324.Requirement;
            local RequiredAmount = v324.RequiredAmount;

            if not RequiredAmount then
                local v325 = tonumber(Requirement.Quantity) or 1;
                RequiredAmount = math.max(1, v325);
            end;

            local Value = Requirement.Value;

            if Requirement.Type == "Seed" and not string.match(Value, "%sSeed$") then
                Value = `{Value} Seed`;
            end;

            if Requirement.Type == "Currency" then
                local v326 = `{FormatCompactNumber(RequiredAmount)} {Value}`;
                table.insert(v321, v326);
            elseif v324.Selectable then
                local v327 = v324.Choices and v324.Choices[v324.ChoiceIndex];
                local v328 = "";

                if v327 then
                    v323 = #v324.Choices > 1 and true or v323;
                    local Variant = v327.Variant;

                    if Variant and (Variant ~= "Normal" and not v327.IsSimpleChoice) then
                        v328 = v328 .. ` · <font color="{VariantColors:GetHex(Variant) or "#FFFFFF"}">{Variant}</font>`;
                        local v329 = `<font color="#FF4444">{RequiredAmount}x {Variant} {Value}</font>`;
                        table.insert(v322, v329);
                    end;

                    if v327.Weight and v327.Weight > 0 then
                        v328 = v328 .. ` · {NumberUtil.RoundToDP(v327.Weight, 2)}kg`;
                    end;

                    if v327.LabelRichText then
                        v328 = v328 .. ` · {v327.LabelRichText}`;
                    end;

                    local v330 = GetChoiceMutations(v327);

                    if v330 and #v330 > 0 then
                        v328 = v328 .. ` · <font color="#FF9500">{table.concat(v330, ", ")}</font>`;
                    end;
                end;

                local v331 = `{RequiredAmount}x {Value}{v328}`;
                table.insert(v321, v331);
            else
                local v332 = `{RequiredAmount}x {Value}`;
                table.insert(v321, v332);
            end;
        end;

        return v322, v323, v321;
    end;

    local function FireStartCraft() -- Line: 1995
        -- upvalues: u70 (ref), u69 (ref), ReplicatedStorage (ref), u72 (ref), PlaySound (ref)
        u70 = u69;
        ReplicatedStorage.GameEvents.SummerCraftingService.StartCraft:FireServer(u69, u72);
        PlaySound("rbxassetid://132025912670429");
    end;

    u112 = function() -- Line: 2001
        -- upvalues: BuildCraftConsumptionSummary (copy), u69 (ref), u70 (ref), ReplicatedStorage (ref), u72 (ref), PlaySound (ref), u2 (ref), ConfirmationPromptController (ref), FireStartCraft (copy)
        local v333, v334, v335 = BuildCraftConsumptionSummary();
        local v336 = nil;
        local v337;

        if #v333 > 0 then
            v337 = {
                Title = "Warning!",
                Header = "Are you sure?",
                Footer = "This can\'t be undone.",
                ConfirmText = "Craft",
                RejectText = "Cancel",
                Middle = `This craft will use your {table.concat(v333, ", ")}`
            };
        else
            v337 = v334 and {
                Title = "Confirm Craft",
                Footer = "These exact items will be used up.",
                ConfirmText = "Craft",
                RejectText = "Cancel",
                Header = `Craft {u69 and string.match(u69, "^%d+:%d+:(.+)$") or "this item"}?`,
                Middle = table.concat(v335, ", ")
            } or v336;
        end;

        if v337 then
            ConfirmationPromptController:Open(v337, {
                ConfirmCallback = FireStartCraft
            });

            return;
        end;

        u70 = u69;
        ReplicatedStorage.GameEvents.SummerCraftingService.StartCraft:FireServer(u69, u72);
        PlaySound(u2.StartCraft);
    end;

    local function QueueRequirementRefresh() -- Line: 2038
        -- upvalues: u113 (ref), SummerCrafting (ref), u73 (ref), RefreshRequirementState (copy)
        if u113 then
            return;
        end;

        u113 = true;
        task.defer(function() -- Line: 2045
            -- upvalues: u113 (ref), SummerCrafting (ref), u73 (ref), RefreshRequirementState (ref)
            u113 = false;

            if not SummerCrafting.Crafting.Main.Crafting.Visible then
                return;
            end;

            for _, v in u73 do
                RefreshRequirementState(v);
            end;
        end);
    end;

    local function SetupRequirementFrame(p338: userdata, p339: number, p340: any) -- Line: 2051
        -- upvalues: ItemImageFinder (ref), BuildRequirementChoices (copy), u1 (ref), UpdateRequirementFrameFromState (copy), u73 (ref), SummerCrafting (ref)
        p338.RequirementImage.Image = ItemImageFinder(p340.Value, p340.Type);
        local v341 = tonumber(p340.Quantity) or 1;
        local u342 = {
            ChoiceIndex = 1,
            Frame = p338,
            Requirement = p340,
            RequirementIndex = p339,
            RequiredAmount = math.max(1, v341)
        };
        local v343 = tostring(p340.Type or "");
        local v344 = (v343 == "Pet Egg" or (v343 == "PetEgg" or v343 == "Egg")) and "Egg" or v343;
        u342.Selectable = (v344 == "Fruit" or (v344 == "Seed" or (v344 == "Pet" or (v344 == "Gear" or v344 == "Egg")))) and true or v344 == "Cosmetic";
        u342.Choices = {};

        if u342.Selectable then
            u342.Choices = BuildRequirementChoices(p340);
        end;

        local Next = p338:FindFirstChild("Next");
        local Previous = p338:FindFirstChild("Previous");

        if Next and Next:IsA("TextButton") then
            u1:Add(Next.Activated:Connect(function() -- Line: 2074
                -- upvalues: u342 (copy), UpdateRequirementFrameFromState (ref)
                if #u342.Choices <= 0 then
                    return;
                end;

                local v345 = u342;
                v345.ChoiceIndex = v345.ChoiceIndex + 1;

                if u342.ChoiceIndex > #u342.Choices then
                    u342.ChoiceIndex = 1;
                end;

                UpdateRequirementFrameFromState(u342);
            end));
        end;

        if Previous and Previous:IsA("TextButton") then
            u1:Add(Previous.Activated:Connect(function() -- Line: 2090
                -- upvalues: u342 (copy), UpdateRequirementFrameFromState (ref)
                if #u342.Choices <= 0 then
                    return;
                end;

                local v346 = u342;
                v346.ChoiceIndex = v346.ChoiceIndex - 1;

                if u342.ChoiceIndex < 1 then
                    u342.ChoiceIndex = #u342.Choices;
                end;

                UpdateRequirementFrameFromState(u342);
            end));
        end;

        u73[p339] = u342;
        UpdateRequirementFrameFromState(u342);
        p338.Parent = SummerCrafting.Crafting.Main.Crafting.Requirements;
    end;

    local OddsButton = SummerCrafting.Crafting.Main.Crafting.Craft.OddsButton;
    u1:Add(OddsButton.Activated:Connect(function() -- Line: 2113
        -- upvalues: OddsButton (copy), PetEggOddsController (ref), SummerCrafting (ref), CosmeticCrateOddsController (ref), SeedPackOddsController (ref)
        local Attribute = OddsButton:GetAttribute("ItemType");
        local Attribute2 = OddsButton:GetAttribute("ItemValue");

        if not (Attribute and Attribute2) then
            warn("Missing ItemType and ItemValue attributes on button.");

            return;
        end;

        if Attribute == "Egg" then
            PetEggOddsController:Open(Attribute2, SummerCrafting);

            return;
        end;

        if Attribute == "Crate" then
            CosmeticCrateOddsController:Open(Attribute2, SummerCrafting);

            return;
        end;

        if Attribute == "SeedPack" then
            SeedPackOddsController:Open(Attribute2, SummerCrafting);
        end;
    end));
    local InfoButton = SummerCrafting.Crafting.Main.Crafting.Craft.InfoButton;

    local function GetCanvasCenterY(p347: userdata) -- Line: 2137
        -- upvalues: Scroller (ref)
        return p347.AbsolutePosition.Y - Scroller.AbsolutePosition.Y + Scroller.CanvasPosition.Y + p347.AbsoluteSize.Y / 2;
    end;

    local function GetCampfireProgress() -- Line: 2144
        -- upvalues: Config (ref)
        local v348 = tonumber(workspace:GetAttribute(Config.WORKSPACE_ATTRIBUTE)) or 0;
        local v349 = tonumber(workspace:GetAttribute(Config.WORKSPACE_EMBER_COUNT)) or 0;
        local v350 = tonumber(workspace:GetAttribute(Config.WORKSPACE_EMBER_COUNT_MAX)) or 0;

        return v348, v350 <= 0 and 0 or math.clamp(v349 / v350, 0, 1);
    end;

    local function UpdateTierTemplateStates(p351: number, p352: boolean) -- Line: 2157
        -- upvalues: Config (ref), u67 (copy), Color3_fromRGB_ret (ref), Color3_fromRGB_ret2 (ref), Chalk (ref)
        local v353;

        if p352 then
            v353 = Config.MAX_TIERS;
        else
            v353 = p351;
        end;

        for _, v in u67 do
            local v354 = v.Tier <= v353;
            local v355 = v.Tier == p351;
            local Tier = v.Tier;
            local v356 = `Tier {Tier or (({ "I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX", "X" })[Tier] or tostring(Tier))}`;
            local v357;

            if v354 then
                v357 = Color3_fromRGB_ret;
            else
                v357 = Color3_fromRGB_ret2;
            end;

            v.TierFrame.Dot.Container.BackgroundColor3 = v357;

            if v354 then
                if v355 then
                    v.TierFrame.TierName.Text = `{v356} <font color="#FFC24B">[CURRENT]</font>`;
                else
                    v.TierFrame.TierName.Text = v356;
                end;
            else
                v.TierFrame.TierName.Text = `{v356} {Chalk.red("[LOCKED]")}`;
            end;
        end;
    end;

    local function updateTierProgressFrames() -- Line: 2176
        -- upvalues: GetCampfireProgress (copy), u67 (copy), Scroller (ref), Spring (ref)
        local v358, v359 = GetCampfireProgress();

        for i, v in u67 do
            local v360 = u67[i + 1];

            if v360 then
                local Container = v.TierFrame.Dot.Container;
                local v361 = Container.AbsolutePosition.Y - Scroller.AbsolutePosition.Y + Scroller.CanvasPosition.Y + Container.AbsoluteSize.Y / 2;
                local Container2 = v360.TierFrame.Dot.Container;
                local v362 = Container2.AbsolutePosition.Y - Scroller.AbsolutePosition.Y + Scroller.CanvasPosition.Y + Container2.AbsoluteSize.Y / 2 - v361;

                if v362 <= 1 then
                    v.ProgressFrame.Visible = false;
                else
                    v.ProgressFrame.Visible = true;
                    local X = v.ProgressFrame.Position.X;
                    local X2 = v.ProgressFrame.Size.X;
                    v.ProgressFrame.Position = UDim2.new(X.Scale, X.Offset, 0, v361);
                    v.ProgressFrame.Size = UDim2.new(X2.Scale, X2.Offset, 0, v362);
                    local v363 = 0;

                    if v.Tier < v358 then
                        v363 = 1;
                    elseif v358 == v.Tier then
                        v363 = v359;
                    end;

                    local Filler = v.ProgressFrame:FindFirstChild("Filler");

                    if Filler and Filler:IsA("GuiObject") then
                        Filler.AnchorPoint = Vector2.new(0, 0);
                        Filler.Position = UDim2.fromScale(0, 0);
                        Spring.target(Filler, 1, 4, {
                            Size = UDim2.fromScale(1, v363)
                        });
                    end;
                end;
            else
                v.ProgressFrame.Visible = false;
            end;
        end;
    end;

    local u364 = false;

    local function QueueUpdate() -- Line: 2226
        -- upvalues: u364 (ref), RunService (ref), updateTierProgressFrames (copy)
        if u364 then
            return;
        end;

        u364 = true;
        task.defer(function() -- Line: 2233
            -- upvalues: RunService (ref), u364 (ref), updateTierProgressFrames (ref)
            RunService.Heartbeat:Wait();
            RunService.Heartbeat:Wait();
            RunService.Heartbeat:Wait();
            u364 = false;
            updateTierProgressFrames();
        end);
    end;

    local function BuildCraftableList() -- Line: 2243
        -- upvalues: ClearDisplayedCraft (copy), Scroller (ref), u67 (copy), u148 (ref), u147 (copy), u150 (copy), Config2 (ref), u146 (copy), UpdateService (ref), TierTemplate (ref), TierProgressTemplate (ref), ItemImageFinder (ref), CraftableTemplate (ref), SetupCampfireEggFrame (ref), Shime (ref), AddEggGlow (ref), ItemInfoHover (ref), BuildResultHoverData (ref), SetupButton (ref), u69 (ref), SummerCrafting (ref), u71 (ref), u130 (ref), TextColor3 (copy), OddsButton (copy), InfoButton (copy), ItemDescriptionFinder (ref), ItemRarityFinder (ref), u72 (ref), u73 (ref), RequirementTemplate (ref), SetupRequirementFrame (copy), FormatCompactNumber (copy), FitSlots (ref), RecipeItemTemplate (ref), u364 (ref), RunService (ref), updateTierProgressFrames (copy)
        ClearDisplayedCraft();

        for _, child in Scroller:GetChildren() do
            if child:IsA("GuiObject") and child.Name ~= "Separator" then
                child:Destroy();
            end;
        end;

        for _, child in Scroller.Separator:GetChildren() do
            if child.Name ~= "UIListLayout" then
                child:Destroy();
            end;
        end;

        table.clear(u67);
        u148 = 1;
        table.clear(u147);
        table.clear(u150);
        local v365 = {};

        for i, v in Config2.Craftables do
            local v366 = i;
            local v367 = v;
            local v368 = false;

            for i2, v2 in u146 do
                if typeof(v367[i2]) ~= v2 then
                    warn((`SummerCraftingConfig: Entry #{v366} has invalid {i2} (Expected {v2}, got {typeof(v367[i2])}). Skipping...`));
                    v368 = true;
                end;
            end;

            if not v368 then
                v365[v367.Tier] = (v365[v367.Tier] or 0) + 1;

                if UpdateService:IsActive(v367.Result.Value) then
                    if not u147[v367.Tier] then
                        u147[v367.Tier] = {};
                    end;

                    local v369 = u147[v367.Tier];
                    local v370 = {
                        Result = v367.Result,
                        Amount = tonumber(v367.Amount) or 1,
                        Recipe = v367.Recipe
                    };
                    local v371;

                    if typeof(v367.Description) == "string" then
                        v371 = v367.Description;
                    else
                        v371 = nil;
                    end;

                    v370.Description = v371;
                    v370.ProductId = v367.ProductId;
                    v370.CraftIndex = v365[v367.Tier];
                    table.insert(v369, v370);
                end;
            end;
        end;

        for i in u147 do
            table.insert(u150, i);
        end;

        table.sort(u150);
        local v372 = 0;

        for _, v in u150 do
            v372 = v372 + #u147[v];
        end;

        local v373 = 0;

        for _, v in u150 do
            local v374 = u147[v];
            local v375 = TierTemplate:Clone();
            local v376 = u148;
            u148 = u148 + 1;
            v375.LayoutOrder = v376;
            v375.Name = `Tier{v}`;
            v375.TierName.Text = `Tier {v or (({ "I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX", "X" })[v] or tostring(v))}`;
            v375.Dot.Container.Label.Text = `{v}.`;
            v375.Parent = Scroller;
            local v377 = TierProgressTemplate:Clone();
            v377.Name = `TierProgress{v}`;
            v377.Position = UDim2.fromScale(0.05, 0);
            v377.Size = UDim2.fromScale(0.032, 0);
            v377.Filler.Size = UDim2.fromScale(1, 0);
            local v378 = u148;
            u148 = u148 + 1;
            v377.LayoutOrder = v378;
            v377.Parent = Scroller.Separator;
            local u379 = v;

            for i, v2 in v374 do
                local Value = v2.Result.Value;
                local u380 = ItemImageFinder(v2.Result.Value, v2.Result.Type);
                local v381 = CraftableTemplate:Clone();
                v381.Name = `{v2.CraftIndex or i}:{Value}`;
                local v382 = v2.Result.Value == "Campfire Egg";
                local ItemName = v381.Inner.ItemName;
                local Value2 = v2.Result.Value;

                if v2.Result.Type == "Seed" and not string.match(Value2, "%sSeed$") then
                    Value2 = `{Value2} Seed`;
                end;

                ItemName.Text = Value2;

                if v382 then
                    SetupCampfireEggFrame(v381);
                end;

                v381.Inner.ItemDescription.Text = v2.Description or "";
                v381.Inner.Craft.Icon.Image = u380;
                local v383;

                if v382 then
                    v383 = v372 - 1;
                else
                    v383 = v373;
                    v373 = v373 + 1;
                end;

                local u384 = Shime.new(v381.Inner.Craft.Icon, 0.7, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, -1, false, (math.max(0, v372 * 0.18 - 0.7)));
                task.delay(v383 * 0.18, function() -- Line: 2353
                    -- upvalues: u384 (copy)
                    u384:Play();
                end);

                if v382 then
                    AddEggGlow(v381.Inner.Craft);
                end;

                local v385 = `SummerFire_{v2.Result.Type}_{v2.Result.Value}`;
                ItemInfoHover:AddItemToData(v385, (BuildResultHoverData(v2.Result.Value, v2.Result.Type, u380)));
                v381.Inner.Craft.Icon:AddTag("ItemInfoHoverTag");
                v381.Inner.Craft.Icon:SetAttribute("UUID", v385);
                local v386;

                if v382 then
                    v386 = 1000000;
                else
                    v386 = u148;
                    u148 = u148 + 1;
                end;

                v381.LayoutOrder = v386;
                v381.Parent = Scroller;
                SetupButton({
                    offset = 0.05,
                    legacy = true,
                    instance = v381.Inner.SENSOR,
                    scale = v381.Inner.UIScale,

                    onclick = function() -- Line: 2372, Name: onclick
                        -- upvalues: u379 (copy), v2 (copy), i (copy), Value (copy), u69 (ref), SummerCrafting (ref), u71 (ref), u130 (ref), TextColor3 (ref), u380 (copy), OddsButton (ref), InfoButton (ref), ItemInfoHover (ref), ItemDescriptionFinder (ref), ItemRarityFinder (ref), u72 (ref), u73 (ref), RequirementTemplate (ref), SetupRequirementFrame (ref), ItemImageFinder (ref), FormatCompactNumber (ref), FitSlots (ref)
                        local v387 = `{u379}:{v2.CraftIndex or i}:{Value}`;

                        if u69 == v387 and SummerCrafting.Crafting.Main.Crafting.Visible then
                            u69 = nil;
                            SummerCrafting.Crafting.Main.Campfire.Visible = true;
                            SummerCrafting.Crafting.Main.Crafting.Visible = false;

                            return;
                        end;

                        u69 = v387;
                        u71 = tonumber(v2.ProductId);
                        u130 = u130 + 1;
                        SummerCrafting.Crafting.Main.Crafting.Tier.TierName.TextColor3 = TextColor3;
                        local ItemName2 = SummerCrafting.Crafting.Main.Crafting.Craft.ItemName;
                        local Value3 = v2.Result.Value;

                        if v2.Result.Type == "Seed" and not string.match(Value3, "%sSeed$") then
                            Value3 = `{Value3} Seed`;
                        end;

                        ItemName2.Text = Value3;
                        local v388 = u379;
                        SummerCrafting.Crafting.Main.Crafting.Tier.TierName.Text = `Campfire {v388 or (({ "I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX", "X" })[v388] or tostring(v388))}`;
                        SummerCrafting.Crafting.Main.Crafting.Craft.Icon.Image = u380;
                        OddsButton.Visible = (v2.Result.Type == "Egg" or v2.Result.Type == "SeedPack") and true or v2.Result.Type == "Crate";
                        OddsButton:SetAttribute("ItemValue", v2.Result.Value);
                        OddsButton:SetAttribute("ItemType", v2.Result.Type);
                        InfoButton.Visible = v2.Result.Type == "Gear";
                        local v389 = `SummerFire_SELECTED_{v2.Result.Type}_{v2.Result.Value}`;
                        ItemInfoHover:AddItemToData(v389, {
                            DescriptionOnly = true,
                            DisplayName = Value,
                            Description = ItemDescriptionFinder(v2.Result.Value, v2.Result.Type),
                            ItemImage = u380,
                            Properties = {
                                Rarity = ItemRarityFinder(v2.Result.Value, v2.Result.Type)
                            }
                        });
                        InfoButton:SetAttribute("UUID", v389);
                        local Icon = SummerCrafting.Crafting.Main.Crafting.Craft.Icon;
                        Icon:AddTag("ItemInfoHoverTag");
                        Icon:SetAttribute("UUID", v389);
                        local ButtonHolder = SummerCrafting.Crafting.Main.Crafting.ButtonHolder;
                        ButtonHolder.CRAFT.Visible = true;
                        ButtonHolder.BUY.Visible = v2.ProductId ~= nil;
                        ButtonHolder.BUY.SENSOR.Label:SetAttribute("ProductId", v2.ProductId);
                        ButtonHolder.BUY.SENSOR.Label[`{v2.ProductId and "Add" or "Remove"}Tag`](ButtonHolder.BUY.SENSOR.Label, "PriceLabel");

                        for _, v3 in SummerCrafting.Crafting.Main.Crafting.Requirements:QueryDescendants("> Frame") do
                            v3:Destroy();
                        end;

                        u72 = {};
                        u73 = {};
                        local v390 = {};

                        for i2, v3 in v2.Recipe do
                            local v391 = RequirementTemplate:Clone();
                            SetupRequirementFrame(v391, i2, v3);
                            table.insert(v390, v391);
                            ItemImageFinder(v3.Value, v3.Type);
                            ItemRarityFinder(v3.Value, v3.Type);
                            ItemDescriptionFinder(v3.Value, v3.Type);
                            local v392 = `{v387}_REQ_{i2}_{v3.Type}_{v3.Value}_{tonumber(v3.Quantity) or 1}`;
                            local v393 = ItemImageFinder(v3.Value, v3.Type);
                            local v394 = ItemRarityFinder(v3.Value, v3.Type);
                            local v395 = ItemDescriptionFinder(v3.Value, v3.Type);
                            local v396;

                            if v3.Type == "Seed" then
                                v396 = `{v3.Value} Seed`;
                            else
                                v396 = `{v3.Value}`;
                            end;

                            local v397 = {
                                DetailsOnly = true,
                                DisplayName = v396
                            };

                            if #v395 <= 0 then
                                v395 = `An interesting {v3.Value}.`;
                            end;

                            v397.Description = v395;
                            v397.ItemImage = v393;
                            local v398 = {
                                Rarity = v394
                            };
                            local v399 = tonumber(v3.Quantity) or 1;
                            local v400 = tostring(v3.Type or "");
                            local v401;

                            if ((v400 == "Pet Egg" or (v400 == "PetEgg" or v400 == "Egg")) and "Egg" or v400) == "Currency" then
                                v401 = FormatCompactNumber(v399);
                            else
                                v401 = `x{v399}`;
                            end;

                            v398.Quantity = v401;
                            v397.Properties = v398;
                            ItemInfoHover:AddItemToData(v392, v397);
                            v391:AddTag("ItemInfoHoverTag");

                            if not v391:GetAttribute("UUID") then
                                v391:SetAttribute("UUID", v392);
                            end;
                        end;

                        FitSlots(v390, SummerCrafting.Crafting.Main.Crafting.Requirements:FindFirstChildOfClass("UIListLayout"));
                        SummerCrafting.Crafting.Main.Campfire.Visible = false;
                        SummerCrafting.Crafting.Main.Crafting.Visible = true;
                    end
                });
                local v402 = i;

                for i2, v3 in v2.Recipe do
                    local v403 = ItemImageFinder(v3.Value, v3.Type);
                    local v404 = ItemRarityFinder(v3.Value, v3.Type);
                    local v405 = ItemDescriptionFinder(v3.Value, v3.Type);
                    local v406 = v3.Type == "Fruit" and true or v3.Type == "Pet";
                    local v407 = RecipeItemTemplate:Clone();
                    v407.RequirementImage.Image = v403;
                    local Quantity = v407.Quantity;
                    local v408 = tonumber(v3.Quantity) or 1;
                    local v409 = tostring(v3.Type or "");
                    local v410;

                    if ((v409 == "Pet Egg" or (v409 == "PetEgg" or v409 == "Egg")) and "Egg" or v409) == "Currency" then
                        v410 = FormatCompactNumber(v408);
                    else
                        v410 = `x{v408}`;
                    end;

                    Quantity.Text = v410;
                    v407.Parent = v381.Inner.Requirements;
                    local v411 = `{`{u379}:{v402}:{Value}`}_REQ_{i2}_{v3.Type}_{v3.Value}_{tonumber(v3.Quantity) or 1}`;
                    local v412;

                    if v3.Type == "Seed" then
                        v412 = `{v3.Value} Seed`;
                    else
                        v412 = `{v3.Value}`;
                    end;

                    local v413 = {
                        DetailsOnly = true,
                        DisplayName = v412
                    };

                    if #v405 <= 0 then
                        v405 = `An interesting {v3.Value}.`;
                    end;

                    v413.Description = v405;
                    v413.ItemImage = v403;
                    local v414 = {
                        Rarity = v404
                    };
                    local v415 = tonumber(v3.Quantity) or 1;
                    local v416 = tostring(v3.Type or "");
                    local v417;

                    if ((v416 == "Pet Egg" or (v416 == "PetEgg" or v416 == "Egg")) and "Egg" or v416) == "Currency" then
                        v417 = FormatCompactNumber(v415);
                    else
                        v417 = `x{v415}`;
                    end;

                    v414.Quantity = v417;
                    v414.Mutations = v406 and "Any" or nil;
                    v414.Weight = v406 and "Any" or nil;
                    v413.Properties = v414;
                    ItemInfoHover:AddItemToData(v411, v413);
                    v407:AddTag("ItemInfoHoverTag");
                    v407:SetAttribute("UUID", v411);
                end;
            end;

            table.insert(u67, {
                Tier = u379,
                TierFrame = v375,
                ProgressFrame = v377
            });
        end;

        if u364 then
            return;
        end;

        u364 = true;
        task.defer(function() -- Line: 2233
            -- upvalues: RunService (ref), u364 (ref), updateTierProgressFrames (ref)
            RunService.Heartbeat:Wait();
            RunService.Heartbeat:Wait();
            RunService.Heartbeat:Wait();
            u364 = false;
            updateTierProgressFrames();
        end);
    end;

    local function RefetchSummerConfigs() -- Line: 2532
        -- upvalues: Config (ref), GameConfigController (ref), Config2 (ref), BuildCraftableList (copy)
        Config = GameConfigController:GetConfig("SummerFireConfig");
        Config2 = GameConfigController:GetConfig("SummerCraftingConfig");
        BuildCraftableList();
    end;

    u1:Add(workspace:GetAttributeChangedSignal("SummerFireConfig"):Connect(RefetchSummerConfigs));
    u1:Add(workspace:GetAttributeChangedSignal("SummerCraftingConfig"):Connect(RefetchSummerConfigs));
    BuildCraftableList();
    u1:Add(Scroller.UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(QueueUpdate));
    u1:Add(Scroller:GetPropertyChangedSignal("AbsoluteSize"):Connect(QueueUpdate));
    u1:Add(Scroller:GetPropertyChangedSignal("CanvasPosition"):Connect(QueueUpdate));

    if not u364 then
        u364 = true;
        task.defer(function() -- Line: 2233
            -- upvalues: RunService (ref), u364 (ref), updateTierProgressFrames (copy)
            RunService.Heartbeat:Wait();
            RunService.Heartbeat:Wait();
            RunService.Heartbeat:Wait();
            u364 = false;
            updateTierProgressFrames();
        end);
    end;

    local function GetCraftSpeedBonusPercent(p418: number, p419: boolean) -- Line: 2547
        -- upvalues: Config (ref), Config2 (ref)
        if p418 <= 0 then
            return 0;
        end;

        if p419 then
            p418 = Config.MAX_TIERS;
        end;

        return p418 * Config2.BoostPerTier;
    end;

    local Value = SummerCrafting.Crafting.Main.Campfire.SpeedBonus.Value;
    local u420 = Value:FindFirstChildOfClass("UIStroke");
    local Color3_fromRGB_ret6 = Color3.fromRGB(50, 255, 17);
    local Color3_fromRGB_ret7 = Color3.fromRGB(150, 255, 120);
    local Color3_fromRGB_ret8 = Color3.fromRGB(105, 117, 110);
    local u421 = u420 and (u420.Transparency or 0) or 0;
    local u422 = TweenService:Create(Value, TweenInfo.new(0.45, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
        TextColor3 = Color3_fromRGB_ret7
    });
    local u423;

    if u420 then
        u423 = TweenService:Create(u420, TweenInfo.new(0.45, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
            Transparency = math.clamp(u421 + 0.35, 0, 1)
        });
    else
        u423 = u420;
    end;

    local u424 = false;

    local function SetSpeedBonusEnergized(p425: boolean) -- Line: 2577
        -- upvalues: u424 (ref), Value (copy), Color3_fromRGB_ret6 (copy), u422 (copy), u423 (copy), Color3_fromRGB_ret8 (copy), u420 (copy), u421 (copy)
        if p425 == u424 then
            return;
        end;

        u424 = p425;

        if p425 then
            Value.TextColor3 = Color3_fromRGB_ret6;
            u422:Play();

            if u423 then
                u423:Play();
            end;
        else
            u422:Cancel();
            Value.TextColor3 = Color3_fromRGB_ret8;

            if u423 then
                u423:Cancel();
                u420.Transparency = u421;
            end;
        end;
    end;

    local function ComputeCampfireState() -- Line: 2599
        -- upvalues: Config (ref), SetCampfireSpriteState (ref), UpdateTierTemplateStates (copy), SummerCrafting (ref), Config2 (ref), u424 (ref), Value (copy), Color3_fromRGB_ret6 (copy), u422 (copy), u423 (copy), Color3_fromRGB_ret8 (copy), u420 (copy), u421 (copy), u364 (ref), RunService (ref), updateTierProgressFrames (copy), UpdateCraftingSlots (copy)
        local v426 = tonumber(workspace:GetAttribute(Config.WORKSPACE_ATTRIBUTE)) or 0;
        local v427 = workspace:GetAttribute(Config.WORKSPACE_SUPER_ATTRIBUTE) == true;
        SetCampfireSpriteState(v426, v427);
        UpdateTierTemplateStates(v426, v427);
        local v428;

        if v427 then
            v428 = Config.MAX_TIERS;
        else
            v428 = v426;
        end;

        SummerCrafting.Crafting.Header.Title.Text = v428 <= 0 and "Campfire Workshop" or `Tier {v428 or (({ "I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX", "X" })[v428] or tostring(v428))} - Campfire Workshop`;
        local Campfire = SummerCrafting.Crafting.Main.Campfire.Campfire;

        if v426 <= 0 then
            Campfire.TierName.Text = "Inactive";
        else
            Campfire.TierName.Text = v427 and "Super Fire" or `Tier {v426 or (({ "I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX", "X" })[v426] or tostring(v426))}`;
        end;

        local v429;

        if v426 <= 0 then
            v429 = 0;
        else
            local v430;

            if v427 then
                v430 = Config.MAX_TIERS;
            else
                v430 = v426;
            end;

            v429 = v430 * Config2.BoostPerTier;
        end;

        if v429 > 0 then
            SummerCrafting.Crafting.Main.Campfire.SpeedBonus.Value.Text = `{v429}%`;

            if u424 ~= true then
                u424 = true;
                Value.TextColor3 = Color3_fromRGB_ret6;
                u422:Play();

                if u423 then
                    u423:Play();
                end;
            end;

            local v431 = `Your crafting speed is boosted by {v429}%, by the Tier {v426 or (({ "I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX", "X" })[v426] or tostring(v426))} Campfire`;
            SummerCrafting.Crafting.Main.Campfire.SpeedBonus:SetAttribute("HoverText", v431);
        else
            SummerCrafting.Crafting.Main.Campfire.SpeedBonus.Value.Text = "Light it up!";

            if u424 ~= false then
                u424 = false;
                u422:Cancel();
                Value.TextColor3 = Color3_fromRGB_ret8;

                if u423 then
                    u423:Cancel();
                    u420.Transparency = u421;
                end;
            end;

            SummerCrafting.Crafting.Main.Campfire.SpeedBonus:SetAttribute("HoverText", "Light the campfire to get a crafting speed boost!");
        end;

        if not u364 then
            u364 = true;
            task.defer(function() -- Line: 2233
                -- upvalues: RunService (ref), u364 (ref), updateTierProgressFrames (ref)
                RunService.Heartbeat:Wait();
                RunService.Heartbeat:Wait();
                RunService.Heartbeat:Wait();
                u364 = false;
                updateTierProgressFrames();
            end);
        end;

        UpdateCraftingSlots();
    end;

    u1:Add(workspace:GetAttributeChangedSignal(Config.WORKSPACE_ATTRIBUTE):Connect(ComputeCampfireState));
    u1:Add(workspace:GetAttributeChangedSignal(Config.WORKSPACE_SUPER_ATTRIBUTE):Connect(ComputeCampfireState));
    u1:Add(workspace:GetAttributeChangedSignal(Config.WORKSPACE_EMBER_COUNT):Connect(ComputeCampfireState));
    u1:Add(workspace:GetAttributeChangedSignal(Config.WORKSPACE_EMBER_COUNT_MAX):Connect(ComputeCampfireState));
    u1:Add(RunService.Heartbeat:Connect(function(p432: number) -- Line: 2647
        -- upvalues: UpdateCraftingSlots (copy), u4 (ref), u6 (ref), u5 (ref), u3 (ref), CampfireSprite (ref)
        UpdateCraftingSlots();

        if u4 == 0 then
            return;
        end;

        u6 = u6 + p432;

        while u6 >= 0.125 do
            u6 = u6 - 0.125;
            u5 = u5 + 1;

            if u5 > #u3 then
                u5 = 1;
            end;
        end;

        CampfireSprite.ImageRectOffset = Vector2.new(u3[u5], u4);
    end));
    ComputeCampfireState();
    UpdateCraftingSlots();
    u1:Add(DataService:GetPathSignal("InventoryData"):Connect(QueueRequirementRefresh));
    u1:Add(DataService:GetPathSignal("PetsData/PetInventory/Data"):Connect(QueueRequirementRefresh));
    u1:Add(DataService:GetPathSignal("CosmeticData/Inventory"):Connect(QueueRequirementRefresh));
    u1:Add(DataService:GetPathSignal("CosmeticData/Pool"):Connect(QueueRequirementRefresh));
end;

local u433 = false;
EventRotationController.EventUpdated:Connect(function(p434: string, p435: string) -- Line: 2681, Name: OnEventUpdated
    -- upvalues: u1 (copy), u433 (ref), u9 (copy)
    if p435 ~= "CampfireEvent" then
        u1:Clean();
        u433 = false;

        return;
    end;

    if u433 then
        return;
    end;

    u433 = true;
    u1:Clean();
    task.spawn(u9.Start);
end);

return u9;