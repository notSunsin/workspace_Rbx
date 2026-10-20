-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local ModernInputNotificationUserInterfaceService = require(ReplicatedStorage.Modules.ModernInputNotificationUserInterfaceService);
local GlobalChatController = require(ReplicatedStorage.Modules.GuestEventServices.GlobalChatController);
GlobalChatController.AuthorizerMessageCreated:Connect(function(u1) -- Line: 9
    -- upvalues: Players (copy), ModernInputNotificationUserInterfaceService (copy), GlobalChatController (copy)
    local NameFromUserIdAsync = Players:GetNameFromUserIdAsync(u1.Messager);
    local UserThumbnailAsync = Players:GetUserThumbnailAsync(u1.Messager, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420);
    ModernInputNotificationUserInterfaceService:CreateNotification({
        Text = `{NameFromUserIdAsync} wants to say: {u1.Message}!`,
        EnabledComponents = {
            OptionSet = true,
            Confirm = true,
            Decline = true,
            IconSet = true
        },
        Icon = UserThumbnailAsync,

        OnConfirm = function() -- Line: 25, Name: OnConfirm
            -- upvalues: GlobalChatController (ref), u1 (copy)
            GlobalChatController:AuthorizeMessage(u1.MessageId);
        end,

        OnDecline = function() -- Line: 28, Name: OnDecline
            -- upvalues: GlobalChatController (ref), u1 (copy)
            GlobalChatController:DenyMessage(u1.MessageId);
        end
    });
end);

return {};