-- Decompiled with Potassium's decompiler.

local u1 = {};
local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("UserInputService");
local LocalPlayer = Players.LocalPlayer;
local GuiController = require(ReplicatedStorage.Modules.GuiController);
local Blur_Module = require(ReplicatedStorage.Blur_Module);
local Field_Of_View_Module = require(ReplicatedStorage.Field_Of_View_Module);
local Notification = require(ReplicatedStorage.Modules.Notification);
local EasterRaffleController = require(ReplicatedStorage.Modules.EasterRaffleControllers.EasterRaffleController);
local InventoryService = require(ReplicatedStorage.Modules.InventoryService);
local CandyBlossomRaffleUI = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("CandyBlossomRaffleUI");
local ExitButton = CandyBlossomRaffleUI.Easter.Header.ExitButton;
local SubmitButton = CandyBlossomRaffleUI.Easter.Main.Content.Holder.EntriesContent.SubmitButton;
local CantSubmitButton = CandyBlossomRaffleUI.Easter.Main.Content.Holder.EntriesContent.CantSubmitButton;
local ProgressBarInner = CandyBlossomRaffleUI.Easter.Main.Content.Holder.EntriesContent.ProgressBar.ProgressBarInner;
local TotalEntriesAmountTextLabel = CandyBlossomRaffleUI.Easter.Main.Content.Holder.EntriesContent.Header.TotalEntriesAmountTextLabel;
local YourOddsAmountTextLabel = CandyBlossomRaffleUI.Easter.Main.Content.Holder.EntriesContent.Holder.Odds.YourOddsAmountTextLabel;
local YourEntriesAmountTextLabel = CandyBlossomRaffleUI.Easter.Main.Content.Holder.EntriesContent.Holder.Enries.YourEntriesAmountTextLabel;
local _ = CandyBlossomRaffleUI.Easter.Main.Content.Tap.TimerHolder.DrawTimeTextLabel;
local Rays = CandyBlossomRaffleUI.Easter.Main.Content.Tap.Rays.Rays;
local RainbowGradient = CandyBlossomRaffleUI.Easter.Main.Content.Holder.ValueContent.Slots.Slot2.UIStroke.RainbowGradient;
local DrawTimeTextLabel = CandyBlossomRaffleUI.Easter.Main.Content.Tap.TimerHolder.DrawTimeTextLabel;
local u2 = 0;
local u3 = {
    ["Golden Egg"] = 1,
    ["Gilded Choc Golden Egg"] = 1,
    ["Premium Golden Egg"] = 2,
    ["Gilded Choc Premium Golden Egg"] = 2
};

local function SecondsUntilNextDraw() -- Line: 48
    local os_time_ret = os.time();
    local os_date_ret = os.date("!*t", os_time_ret);
    local os_time_ret2 = os.time({
        hour = 23,
        min = 0,
        sec = 0,
        year = os_date_ret.year,
        month = os_date_ret.month,
        day = os_date_ret.day
    });

    if os_time_ret2 <= os_time_ret then
        os_time_ret2 = os_time_ret2 + 86400;
    end;

    return os_time_ret2 - os_time_ret;
end;

local function FormatCountdown(p4: number) -- Line: 61
    local math_floor_ret = math.floor(p4);
    local math_max_ret = math.max(0, math_floor_ret);

    if math_max_ret >= 3600 then
        return `Draw In: {math.floor(math_max_ret / 3600)}h {math.floor(math_max_ret % 3600 / 60)}m`;
    end;

    if math_max_ret >= 60 then
        return `Draw In: {math.floor(math_max_ret / 60)}m {math_max_ret % 60}s`;
    end;

    return `Draw In: {math_max_ret}s`;
end;

function u1.Toggle(p5: table, p6: boolean) -- Line: 76
    -- upvalues: CandyBlossomRaffleUI (copy)
    if p6 == nil then
        CandyBlossomRaffleUI.Enabled = not CandyBlossomRaffleUI.Enabled;

        return;
    end;

    CandyBlossomRaffleUI.Enabled = p6;
end;

function u1.Start(p7) -- Line: 84
    -- upvalues: ExitButton (copy), GuiController (copy), CandyBlossomRaffleUI (copy), EasterRaffleController (copy), u2 (ref), TotalEntriesAmountTextLabel (copy), YourEntriesAmountTextLabel (copy), YourOddsAmountTextLabel (copy), TweenService (copy), ProgressBarInner (copy), DrawTimeTextLabel (copy), FormatCountdown (copy), SecondsUntilNextDraw (copy), u1 (copy), Field_Of_View_Module (copy), Blur_Module (copy), Rays (copy), RainbowGradient (copy), CantSubmitButton (copy), Notification (copy), SubmitButton (copy), LocalPlayer (copy), InventoryService (copy), u3 (copy)
    ExitButton.MouseButton1Up:Connect(function() -- Line: 85
        -- upvalues: GuiController (ref), CandyBlossomRaffleUI (ref)
        GuiController:Close(CandyBlossomRaffleUI);
    end);
    local StateForGui = GuiController:GetStateForGui(CandyBlossomRaffleUI);
    StateForGui.ChangeEnabled:Set(true);

    local function UpdateTotalTickets() -- Line: 93
        -- upvalues: EasterRaffleController (ref), u2 (ref), TotalEntriesAmountTextLabel (ref)
        local total_tickets = EasterRaffleController:GetRaffleDataAsync().total_tickets;
        u2 = total_tickets;
        TotalEntriesAmountTextLabel.Text = `{total_tickets}`;
    end;

    local function UpdatePlayerData() -- Line: 102
        -- upvalues: EasterRaffleController (ref), YourEntriesAmountTextLabel (ref), u2 (ref), YourOddsAmountTextLabel (ref), TweenService (ref), ProgressBarInner (ref)
        local PlayerRaffleDataAsync = EasterRaffleController:GetPlayerRaffleDataAsync();
        YourEntriesAmountTextLabel.Text = `{PlayerRaffleDataAsync}`;
        local math_clamp_ret = math.clamp(PlayerRaffleDataAsync / (u2 == 0 and 1 or (u2 or 1)), 0, 1);
        YourOddsAmountTextLabel.Text = string.format("%.3f%%", (`{math_clamp_ret * 100}`));
        TweenService:Create(ProgressBarInner.UIGradient, TweenInfo.new(0.2), {
            Offset = Vector2.xAxis * (math_clamp_ret - 0.5)
        }):Play();
        TweenService:Create(ProgressBarInner.Parent.Indicator, TweenInfo.new(0.2), {
            Position = UDim2.fromScale(math_clamp_ret, 0.5)
        }):Play();
    end;

    local function UpdateUserInterface() -- Line: 114
        -- upvalues: EasterRaffleController (ref), u2 (ref), TotalEntriesAmountTextLabel (ref), UpdatePlayerData (copy)
        local total_tickets = EasterRaffleController:GetRaffleDataAsync().total_tickets;
        u2 = total_tickets;
        TotalEntriesAmountTextLabel.Text = `{total_tickets}`;
        UpdatePlayerData();
    end;

    task.spawn(function() -- Line: 119
        -- upvalues: DrawTimeTextLabel (ref), FormatCountdown (ref), SecondsUntilNextDraw (ref)
        while true do
            DrawTimeTextLabel.Text = FormatCountdown((SecondsUntilNextDraw()));
            task.wait(1);
        end;
    end);
    StateForGui.Visible:Observe(function(p8) -- Line: 126
        -- upvalues: u1 (ref), Field_Of_View_Module (ref), Blur_Module (ref), EasterRaffleController (ref), u2 (ref), TotalEntriesAmountTextLabel (ref), UpdatePlayerData (copy)
        u1:Toggle(p8);
        Field_Of_View_Module.Change_FOV(p8 and 60 or 70);
        Blur_Module.Blur(p8 and 15 or 0, 0.1);

        if p8 then
            local total_tickets = EasterRaffleController:GetRaffleDataAsync().total_tickets;
            u2 = total_tickets;
            TotalEntriesAmountTextLabel.Text = `{total_tickets}`;
            UpdatePlayerData();
        end;
    end);
    task.spawn(function() -- Line: 142
        -- upvalues: TweenService (ref), Rays (ref), RainbowGradient (ref)
        while true do
            local task_wait_ret = task.wait(0.1);
            TweenService:Create(Rays, TweenInfo.new(0.1), {
                Rotation = Rays.Rotation + 30 * task_wait_ret
            }):Play();
            TweenService:Create(RainbowGradient, TweenInfo.new(0.1), {
                Rotation = RainbowGradient.Rotation + 30 * task_wait_ret
            }):Play();
        end;
    end);
    CantSubmitButton.MouseButton1Up:Connect(function() -- Line: 159
        -- upvalues: Notification (ref)
        Notification:CreateNotification("Hold out a egg to submit your entry!");
    end);
    SubmitButton.MouseButton1Up:Connect(function() -- Line: 163
        -- upvalues: EasterRaffleController (ref), u2 (ref), TotalEntriesAmountTextLabel (ref), UpdatePlayerData (copy)
        EasterRaffleController:SubmitEgg();
        local total_tickets = EasterRaffleController:GetRaffleDataAsync().total_tickets;
        u2 = total_tickets;
        TotalEntriesAmountTextLabel.Text = `{total_tickets}`;
        UpdatePlayerData();
    end);

    local function HasTool() -- Line: 168
        -- upvalues: LocalPlayer (ref), InventoryService (ref), u3 (ref)
        local Character = LocalPlayer.Character;

        if not Character then
            return false;
        end;

        local v9 = Character:FindFirstChildOfClass("Tool");

        if not v9 then
            return false;
        end;

        local ToolData = InventoryService:GetToolData(v9);

        if ToolData then
            return u3[ToolData.ItemData.EggName] and true or false;
        end;

        return false;
    end;

    local function ToggleButton() -- Line: 198
        -- upvalues: LocalPlayer (ref), InventoryService (ref), u3 (ref), CantSubmitButton (ref), SubmitButton (ref)
        local Character = LocalPlayer.Character;
        local v10;

        if Character then
            local v11 = Character:FindFirstChildOfClass("Tool");

            if v11 then
                local ToolData = InventoryService:GetToolData(v11);

                if ToolData then
                    v10 = u3[ToolData.ItemData.EggName] and true or false;
                else
                    v10 = false;
                end;
            else
                v10 = false;
            end;
        else
            v10 = false;
        end;

        CantSubmitButton.Visible = not v10;
        SubmitButton.Visible = v10;
    end;

    local function SetupCharacterSignal() -- Line: 205
        -- upvalues: LocalPlayer (ref), InventoryService (ref), u3 (ref), CantSubmitButton (ref), SubmitButton (ref)
        local Character = LocalPlayer.Character;

        if not Character then
            return;
        end;

        Character.ChildAdded:Connect(function() -- Line: 212
            -- upvalues: LocalPlayer (ref), InventoryService (ref), u3 (ref), CantSubmitButton (ref), SubmitButton (ref)
            local Character2 = LocalPlayer.Character;
            local v12;

            if Character2 then
                local v13 = Character2:FindFirstChildOfClass("Tool");

                if v13 then
                    local ToolData = InventoryService:GetToolData(v13);

                    if ToolData then
                        v12 = u3[ToolData.ItemData.EggName] and true or false;
                    else
                        v12 = false;
                    end;
                else
                    v12 = false;
                end;
            else
                v12 = false;
            end;

            CantSubmitButton.Visible = not v12;
            SubmitButton.Visible = v12;
        end);
        Character.ChildRemoved:Connect(function() -- Line: 216
            -- upvalues: LocalPlayer (ref), InventoryService (ref), u3 (ref), CantSubmitButton (ref), SubmitButton (ref)
            local Character2 = LocalPlayer.Character;
            local v14;

            if Character2 then
                local v15 = Character2:FindFirstChildOfClass("Tool");

                if v15 then
                    local ToolData = InventoryService:GetToolData(v15);

                    if ToolData then
                        v14 = u3[ToolData.ItemData.EggName] and true or false;
                    else
                        v14 = false;
                    end;
                else
                    v14 = false;
                end;
            else
                v14 = false;
            end;

            CantSubmitButton.Visible = not v14;
            SubmitButton.Visible = v14;
        end);
    end;

    SetupCharacterSignal();
    LocalPlayer.CharacterAdded:Connect(function() -- Line: 222
        -- upvalues: SetupCharacterSignal (copy)
        SetupCharacterSignal();
    end);
    local total_tickets = EasterRaffleController:GetRaffleDataAsync().total_tickets;
    u2 = total_tickets;
    TotalEntriesAmountTextLabel.Text = `{total_tickets}`;
    UpdatePlayerData();
end;

task.spawn(function() -- Line: 231
end);

return u1;