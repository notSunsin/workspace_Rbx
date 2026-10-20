-- Decompiled with Potassium's decompiler.

local CollectionService = game:GetService("CollectionService");
local UserInputService = game:GetService("UserInputService");
local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TimeHelper = require(ReplicatedStorage.Modules.TimeHelper);
local utils = require(ReplicatedStorage.Modules.Utility.utils);
local LocalPlayer = Players.LocalPlayer;
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui");
local v1 = {};
local u2 = nil;
local u3 = {};
local u4 = nil;

local function MakeLabel(p5: userdata, p6: string, p7: number, p8) -- Line: 21
    local TextLabel = Instance.new("TextLabel");
    TextLabel.Name = p6;
    TextLabel.Size = UDim2.new(0, 0, 0, 0);
    TextLabel.AutomaticSize = Enum.AutomaticSize.XY;
    TextLabel.BackgroundTransparency = 1;
    TextLabel.TextColor3 = p8;
    TextLabel.TextSize = 15;
    TextLabel.FontFace = Font.new("rbxasset://fonts/families/ComicNeueAngular.json", Enum.FontWeight.Bold);
    TextLabel.TextXAlignment = Enum.TextXAlignment.Center;
    TextLabel.RichText = true;
    TextLabel.LayoutOrder = p7;
    TextLabel.Parent = p5;
    local UIStroke = Instance.new("UIStroke");
    UIStroke.Color = Color3.fromRGB(0, 0, 0);
    UIStroke.Thickness = 2;
    UIStroke.Parent = TextLabel;

    return TextLabel;
end;

local function CreateUI() -- Line: 43
    -- upvalues: PlayerGui (copy), MakeLabel (copy), UserInputService (copy)
    local ScreenGui = Instance.new("ScreenGui");
    ScreenGui.Name = "EggHoverUI";
    ScreenGui.ResetOnSpawn = false;
    ScreenGui.IgnoreGuiInset = true;
    ScreenGui.Parent = PlayerGui;
    local Frame = Instance.new("Frame");
    Frame.Name = "EggInfo";
    Frame.Size = UDim2.new(0, 0, 0, 0);
    Frame.AutomaticSize = Enum.AutomaticSize.XY;
    Frame.BackgroundTransparency = 1;
    Frame.Visible = false;
    Frame.Parent = ScreenGui;
    local UIListLayout = Instance.new("UIListLayout");
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder;
    UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center;
    UIListLayout.Parent = Frame;
    MakeLabel(Frame, "BeeName", 1, Color3.fromRGB(255, 255, 255));
    MakeLabel(Frame, "TimeLeft", 2, Color3.fromRGB(85, 255, 0));
    local UIScale = Instance.new("UIScale");
    UIScale.Scale = UserInputService.PreferredInput == Enum.PreferredInput.Touch and 1.5 or 1;
    UIScale.Parent = Frame;
    UserInputService:GetPropertyChangedSignal("PreferredInput"):Connect(function() -- Line: 70
        -- upvalues: UIScale (copy), UserInputService (ref)
        UIScale.Scale = UserInputService.PreferredInput == Enum.PreferredInput.Touch and 1.5 or 1;
    end);

    return ScreenGui;
end;

local function GetClickDetector(p9: userdata) -- Line: 77
    local v10 = p9:FindFirstChildOfClass("ClickDetector");

    if v10 then
        return v10;
    end;

    local ClickDetector = Instance.new("ClickDetector");
    ClickDetector.CursorIcon = "rbxasset://textures/Cursors/KeyboardMouse/ArrowCursor.png";
    ClickDetector.MaxActivationDistance = 32;
    ClickDetector.Parent = p9;

    return ClickDetector;
end;

local function UpdateFrame(p11: userdata, p12: userdata) -- Line: 90
    -- upvalues: TimeHelper (copy), utils (copy)
    local v13 = p12:GetAttribute("HatchedFrom") or "Egg";
    local v14 = p12:GetAttribute("TimeUntilHatch") or 0;
    local v15 = TimeHelper:GenerateColonFormatFromTime(v14);
    p11.BeeName.Text = v13;
    local v16 = utils.isMobile() and "Tap" or "Click";

    if v14 <= 0 then
        p11.TimeLeft.Text = `{v16} to Hatch!`;

        return;
    end;

    p11.TimeLeft.Text = `Hatching in {v15}<br/>[{v16} to Skip]`;
end;

function v1.Start(p17) -- Line: 106
    -- upvalues: u4 (ref), ReplicatedStorage (copy), CreateUI (copy), u3 (copy), LocalPlayer (copy), u2 (ref), UpdateFrame (copy), UserInputService (copy), CollectionService (copy)
    u4 = Instance.new("Highlight");
    u4.Name = "BeeEggHoverHighlight";
    u4.FillTransparency = 1;
    u4.OutlineColor = Color3.fromRGB(255, 255, 255);
    u4.OutlineTransparency = 0;
    u4.Parent = ReplicatedStorage;
    local EggInfo = CreateUI().EggInfo;

    local function TrackEgg(u18: userdata) -- Line: 117
        -- upvalues: u3 (ref), LocalPlayer (ref), u2 (ref), UpdateFrame (ref), EggInfo (copy), u4 (ref)
        if u3[u18] or not u18:IsA("BasePart") then
            return;
        end;

        local v19 = u18:FindFirstChildOfClass("ClickDetector");

        if not v19 then
            v19 = Instance.new("ClickDetector");
            v19.CursorIcon = "rbxasset://textures/Cursors/KeyboardMouse/ArrowCursor.png";
            v19.MaxActivationDistance = 32;
            v19.Parent = u18;
        end;

        u3[u18] = {
            v19.MouseHoverEnter:Connect(function(p20) -- Line: 125
                -- upvalues: LocalPlayer (ref), u2 (ref), u18 (copy), UpdateFrame (ref), EggInfo (ref), u4 (ref)
                if p20 ~= LocalPlayer then
                    return;
                end;

                u2 = u18;
                UpdateFrame(EggInfo, u18);
                EggInfo.Visible = true;
                u4.Adornee = u18;
            end),
            v19.MouseHoverLeave:Connect(function(p21) -- Line: 136
                -- upvalues: LocalPlayer (ref), u2 (ref), u18 (copy), EggInfo (ref), u4 (ref)
                if p21 ~= LocalPlayer or u2 ~= u18 then
                    return;
                end;

                u2 = nil;
                EggInfo.Visible = false;
                u4.Adornee = nil;
            end),
            u18:GetAttributeChangedSignal("TimeUntilHatch"):Connect(function() -- Line: 146
                -- upvalues: u2 (ref), u18 (copy), UpdateFrame (ref), EggInfo (ref)
                if u2 == u18 then
                    UpdateFrame(EggInfo, u18);
                end;
            end),
            u18:GetAttributeChangedSignal("HatchedFrom"):Connect(function() -- Line: 152
                -- upvalues: u2 (ref), u18 (copy), UpdateFrame (ref), EggInfo (ref)
                if u2 == u18 then
                    UpdateFrame(EggInfo, u18);
                end;
            end)
        };
    end;

    local function UntrackEgg(p22: userdata) -- Line: 160
        -- upvalues: u3 (ref), u2 (ref), EggInfo (copy), u4 (ref)
        local v23 = u3[p22];

        if not v23 then
            return;
        end;

        for _, v in v23 do
            v:Disconnect();
        end;

        u3[p22] = nil;

        if u2 == p22 then
            u2 = nil;
            EggInfo.Visible = false;
            u4.Adornee = nil;
        end;
    end;

    UserInputService.InputChanged:Connect(function(p24) -- Line: 179
        -- upvalues: UserInputService (ref), EggInfo (copy)
        if p24.UserInputType ~= Enum.UserInputType.MouseMovement and p24.UserInputType ~= Enum.UserInputType.Touch then
            return;
        end;

        local MouseLocation = UserInputService:GetMouseLocation();
        EggInfo.Position = UDim2.new(0, MouseLocation.X + 15, 0, MouseLocation.Y + 15);
    end);

    for _, v in CollectionService:GetTagged("BeeSwarmEgg") do
        TrackEgg(v);
    end;

    CollectionService:GetInstanceAddedSignal("BeeSwarmEgg"):Connect(TrackEgg);
    CollectionService:GetInstanceRemovedSignal("BeeSwarmEgg"):Connect(UntrackEgg);
end;

return v1;