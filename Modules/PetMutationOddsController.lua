-- Decompiled with Potassium's decompiler.

local ProximityPromptService = game:GetService("ProximityPromptService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local PetMutationRegistry = require(ReplicatedStorage.Data.PetRegistry.PetMutationRegistry);
local GuiController = require(ReplicatedStorage.Modules.GuiController);
require(ReplicatedStorage.Modules.UpdateService);
local Trove = require(ReplicatedStorage.Modules.Trove);
local PetMutationOdds_UI = Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("PetMutationOdds_UI");
local Holder = PetMutationOdds_UI.Frame.Main.Holder;
local u1 = Trove.new();
local u2 = {};

local function GetMutationItems(p3: boolean) -- Line: 21
    -- upvalues: PetMutationRegistry (copy)
    local v4 = {};
    local v5 = 0;

    for i, v in PetMutationRegistry.PetMutationRegistry do
        local Chance = v.Chance;

        if Chance and Chance ~= 0 and v.Level500Only == true == p3 then
            v5 = v5 + Chance;
            table.insert(v4, {
                Name = i,
                Item = v,
                NormalizedOdd = Chance
            });
        end;
    end;

    if v5 <= 0 then
        return v4;
    end;

    for _, v in v4 do
        v.NormalizedOdd = v.NormalizedOdd / v5 * 100;
    end;

    table.sort(v4, function(p6, p7) -- Line: 51
        return p6.NormalizedOdd > p7.NormalizedOdd;
    end);

    return v4;
end;

local function ApplySpecialTextEffects(u8: any, u9: any, p10: any, u11: any, p12: number) -- Line: 58
    -- upvalues: RunService (copy)
    local bg = u11:FindFirstChild("bg");
    local u13;

    if bg then
        u13 = bg:FindFirstChildOfClass("UIGradient");
    else
        u13 = nil;
    end;

    local v14 = u11:FindFirstChildOfClass("UIStroke");
    local u15;

    if v14 then
        u15 = v14:FindFirstChildOfClass("UIGradient");
    else
        u15 = nil;
    end;

    local function ApplyAnimatedEffect(u16: function) -- Line: 64
        -- upvalues: u8 (copy), u9 (copy), RunService (ref)
        local u17 = nil;
        u8:Add(u9.Visible:Observe(function(p18: boolean) -- Line: 67
            -- upvalues: u17 (ref), u8 (ref), RunService (ref), u16 (copy)
            if p18 and not u17 then
                u17 = u8:Add(RunService.PostSimulation:Connect(u16));

                return;
            end;

            if not p18 and u17 then
                u8:Remove(u17);
                u17 = nil;
            end;
        end));
    end;

    if p10.Name == "Ascended" then
        local function u20() -- Line: 78
            -- upvalues: u11 (copy)
            local v19 = os.clock() * 3.141592653589793;
            local math_sin_ret = math.sin(v19);
            local math_abs_ret = math.abs(math_sin_ret);
            local Color3_fromHSV_ret = Color3.fromHSV(0.16, 0.25, (math.lerp(1, 0.75, math_abs_ret)));
            u11.Odds.TextColor3 = Color3_fromHSV_ret;
            u11.Title.TextColor3 = Color3_fromHSV_ret;
        end;

        local u21 = nil;
        u8:Add(u9.Visible:Observe(function(p22: boolean) -- Line: 67
            -- upvalues: u21 (ref), u8 (copy), RunService (ref), u20 (copy)
            if p22 and not u21 then
                u21 = u8:Add(RunService.PostSimulation:Connect(u20));

                return;
            end;

            if not p22 and u21 then
                u8:Remove(u21);
                u21 = nil;
            end;
        end));

        return;
    end;

    if p10.Name == "Exalted" then
        local function u26() -- Line: 86
            -- upvalues: u11 (copy), u13 (copy)
            local v23 = os.clock() * 3.141592653589793;
            local math_sin_ret = math.sin(v23);
            local math_abs_ret = math.abs(math_sin_ret);
            local Color3_fromRGB = Color3.fromRGB;
            local math_lerp_ret = math.lerp(170, 255, math_abs_ret);
            local math_floor_ret = math.floor(math_lerp_ret);
            local math_lerp_ret2 = math.lerp(105, 205, math_abs_ret);
            local math_floor_ret2 = math.floor(math_lerp_ret2);
            local math_lerp_ret3 = math.lerp(10, 45, math_abs_ret);
            local v24 = Color3_fromRGB(math_floor_ret, math_floor_ret2, (math.floor(math_lerp_ret3)));
            local Color3_fromRGB_ret = Color3.fromRGB(115, 66, 0);
            u11.Odds.TextColor3 = v24;
            u11.Title.TextColor3 = v24;

            if u13 then
                u13.Enabled = true;
                u13.Rotation = os.clock() * 35 % 360;
                local Vector2_new = Vector2.new;
                local v25 = os.clock() * 1.5;
                u13.Offset = Vector2_new(math.sin(v25) * 0.2, 0);
                u13.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3_fromRGB_ret), ColorSequenceKeypoint.new(0.5, v24), ColorSequenceKeypoint.new(1, Color3_fromRGB_ret) });
            end;
        end;

        local u27 = nil;
        u8:Add(u9.Visible:Observe(function(p28: boolean) -- Line: 67
            -- upvalues: u27 (ref), u8 (copy), RunService (ref), u26 (copy)
            if p28 and not u27 then
                u27 = u8:Add(RunService.PostSimulation:Connect(u26));

                return;
            end;

            if not p28 and u27 then
                u8:Remove(u27);
                u27 = nil;
            end;
        end));

        return;
    end;

    if p10.Name == "Iridescent" then
        local function u34() -- Line: 110
            -- upvalues: u11 (copy), u13 (copy)
            local v29 = os.clock() * 3.141592653589793;
            local math_sin_ret = math.sin(v29);
            local math_abs_ret = math.abs(math_sin_ret);
            local Color3_fromRGB = Color3.fromRGB;
            local math_lerp_ret = math.lerp(115, 225, math_abs_ret);
            local math_floor_ret = math.floor(math_lerp_ret);
            local math_lerp_ret2 = math.lerp(55, 175, math_abs_ret);
            local math_floor_ret2 = math.floor(math_lerp_ret2);
            local math_lerp_ret3 = math.lerp(190, 255, math_abs_ret);
            local v30 = Color3_fromRGB(math_floor_ret, math_floor_ret2, (math.floor(math_lerp_ret3)));
            local Color3_fromRGB_ret = Color3.fromRGB(70, 25, 135);
            local Color3_fromRGB_ret2 = Color3.fromRGB(220, 185, 255);
            u11.Odds.TextColor3 = v30;
            u11.Title.TextColor3 = Color3_fromRGB_ret2;

            if u13 then
                u13.Enabled = true;
                u13.Rotation = os.clock() * 40 % 360;
                local Vector2_new = Vector2.new;
                local v31 = os.clock() * 1.75;
                local v32 = math.sin(v31) * 0.25;
                local v33 = os.clock() * 1.25;
                u13.Offset = Vector2_new(v32, math.cos(v33) * 0.12);
                u13.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3_fromRGB_ret), ColorSequenceKeypoint.new(0.45, Color3_fromRGB_ret2), ColorSequenceKeypoint.new(1, Color3_fromRGB_ret) });
            end;
        end;

        local u35 = nil;
        u8:Add(u9.Visible:Observe(function(p36: boolean) -- Line: 67
            -- upvalues: u35 (ref), u8 (copy), RunService (ref), u34 (copy)
            if p36 and not u35 then
                u35 = u8:Add(RunService.PostSimulation:Connect(u34));

                return;
            end;

            if not p36 and u35 then
                u8:Remove(u35);
                u35 = nil;
            end;
        end));

        return;
    end;

    if p10.Name == "Gigantic" then
        local function u41() -- Line: 135
            -- upvalues: u11 (copy), u13 (copy)
            local v37 = os.clock() * 3.141592653589793 * 0.85;
            local math_sin_ret = math.sin(v37);
            local math_abs_ret = math.abs(math_sin_ret);
            local Color3_fromRGB = Color3.fromRGB;
            local math_lerp_ret = math.lerp(130, 255, math_abs_ret);
            local math_floor_ret = math.floor(math_lerp_ret);
            local math_lerp_ret2 = math.lerp(0, 55, math_abs_ret);
            local math_floor_ret2 = math.floor(math_lerp_ret2);
            local math_lerp_ret3 = math.lerp(0, 45, math_abs_ret);
            local v38 = Color3_fromRGB(math_floor_ret, math_floor_ret2, (math.floor(math_lerp_ret3)));
            local Color3_fromRGB_ret = Color3.fromRGB(55, 0, 0);
            local Color3_fromRGB_ret2 = Color3.fromRGB(105, 0, 0);
            u11.Odds.TextColor3 = v38;
            u11.Title.TextColor3 = v38;

            if u13 then
                u13.Enabled = true;
                local v39 = os.clock() * 2;
                u13.Rotation = math.sin(v39) * 18 + 90;
                local Vector2_new = Vector2.new;
                local v40 = os.clock() * 2.5;
                u13.Offset = Vector2_new(math.sin(v40) * 0.3, 0);
                u13.Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, Color3_fromRGB_ret),
                    ColorSequenceKeypoint.new(0.25, v38),
                    ColorSequenceKeypoint.new(0.5, Color3_fromRGB_ret2),
                    ColorSequenceKeypoint.new(0.75, v38),
                    ColorSequenceKeypoint.new(1, Color3_fromRGB_ret)
                });
            end;
        end;

        local u42 = nil;
        u8:Add(u9.Visible:Observe(function(p43: boolean) -- Line: 67
            -- upvalues: u42 (ref), u8 (copy), RunService (ref), u41 (copy)
            if p43 and not u42 then
                u42 = u8:Add(RunService.PostSimulation:Connect(u41));

                return;
            end;

            if not p43 and u42 then
                u8:Remove(u42);
                u42 = nil;
            end;
        end));

        return;
    end;

    if p10.Name ~= "Transcendent" then
        if p10.Name == "Rainbow" or p12 <= 1 then
            local function u45() -- Line: 203
                -- upvalues: u11 (copy)
                local v44 = os.clock() % 5 / 5;
                local Color3_fromHSV_ret = Color3.fromHSV(v44, 1, 1);
                u11.Odds.TextColor3 = Color3_fromHSV_ret;
                u11.Title.TextColor3 = Color3_fromHSV_ret;
            end;

            local u46 = nil;
            u8:Add(u9.Visible:Observe(function(p47: boolean) -- Line: 67
                -- upvalues: u46 (ref), u8 (copy), RunService (ref), u45 (copy)
                if p47 and not u46 then
                    u46 = u8:Add(RunService.PostSimulation:Connect(u45));

                    return;
                end;

                if not p47 and u46 then
                    u8:Remove(u46);
                    u46 = nil;
                end;
            end));
        end;

        return;
    end;

    if v14 then
        v14.Enabled = true;
    end;

    local function u50() -- Line: 166
        -- upvalues: u11 (copy), u13 (copy), u15 (copy)
        local v48 = os.clock() * 0.25;
        local v49 = v48 % 1;
        local Color3_fromHSV_ret = Color3.fromHSV(v49, 1, 1);
        local Color3_fromHSV_ret2 = Color3.fromHSV((v49 + 0.15) % 1, 1, 1);
        local Color3_fromHSV_ret3 = Color3.fromHSV((v49 + 0.35) % 1, 1, 1);
        local Color3_fromHSV_ret4 = Color3.fromHSV((v49 + 0.6) % 1, 1, 1);
        u11.Odds.TextColor3 = Color3_fromHSV_ret;
        u11.Title.TextColor3 = Color3_fromHSV_ret2;

        if u13 then
            u13.Enabled = true;
            u13.Rotation = v48 * 95 % 360;
            u13.Offset = Vector2.new(math.sin(v48 * 3.5) * 0.35, math.cos(v48 * 2.5) * 0.25);
            u13.Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3_fromHSV_ret4),
                ColorSequenceKeypoint.new(0.35, Color3_fromHSV_ret2),
                ColorSequenceKeypoint.new(0.7, Color3_fromHSV_ret3),
                ColorSequenceKeypoint.new(1, Color3_fromHSV_ret4)
            });
        end;

        if u15 then
            u15.Enabled = true;
            u15.Rotation = v48 * 140 % 360;
            u15.Offset = Vector2.new(math.sin(v48 * 4) * 0.45, math.cos(v48 * 3) * 0.25);
            u15.Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3_fromHSV_ret2),
                ColorSequenceKeypoint.new(0.25, Color3_fromHSV_ret3),
                ColorSequenceKeypoint.new(0.5, Color3_fromHSV_ret4),
                ColorSequenceKeypoint.new(0.75, Color3_fromHSV_ret),
                ColorSequenceKeypoint.new(1, Color3_fromHSV_ret2)
            });
        end;
    end;

    local u51 = nil;
    u8:Add(u9.Visible:Observe(function(p52: boolean) -- Line: 67
        -- upvalues: u51 (ref), u8 (copy), RunService (ref), u50 (copy)
        if p52 and not u51 then
            u51 = u8:Add(RunService.PostSimulation:Connect(u50));

            return;
        end;

        if not p52 and u51 then
            u8:Remove(u51);
            u51 = nil;
        end;
    end));
end;

local function RenderEntries(p53: any, p54: any, p55: userdata, p56: userdata, p57: number, p58: any, p59: number) -- Line: 213
    -- upvalues: ApplySpecialTextEffects (copy)
    local v60 = nil;
    local v61 = 0;

    for _, v in p58 do
        local v62;

        if v60 and p57 > v61 then
            v62 = v;
        else
            p59 = p59 + 1;
            v60 = p53:Clone(p56);
            v60.Name = `Row_{p59}`;
            v60.LayoutOrder = p59;
            v60.Visible = true;
            v60.Parent = p55;
            v62 = v;
            v61 = 0;

            for _, child in v60:GetChildren() do
                if child:IsA("GuiObject") and child.Name == "TEMPLATE" then
                    child:Destroy();
                end;
            end;
        end;

        v61 = v61 + 1;
        local v63 = p53:Clone(p56.TEMPLATE);
        v63.Name = v62.Name;
        v63.LayoutOrder = v61;
        v63.Visible = true;
        v63.Parent = v60;
        local Frame = v63.Frame;
        Frame.Title.Text = v62.Name;
        Frame.Title.TextColor3 = v62.Item.Color or Color3.new(1, 1, 1);
        local v64 = math.floor(v62.NormalizedOdd * 100 + 0.5) / 100;
        Frame.Odds.Text = `{v64}%`;
        Frame.Vector.Visible = false;
        ApplySpecialTextEffects(p53, p54, v62, Frame, v64);
        Frame.Title.TextScaled = true;
        Frame.Odds.TextScaled = true;
    end;

    return p59;
end;

local function RenderOdds(p65, p66) -- Line: 263
    -- upvalues: Holder (copy), GetMutationItems (copy), RenderEntries (copy)
    local ScrollingFrame = Holder.ScrollingFrame;
    local UIListLayout = ScrollingFrame.UIListLayout;
    local TemplateRow = UIListLayout.TemplateRow;
    local HeaderTemplate = UIListLayout.HeaderTemplate;

    for _, child in ScrollingFrame:GetChildren() do
        if child:IsA("GuiObject") then
            child:Destroy();
        end;
    end;

    TemplateRow.Visible = false;
    HeaderTemplate.Visible = false;
    local v67 = RenderEntries(p65, p66, ScrollingFrame, TemplateRow, 4, GetMutationItems(false), 0);
    local v68 = GetMutationItems(true);

    if #v68 > 0 then
        local v69 = v67 + 1;
        local v70 = p65:Clone(HeaderTemplate);
        v70.Name = "Level500Header";
        v70.LayoutOrder = v69;
        v70.Visible = true;
        v70.Parent = ScrollingFrame;
        local Title = v70:FindFirstChild("Title", true);

        if Title and Title:IsA("TextLabel") then
            Title.Text = "Level 500 Mutations Only";
        end;

        RenderEntries(p65, p66, ScrollingFrame, TemplateRow, 4, v68, v69);
    end;

    task.defer(function() -- Line: 302
        -- upvalues: ScrollingFrame (copy), UIListLayout (copy)
        ScrollingFrame.CanvasPosition = Vector2.zero;
        ScrollingFrame.CanvasSize = UDim2.fromOffset(0, UIListLayout.AbsoluteContentSize.Y);
    end);
end;

function u2.Open(p71: table, u72: userdata?) -- Line: 308
    -- upvalues: GuiController (copy), PetMutationOdds_UI (copy), u1 (ref), Trove (copy), RenderOdds (copy)
    local StateForGui = GuiController:GetStateForGui(PetMutationOdds_UI);
    GuiController:Close(PetMutationOdds_UI);
    u1:Clean();
    local u73 = Trove.new();
    u1 = u73;
    RenderOdds(u73, StateForGui);
    GuiController:Open(PetMutationOdds_UI);
    u73:Add(PetMutationOdds_UI.Frame.Exit.EXIT_BUTTON.Activated:Once(function() -- Line: 321
        -- upvalues: GuiController (ref), PetMutationOdds_UI (ref), u72 (copy), u73 (copy)
        GuiController:Close(PetMutationOdds_UI);

        if u72 then
            GuiController:Open(u72);
        end;

        u73:Clean();
    end));
end;

function u2.Start(p74) -- Line: 331
    -- upvalues: GuiController (copy), PetMutationOdds_UI (copy), ProximityPromptService (copy), u2 (copy)
    GuiController:UsePopupAnims(PetMutationOdds_UI);
    ProximityPromptService.PromptTriggered:Connect(function(p75: userdata) -- Line: 334
        -- upvalues: u2 (ref)
        if p75:HasTag("PetMutationOddsPrompt") then
            u2:Open();
        end;
    end);
end;

task.spawn(u2.Start, u2);

return u2;