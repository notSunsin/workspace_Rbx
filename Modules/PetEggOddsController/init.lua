-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local PityHoverController = require(ReplicatedStorage.Modules.PityHoverController);
local GuiController = require(ReplicatedStorage.Modules.GuiController);
local PetEggs = require(ReplicatedStorage.Data.PetRegistry.PetEggs);
local PetRegistry = require(ReplicatedStorage.Data.PetRegistry);
local PityData = require(ReplicatedStorage.Data.PityData);
local Trove = require(ReplicatedStorage.Modules.Trove);
local PetUtilities = require(ReplicatedStorage.Modules.PetServices.PetUtilities);
local ItemInfoHover = require(ReplicatedStorage.Modules.UIComponents.ItemInfoHover);
local DisclaimerPresets = require(ReplicatedStorage.Modules.UIComponents.DisclaimerPresets);
local OpenPetEggOddsRE = ReplicatedStorage.GameEvents.OddsUI.OpenPetEggOddsRE;
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui");
local Odds_UI = PlayerGui:WaitForChild("Odds_UI");
local Items = Odds_UI.Frame.Main.Items;
local script_OddsAttachment = script.OddsAttachment;
local u1 = {};
local PetList = PetRegistry.PetList;
local u2 = {
    ScreenTrove = nil,
    BillboardTrove = nil,
    BillboardCtx = nil,
    Stack = {},
    BillboardStack = {}
};

local function ApplyParentChance(p3: number, p4: number?) -- Line: 65
    if p4 == nil then
        return p3;
    end;

    return p3 * (p4 / 100);
end;

local function ComposeNestedParentChance(p5: number?, p6: number) -- Line: 73
    if p5 == nil then
        return p6;
    end;

    return p5 * (p6 / 100);
end;

local function FormatPercent(p7: number, p8: boolean?) -- Line: 81
    return p7 > 0 and p7 < 0.01 and (p8 and "&lt;0.01%" or "<0.01%") or `{math.round(p7 * 100) / 100}%`;
end;

local function GetNestedEggName(p9: string) -- Line: 89
    return p9:match("^Egg/(.+)$");
end;

local function ApplyDisclaimer(p10: userdata, p11: string?) -- Line: 100
    -- upvalues: DisclaimerPresets (copy)
    local Parent = p10.Parent;

    if Parent then
        Parent = Parent.Parent;
    end;

    if not Parent then
        return;
    end;

    local Disclaimer = Parent:FindFirstChild("Disclaimer");

    if Disclaimer and Disclaimer:IsA("TextLabel") then
        Disclaimer.Text = DisclaimerPresets.Resolve(p11);
    end;
end;

function u2.CleanupCurrentScreen(p12) -- Line: 113
    if p12.ScreenTrove then
        p12.ScreenTrove:Destroy();
        p12.ScreenTrove = nil;
    end;
end;

function u2.ClearEntries(p13: table, p14: userdata) -- Line: 120
    for _, child in p14.ScrollingFrame:GetChildren() do
        if child:IsA("GuiObject") and (child.Name ~= "UIListLayout" and not child:IsDescendantOf(p14.ScrollingFrame.UIListLayout)) then
            child:Destroy();
        end;
    end;
end;

function u2.CloseCurrent(p15) -- Line: 128
    -- upvalues: ItemInfoHover (copy), u1 (copy), GuiController (copy), Odds_UI (copy)
    ItemInfoHover:RemoveRewardTable("PetEggOdds", u1);
    table.clear(u1);
    p15:CleanupCurrentScreen();
    table.clear(p15.Stack);
    GuiController:Close(Odds_UI);
end;

function u2.GoBack(p16) -- Line: 136
    -- upvalues: GuiController (copy), Odds_UI (copy)
    if #p16.Stack > 1 then
        table.remove(p16.Stack, #p16.Stack);
        p16:RenderCurrent();

        return;
    end;

    local v17 = p16.Stack[1];
    p16:CleanupCurrentScreen();
    table.clear(p16.Stack);
    GuiController:Close(Odds_UI);

    if v17 and v17.Breadcrumb then
        GuiController:Open(v17.Breadcrumb);
    end;
end;

function u2.RenderEntries(u18: table, u19: table) -- Line: 153
    -- upvalues: PetEggs (copy), u1 (copy), ItemInfoHover (copy), DisclaimerPresets (copy), PityData (copy), PetUtilities (copy), PityHoverController (copy), PetList (copy), RunService (copy)
    local u20 = u19.Stack[#u19.Stack];

    if not u20 then
        return;
    end;

    local EggName = u20.EggName;
    local v21 = PetEggs[EggName];

    if not v21 then
        warn((`Egg '{EggName}' not found in PetEggs`));

        return;
    end;

    for i, _ in v21.RarityData.Items do
        table.insert(u1, {
            Type = "Pet",
            Value = i
        });
    end;

    ItemInfoHover:AddRewardTable("PetEggOdds", u1);
    local Disclaimer = u20.Disclaimer;
    local Parent = u19.Container.Parent;

    if Parent then
        Parent = Parent.Parent;
    end;

    if Parent then
        local Disclaimer2 = Parent:FindFirstChild("Disclaimer");

        if Disclaimer2 and Disclaimer2:IsA("TextLabel") then
            Disclaimer2.Text = DisclaimerPresets.Resolve(Disclaimer);
        end;
    end;

    local v22;

    if u20.PityName then
        v22 = PityData[u20.PityName];
    else
        v22 = nil;
    end;

    local v23 = EggName:find("^Rainbow Premium") or EggName:find("^Festive Premium");
    u18:ClearEntries(u19.Container);

    if u19.RenderTrove then
        u19.RenderTrove:Destroy();
    end;

    local v24 = u19.Trove:Extend();
    u19.RenderTrove = v24;
    local v25 = u20.EggBoostAmount or 0;
    local v26 = u20.CurrentEggBoostAmount or 0;
    local v27 = v25 ~= v26;
    local Items2 = v21.RarityData.Items;
    local v28;

    if v26 > 0 then
        v28 = PetUtilities:GetBoostedRarityData(v21.RarityData, v26).Items;
    else
        v28 = Items2;
    end;

    local v29;

    if v25 > 0 then
        v29 = PetUtilities:GetBoostedRarityData(v21.RarityData, v25).Items;
    else
        v29 = Items2;
    end;

    local v30 = {};

    for i, v in v29 do
        local v31 = {
            Name = i,
            Item = v,
            IsNestedEgg = i:match("^Egg/(.+)$") ~= nil,
            BoostedOdd = v.NormalizedOdd or (v.ItemOdd or 0),
            CurrentOdd = v27 and (v28[i] and (v28[i].NormalizedOdd or (v28[i].ItemOdd or 0)) or 0) or nil,
            RawOdd = Items2[i] and (Items2[i].NormalizedOdd or (Items2[i].ItemOdd or 0)) or 0
        };
        table.insert(v30, v31);
    end;

    table.sort(v30, function(p32, p33) -- Line: 212
        if p32.IsNestedEgg == p33.IsNestedEgg then
            return p32.RawOdd > p33.RawOdd;
        end;

        return not p32.IsNestedEgg;
    end);
    local v34 = (1 / 0);
    local v35 = nil;
    local v36 = true;

    for _, v in v30 do
        if not v.IsNestedEgg and v.RawOdd < v34 then
            v34 = v.RawOdd;
        end;
    end;

    for _, v in v30 do
        if not v.IsNestedEgg and math.abs(v.RawOdd - v34) > 1e-6 then
            v36 = false;

            if v35 == nil or v.RawOdd < v35 then
                v35 = v.RawOdd;
            end;
        end;
    end;

    local ScrollingFrame = u19.Container.ScrollingFrame;

    for _, v in v30 do
        local v37 = not (v.IsNestedEgg or v36) and math.abs(v.RawOdd - v34) < 1e-6;
        local v38 = v37 or v.IsNestedEgg;
        local v39 = not v.IsNestedEgg;

        if v39 then
            if v35 == nil then
                v39 = false;
            else
                v39 = math.abs(v.RawOdd - v35) < 1e-6;
            end;
        end;

        local v40;

        if v38 then
            v40 = ScrollingFrame.UIListLayout.TemplateRainbow;
        elseif v39 then
            v40 = ScrollingFrame.UIListLayout.TemplateBigger;
        else
            v40 = ScrollingFrame.UIListLayout.TemplateSmaller;
        end;

        local u41 = v24:Clone(v40);
        local u42 = v.Name:match("^Egg/(.+)$");
        local v43 = u42 or v.Name;
        u41:SetAttribute("UUID", (`PetEggOdds_Pet_{v.Name}`));
        u41:AddTag("ItemInfoHoverTag");
        u41.Title.Text = v43;
        u41.LayoutOrder = v.IsNestedEgg and 1000000 or -math.floor(v.RawOdd * 1000);
        local u44;

        if v22 then
            u44 = v;
            local v45 = 0;

            for _, v2 in v22.Items do
                if v2.RewardId == u44.Name then
                    v45 = v2.Pity;
                    break;
                end;
            end;

            if v45 > 0 then
                local Pity = u41.Pity;
                Pity.Text = `{v45}*`;
                Pity.Visible = true;
                PityHoverController:AddGuiObject(u41, v45, v22.DisplayPlural);
                u19.Trove:Add(function() -- Line: 295
                    -- upvalues: PityHoverController (ref), u41 (copy)
                    PityHoverController:RemoveGuiObject(u41);
                end);
            end;
        else
            u44 = v;
        end;

        local BoostedOdd = u44.BoostedOdd;
        local ParentChancePercent = u20.ParentChancePercent;

        if ParentChancePercent ~= nil then
            BoostedOdd = BoostedOdd * (ParentChancePercent / 100);
        end;

        if v27 then
            local v46;

            if u44.CurrentOdd then
                local CurrentOdd = u44.CurrentOdd;
                local ParentChancePercent2 = u20.ParentChancePercent;

                if ParentChancePercent2 ~= nil then
                    CurrentOdd = CurrentOdd * (ParentChancePercent2 / 100);
                end;

                v46 = CurrentOdd or 0;
            else
                v46 = 0;
            end;

            u41.Odds.RichText = true;
            u41.Odds.Text = `<font size="13" color="#FF0000"><s>{v46 > 0 and v46 < 0.01 and "&lt;0.01%" or `{math.round(v46 * 100) / 100}%`}</s></font> <font size="20" color="#00FF00">{BoostedOdd > 0 and BoostedOdd < 0.01 and "&lt;0.01%" or `{math.round(BoostedOdd * 100) / 100}%`}</font>`;
        else
            u41.Odds.Text = BoostedOdd > 0 and BoostedOdd < 0.01 and "<0.01%" or `{math.round(BoostedOdd * 100) / 100}%`;
        end;

        if u42 then
            local v47 = PetEggs[u42];

            if v47 then
                v47 = v47.Icon;
            end;

            u41.Vector.Image = v47 or "";
            u41.Vector.Visible = v47 ~= nil;

            if u41:FindFirstChild("OddsButton") then
                u41.OddsButton.Visible = true;
                u19.Trove:Add(u41.OddsButton.Activated:Connect(function() -- Line: 321
                    -- upvalues: u19 (copy), u42 (copy), u20 (copy), u44 (copy), u18 (copy)
                    local Stack = u19.Stack;
                    local v48 = {
                        PityName = nil,
                        EggName = u42,
                        Breadcrumb = u20.Breadcrumb
                    };
                    local ParentChancePercent2 = u20.ParentChancePercent;
                    local BoostedOdd2 = u44.BoostedOdd;

                    if ParentChancePercent2 ~= nil then
                        BoostedOdd2 = ParentChancePercent2 * (BoostedOdd2 / 100);
                    end;

                    v48.ParentChancePercent = BoostedOdd2;
                    v48.Disclaimer = u20.Disclaimer;
                    table.insert(Stack, v48);
                    u18:RenderEntries(u19);
                end));
            end;
        else
            local v49 = PetList[u44.Name];

            if v49 then
                local v50 = v49.OddsIcon or v49.Icon;
                u41.Vector.Image = v50 or "";
                u41.Vector.Visible = v50 ~= nil;
            else
                u41.Vector.Visible = false;
            end;

            if u41:FindFirstChild("OddsButton") then
                u41.OddsButton.Visible = false;
            end;
        end;

        if v38 or v23 then
            v24:Add(RunService.PostSimulation:Connect(function() -- Line: 353
                -- upvalues: u41 (copy)
                local Color3_fromHSV_ret = Color3.fromHSV(os.clock() % 5 / 5, 1, 1);
                u41.Odds.TextColor3 = Color3_fromHSV_ret;
                u41.Title.TextColor3 = Color3_fromHSV_ret;
            end));
        elseif v39 then
            local Color3_fromRGB_ret = Color3.fromRGB(255, 204, 1);
            u41.Odds.TextColor3 = Color3_fromRGB_ret;
            u41.Title.TextColor3 = Color3_fromRGB_ret;
        end;

        u41.Title.TextScaled = true;
        u41.Odds.TextScaled = true;
        u41.Parent = ScrollingFrame;
    end;

    v24:Add(ScrollingFrame:GetPropertyChangedSignal("AbsoluteCanvasSize"):Connect(function() -- Line: 369
        -- upvalues: ScrollingFrame (copy)
        if ScrollingFrame.AbsoluteCanvasSize.X > ScrollingFrame.AbsoluteWindowSize.X then
            ScrollingFrame.UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left;

            return;
        end;

        ScrollingFrame.UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center;
    end));
end;

function u2.RenderCurrent(u51) -- Line: 378
    -- upvalues: PetEggs (copy), Trove (copy), Items (copy), Odds_UI (copy)
    local v52 = u51.Stack[#u51.Stack];

    if not v52 then
        u51:CloseCurrent();

        return;
    end;

    if not PetEggs[v52.EggName] then
        warn((`Egg '{v52.EggName}' not found in PetEggs`));
        u51:GoBack();

        return;
    end;

    u51:CleanupCurrentScreen();
    local v53 = Trove.new();
    u51.ScreenTrove = v53;
    u51:RenderEntries({
        IsScreen = true,
        Container = Items,
        Trove = v53,
        Stack = u51.Stack
    });
    v53:Add(Odds_UI.Frame.ExitButton.Activated:Connect(function() -- Line: 405
        -- upvalues: u51 (copy)
        u51:GoBack();
    end));
    Odds_UI.Frame.ExpandButton.Visible = false;
end;

function u2.CleanupBillboard(p54) -- Line: 413
    p54.BillboardCtx = nil;

    if p54.BillboardTrove then
        p54.BillboardTrove:Destroy();
        p54.BillboardTrove = nil;
        table.clear(p54.BillboardStack);
    end;
end;

function u2.OpenBillboard(u55: table, p56: userdata, p57: string, p58: number?, p59: number?, u60: function?) -- Line: 422
    -- upvalues: script_OddsAttachment (copy), PlayerGui (copy), Odds_UI (copy), Trove (copy)
    u55:CleanupBillboard();
    local OddsBillboardGui = script_OddsAttachment:Clone().OddsBillboardGui;
    OddsBillboardGui.Adornee = p56;
    OddsBillboardGui.Parent = PlayerGui;
    local v61 = Odds_UI.Frame:Clone();
    v61.Parent = OddsBillboardGui;
    v61.Size = UDim2.new(1, 0, 1, 0);
    local v62 = Trove.new();
    v62:Add(OddsBillboardGui);
    u55.BillboardTrove = v62;
    table.clear(u55.BillboardStack);
    table.insert(u55.BillboardStack, {
        EggName = p57,
        EggBoostAmount = p58,
        CurrentEggBoostAmount = p59
    });
    local u63 = {
        IsScreen = false,
        Container = v61.Main.Items,
        Trove = v62,
        Stack = u55.BillboardStack
    };
    u55.BillboardCtx = u63;
    v61.ExpandButton.Visible = true;
    v62:Add(v61.ExitButton.Activated:Connect(function() -- Line: 464
        -- upvalues: u55 (copy), u63 (copy), u60 (copy)
        if #u55.BillboardStack > 1 then
            table.remove(u55.BillboardStack, #u55.BillboardStack);
            u55:RenderEntries(u63);

            return;
        end;

        u55:CleanupBillboard();

        if u60 then
            u60();
        end;
    end));
    v62:Add(v61.ExpandButton.Activated:Connect(function() -- Line: 475
        -- upvalues: u55 (copy)
        local v64 = u55.BillboardStack[1];

        if not v64 then
            return;
        end;

        u55:Open(v64.EggName, nil, v64.PityName, v64.EggBoostAmount, nil, v64.Disclaimer);
    end));
    u55:RenderEntries(u63);
end;

function u2.UpdateBillboardBoost(p65: table, p66: number, p67: number) -- Line: 484
    local BillboardCtx = p65.BillboardCtx;

    if not (BillboardCtx and BillboardCtx.Stack[1]) then
        return;
    end;

    BillboardCtx.Stack[1].EggBoostAmount = p66;
    BillboardCtx.Stack[1].CurrentEggBoostAmount = p67;
    p65:RenderEntries(BillboardCtx);
end;

function u2.Open(p68: table, p69: string, p70: userdata?, p71: string?, p72: number?, p73: number?, p74: string?) -- Line: 492
    -- upvalues: GuiController (copy), Odds_UI (copy)
    table.clear(p68.Stack);
    table.insert(p68.Stack, {
        EggName = p69,
        PityName = p71,
        Breadcrumb = p70,
        EggBoostAmount = p72,
        ParentChancePercent = p73,
        Disclaimer = p74
    });
    p68:RenderCurrent();
    GuiController:Open(Odds_UI);
end;

function u2.Start(p75) -- Line: 507
    -- upvalues: GuiController (copy), Odds_UI (copy)
    GuiController:UsePopupAnims(Odds_UI);
end;

OpenPetEggOddsRE.OnClientEvent:Connect(function(p76: string, p77: number, p78: userdata) -- Line: 511
    -- upvalues: u2 (copy)
    u2:OpenBillboard(p78, p76, p77);
end);
task.spawn(u2.Start, u2);

return u2;