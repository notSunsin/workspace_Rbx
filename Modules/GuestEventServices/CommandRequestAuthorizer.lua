-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local ModernInputNotificationUserInterfaceService = require(ReplicatedStorage.Modules.ModernInputNotificationUserInterfaceService);
local CommandRequestController = require(ReplicatedStorage.Modules.GuestEventServices.CommandRequestController);
CommandRequestController.CommandRequestMessageCreated:Connect(function(u1) -- Line: 9
    -- upvalues: Players (copy), ModernInputNotificationUserInterfaceService (copy), CommandRequestController (copy)
    local NameFromUserIdAsync = Players:GetNameFromUserIdAsync(u1.Messager);
    local UserThumbnailAsync = Players:GetUserThumbnailAsync(u1.Messager, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420);
    ModernInputNotificationUserInterfaceService:CreateNotification({
        Text = `{NameFromUserIdAsync} wants to use: {u1.RawText}!`,
        EnabledComponents = {
            OptionSet = true,
            Confirm = true,
            Decline = true,
            IconSet = true
        },
        Icon = UserThumbnailAsync,

        OnConfirm = function() -- Line: 25, Name: OnConfirm
            -- upvalues: CommandRequestController (ref), u1 (copy)
            CommandRequestController:AuthorizeCommand(u1.MessageId);
        end,

        OnDecline = function() -- Line: 28, Name: OnDecline
            -- upvalues: CommandRequestController (ref), u1 (copy)
            CommandRequestController:DenyCommand(u1.MessageId);
        end
    });
end);

return {};