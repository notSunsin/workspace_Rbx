-- Decompiled with Potassium's decompiler.

local UserInputService = game:GetService("UserInputService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local GetMouseToWorld = require(ReplicatedStorage.Modules.GetMouseToWorld);
local findFirstAncestorWithTag = require(ReplicatedStorage.Modules.Utility.utils.Object.findFirstAncestorWithTag);
local u1 = {
    [Enum.UserInputType.Gamepad1] = true,
    [Enum.UserInputType.Gamepad2] = true,
    [Enum.UserInputType.Gamepad3] = true,
    [Enum.UserInputType.Gamepad4] = true
};

local function IsGamepadMode() -- Line: 18
    -- upvalues: UserInputService (copy), u1 (copy)
    return UserInputService.GamepadEnabled and not UserInputService.MouseEnabled and true or u1[UserInputService:GetLastInputType()] == true;
end;

local function IsTouchMode() -- Line: 25
    -- upvalues: UserInputService (copy)
    return UserInputService.TouchEnabled and not UserInputService.MouseEnabled and not UserInputService.GamepadEnabled;
end;

local function GetButtonPrefix() -- Line: 29
    -- upvalues: UserInputService (copy), u1 (copy)
    if UserInputService.GamepadEnabled and not UserInputService.MouseEnabled and true or u1[UserInputService:GetLastInputType()] == true then
        return "[L2]";
    end;

    return UserInputService.TouchEnabled and not UserInputService.MouseEnabled and not UserInputService.GamepadEnabled and "[Tap]" or "[Click]";
end;

local Arrows = script:WaitForChild("Arrows");
local Attachment1 = Arrows.Attachment1;
local Attachment2 = Arrows.Attachment2;
local u2 = {
    Handler = nil,
    CurrentTarget = nil,
    LastHover = nil
};
local u10 = {
    Plant = function(p3: userdata) -- Line: 64
        local v4 = p3:FindFirstAncestorWhichIsA("Model");

        if not v4 then
            return;
        end;

        local Grow = v4:FindFirstChild("Grow");

        if not Grow then
            return;
        end;

        if Grow:FindFirstChild("Age") then
            return v4;
        end;
    end,

    PetEgg = function(p5: userdata) -- Line: 76
        -- upvalues: findFirstAncestorWithTag (copy)
        local v6 = findFirstAncestorWithTag(p5, "PetEggServer");

        if not v6 then
            return;
        end;

        if v6:GetAttribute("OBJECT_TYPE") == "PetEgg" then
            return v6;
        end;
    end,

    ["Candy Blossom"] = function(p7: userdata) -- Line: 85
        -- upvalues: findFirstAncestorWithTag (copy)
        local v8 = findFirstAncestorWithTag(p7, "Growable");

        if not v8 then
            return;
        end;

        if v8.Name == "Candy Blossom" then
            return v8;
        end;
    end,

    BeeSlot = function(p9: userdata) -- Line: 92
        if p9:HasTag("BeeSlot") then
            return p9;
        end;
    end
};
local Highlight = Instance.new("Highlight");
Highlight.FillTransparency = 1;
local LocalPlayer = Players.LocalPlayer;

if LocalPlayer then
    LocalPlayer = LocalPlayer:WaitForChild("PlayerGui");
end;

local ScreenGui = Instance.new("ScreenGui");
ScreenGui.Name = "GeneralTargettingReticle";
ScreenGui.ResetOnSpawn = false;
ScreenGui.IgnoreGuiInset = true;
ScreenGui.DisplayOrder = 5;
ScreenGui.Enabled = false;
ScreenGui.Parent = LocalPlayer;
local BillboardGui = Instance.new("BillboardGui");
BillboardGui.Name = "GeneralTargettingHoverHint";
BillboardGui.Size = UDim2.fromOffset(160, 20);
BillboardGui.StudsOffset = Vector3.new(0, 3, 0);
BillboardGui.AlwaysOnTop = true;
BillboardGui.LightInfluence = 0;
BillboardGui.MaxDistance = 80;
BillboardGui.Enabled = false;
BillboardGui.Parent = ScreenGui;
local TextLabel = Instance.new("TextLabel");
TextLabel.Size = UDim2.fromScale(1, 1);
TextLabel.BackgroundTransparency = 1;
TextLabel.FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Bold);
TextLabel.TextScaled = true;
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255);
TextLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0);
TextLabel.TextStrokeTransparency = 0;
TextLabel.Text = "";
TextLabel.Parent = BillboardGui;
local UIStroke = Instance.new("UIStroke");
UIStroke.Color = Color3.fromRGB(0, 0, 0);
UIStroke.Thickness = 2;
UIStroke.Transparency = 0;
UIStroke.LineJoinMode = Enum.LineJoinMode.Round;
UIStroke.Parent = TextLabel;

local function GetHintAdornee(p11: userdata?) -- Line: 151
    if not p11 then
        return nil;
    end;

    if p11:IsA("BasePart") then
        return p11;
    end;

    if p11:IsA("Model") then
        return p11.PrimaryPart or p11:FindFirstChildWhichIsA("BasePart");
    end;

    return nil;
end;

local function UpdateTargetingFeedback() -- Line: 158
    -- upvalues: u2 (copy), ScreenGui (copy), BillboardGui (copy), UserInputService (copy), u1 (copy), TextLabel (copy)
    local Handler = u2.Handler;
    local CurrentTarget = u2.CurrentTarget;

    if not Handler then
        ScreenGui.Enabled = false;
        BillboardGui.Enabled = false;
        BillboardGui.Adornee = nil;

        return;
    end;

    ScreenGui.Enabled = true;

    if CurrentTarget then
        if not CurrentTarget:IsA("BasePart") then
            if CurrentTarget:IsA("Model") then
                CurrentTarget = CurrentTarget.PrimaryPart or CurrentTarget:FindFirstChildWhichIsA("BasePart");
            else
                CurrentTarget = nil;
            end;
        end;
    else
        CurrentTarget = nil;
    end;

    if not (CurrentTarget and (UserInputService.GamepadEnabled and not UserInputService.MouseEnabled or u1[UserInputService:GetLastInputType()] == true)) then
        BillboardGui.Adornee = nil;
        BillboardGui.Enabled = false;

        return;
    end;

    local v12 = Handler.HoverActionVerb or "Confirm";
    local v13;

    if UserInputService.GamepadEnabled and not UserInputService.MouseEnabled and true or u1[UserInputService:GetLastInputType()] == true then
        v13 = "[L2]";
    else
        v13 = UserInputService.TouchEnabled and not UserInputService.MouseEnabled and not UserInputService.GamepadEnabled and "[Tap]" or "[Click]";
    end;

    TextLabel.Text = `{v13} {v12}`;
    BillboardGui.Adornee = CurrentTarget;
    BillboardGui.Enabled = true;
end;

local function ResetStates() -- Line: 183
    -- upvalues: u2 (copy), Highlight (copy), Arrows (copy), ScreenGui (copy), BillboardGui (copy)
    u2.LastHover = nil;
    u2.CurrentTarget = nil;
    u2.Handler = nil;
    Highlight.Parent = nil;
    Arrows.Parent = script;
    ScreenGui.Enabled = false;
    BillboardGui.Enabled = false;
    BillboardGui.Adornee = nil;
end;

local u14 = false;

local function Confirm() -- Line: 196
    -- upvalues: u14 (ref), u2 (copy), Highlight (copy), Arrows (copy), ScreenGui (copy), BillboardGui (copy)
    if u14 then
        return;
    end;

    local Handler = u2.Handler;

    if not Handler then
        return;
    end;

    if not u2.CurrentTarget then
        return;
    end;

    Handler.OnUnhover(u2.LastHover);
    Handler.OnConfirm(u2.CurrentTarget);

    if not Handler.DontReset then
        u2.LastHover = nil;
        u2.CurrentTarget = nil;
        u2.Handler = nil;
        Highlight.Parent = nil;
        Arrows.Parent = script;
        ScreenGui.Enabled = false;
        BillboardGui.Enabled = false;
        BillboardGui.Adornee = nil;
    end;
end;

function u2.Cancel(p15) -- Line: 212
    -- upvalues: u2 (copy), Highlight (copy), Arrows (copy), ScreenGui (copy), BillboardGui (copy)
    u2.CurrentTarget = nil;
    local Handler = u2.Handler;

    if Handler then
        Handler.OnUnhover(u2.LastHover);
        Handler.OnCancelled();
    end;

    u2.LastHover = nil;
    u2.CurrentTarget = nil;
    u2.Handler = nil;
    Highlight.Parent = nil;
    Arrows.Parent = script;
    ScreenGui.Enabled = false;
    BillboardGui.Enabled = false;
    BillboardGui.Adornee = nil;
end;

function u2.CreateTargetingHandler(p16: table, p17: table) -- Line: 223
    -- upvalues: u14 (ref), u2 (copy), Highlight (copy), Arrows (copy), ScreenGui (copy), BillboardGui (copy)
    u14 = true;
    u2.LastHover = nil;
    u2.CurrentTarget = nil;
    u2.Handler = nil;
    Highlight.Parent = nil;
    Arrows.Parent = script;
    ScreenGui.Enabled = false;
    BillboardGui.Enabled = false;
    BillboardGui.Adornee = nil;
    u2.Handler = p17;
    p17.OnHover = p17.OnHover or function() -- Line: 228
    end;
    p17.OnUnhover = p17.OnUnhover or function() -- Line: 229
    end;
    p17.OnCancelled = p17.OnCancelled or function() -- Line: 230
    end;
    p17.OnConfirm = p17.OnConfirm or function() -- Line: 231
    end;
    p17.DontReset = p17.DontReset or false;
    p17.TargetingRayCastParams = p17.TargetingRayCastParams or RaycastParams.new();
    task.delay(0.5, function() -- Line: 234
        -- upvalues: u14 (ref)
        u14 = false;
    end);
end;

RunService.RenderStepped:Connect(function() -- Line: 240
    -- upvalues: u2 (copy), u10 (copy), GetMouseToWorld (copy), Arrows (copy), Highlight (copy), Attachment1 (copy), Attachment2 (copy), UpdateTargetingFeedback (copy)
    local Handler = u2.Handler;

    if not Handler then
        return;
    end;

    local v18 = u10[Handler.TargetType];

    if not v18 then
        return;
    end;

    local v19 = GetMouseToWorld(Handler.TargetingRayCastParams, 100);
    local v20;

    if v19 then
        v20 = v19.Instance;
    else
        v20 = v19;
    end;

    local v21;

    if v20 then
        v21 = v18(v20);
    else
        v21 = v20;
    end;

    u2.CurrentTarget = v21;
    Arrows.Parent = v20 and workspace or script;
    Highlight.FillColor = Handler.HighlightFillColor or Color3.fromRGB(255, 255, 255);
    Highlight.FillTransparency = Handler.HighlightFillTransparency or 1;
    Highlight.OutlineTransparency = Handler.HighlightOutlineTransparency or 0;
    Highlight.OutlineColor = Handler.HighlightOutlineColor or Color3.fromRGB(255, 255, 255);
    Highlight.Adornee = v21;
    Highlight.Parent = v21;

    if v19 then
        Attachment1.WorldCFrame = Handler.Targeter:GetPivot();
        Attachment2.WorldCFrame = v21 and v21:GetPivot() or CFrame.new(v19.Position);
    end;

    UpdateTargetingFeedback();
    local LastHover = u2.LastHover;

    if LastHover == v21 then
        return;
    end;

    u2.LastHover = v21;
    Handler.OnUnhover(LastHover);
    Handler.OnHover(v21);
end);
local u22 = {
    [Enum.UserInputType.MouseButton1] = {}
};
local u27 = {
    [Enum.UserInputType.MouseButton1] = { function(p23: userdata) -- Line: 282
            -- upvalues: u14 (ref), u2 (copy), Highlight (copy), Arrows (copy), ScreenGui (copy), BillboardGui (copy)
            if u14 then
                return;
            end;

            local Handler = u2.Handler;

            if not Handler then
                return;
            end;

            if not u2.CurrentTarget then
                return;
            end;

            Handler.OnUnhover(u2.LastHover);
            Handler.OnConfirm(u2.CurrentTarget);

            if not Handler.DontReset then
                u2.LastHover = nil;
                u2.CurrentTarget = nil;
                u2.Handler = nil;
                Highlight.Parent = nil;
                Arrows.Parent = script;
                ScreenGui.Enabled = false;
                BillboardGui.Enabled = false;
                BillboardGui.Adornee = nil;
            end;
        end },
    [Enum.KeyCode.ButtonX] = { function(p24: userdata) -- Line: 287
            -- upvalues: u14 (ref), u2 (copy), Highlight (copy), Arrows (copy), ScreenGui (copy), BillboardGui (copy)
            if u14 then
                return;
            end;

            local Handler = u2.Handler;

            if not Handler then
                return;
            end;

            if not u2.CurrentTarget then
                return;
            end;

            Handler.OnUnhover(u2.LastHover);
            Handler.OnConfirm(u2.CurrentTarget);

            if not Handler.DontReset then
                u2.LastHover = nil;
                u2.CurrentTarget = nil;
                u2.Handler = nil;
                Highlight.Parent = nil;
                Arrows.Parent = script;
                ScreenGui.Enabled = false;
                BillboardGui.Enabled = false;
                BillboardGui.Adornee = nil;
            end;
        end },
    [Enum.KeyCode.ButtonL2] = { function(p25: userdata) -- Line: 292
            -- upvalues: u14 (ref), u2 (copy), Highlight (copy), Arrows (copy), ScreenGui (copy), BillboardGui (copy)
            if u14 then
                return;
            end;

            local Handler = u2.Handler;

            if not Handler then
                return;
            end;

            if not u2.CurrentTarget then
                return;
            end;

            Handler.OnUnhover(u2.LastHover);
            Handler.OnConfirm(u2.CurrentTarget);

            if not Handler.DontReset then
                u2.LastHover = nil;
                u2.CurrentTarget = nil;
                u2.Handler = nil;
                Highlight.Parent = nil;
                Arrows.Parent = script;
                ScreenGui.Enabled = false;
                BillboardGui.Enabled = false;
                BillboardGui.Adornee = nil;
            end;
        end },
    [Enum.KeyCode.ButtonR2] = { function(p26: userdata) -- Line: 297
            -- upvalues: u14 (ref), u2 (copy), Highlight (copy), Arrows (copy), ScreenGui (copy), BillboardGui (copy)
            if u14 then
                return;
            end;

            local Handler = u2.Handler;

            if not Handler then
                return;
            end;

            if not u2.CurrentTarget then
                return;
            end;

            Handler.OnUnhover(u2.LastHover);
            Handler.OnConfirm(u2.CurrentTarget);

            if not Handler.DontReset then
                u2.LastHover = nil;
                u2.CurrentTarget = nil;
                u2.Handler = nil;
                Highlight.Parent = nil;
                Arrows.Parent = script;
                ScreenGui.Enabled = false;
                BillboardGui.Enabled = false;
                BillboardGui.Adornee = nil;
            end;
        end }
};
UserInputService.InputBegan:Connect(function(u28, p29) -- Line: 303
    -- upvalues: u22 (copy)
    local v30 = u22[u28.KeyCode] or u22[u28.UserInputType];

    if not v30 then
        return;
    end;

    for _, v in v30 do
        task.spawn(function() -- Line: 307
            -- upvalues: v (copy), u28 (copy)
            v(u28);
        end);
    end;
end);
UserInputService.InputEnded:Connect(function(u31, p32) -- Line: 313
    -- upvalues: u27 (copy)
    local v33 = u27[u31.KeyCode] or u27[u31.UserInputType];

    if not v33 then
        return;
    end;

    for _, v in v33 do
        task.spawn(function() -- Line: 317
            -- upvalues: v (copy), u31 (copy)
            v(u31);
        end);
    end;
end);
UserInputService.TouchTap:Connect(function() -- Line: 323
    -- upvalues: u14 (ref), u2 (copy), Highlight (copy), Arrows (copy), ScreenGui (copy), BillboardGui (copy)
    if u14 then
        return;
    end;

    local Handler = u2.Handler;

    if not Handler then
        return;
    end;

    if not u2.CurrentTarget then
        return;
    end;

    Handler.OnUnhover(u2.LastHover);
    Handler.OnConfirm(u2.CurrentTarget);

    if not Handler.DontReset then
        u2.LastHover = nil;
        u2.CurrentTarget = nil;
        u2.Handler = nil;
        Highlight.Parent = nil;
        Arrows.Parent = script;
        ScreenGui.Enabled = false;
        BillboardGui.Enabled = false;
        BillboardGui.Adornee = nil;
    end;
end);

return u2;