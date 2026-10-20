-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CollectionService = game:GetService("CollectionService");
local SoundService = game:GetService("SoundService");
local UserInputService = game:GetService("UserInputService");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local EventRotationUtils = require(ReplicatedStorage.Modules.EventRotation.EventRotationUtils);
local EventRotationController = require(ReplicatedStorage.Modules.EventRotation.EventRotationController);
local GameConfigController = require(ReplicatedStorage.Modules.GameConfigController);
local DataService = require(ReplicatedStorage.Modules.DataService);
local GuiController = require(ReplicatedStorage.Modules.GuiController);
local ItemImageFinder = require(ReplicatedStorage.Modules.ItemImageFinder);
local MarketController = require(ReplicatedStorage.Modules.MarketController);
local GenericRewardsUIController = require(ReplicatedStorage.Modules.GenericRewardsUIController);
local MutationHandler = require(ReplicatedStorage.Modules.MutationHandler);
local Trove = require(ReplicatedStorage.Modules.Trove);
local u1 = {
    Silver = Color3.fromRGB(190, 195, 200),
    Gold = Color3.fromRGB(255, 201, 60),
    Rainbow = Color3.fromRGB(255, 130, 220)
};
local LocalPlayer = Players.LocalPlayer;
local Config = GameConfigController:GetConfig("BasketDeliveryConfig");
workspace:GetAttributeChangedSignal("BasketDeliveryConfig"):Connect(function() -- Line: 38
    -- upvalues: Config (ref), GameConfigController (copy)
    Config = GameConfigController:GetConfig("BasketDeliveryConfig");
end);
local u2 = {};
local u3 = Trove.new();
local u4 = Trove.new();
local u5 = nil;
local u6 = "idle";

local function substitute(p7: string, p8: table) -- Line: 52
    for i, v in p8 do
        p7 = p7:gsub("%[" .. i .. "%]", function() -- Line: 55
            -- upvalues: v (copy)
            return v;
        end);
    end;

    return p7;
end;

local function waitFor(p9: userdata?, p10: string, p11: number?) -- Line: 61
    if p9 then
        return p9:WaitForChild(p10, p11 or 10);
    end;

    return nil;
end;

local function basketData() -- Line: 66
    -- upvalues: DataService (copy)
    local Data = DataService:GetData();

    if Data then
        Data = Data.BasketDeliveryData;
    end;

    return Data;
end;

local function submissions() -- Line: 71
    -- upvalues: Config (ref)
    return Config.SUBMISSIONS or {};
end;

local function requirementAt(p12: number) -- Line: 75
    -- upvalues: Config (ref)
    local v13 = Config.SUBMISSIONS or {};

    if #v13 == 0 then
        return nil;
    end;

    return v13[(p12 - 1) % #v13 + 1];
end;

local function describeSplit(p14) -- Line: 83
    -- upvalues: Config (ref), substitute (copy), MutationHandler (copy), u1 (copy)
    if not p14 then
        return "", "";
    end;

    local DISPLAY = Config.DISPLAY;
    local v15;

    if p14.MinWeight then
        v15 = substitute(DISPLAY.NAME_LINE_WEIGHT, {
            PLANT = p14.Plant,
            KG = tostring(p14.MinWeight)
        });
    else
        v15 = substitute(DISPLAY.NAME_LINE, {
            PLANT = p14.Plant
        });
    end;

    local Mutations = MutationHandler:GetMutations();
    local u16 = {};

    local function push(p17: string, p18) -- Line: 98
        -- upvalues: u16 (copy)
        if not p18 then
            table.insert(u16, p17);

            return;
        end;

        local v19 = `<font color="#{p18:ToHex()}">{p17}</font>`;
        table.insert(u16, v19);
    end;

    if p14.Variant and p14.Variant ~= "Normal" then
        local Variant = p14.Variant;
        local v20 = u1[p14.Variant];

        if v20 then
            local v21 = `<font color="#{v20:ToHex()}">{Variant}</font>`;
            table.insert(u16, v21);
        else
            table.insert(u16, Variant);
        end;
    end;

    for _, v in p14.Mutations or {} do
        local v22 = Mutations[v];

        if v22 then
            v22 = v22.Color;
        end;

        if v22 then
            local v23 = `<font color="#{v22:ToHex()}">{v}</font>`;
            table.insert(u16, v23);
        else
            table.insert(u16, v);
        end;
    end;

    if #u16 == 0 then
        return v15, "";
    end;

    return v15, substitute(DISPLAY.MODIFIER_LINE, {
        MODS = table.concat(u16, DISPLAY.MUTATION_JOIN or " ")
    });
end;

local function describe(p24) -- Line: 121
    -- upvalues: Config (ref), substitute (copy)
    if not p24 then
        return "";
    end;

    local DISPLAY = Config.DISPLAY;
    local Plant = p24.Plant;

    if p24.Mutations and #p24.Mutations > 0 then
        Plant = substitute(DISPLAY.MUTATION_PREFIX, {
            MUTATIONS = table.concat(p24.Mutations, DISPLAY.MUTATION_JOIN or " ")
        }) .. Plant;
    end;

    if p24.Variant and p24.Variant ~= "Normal" then
        Plant = substitute(DISPLAY.VARIANT_PREFIX, {
            VARIANT = p24.Variant
        }) .. Plant;
    end;

    if p24.MinWeight then
        return substitute(DISPLAY.ASK_WEIGHT, {
            PLANT = Plant,
            KG = tostring(p24.MinWeight)
        });
    end;

    return substitute(DISPLAY.ASK_PLAIN, {
        PLANT = Plant
    });
end;

local function distanceTo(p25: userdata?) -- Line: 141
    -- upvalues: LocalPlayer (copy)
    local Character = LocalPlayer.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    return not (p25 and Character) and (1 / 0) or (Character.Position - p25.Position).Magnitude;
end;

local function smoothstep(p26: number) -- Line: 148
    local math_clamp_ret = math.clamp(p26, 0, 1);

    return math_clamp_ret * math_clamp_ret * (3 - math_clamp_ret * 2);
end;

local u27 = Trove.new();
local TweenInfo_new_ret = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
local UDim2_fromScale_ret = UDim2.fromScale(0.3, 0.825);
local u28 = Trove.new();

local function tierForIndex(p29: number) -- Line: 165
    -- upvalues: Config (ref)
    local v30 = Config.TIERS or {};

    for i, v in v30 do
        if p29 <= (v.UpTo or 0) then
            return v, i;
        end;
    end;

    return v30[#v30], #v30;
end;

local function pendingTierIndex() -- Line: 175
    -- upvalues: DataService (copy), Config (ref)
    local Data = DataService:GetData();

    if Data then
        Data = Data.BasketDeliveryData;
    end;

    local v31 = #(Config.SUBMISSIONS or {});

    return (not Data or v31 == 0) and 1 or (Data.Index - 2) % v31 + 1;
end;

function u2.OpenTierOdds(p32: table, p33: userdata?) -- Line: 184
    -- upvalues: tierForIndex (copy), DataService (copy), Config (ref), GenericRewardsUIController (copy)
    local Data = DataService:GetData();

    if Data then
        Data = Data.BasketDeliveryData;
    end;

    local v34 = #(Config.SUBMISSIONS or {});
    local v35, v36 = tierForIndex((not Data or v34 == 0) and 1 or (Data.Index - 2) % v34 + 1);

    if not (v35 and v35.Pool) then
        return;
    end;

    local v37 = {};

    for _, v in v35.Pool do
        table.insert(v37, {
            Reward = {
                Type = v.ItemType,
                Value = v.ItemName,
                Quantity = v.ItemAmount or 1
            },
            Weight = v.Chance or 0
        });
    end;

    GenericRewardsUIController:Open({
        DisplayOdds = true,
        Title = `Tier {v36} Rewards`,
        RewardData = v37,
        Breadcrumb = p33,
        HeaderColor = Color3.fromRGB(92, 175, 68),
        Disclaimer = GenericRewardsUIController.RoundedOddsDisclaimer(v37)
    });
end;

function u2.OpenRewards(p38) -- Line: 210
    -- upvalues: DataService (copy), LocalPlayer (copy), u27 (copy), ReplicatedStorage (copy), Config (ref), RunService (copy), UserInputService (copy), SoundService (copy), TweenService (copy), TweenInfo_new_ret (copy), u28 (copy), ItemImageFinder (copy), GuiController (copy), UDim2_fromScale_ret (copy), MarketController (copy), u2 (copy)
    local Data = DataService:GetData();

    if Data then
        Data = Data.BasketDeliveryData;
    end;

    if not Data or #(Data.PendingRewards or {}) == 0 then
        return;
    end;

    local u39 = LocalPlayer:FindFirstChildOfClass("PlayerGui");

    if u39 then
        u39 = u39:FindFirstChild("ChooseRewards_UI");
    end;

    if not u39 then
        return;
    end;

    local Items = u39.Frame.Main.Items;
    local Template = Items.UIListLayout:FindFirstChild("Template");

    if not Template then
        return;
    end;

    u27:Clean();
    local u40 = ReplicatedStorage.GameEvents.Events.BeanstalkEvent:FindFirstChild(Config.CLAIM_REMOTE);
    local u41 = {};
    local u42 = nil;
    u27:Add(RunService.RenderStepped:Connect(function() -- Line: 230
        -- upvalues: u39 (copy), UserInputService (ref), u41 (copy), u42 (ref), SoundService (ref), TweenService (ref), TweenInfo_new_ret (ref)
        if not u39.Enabled then
            return;
        end;

        local MouseLocation = UserInputService:GetMouseLocation();
        local v43 = nil;

        for _, v in u41 do
            local AbsolutePosition = v.Card.AbsolutePosition;
            local AbsoluteSize = v.Card.AbsoluteSize;

            if MouseLocation.X >= AbsolutePosition.X and (MouseLocation.X <= AbsolutePosition.X + AbsoluteSize.X and (MouseLocation.Y >= AbsolutePosition.Y and MouseLocation.Y <= AbsolutePosition.Y + AbsoluteSize.Y)) then
                v43 = v.Card;
                break;
            end;
        end;

        if v43 == u42 then
            return;
        end;

        u42 = v43;

        if v43 then
            SoundService:PlayLocalSound(SoundService.Hover);
        end;

        for _, v in u41 do
            TweenService:Create(v.Scale, TweenInfo_new_ret, {
                Scale = v.Card == v43 and 1.12 or 1
            }):Play();
        end;
    end));

    local function renderCards() -- Line: 253
        -- upvalues: DataService (ref), u28 (ref), u41 (copy), Items (copy), Template (copy), ItemImageFinder (ref), SoundService (ref), u40 (copy), GuiController (ref), u39 (copy), u27 (ref), UDim2_fromScale_ret (ref)
        local Data2 = DataService:GetData();

        if Data2 then
            Data2 = Data2.BasketDeliveryData;
        end;

        local v44 = Data2 and Data2.PendingRewards or {};
        u28:Clean();
        table.clear(u41);

        for _, child in Items:GetChildren() do
            if child:IsA("GuiObject") then
                child:Destroy();
            end;
        end;

        for i, v in v44 do
            local v45 = u28:Clone(Template);
            v45.Visible = true;
            v45.LayoutOrder = i;
            local Title = v45:FindFirstChild("Title");
            local Vector = v45:FindFirstChild("Vector");
            local v46 = v.ItemAmount or 1;

            if Title then
                Title.Text = v46 > 1 and `x{v46} {v.ItemName}` or v.ItemName;
            end;

            if Vector then
                Vector.Image = ItemImageFinder(v.ItemName, v.ItemType);
            end;

            u28:Add(v45.Activated:Once(function() -- Line: 278
                -- upvalues: SoundService (ref), u40 (ref), v (copy), GuiController (ref), u39 (ref), u28 (ref), u27 (ref)
                SoundService:PlayLocalSound(SoundService.Click);

                if u40 then
                    u40:FireServer(v.UUID);
                end;

                GuiController:Close(u39);
                u28:Clean();
                u27:Clean();
            end));
            v45.Size = UDim2_fromScale_ret;
            local UIScale = Instance.new("UIScale");
            UIScale.Scale = 1;
            UIScale.Parent = v45;
            table.insert(u41, {
                Card = v45,
                Scale = UIScale
            });
            v45.Parent = Items;
        end;
    end;

    renderCards();

    local function stampOf() -- Line: 304
        -- upvalues: DataService (ref)
        local Data2 = DataService:GetData();

        if Data2 then
            Data2 = Data2.BasketDeliveryData;
        end;

        local v47 = {};

        for _, v in Data2 and Data2.PendingRewards or {} do
            local v48 = tostring(v.UUID);
            table.insert(v47, v48);
        end;

        return table.concat(v47, "|");
    end;

    local u49 = stampOf();
    pcall(function() -- Line: 314
        -- upvalues: u27 (ref), DataService (ref), stampOf (copy), u49 (ref), renderCards (copy)
        u27:Add(DataService:GetPathSignal("BasketDeliveryData/@"):Connect(function() -- Line: 315
            -- upvalues: stampOf (ref), u49 (ref), renderCards (ref)
            local v50 = stampOf();

            if v50 == u49 or v50 == "" then
                return;
            end;

            u49 = v50;
            renderCards();
        end));
    end);
    local RerollButton = u39.Frame:FindFirstChild("RerollButton", true);

    if RerollButton then
        RerollButton.Visible = true;
        MarketController:SetPriceLabel(RerollButton:FindFirstChild("Price") or RerollButton, Config.REROLL_PRODUCT_ID, Config.DISPLAY.REROLL_BUTTON);
        u27:Add(RerollButton.Activated:Connect(function() -- Line: 330
            -- upvalues: SoundService (ref), MarketController (ref), Config (ref)
            SoundService:PlayLocalSound(SoundService.Click);
            MarketController:PromptPurchase(Config.REROLL_PRODUCT_ID, Enum.InfoType.Product);
        end));
    end;

    local TierOddsButton = u39.Frame:FindFirstChild("TierOddsButton");

    if TierOddsButton then
        TierOddsButton.Visible = true;
        u27:Add(TierOddsButton.Activated:Connect(function() -- Line: 340
            -- upvalues: SoundService (ref), GuiController (ref), u39 (copy), u2 (ref)
            SoundService:PlayLocalSound(SoundService.Click);
            GuiController:Close(u39);
            u2:OpenTierOdds(u39);
        end));
    end;

    GuiController:Open(u39);
    u27:Add(u39.Frame.ExitButton.Activated:Once(function() -- Line: 348
        -- upvalues: GuiController (ref), u39 (copy), u28 (ref), u27 (ref)
        GuiController:Close(u39);
        u28:Clean();
        u27:Clean();
    end));
end;

local function bind(u51: userdata) -- Line: 357
    -- upvalues: u5 (ref), u4 (copy), Config (ref), ItemImageFinder (copy), u6 (ref), DataService (copy), RunService (copy), u2 (copy), LocalPlayer (copy), describeSplit (copy)
    if u5 == u51 then
        return;
    end;

    local u52;

    if u51 then
        u52 = u51:WaitForChild("Basket", 10);
    else
        u52 = nil;
    end;

    local u53;

    if u52 then
        u53 = u52:WaitForChild("FruitBounds", 10);
    else
        u53 = nil;
    end;

    local v54;

    if u51 then
        v54 = u51:WaitForChild("BasketUI", 10);
    else
        v54 = nil;
    end;

    local v55;

    if v54 then
        v55 = v54:WaitForChild("Billboard", 10);
    else
        v55 = nil;
    end;

    local u56;

    if v55 then
        u56 = v55:WaitForChild("Title", 10);
    else
        u56 = nil;
    end;

    local u57;

    if v55 then
        u57 = v55:WaitForChild("Mutation", 3);
    else
        u57 = nil;
    end;

    local u58;

    if v55 then
        u58 = v55:WaitForChild("FruitIcon", 3);
    else
        u58 = nil;
    end;

    if not (u52 and u53) then
        warn("BasketDeliveryController | Basket/FruitBounds missing on the Part 3 model");

        return;
    end;

    if not u51:IsDescendantOf(workspace) then
        return;
    end;

    if u5 == u51 then
        return;
    end;

    u4:Clean();
    u5 = u51;
    local Pivot = u52:GetPivot();
    local Attribute = u51:GetAttribute(Config.TOP_CFRAME_ATTRIBUTE);
    u4:Add(u51:GetAttributeChangedSignal(Config.TOP_CFRAME_ATTRIBUTE):Connect(function() -- Line: 379
        -- upvalues: Attribute (ref), u51 (copy), Config (ref)
        Attribute = u51:GetAttribute(Config.TOP_CFRAME_ATTRIBUTE);
    end));
    u4:Add(function() -- Line: 384
        -- upvalues: u52 (copy), Pivot (copy)
        if u52 and u52.Parent then
            u52:PivotTo(Pivot);
        end;
    end);
    local u59 = {};
    local u60 = {};

    for _, descendant in u52:GetDescendants() do
        if descendant:IsA("BasePart") and descendant ~= u53 then
            table.insert(u59, descendant);
            u60[descendant] = descendant.CanCollide;
        end;
    end;

    u4:Add(function() -- Line: 398
        -- upvalues: u60 (copy)
        for i, v in u60 do
            if i.Parent then
                i.CanCollide = v;
            end;
        end;
    end);
    local u61 = nil;

    local function setCollisions(p62: boolean) -- Line: 405
        -- upvalues: u61 (ref), u59 (copy)
        if u61 == p62 then
            return;
        end;

        u61 = p62;

        for _, v in u59 do
            v.CanCollide = p62;
        end;
    end;

    if u61 ~= true then
        u61 = true;

        for _, v in u59 do
            v.CanCollide = true;
        end;
    end;

    local function showFruit(p63) -- Line: 419
        -- upvalues: u58 (copy), ItemImageFinder (ref)
        if not u58 then
            return;
        end;

        if not p63 then
            u58.Visible = false;

            return;
        end;

        u58.Image = ItemImageFinder(p63.Plant, "Fruit");
        u58.Visible = true;
    end;

    u4:Add(function() -- Line: 429
        -- upvalues: u58 (copy)
        if not u58 then
            return;
        end;

        u58.Visible = false;
    end);
    local u64 = 0;
    local u65 = false;
    u6 = "idle";
    u4:Add(function() -- Line: 437
        -- upvalues: u6 (ref)
        u6 = "idle";
    end);

    local function setPhase(p66: string) -- Line: 439
        -- upvalues: u6 (ref), u64 (ref)
        u6 = p66;
        u64 = os.clock();
    end;

    local u67 = nil;

    local function onIndexChanged() -- Line: 445
        -- upvalues: DataService (ref), u67 (ref), u6 (ref), u65 (ref), u64 (ref)
        local Data = DataService:GetData();

        if Data then
            Data = Data.BasketDeliveryData;
        end;

        if not Data then
            return;
        end;

        local v68 = Data.Index or 1;

        if u67 ~= nil and (v68 ~= u67 and u6 == "idle") then
            u65 = true;
            u6 = "rising";
            u64 = os.clock();
        end;

        u67 = v68;
    end;

    pcall(function() -- Line: 457
        -- upvalues: u4 (ref), DataService (ref), onIndexChanged (copy)
        u4:Add(DataService:GetPathSignal("BasketDeliveryData/Index"):Connect(onIndexChanged));
    end);
    local Data = DataService:GetData();

    if Data then
        Data = Data.BasketDeliveryData;
    end;

    if Data then
        local v69 = Data.Index or 1;

        if u67 ~= nil and (v69 ~= u67 and u6 == "idle") then
            u65 = true;
            u6 = "rising";
            u64 = os.clock();
        end;

        u67 = v69;
    end;

    local FRUIT = Config.FRUIT;
    local u70 = FRUIT.ACTIVE_DISTANCE or 250;
    local u71 = false;
    u4:Add(RunService.Heartbeat:Connect(function(p72) -- Line: 471
        -- upvalues: u6 (ref), Config (ref), u64 (ref), Attribute (ref), u52 (copy), Pivot (copy), u65 (ref), u2 (ref)
        if u6 == "idle" then
            return;
        end;

        local TRAVEL = Config.TRAVEL;
        local v73 = os.clock() - u64;

        if u6 == "rising" and Attribute then
            local v74 = v73 / math.max(TRAVEL.RISE or 3.5, 0.01);
            local math_clamp_ret = math.clamp(v74, 0, 1);
            local v75 = math_clamp_ret * math_clamp_ret * (3 - math_clamp_ret * 2);
            u52:PivotTo(Pivot:Lerp(Attribute, v75));

            if v75 >= 1 then
                u6 = "holding";
                u64 = os.clock();
            end;
        elseif u6 == "holding" then
            if (TRAVEL.HOLD or 1.5) <= v73 then
                u6 = "returning";
                u64 = os.clock();
            end;
        elseif u6 == "returning" and Attribute then
            local v76 = v73 / math.max(TRAVEL.RETURN or 3, 0.01);
            local math_clamp_ret = math.clamp(v76, 0, 1);
            local v77 = math_clamp_ret * math_clamp_ret * (3 - math_clamp_ret * 2);
            u52:PivotTo(Attribute:Lerp(Pivot, v77));

            if v77 >= 1 then
                u52:PivotTo(Pivot);
                u6 = "idle";
                u64 = os.clock();

                if u65 then
                    u65 = false;
                    task.spawn(function() -- Line: 492
                        -- upvalues: u2 (ref)
                        u2:OpenRewards();
                    end);
                end;
            end;
        elseif u6 ~= "idle" and not Attribute then
            u6 = "idle";
            u64 = os.clock();

            if u65 then
                u65 = false;
                task.spawn(function() -- Line: 501
                    -- upvalues: u2 (ref)
                    u2:OpenRewards();
                end);
            end;
        end;
    end));
    u4:Add(task.spawn(function() -- Line: 509
        -- upvalues: u71 (ref), FRUIT (copy), u53 (copy), LocalPlayer (ref), u70 (copy), u6 (ref), u51 (copy), DataService (ref), Config (ref), u58 (copy), ItemImageFinder (ref), u61 (ref), u59 (copy), u56 (copy), describeSplit (ref), u57 (copy)
        while true do
            task.wait(u71 and (FRUIT.UPDATE_RATE or 0.05) or 0.5);
            local v78 = u53;
            local Character = LocalPlayer.Character;

            if Character then
                Character = Character:FindFirstChild("HumanoidRootPart");
            end;

            u71 = (not (v78 and Character) and (1 / 0) or (Character.Position - v78.Position).Magnitude) <= u70;

            if (u71 or u6 ~= "idle") and u51:IsDescendantOf(workspace) then
                local Data2 = DataService:GetData();

                if Data2 then
                    Data2 = Data2.BasketDeliveryData;
                end;

                local v79 = Data2 and (Data2.Index or 1) or 1;
                local v80 = Config.SUBMISSIONS or {};
                local v81;

                if #v80 == 0 then
                    v81 = nil;
                else
                    v81 = v80[(v79 - 1) % #v80 + 1];
                end;

                local v82;

                if u6 == "idle" then
                    v82 = v81;
                else
                    v82 = nil;
                end;

                if u58 then
                    if v82 then
                        u58.Image = ItemImageFinder(v82.Plant, "Fruit");
                        u58.Visible = true;
                    else
                        u58.Visible = false;
                    end;
                end;

                local v83 = u6 == "idle";

                if u61 ~= v83 then
                    u61 = v83;

                    for _, v in u59 do
                        v.CanCollide = v83;
                    end;
                end;

                if u56 then
                    local DISPLAY = Config.DISPLAY;
                    local v84, v85 = describeSplit(v81);

                    if u6 == "rising" or u6 == "holding" then
                        u56.Text = DISPLAY.DELIVERING;
                        v85 = "";
                    elseif u6 == "returning" then
                        u56.Text = DISPLAY.RETURNING;
                        v85 = "";
                    elseif Data2 and #(Data2.PendingRewards or {}) > 0 then
                        u56.Text = DISPLAY.CHOOSE;
                        v85 = "";
                    else
                        u56.Text = v84;
                    end;

                    if u57 then
                        u57.Text = v85;
                        u57.Visible = v85 ~= "";
                    end;
                end;
            end;
        end;
    end));
end;

local function unbind(p86: userdata) -- Line: 551
    -- upvalues: u5 (ref), u4 (copy)
    if u5 ~= p86 then
        return;
    end;

    u4:Clean();
    u5 = nil;
end;

function u2.GetBoundModel(p87) -- Line: 557
    -- upvalues: u5 (ref)
    return u5;
end;

function u2.IsBusy(p88) -- Line: 561
    -- upvalues: u6 (ref)
    return u6 ~= "idle";
end;

local function tryBindExisting() -- Line: 565
    -- upvalues: CollectionService (copy), Config (ref), bind (copy)
    local v89 = CollectionService:GetTagged(Config.MODEL_TAG)[1];

    if v89 and (v89:IsA("Model") and v89:IsDescendantOf(workspace)) then
        bind(v89);
    end;
end;

local function startWatching() -- Line: 573
    -- upvalues: u3 (copy), CollectionService (copy), Config (ref), bind (copy), u5 (ref), u4 (copy), tryBindExisting (copy)
    u3:Add(CollectionService:GetInstanceAddedSignal(Config.MODEL_TAG):Connect(function(p90) -- Line: 574
        -- upvalues: bind (ref)
        if p90:IsA("Model") then
            task.defer(bind, p90);
        end;
    end));
    u3:Add(CollectionService:GetInstanceRemovedSignal(Config.MODEL_TAG):Connect(function(p91) -- Line: 579
        -- upvalues: u5 (ref), u4 (ref)
        if p91:IsA("Model") then
            if u5 ~= p91 then
                return;
            end;

            u4:Clean();
            u5 = nil;
        end;
    end));
    u3:Add(function() -- Line: 584
        -- upvalues: u5 (ref), u4 (ref)
        if u5 then
            if u5 ~= u5 then
                return;
            end;

            u4:Clean();
            u5 = nil;
        end;
    end);
    task.spawn(tryBindExisting);
end;

local u92 = false;
EventRotationController.EventUpdated:Connect(function(p93: string, p94: string) -- Line: 591, Name: OnEventUpdated
    -- upvalues: u3 (copy), u92 (ref), EventRotationUtils (copy), startWatching (copy)
    if p94 ~= "BeanstalkEvent" then
        u3:Clean();
        u92 = false;

        return;
    end;

    local EventInSetIndex = EventRotationUtils:GetEventInSetIndex(p93, p94);

    if not EventInSetIndex then
        return;
    end;

    if EventInSetIndex < 3 then
        return;
    end;

    if u92 then
        return;
    end;

    u92 = true;
    u3:Clean();
    startWatching();
end);
local LoadedEvent = EventRotationController:GetLoadedEvent();

if LoadedEvent and LoadedEvent.EventSet == "BeanstalkEvent" then
    local EventID = LoadedEvent.EventID;
    local EventSet = LoadedEvent.EventSet;

    if EventSet == "BeanstalkEvent" then
        local EventInSetIndex = EventRotationUtils:GetEventInSetIndex(EventID, EventSet);

        if EventInSetIndex and (EventInSetIndex >= 3 and not u92) then
            u92 = true;
            u3:Clean();
            startWatching();
        end;
    else
        u3:Clean();
        u92 = false;
    end;
end;

return u2;