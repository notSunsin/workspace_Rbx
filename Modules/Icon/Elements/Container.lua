-- Decompiled with Potassium's decompiler.

local u1 = 0;

return function(u2) -- Line: 3
    -- upvalues: u1 (ref)
    local GuiService = game:GetService("GuiService");
    local Players = game:GetService("Players");
    local UserInputService = game:GetService("UserInputService");
    local v3 = {};
    local u4 = require(script.Parent.Parent.Packages.GoodSignal).new();
    local GuiInset = GuiService:GetGuiInset();
    local u5 = 0;
    local u6 = 0;
    local u7 = 0;
    local u8 = 0;
    local u9 = false;
    local u10 = false;

    local function checkInset(p11) -- Line: 20
        -- upvalues: GuiService (copy), u9 (ref), u10 (ref), UserInputService (copy), u2 (copy), u8 (ref), checkInset (copy), Players (copy), GuiInset (ref), u5 (ref), u6 (ref), u7 (ref), u4 (copy), u1 (ref)
        local Height = GuiService.TopbarInset.Height;
        u9 = GuiService:IsTenFootInterface();
        u10 = UserInputService.VREnabled;
        u2.isOldTopbar = false;
        u8 = u8 + 1;

        if Height == 0 and p11 == nil then
            task.defer(function() -- Line: 33
                -- upvalues: checkInset (ref)
                task.wait(8);
                checkInset("ForceConvertToOld");
            end);
        elseif u8 == 1 then
            task.delay(5, function() -- Line: 38
                -- upvalues: Players (ref), u8 (ref), checkInset (ref)
                Players.LocalPlayer:WaitForChild("PlayerGui");

                if u8 == 1 then
                    checkInset();
                end;
            end);
        end;

        GuiInset = GuiService:GetGuiInset();
        u5 = GuiInset.Y - 50;
        u6 = 0;
        u7 = -2;

        if u9 then
            u5 = 10;
            u6 = 0;
        end;

        if GuiService.TopbarInset.Height == 0 then
            u7 = 50;
        end;

        u4:Fire(GuiInset);
        local Y = GuiInset.Y;

        if Y ~= u1 then
            u1 = Y;
            task.defer(function() -- Line: 88
                -- upvalues: u2 (ref), Y (copy)
                u2.insetHeightChanged:Fire(Y);
            end);
        end;
    end;

    GuiService:GetPropertyChangedSignal("TopbarInset"):Connect(checkInset);
    checkInset("FirstTime");
    local ScreenGui = Instance.new("ScreenGui");
    u4:Connect(function() -- Line: 98
        -- upvalues: ScreenGui (copy), u5 (ref)
        ScreenGui:SetAttribute("StartInset", u5);
    end);
    ScreenGui.Name = "TopbarStandard";
    ScreenGui.Enabled = true;
    ScreenGui.DisplayOrder = u2.baseDisplayOrder;
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
    ScreenGui.IgnoreGuiInset = true;
    ScreenGui.ResetOnSpawn = false;
    ScreenGui.ScreenInsets = Enum.ScreenInsets.TopbarSafeInsets;
    v3[ScreenGui.Name] = ScreenGui;
    u2.baseDisplayOrderChanged:Connect(function() -- Line: 109
        -- upvalues: ScreenGui (copy), u2 (copy)
        ScreenGui.DisplayOrder = u2.baseDisplayOrder;
    end);
    local Frame = Instance.new("Frame");
    Frame.Name = "Holders";
    Frame.BackgroundTransparency = 1;
    u4:Connect(function() -- Line: 116
        -- upvalues: u10 (ref), u9 (ref), u7 (ref), Frame (copy), u6 (ref)
        local v12 = u10 and 36 or 56;
        local v13;

        if u9 then
            v13 = UDim2.new(1, 0, 0, v12);
        else
            v13 = UDim2.new(1, 0, 1, u7);
        end;

        Frame.Position = UDim2.new(0, 0, 0, u6);
        Frame.Size = v13;
    end);
    Frame.Visible = true;
    Frame.ZIndex = 1;
    Frame.Parent = ScreenGui;
    local u14 = ScreenGui:Clone();
    local Holders = u14.Holders;

    local function updateCenteredHoldersHeight() -- Line: 128
        -- upvalues: Holders (copy), GuiService (copy), u7 (ref)
        Holders.Size = UDim2.new(1, 0, 0, GuiService.TopbarInset.Height + u7);
    end;

    u14.Name = "TopbarCentered";
    u14.DisplayOrder = u2.baseDisplayOrder;
    u14.ScreenInsets = Enum.ScreenInsets.None;
    u2.baseDisplayOrderChanged:Connect(function() -- Line: 134
        -- upvalues: u14 (copy), u2 (copy)
        u14.DisplayOrder = u2.baseDisplayOrder;
    end);
    v3[u14.Name] = u14;
    u4:Connect(updateCenteredHoldersHeight);
    Holders.Size = UDim2.new(1, 0, 0, GuiService.TopbarInset.Height + u7);
    local u15 = ScreenGui:Clone();
    u15.Name = u15.Name .. "Clipped";
    u15.DisplayOrder = u2.baseDisplayOrder + 1;
    u2.baseDisplayOrderChanged:Connect(function() -- Line: 145
        -- upvalues: u15 (copy), u2 (copy)
        u15.DisplayOrder = u2.baseDisplayOrder + 1;
    end);
    v3[u15.Name] = u15;
    local u16 = u14:Clone();
    u16.Name = u16.Name .. "Clipped";
    u16.DisplayOrder = u2.baseDisplayOrder + 1;
    u2.baseDisplayOrderChanged:Connect(function() -- Line: 153
        -- upvalues: u16 (copy), u2 (copy)
        u16.DisplayOrder = u2.baseDisplayOrder + 1;
    end);
    v3[u16.Name] = u16;
    local ScrollingFrame = Instance.new("ScrollingFrame");
    ScrollingFrame:SetAttribute("IsAHolder", true);
    ScrollingFrame.Name = "Left";
    u4:Connect(function() -- Line: 162
        -- upvalues: ScrollingFrame (copy), u5 (ref)
        ScrollingFrame.Position = UDim2.fromOffset(u5, 0);
    end);
    ScrollingFrame.Size = UDim2.new(1, -24, 1, 0);
    ScrollingFrame.BackgroundTransparency = 1;
    ScrollingFrame.Visible = true;
    ScrollingFrame.ZIndex = 1;
    ScrollingFrame.Active = false;
    ScrollingFrame.ClipsDescendants = true;
    ScrollingFrame.HorizontalScrollBarInset = Enum.ScrollBarInset.None;
    ScrollingFrame.CanvasSize = UDim2.new(0, 0, 1, -1);
    ScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.X;
    ScrollingFrame.ScrollingDirection = Enum.ScrollingDirection.X;
    ScrollingFrame.ScrollBarThickness = 0;
    ScrollingFrame.BorderSizePixel = 0;
    ScrollingFrame.Selectable = false;
    ScrollingFrame.ScrollingEnabled = false;
    ScrollingFrame.ElasticBehavior = Enum.ElasticBehavior.Never;
    ScrollingFrame.Parent = Frame;
    local UIListLayout = Instance.new("UIListLayout");
    u4:Connect(function() -- Line: 183
        -- upvalues: UIListLayout (copy), u5 (ref)
        UIListLayout.Padding = UDim.new(0, u5);
    end);
    UIListLayout.FillDirection = Enum.FillDirection.Horizontal;
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder;
    UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom;
    UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left;
    UIListLayout.Parent = ScrollingFrame;
    local u17 = ScrollingFrame:Clone();
    u4:Connect(function() -- Line: 193
        -- upvalues: u17 (copy), u5 (ref)
        u17.UIListLayout.Padding = UDim.new(0, u5);
    end);
    u17.ScrollingEnabled = false;
    u17.UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center;
    u17.Name = "Center";
    u17.Parent = Holders;
    local u18 = ScrollingFrame:Clone();
    u4:Connect(function() -- Line: 202
        -- upvalues: u18 (copy), u5 (ref)
        u18.UIListLayout.Padding = UDim.new(0, u5);
    end);
    u18.UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right;
    u18.Name = "Right";
    u18.AnchorPoint = Vector2.new(1, 0);
    u18.Position = UDim2.new(1, -12, 0, 0);
    u18.Parent = Frame;
    u4:Fire(GuiInset);

    return v3;
end;