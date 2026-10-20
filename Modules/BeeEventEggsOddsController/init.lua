-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local GuiController = require(ReplicatedStorage.Modules.GuiController);
local BeeEggRegistry = require(ReplicatedStorage.Data.BeeEvent.BeeEggRegistry);
local BeeRegistry = require(ReplicatedStorage.Data.BeeEvent.BeeRegistry);
local Trove = require(ReplicatedStorage.Modules.Trove);
local OpenBeeEventEggOddsRE = ReplicatedStorage.GameEvents.OddsUI.OpenBeeEventEggOddsRE;
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui");
local Odds_UI = PlayerGui:WaitForChild("Odds_UI");
local Items = Odds_UI.Frame.Main.Items;
local script_OddsAttachment = script.OddsAttachment;
local u1 = {
    ScreenTrove = nil,
    BillboardTrove = nil,
    BillboardCtx = nil,
    Stack = {},
    BillboardStack = {}
};

local function GetBeeIcon(p2: string) -- Line: 42
    -- upvalues: BeeRegistry (copy)
    local v3 = BeeRegistry[p2];

    if v3 then
        return v3.Icon;
    end;

    return nil;
end;

function u1.CleanupCurrentScreen(p4) -- Line: 52
    if p4.ScreenTrove then
        p4.ScreenTrove:Destroy();
        p4.ScreenTrove = nil;
    end;
end;

function u1.ClearEntries(p5: table, p6: userdata) -- Line: 59
    for _, child in p6.ScrollingFrame:GetChildren() do
        if child:IsA("GuiObject") and child.Name ~= "UIListLayout" then
            child:Destroy();
        end;
    end;
end;

function u1.CloseCurrent(p7) -- Line: 67
    -- upvalues: GuiController (copy), Odds_UI (copy)
    p7:CleanupCurrentScreen();
    table.clear(p7.Stack);
    GuiController:Close(Odds_UI);
end;

function u1.GoBack(p8) -- Line: 73
    -- upvalues: GuiController (copy), Odds_UI (copy)
    if #p8.Stack > 1 then
        table.remove(p8.Stack, #p8.Stack);
        p8:RenderCurrent();

        return;
    end;

    local v9 = p8.Stack[1];
    p8:CleanupCurrentScreen();
    table.clear(p8.Stack);
    GuiController:Close(Odds_UI);

    if v9 and v9.Breadcrumb then
        GuiController:Open(v9.Breadcrumb);
    end;
end;

function u1.RenderEntries(p10: table, p11: table) -- Line: 90
    -- upvalues: BeeEggRegistry (copy), BeeRegistry (copy), RunService (copy)
    local v12 = p11.Stack[#p11.Stack];

    if not v12 then
        return;
    end;

    local EggName = v12.EggName;
    local v13 = BeeEggRegistry.Entries[EggName];

    if not v13 then
        warn((`Bee egg '{EggName}' not found in BeeEggRegistry`));

        return;
    end;

    p10:ClearEntries(p11.Container);

    if p11.RenderTrove then
        p11.RenderTrove:Destroy();
    end;

    local v14 = p11.Trove:Extend();
    p11.RenderTrove = v14;
    local v15 = 0;

    for _, v in v13.BeeWeights do
        v15 = v15 + v.Weight;
    end;

    local v16 = {};

    for _, v in v13.BeeWeights do
        table.insert(v16, {
            Name = v.BeeName,
            Odd = v15 <= 0 and 0 or v.Weight / v15 * 100
        });
    end;

    table.sort(v16, function(p17, p18) -- Line: 130
        return p17.Odd < p18.Odd;
    end);
    local v19 = (1 / 0);
    local v20 = nil;
    local v21 = true;

    for _, v in v16 do
        if v.Odd < v19 then
            v19 = v.Odd;
        end;
    end;

    for _, v in v16 do
        if math.abs(v.Odd - v19) > 1e-6 then
            v21 = false;

            if v20 == nil or v.Odd < v20 then
                v20 = v.Odd;
            end;
        end;
    end;

    local ScrollingFrame = p11.Container.ScrollingFrame;

    for _, v in v16 do
        local v22 = not v21 and math.abs(v.Odd - v19) < 1e-6;
        local v23;

        if v20 == nil then
            v23 = false;
        else
            v23 = math.abs(v.Odd - v20) < 1e-6;
        end;

        local v24;

        if v22 then
            v24 = ScrollingFrame.UIListLayout.TemplateRainbow;
        elseif v23 then
            v24 = ScrollingFrame.UIListLayout.TemplateBigger;
        else
            v24 = ScrollingFrame.UIListLayout.TemplateSmaller;
        end;

        local u25 = v14:Clone(v24);
        local v26 = math.round(v.Odd * 100) / 100;
        local v27 = BeeRegistry[v.Name];
        local v28;

        if v27 then
            v28 = v27.Icon;
        else
            v28 = nil;
        end;

        u25.LayoutOrder = -math.floor(v.Odd * 1000);
        u25.Title.Text = v.Name;
        u25.Odds.Text = `{v26}%`;
        u25.Vector.Image = v28 or "";
        u25.Vector.Visible = v28 ~= nil;

        if u25:FindFirstChild("OddsButton") then
            u25.OddsButton.Visible = false;
        end;

        if v22 then
            v14:Add(RunService.PostSimulation:Connect(function() -- Line: 182
                -- upvalues: u25 (copy)
                if not u25.Parent then
                    return;
                end;

                local Color3_fromHSV_ret = Color3.fromHSV(os.clock() % 5 / 5, 1, 1);
                u25.Odds.TextColor3 = Color3_fromHSV_ret;
                u25.Title.TextColor3 = Color3_fromHSV_ret;
            end));
        elseif v23 then
            local Color3_fromRGB_ret = Color3.fromRGB(255, 204, 1);
            u25.Odds.TextColor3 = Color3_fromRGB_ret;
            u25.Title.TextColor3 = Color3_fromRGB_ret;
        end;

        u25.Title.TextScaled = true;
        u25.Odds.TextScaled = true;
        u25.Parent = ScrollingFrame;
    end;

    v14:Add(ScrollingFrame:GetPropertyChangedSignal("AbsoluteCanvasSize"):Connect(function() -- Line: 201
        -- upvalues: ScrollingFrame (copy)
        if ScrollingFrame.AbsoluteCanvasSize.X > ScrollingFrame.AbsoluteWindowSize.X then
            ScrollingFrame.UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left;

            return;
        end;

        ScrollingFrame.UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center;
    end));
end;

function u1.RenderCurrent(u29) -- Line: 210
    -- upvalues: BeeEggRegistry (copy), Trove (copy), Items (copy), Odds_UI (copy)
    local v30 = u29.Stack[#u29.Stack];

    if not v30 then
        u29:CloseCurrent();

        return;
    end;

    if not BeeEggRegistry.Entries[v30.EggName] then
        warn((`Bee egg '{v30.EggName}' not found in BeeEggRegistry`));
        u29:GoBack();

        return;
    end;

    u29:CleanupCurrentScreen();
    local v31 = Trove.new();
    u29.ScreenTrove = v31;
    u29:RenderEntries({
        IsScreen = true,
        Container = Items,
        Trove = v31,
        Stack = u29.Stack
    });
    v31:Add(Odds_UI.Frame.ExitButton.Activated:Connect(function() -- Line: 238
        -- upvalues: u29 (copy)
        u29:GoBack();
    end));
    Odds_UI.Frame.ExpandButton.Visible = false;
end;

function u1.CleanupBillboard(p32) -- Line: 245
    p32.BillboardCtx = nil;

    if p32.BillboardTrove then
        p32.BillboardTrove:Destroy();
        p32.BillboardTrove = nil;
        table.clear(p32.BillboardStack);
    end;
end;

function u1.OpenBillboard(u33: table, p34: userdata, p35: string, u36: function?) -- Line: 255
    -- upvalues: script_OddsAttachment (copy), PlayerGui (copy), Odds_UI (copy), Trove (copy)
    u33:CleanupBillboard();
    local OddsBillboardGui = script_OddsAttachment:Clone().OddsBillboardGui;
    OddsBillboardGui.Adornee = p34;
    OddsBillboardGui.Parent = PlayerGui;
    local v37 = Odds_UI.Frame:Clone();
    v37.Parent = OddsBillboardGui;
    v37.Size = UDim2.new(1, 0, 1, 0);
    local v38 = Trove.new();
    v38:Add(OddsBillboardGui);
    u33.BillboardTrove = v38;
    table.clear(u33.BillboardStack);
    table.insert(u33.BillboardStack, {
        EggName = p35
    });
    local u39 = {
        IsScreen = false,
        Container = v37.Main.Items,
        Trove = v38,
        Stack = u33.BillboardStack
    };
    u33.BillboardCtx = u39;
    v37.ExpandButton.Visible = true;
    v38:Add(v37.ExitButton.Activated:Connect(function() -- Line: 288
        -- upvalues: u33 (copy), u39 (copy), u36 (copy)
        if #u33.BillboardStack > 1 then
            table.remove(u33.BillboardStack, #u33.BillboardStack);
            u33:RenderEntries(u39);

            return;
        end;

        u33:CleanupBillboard();

        if u36 then
            u36();
        end;
    end));
    v38:Add(v37.ExpandButton.Activated:Connect(function() -- Line: 301
        -- upvalues: u33 (copy)
        local v40 = u33.BillboardStack[1];

        if not v40 then
            return;
        end;

        u33:Open(v40.EggName);
    end));
    u33:RenderEntries(u39);
end;

function u1.Open(p41: table, p42: string, p43: userdata?) -- Line: 314
    -- upvalues: GuiController (copy), Odds_UI (copy)
    table.clear(p41.Stack);
    table.insert(p41.Stack, {
        EggName = p42,
        Breadcrumb = p43
    });
    p41:RenderCurrent();
    GuiController:Open(Odds_UI);
end;

function u1.Start(p44) -- Line: 325
    -- upvalues: GuiController (copy), Odds_UI (copy)
    GuiController:UsePopupAnims(Odds_UI);
end;

OpenBeeEventEggOddsRE.OnClientEvent:Connect(function(p45: string, p46: userdata) -- Line: 329
    -- upvalues: u1 (copy)
    u1:OpenBillboard(p46, p45);
end);
task.spawn(u1.Start, u1);

return u1;