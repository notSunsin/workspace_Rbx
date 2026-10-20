-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local UserInputService = game:GetService("UserInputService");
local Players = game:GetService("Players");
local GuiService = game:GetService("GuiService");
local LocalPlayer = Players.LocalPlayer;
local PlayerGui = LocalPlayer.PlayerGui;
local GlobalMessageUI = PlayerGui:WaitForChild("GlobalMessageUI");
local GameConfigController = require(ReplicatedStorage.Modules.GameConfigController);
GlobalMessageUI.Enabled = table.find(GameConfigController:GetConfig("AuthorizedGlobalChatQueuers") or {}, LocalPlayer.UserId) ~= nil;
local SetupHoverAnimations = require(ReplicatedStorage.Modules.SetupHoverAnimations);
local GlobalChatController = require(ReplicatedStorage.Modules.GuestEventServices.GlobalChatController);
local MainFrame = GlobalMessageUI.MainFrame;
local GLOBAL_MESSAGE_INPUT = MainFrame.Frame.Frame.Frame.GLOBAL_MESSAGE_INPUT;
local SUBMIT_BUTTON = MainFrame.Frame.Frame1.Frame.SUBMIT_BUTTON;
SetupHoverAnimations(MainFrame.Frame.TextLabel.Frame.CLOSE_BUTTON).Activated:Connect(function() -- Line: 24
    -- upvalues: GlobalMessageUI (copy)
    GlobalMessageUI:Destroy();
end);
SetupHoverAnimations(SUBMIT_BUTTON).Activated:Connect(function() -- Line: 29
    -- upvalues: GlobalChatController (copy), GLOBAL_MESSAGE_INPUT (copy)
    GlobalChatController:QueueChatMessage(GLOBAL_MESSAGE_INPUT.Text);
end);
local MouseLocation = UserInputService:GetMouseLocation();

local function GetGuiObjects() -- Line: 35
    -- upvalues: UserInputService (copy), GuiService (copy), PlayerGui (copy), MainFrame (copy)
    local v1 = UserInputService:GetMouseLocation() - GuiService:GetGuiInset();
    local GuiObjectsAtPosition = PlayerGui:GetGuiObjectsAtPosition(v1.X, v1.Y);

    return table.find(GuiObjectsAtPosition, MainFrame);
end;

RunService.RenderStepped:Connect(function() -- Line: 42
    -- upvalues: UserInputService (copy), MouseLocation (ref), GuiService (copy), PlayerGui (copy), MainFrame (copy)
    local MouseLocation2 = UserInputService:GetMouseLocation();

    if MouseLocation2 == MouseLocation then
        return;
    end;

    local v2 = MouseLocation2.X - MouseLocation.X;
    local v3 = MouseLocation2.Y - MouseLocation.Y;
    MouseLocation = MouseLocation2;

    if UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
        local v4 = UserInputService:GetMouseLocation() - GuiService:GetGuiInset();
        local GuiObjectsAtPosition = PlayerGui:GetGuiObjectsAtPosition(v4.X, v4.Y);

        if table.find(GuiObjectsAtPosition, MainFrame) then
            MainFrame.Position = MainFrame.Position + UDim2.fromOffset(v2, v3);
        end;
    end;
end);

return {};