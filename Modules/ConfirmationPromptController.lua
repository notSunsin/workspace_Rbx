-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
game:GetService("StarterGui");
local GuiController = require(script.Parent.GuiController);
local LocalPlayer = Players.LocalPlayer;
local ConfirmationPromptOpen = game.ReplicatedStorage.GameEvents.ConfirmationPromptOpen;
local ConfirmationPromptClose = game.ReplicatedStorage.GameEvents.ConfirmationPromptClose;
local ConfirmationPromptUpdateText = game.ReplicatedStorage.GameEvents.ConfirmationPromptUpdateText;
local GenericConfirmationPrompt = LocalPlayer.PlayerGui:WaitForChild("GenericConfirmationPrompt", 30);
local Main = GenericConfirmationPrompt.PromptFrame.Main;
local HeaderText = Main.HeaderText;
local MiddleText = Main.MiddleText;
local FooterText = Main.FooterText;
local Buttons = Main.Buttons;
local Confirm = Buttons.Confirm;
local Cancel = Buttons.Cancel;
local HeaderContainer = Main.HeaderContainer;
local Title = HeaderContainer.Title;
local ExitButton = HeaderContainer.Exit.ExitButton;
local u1 = {};
local u2 = {};
local u3 = {
    Prismatic = true,
    Transcendent = true
};
local u4 = nil;
local u5 = {};

local function Cleanup() -- Line: 69
    -- upvalues: u1 (copy), u2 (copy)
    for _, v in u1 do
        v:Disconnect();
    end;

    table.clear(u1);

    for _, v in u2 do
        v:Disconnect();
    end;

    table.clear(u2);
end;

local function Close() -- Line: 81
    -- upvalues: Cleanup (copy), GenericConfirmationPrompt (copy), GuiController (copy)
    Cleanup();
    GenericConfirmationPrompt.Enabled = false;
    GuiController:ShowHUD();
end;

local function AnimatedText(u6: userdata, u7: table) -- Line: 88
    -- upvalues: u3 (copy), RunService (copy)
    u6.RichText = true;
    local Text = u6.Text;
    local v8 = false;

    for _, v in pairs(u7) do
        if u3[v] then
            v8 = true;
            break;
        end;
    end;

    if v8 then
        local u9 = nil;
        u9 = RunService.Heartbeat:Connect(function() -- Line: 101
            -- upvalues: u6 (copy), u9 (ref), Text (copy), u7 (copy)
            if not u6.Parent then
                u9:Disconnect();

                return;
            end;

            local v10 = Text;

            for i, v in pairs(u7) do
                local v11, v12, v13;

                if v == "Prismatic" then
                    v11 = os.clock() * 0.1 % 1;
                    v12 = Color3.fromHSV(v11, 1, 1);
                    v13 = string.format("%02X%02X%02X", v12.R * 255, v12.G * 255, v12.B * 255);
                    v10 = v10:gsub(i:gsub("(%W)", "%%%1"), string.format("<font color=\"#%s\">%s</font>", v13, i));
                elseif v == "Transcendent" then
                    local v14 = os.clock() * 1.5;
                    v11 = math.sin(v14) * 0.03 + 0.72;
                    v12 = Color3.fromHSV(v11, 1, 1);
                    v13 = string.format("%02X%02X%02X", v12.R * 255, v12.G * 255, v12.B * 255);
                    v10 = v10:gsub(i:gsub("(%W)", "%%%1"), string.format("<font color=\"#%s\">%s</font>", v13, i));
                end;
            end;

            u6.Text = v10;
        end);

        return u9;
    end;
end;

function u5.Open(p15: table, p16: table, p17: table) -- Line: 151
    -- upvalues: Cleanup (copy), Title (copy), HeaderText (copy), MiddleText (copy), FooterText (copy), AnimatedText (copy), u1 (copy), Confirm (copy), Cancel (copy), Close (copy), u2 (copy), ExitButton (copy), GuiController (copy), u4 (ref), LocalPlayer (copy), GenericConfirmationPrompt (copy)
    Cleanup();
    local v18 = p16 or {};
    local u19 = p17 or {};
    Title.Text = v18.Title or "Confirmation Prompt";
    HeaderText.Text = v18.Header or "Are you sure?";
    MiddleText.Text = v18.Middle or "Action";
    FooterText.Text = v18.Footer or "This action is irreversible.";

    if v18.AnimatedWords then
        if v18.TextLabel then
            local TextLabel = v18.TextLabel;
            local v20 = MiddleText;

            if TextLabel == "Title" then
                v20 = Title;
            elseif TextLabel == "Header" then
                v20 = HeaderText;
            elseif TextLabel == "Footer" then
                v20 = FooterText;
            end;

            local v21 = AnimatedText(v20, v18.AnimatedWords);
            table.insert(u1, v21);
        else
            local v22 = AnimatedText(MiddleText, v18.AnimatedWords);
            table.insert(u1, v22);
        end;
    end;

    Confirm.TextLabel.Text = v18.ConfirmText or "Confirm";
    Cancel.TextLabel.Text = v18.RejectText or "Cancel";
    Confirm.Visible = not v18.HideConfirm;
    Cancel.Visible = not v18.HideReject;

    if u19.ConfirmEvent then
        table.insert(u1, Confirm.Activated:Connect(function() -- Line: 187
            -- upvalues: u19 (ref)
            u19.ConfirmEvent:FireServer(unpack(u19.ConfirmEventData or {}));
        end));
    end;

    if u19.ConfirmCallback then
        table.insert(u1, Confirm.Activated:Connect(function() -- Line: 193
            -- upvalues: u19 (ref)
            u19.ConfirmCallback(unpack(u19.ConfirmCallbackData or {}));
        end));
    end;

    table.insert(u1, Confirm.Activated:Connect(function() -- Line: 199
        -- upvalues: Close (ref)
        task.defer(Close);
    end));

    if u19.RejectEvent then
        local function RejectEvent() -- Line: 205
            -- upvalues: u19 (ref)
            u19.RejectEvent:FireServer(unpack(u19.RejectEventData or {}));
        end;

        table.insert(u2, ExitButton.Activated:Connect(RejectEvent));
        table.insert(u2, Cancel.Activated:Connect(RejectEvent));
    end;

    if u19.RejectCallback then
        local function RejectConnCallback() -- Line: 214
            -- upvalues: u19 (ref)
            u19.RejectCallback(unpack(u19.RejectCallbackData or {}));
        end;

        table.insert(u2, ExitButton.Activated:Connect(RejectConnCallback));
        table.insert(u2, Cancel.Activated:Connect(RejectConnCallback));
    end;

    if v18.HideHUD == nil or v18.HideHUD then
        GuiController:HideHUD();
    end;

    u4 = LocalPlayer:GetAttribute("SelectedSlot");
    GenericConfirmationPrompt.Enabled = true;
end;

function u5.Close(p23: table, p24: string?) -- Line: 234
    -- upvalues: Title (copy), Cleanup (copy), GenericConfirmationPrompt (copy), GuiController (copy)
    if not p24 or Title.Text == p24 then
        Cleanup();
        GenericConfirmationPrompt.Enabled = false;
        GuiController:ShowHUD();
    end;
end;

function u5.UpdateText(p25: table, p26: table, p27: string?) -- Line: 240
    -- upvalues: u5 (copy), Title (copy), HeaderText (copy), MiddleText (copy), FooterText (copy)
    if not p26 then
        return;
    end;

    if not u5:IsThisOpen(p27 or p26.Title) then
        return;
    end;

    Title.Text = p26.Title or Title.Text;
    HeaderText.Text = p26.Header or HeaderText.Text;
    MiddleText.Text = p26.Middle or MiddleText.Text;
    FooterText.Text = p26.Footer or FooterText.Text;
end;

function u5.IsThisOpen(p28: table, p29: string?) -- Line: 256
    -- upvalues: GenericConfirmationPrompt (copy), Title (copy)
    return GenericConfirmationPrompt.Enabled and Title.Text == p29 and true or GenericConfirmationPrompt.Enabled;
end;

ExitButton.Activated:Connect(Close);
Cancel.Activated:Connect(Close);
LocalPlayer:GetAttributeChangedSignal("SelectedSlot"):Connect(function() -- Line: 265
    -- upvalues: GenericConfirmationPrompt (copy), LocalPlayer (copy), u4 (ref), Cleanup (copy), GuiController (copy)
    if GenericConfirmationPrompt.Enabled and LocalPlayer:GetAttribute("SelectedSlot") ~= u4 then
        Cleanup();
        GenericConfirmationPrompt.Enabled = false;
        GuiController:ShowHUD();
    end;
end);
ConfirmationPromptOpen.OnClientEvent:Connect(function(p30: table, p31: table) -- Line: 273
    -- upvalues: u5 (copy)
    if not (p30 and p31) then
        return;
    end;

    u5:Open(p30, p31);
end);
ConfirmationPromptClose.OnClientEvent:Connect(function() -- Line: 278
    -- upvalues: u5 (copy)
    u5:Close();
end);
ConfirmationPromptUpdateText.OnClientEvent:Connect(function(p32: table, p33: string) -- Line: 282
    -- upvalues: u5 (copy), Title (copy), HeaderText (copy), MiddleText (copy), FooterText (copy)
    if not p32 then
        return;
    end;

    if not u5:IsThisOpen(p33 or p32.Title) then
        return;
    end;

    Title.Text = p32.Title or Title.Text;
    HeaderText.Text = p32.Header or HeaderText.Text;
    MiddleText.Text = p32.Middle or MiddleText.Text;
    FooterText.Text = p32.Footer or FooterText.Text;
end);

return u5;