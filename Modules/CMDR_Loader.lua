-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local UserInputService = game:GetService("UserInputService");
local EnableCommandUI = game:GetService("ReplicatedFirst").EnableCommandUI;
local LocalPlayer = Players.LocalPlayer;
local IsCommandAuthorized = require(ReplicatedStorage.Modules.IsCommandAuthorized);
local ModernInputNotificationUserInterfaceService = require(ReplicatedStorage.Modules.ModernInputNotificationUserInterfaceService);
local Icon = require(ReplicatedStorage.Modules.Icon);
task.spawn(function() -- Line: 15
    -- upvalues: IsCommandAuthorized (copy), LocalPlayer (copy), ReplicatedStorage (copy), EnableCommandUI (copy), Icon (copy), ModernInputNotificationUserInterfaceService (copy), UserInputService (copy)
    if not IsCommandAuthorized(LocalPlayer) then
        return;
    end;

    local CmdrClient = require(ReplicatedStorage:WaitForChild("CmdrClient"));

    if not EnableCommandUI.Value then
        CmdrClient:SetActivationKeys({ Enum.KeyCode.F2 });

        return;
    end;

    local u1 = Icon.new();
    u1:setName("CMDR");
    u1:setOrder(5);
    u1:setLabel("CMDR");
    u1:align("Right");
    u1:setCaption("Toggle the admin console.");
    u1.deselectWhenOtherIconSelected = false;
    ModernInputNotificationUserInterfaceService:CreateNotification({
        Text = "You have access to the developer command console! Press [F2] to toggle!",
        Icon = "rbxassetid://0",
        Lifetime = 3,
        EnabledComponents = {
            OptionSet = true,
            Confirm = true,
            Decline = false,
            IconSet = true
        }
    });
    local u2 = false;
    UserInputService.InputEnded:Connect(function(p3) -- Line: 59
        -- upvalues: UserInputService (ref), u2 (ref), u1 (copy)
        if UserInputService:GetFocusedTextBox() then
            return;
        end;

        if p3.KeyCode ~= Enum.KeyCode.F2 then
            return;
        end;

        u2 = not u2;

        if u2 then
            u1:select();

            return;
        end;

        u1:deselect();
    end);
    u1.selected:Connect(function(p4) -- Line: 72
        -- upvalues: CmdrClient (copy)
        CmdrClient:Show();
    end);
    u1.deselected:Connect(function(p5) -- Line: 76
        -- upvalues: CmdrClient (copy)
        CmdrClient:Hide();
    end);
end);

return {};