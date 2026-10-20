-- Decompiled with Potassium's decompiler.

local v1 = {};
game:GetService("RunService");
local Gift_Notification = game.ReplicatedStorage.Gift_Notification;

function v1.Gift(p2, p3, p4, p5, p6) -- Line: 6
    -- upvalues: Gift_Notification (copy)
    if workspace:GetAttribute("InTutorial") then
        return;
    end;

    print(p2, p3);
    local v7 = Gift_Notification:Clone();

    if game:GetService("UserInputService").PreferredInput == Enum.PreferredInput.Touch then
        local UIScale = Instance.new("UIScale");
        UIScale.Scale = 1.3;
        UIScale.Parent = v7;
    end;

    v7.Parent = p2.PlayerGui.Gift_Notification.Frame;
    v7.Holder.TextLabel.Text = p4.Name;
    v7.Holder.Tool_OBJ.Value = p4;
    v7.Holder.String_OF.Value = p6;
    v7.Holder.PLR_OBJ.Value = p3;
    v7.Holder.PLR_String.Value = p3.Name;
end;

return v1;