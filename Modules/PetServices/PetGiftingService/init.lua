-- Decompiled with Potassium's decompiler.

local v1 = {};
local PetGiftingService = game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("PetGiftingService");
local script_Gift_Notification = script.Gift_Notification;
local Gift_Notification = game.Players.LocalPlayer.PlayerGui:WaitForChild("Gift_Notification");

function v1.GivePet(p2: table, p3: userdata) -- Line: 12
    -- upvalues: PetGiftingService (copy)
    PetGiftingService:FireServer("GivePet", p3);
end;

game.ReplicatedStorage.GameEvents.GiftPet.OnClientEvent:Connect(function(u4, p5, p6) -- Line: 16
    -- upvalues: script_Gift_Notification (copy), Gift_Notification (copy)
    local u7 = script_Gift_Notification:Clone();

    if game:GetService("UserInputService").PreferredInput == Enum.PreferredInput.Touch then
        local UIScale = Instance.new("UIScale");
        UIScale.Scale = 1.3;
        UIScale.Parent = u7;
    end;

    u7.Parent = Gift_Notification.Frame;
    u7.Holder.Notification_UI.TextLabel.Text = "Gift from @" .. p6;
    u7.Holder.TextLabel.Text = p5;
    u7.Holder.Frame.Accept.MouseButton1Click:Connect(function() -- Line: 30
        -- upvalues: u7 (copy), u4 (copy)
        u7:Destroy();
        game.ReplicatedStorage.GameEvents.AcceptPetGift:FireServer(true, u4);
    end);
    u7.Holder.Frame.Decline.MouseButton1Click:Connect(function() -- Line: 35
        -- upvalues: u7 (copy), u4 (copy)
        u7:Destroy();
        game.ReplicatedStorage.GameEvents.AcceptPetGift:FireServer(false, u4);
    end);
end);

return v1;