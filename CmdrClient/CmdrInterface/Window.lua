-- Decompiled with Potassium's decompiler.

local GuiService = game:GetService("GuiService");
local UserInputService = game:GetService("UserInputService");
local TextChatService = game:GetService("TextChatService");
local LocalPlayer = game:GetService("Players").LocalPlayer;
local u1 = { Enum.UserInputType.MouseButton1, Enum.UserInputType.MouseButton2, Enum.UserInputType.Touch };
local u2 = {
    Valid = true,
    AutoComplete = nil,
    ProcessEntry = nil,
    OnTextChanged = nil,
    Cmdr = nil,
    HistoryState = nil
};

if not LocalPlayer then
    return {};
end;

local Frame = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Cmdr"):WaitForChild("Frame");
local Line = Frame:WaitForChild("Line");
local Entry = Frame:WaitForChild("Entry");
Line.Parent = nil;

function u2.UpdateLabel(p3) -- Line: 31
    -- upvalues: Entry (copy), LocalPlayer (copy)
    Entry.TextLabel.Text = LocalPlayer.Name .. "@" .. p3.Cmdr.PlaceName .. "$";
end;

function u2.GetLabel(p4) -- Line: 36
    -- upvalues: Entry (copy)
    return Entry.TextLabel.Text;
end;

function u2.UpdateWindowHeight(p5) -- Line: 41
    -- upvalues: Frame (copy)
    local v6 = Frame.UIListLayout.AbsoluteContentSize.Y + Frame.UIPadding.PaddingTop.Offset + Frame.UIPadding.PaddingBottom.Offset;
    Frame.Size = UDim2.new(Frame.Size.X.Scale, Frame.Size.X.Offset, 0, (math.clamp(v6, 0, 300)));
    Frame.CanvasPosition = Vector2.new(0, v6);
end;

function u2.AddLine(p7, p8, p9) -- Line: 50
    -- upvalues: u2 (copy), Line (copy), Frame (copy)
    local v10 = p9 or {};
    local v11 = tostring(p8);
    local v12 = typeof(v10) == "Color3" and {
        Color = v10
    } or v10;

    if #v11 == 0 then
        u2:UpdateWindowHeight();

        return;
    end;

    local v13 = p7.Cmdr.Util.EmulateTabstops(v11 or "nil", 8);
    local v14 = Line:Clone();
    v14.Text = v13;
    v14.TextColor3 = v12.Color or v14.TextColor3;
    v14.RichText = v12.RichText or false;
    v14.Parent = Frame;
end;

function u2.IsVisible(p15) -- Line: 73
    -- upvalues: Frame (copy)
    return Frame.Visible;
end;

function u2.SetVisible(p16, p17) -- Line: 78
    -- upvalues: Frame (copy), TextChatService (copy), Entry (copy), UserInputService (copy)
    Frame.Visible = p17;

    if p17 then
        p16.PreviousChatWindowConfigurationEnabled = TextChatService.ChatWindowConfiguration.Enabled;
        p16.PreviousChatInputBarConfigurationEnabled = TextChatService.ChatInputBarConfiguration.Enabled;
        TextChatService.ChatWindowConfiguration.Enabled = false;
        TextChatService.ChatInputBarConfiguration.Enabled = false;
        Entry.TextBox:CaptureFocus();
        p16:SetEntryText("");

        if p16.Cmdr.ActivationUnlocksMouse then
            p16.PreviousMouseBehavior = UserInputService.MouseBehavior;
            UserInputService.MouseBehavior = Enum.MouseBehavior.Default;
        end;
    else
        TextChatService.ChatWindowConfiguration.Enabled = p16.PreviousChatWindowConfigurationEnabled == nil and true or p16.PreviousChatWindowConfigurationEnabled;
        TextChatService.ChatInputBarConfiguration.Enabled = p16.PreviousChatInputBarConfigurationEnabled == nil and true or p16.PreviousChatInputBarConfigurationEnabled;
        Entry.TextBox:ReleaseFocus();
        p16.AutoComplete:Hide();

        if p16.PreviousMouseBehavior then
            UserInputService.MouseBehavior = p16.PreviousMouseBehavior;
            p16.PreviousMouseBehavior = nil;
        end;
    end;
end;

function u2.Hide(p18) -- Line: 111
    return p18:SetVisible(false);
end;

function u2.Show(p19) -- Line: 116
    return p19:SetVisible(true);
end;

function u2.SetEntryText(p20, p21) -- Line: 121
    -- upvalues: Entry (copy), u2 (copy)
    Entry.TextBox.Text = p21;

    if p20:IsVisible() then
        Entry.TextBox:CaptureFocus();
        Entry.TextBox.CursorPosition = #p21 + 1;
        u2:UpdateWindowHeight();
    end;
end;

function u2.GetEntryText(p22) -- Line: 132
    -- upvalues: Entry (copy)
    return Entry.TextBox.Text:gsub("\t", "");
end;

function u2.SetIsValidInput(p23, p24, p25) -- Line: 138
    -- upvalues: Entry (copy)
    Entry.TextBox.TextColor3 = p24 and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(255, 73, 73);
    p23.Valid = p24;
    p23._errorText = p25;
end;

function u2.HideInvalidState(p26) -- Line: 144
    -- upvalues: Entry (copy)
    Entry.TextBox.TextColor3 = Color3.fromRGB(255, 255, 255);
end;

function u2.LoseFocus(p27, p28) -- Line: 149
    -- upvalues: Entry (copy), Frame (copy), GuiService (copy)
    local Text = Entry.TextBox.Text;
    p27:ClearHistoryState();

    if Frame.Visible and not GuiService.MenuIsOpen then
        Entry.TextBox:CaptureFocus();
    elseif GuiService.MenuIsOpen and Frame.Visible then
        p27:Hide();
    end;

    if not (p28 and p27.Valid) then
        if p28 then
            p27:AddLine(p27._errorText, Color3.fromRGB(255, 153, 153));
        end;

        return;
    end;

    wait();
    p27:SetEntryText("");
    p27.ProcessEntry(Text);
end;

function u2.TraverseHistory(p29, p30) -- Line: 170
    local History = p29.Cmdr.Dispatcher:GetHistory();

    if p29.HistoryState == nil then
        p29.HistoryState = {
            Position = #History + 1,
            InitialText = p29:GetEntryText()
        };
    end;

    p29.HistoryState.Position = math.clamp(p29.HistoryState.Position + p30, 1, #History + 1);
    p29:SetEntryText(p29.HistoryState.Position == #History + 1 and p29.HistoryState.InitialText or History[p29.HistoryState.Position]);
end;

function u2.ClearHistoryState(p31) -- Line: 188
    p31.HistoryState = nil;
end;

function u2.SelectVertical(p32, p33) -- Line: 192
    if p32.AutoComplete:IsVisible() and not p32.HistoryState then
        p32.AutoComplete:Select(p33);

        return;
    end;

    p32:TraverseHistory(p33);
end;

local u34 = 0;
local u35 = 0;

function u2.BeginInput(p36, p37, p38) -- Line: 203
    -- upvalues: GuiService (copy), u34 (ref), u35 (ref), u1 (copy), Frame (copy)
    if GuiService.MenuIsOpen then
        p36:Hide();
    end;

    if p38 and p36:IsVisible() == false then
        return;
    end;

    if p36.Cmdr.ActivationKeys[p37.KeyCode] then
        if not p36.Cmdr.MashToEnable or p36.Cmdr.Enabled then
            if p36.Cmdr.Enabled then
                p36:SetVisible(not p36:IsVisible());
                wait();
                p36:SetEntryText("");

                if GuiService.MenuIsOpen then
                    p36:Hide();
                end;
            end;

            return;
        end;

        if tick() - u34 < 1 then
            if u35 >= 5 then
                return p36.Cmdr:SetEnabled(true);
            end;

            u35 = u35 + 1;
        else
            u35 = 1;
        end;

        u34 = tick();

        return;
    end;

    if p36.Cmdr.Enabled == false or not p36:IsVisible() then
        if p36:IsVisible() then
            p36:Hide();
        end;

        return;
    end;

    if p36.Cmdr.HideOnLostFocus and table.find(u1, p37.UserInputType) then
        local Position = p37.Position;
        local AbsolutePosition = Frame.AbsolutePosition;
        local AbsoluteSize = Frame.AbsoluteSize;

        if Position.X < AbsolutePosition.X or (Position.X > AbsolutePosition.X + AbsoluteSize.X or (Position.Y < AbsolutePosition.Y or Position.Y > AbsolutePosition.Y + AbsoluteSize.Y)) then
            p36:Hide();
        end;
    else
        if p37.KeyCode == Enum.KeyCode.Down then
            p36:SelectVertical(1);

            return;
        end;

        if p37.KeyCode == Enum.KeyCode.Up then
            p36:SelectVertical(-1);

            return;
        end;

        if p37.KeyCode == Enum.KeyCode.Return then
            wait();
            p36:SetEntryText(p36:GetEntryText():gsub("\n", ""):gsub("\r", ""));

            return;
        end;

        if p37.KeyCode == Enum.KeyCode.Tab then
            local SelectedItem = p36.AutoComplete:GetSelectedItem();
            local EntryText = p36:GetEntryText();

            if not SelectedItem or EntryText:sub(#EntryText, #EntryText):match("%s") and p36.AutoComplete.LastItem then
                wait();
                p36:SetEntryText(p36:GetEntryText());

                return;
            end;

            local v39 = SelectedItem[2];
            local Command = p36.AutoComplete.Command;
            local v40, v41;

            if Command then
                local Arg = p36.AutoComplete.Arg;
                v40 = Command.Alias;

                if p36.AutoComplete.NumArgs == #Command.ArgumentDefinitions then
                    v41 = false;
                else
                    v41 = p36.AutoComplete.IsPartial == false;
                end;

                local Arguments = Command.Arguments;

                for i = 1, #Arguments do
                    local v42 = Arguments[i];
                    local RawSegments = v42.RawSegments;

                    if v42 == Arg then
                        RawSegments[#RawSegments] = v39;
                    end;

                    local v43 = v42.Prefix .. table.concat(RawSegments, ",");

                    if v43:find(" ") or v43 == "" then
                        v43 = ("%q"):format(v43);
                    end;

                    v40 = ("%s %s"):format(v40, v43);

                    if v42 == Arg then
                        break;
                    end;

                    local _ = i;
                end;
            else
                v40 = v39;
                v41 = true;
            end;

            wait();
            p36:SetEntryText(v40 .. (v41 and " " or ""));

            return;
        end;

        p36:ClearHistoryState();
    end;
end;

Entry.TextBox.FocusLost:Connect(function(p44) -- Line: 314
    -- upvalues: u2 (copy)
    return u2:LoseFocus(p44);
end);
UserInputService.InputBegan:Connect(function(p45, p46) -- Line: 318
    -- upvalues: u2 (copy)
    return u2:BeginInput(p45, p46);
end);
Entry.TextBox:GetPropertyChangedSignal("Text"):Connect(function() -- Line: 322
    -- upvalues: Frame (copy), Entry (copy), u2 (copy)
    Frame.CanvasPosition = Vector2.new(0, Frame.AbsoluteCanvasSize.Y);

    if Entry.TextBox.Text:match("\t") then
        Entry.TextBox.Text = Entry.TextBox.Text:gsub("\t", "");

        return;
    end;

    if u2.OnTextChanged then
        return u2.OnTextChanged(Entry.TextBox.Text);
    end;
end);
Frame.ChildAdded:Connect(function() -- Line: 334
    -- upvalues: u2 (copy)
    task.defer(u2.UpdateWindowHeight);
end);

return u2;