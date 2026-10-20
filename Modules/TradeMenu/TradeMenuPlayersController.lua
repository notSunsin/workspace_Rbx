-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local u1 = require("../FriendsAPI");
require("../DataService");
require("../Notification");
require("../GuiController");
require("../TradeControllers/TradingController");
local u2 = require("../TradeControllers/TradeInventoryController");
local u3 = require("../TradeControllers/TradeRequestController");
require("../../Data/TradeData");
require(ReplicatedStorage.Modules.PlayClickSound);
local u4 = Players.LocalPlayer or Players.PlayerAdded:Wait();
local TradeMenu = u4.PlayerGui.TradeMenu;
local Players2 = TradeMenu.TradeMenuFrame.FrameSECTIONS.Players;
local ScrollingFrame = Players2.ScrollingFrame;
local Template = ScrollingFrame.UIListLayout.Template;
local u5 = true;
local u6 = {};

function u6.SetUpPlayersUI(p7) -- Line: 29
    -- upvalues: Players2 (copy), u6 (copy), TradeMenu (copy), Players (copy), u2 (copy), u1 (copy), u4 (copy)
    Players2:GetPropertyChangedSignal("Visible"):Connect(function() -- Line: 30
        -- upvalues: u6 (ref)
        u6:Update();
    end);
    TradeMenu:GetPropertyChangedSignal("Enabled"):Connect(function() -- Line: 31
        -- upvalues: u6 (ref)
        u6:Update();
    end);
    Players.PlayerAdded:Connect(function(p8) -- Line: 33
        -- upvalues: u6 (ref)
        u6:Update();
    end);
    Players.PlayerRemoving:Connect(function(p9) -- Line: 34
        -- upvalues: u6 (ref)
        u6:Update();
    end);
    u2.OnViewPlayerChanged:Connect(function(p10) -- Line: 35
        -- upvalues: u6 (ref)
        u6:Update();
    end);
    u1:OnFriendshipUpdate(u4, function() -- Line: 37
        -- upvalues: u6 (ref)
        u6:Update();
    end);
end;

function u6.GetCardFor(p11: table, u12: userdata) -- Line: 40
    -- upvalues: ScrollingFrame (copy), Template (copy), Players (copy), u2 (copy), TradeMenu (copy), u3 (copy), ReplicatedStorage (copy), u6 (copy)
    local v13 = tostring(u12.UserId);
    local v14 = ScrollingFrame:FindFirstChild(v13);

    if not v14 then
        v14 = Template:Clone();
        v14.Name = v13;
        v14.Title.Text = "@" .. u12.Name;
        local success, result = pcall(function() -- Line: 49
            -- upvalues: Players (ref), u12 (copy)
            return Players:GetUserThumbnailAsync(u12.UserId, Enum.ThumbnailType.AvatarBust, Enum.ThumbnailSize.Size48x48);
        end);

        if success then
            v14.Headshot.Image = result;
        end;

        local _ = u12.Name .. " Inventory\'s";
        local u15 = v14.Options.Inventory.Activated:Connect(function() -- Line: 59
            -- upvalues: u2 (ref), u12 (copy), TradeMenu (ref)
            if u2:CanViewInventory(u12) then
                u2:OpenInventory(u12, TradeMenu);
            end;
        end);
        local u16 = v14.Options.Send.Activated:Connect(function() -- Line: 65
            -- upvalues: u12 (copy), u3 (ref), ReplicatedStorage (ref)
            if u12.Parent ~= nil and u3:CanSendRequest(u12) then
                ReplicatedStorage.GameEvents.TradeEvents.SendRequest:FireServer(u12);
            end;
        end);
        local u17 = u12:GetAttributeChangedSignal(u3.PERMISSION_ATTRIBUTE):Connect(function() -- Line: 72
            -- upvalues: u6 (ref)
            u6:Update();
        end);
        v14.Destroying:Once(function() -- Line: 76
            -- upvalues: u15 (ref), u16 (ref), u17 (ref)
            u15:Disconnect();
            u16:Disconnect();
            u17:Disconnect();
        end);
        v14.Parent = ScrollingFrame;
    end;

    return v14;
end;

function u6.Update(p18) -- Line: 87
    -- upvalues: Players2 (copy), TradeMenu (copy), u5 (ref), Players (copy), u6 (copy), u4 (copy), u3 (copy), u2 (copy)
    if Players2.Visible and (TradeMenu.Enabled and u5) then
        u5 = false;
        Players2.Empty.Visible = #Players:GetPlayers() < 2;
        u6:Clear();

        for _, v in Players:GetPlayers() do
            if v ~= u4 then
                local CardFor = u6:GetCardFor(v);
                local v19 = u3:CanSendRequest(v);
                local v20 = u2:CanViewInventory(v);

                if v19 then
                    CardFor.Image = "rbxassetid://101580464985706";
                    CardFor.Options.Send.BackgroundColor3 = Color3.fromRGB(55, 237, 41);
                    CardFor.Options.Send.UIStroke.Color = Color3.fromRGB(11, 152, 0);
                    CardFor.Options.Send.Label.TextTransparency = 0;
                    CardFor.Options.Send.Label.UIStroke.Color = Color3.fromRGB(0, 85, 0);
                    CardFor.Options.Send.Label.UIStroke.Transparency = 0;
                else
                    CardFor.Image = "rbxassetid://128773672676095";
                    CardFor.Options.Send.BackgroundColor3 = Color3.fromRGB(92, 92, 92);
                    CardFor.Options.Send.UIStroke.Color = Color3.fromRGB(65, 65, 65);
                    CardFor.Options.Send.Label.TextTransparency = 0.65;
                    CardFor.Options.Send.Label.UIStroke.Color = Color3.fromRGB(53, 53, 53);
                    CardFor.Options.Send.Label.UIStroke.Transparency = 0.75;
                end;

                if v20 then
                    CardFor.Options.Inventory.BackgroundColor3 = Color3.fromRGB(0, 192, 255);
                    CardFor.Options.Inventory.UIStroke.Color = Color3.fromRGB(0, 99, 132);
                    CardFor.Options.Inventory.Label.TextTransparency = 0;
                    CardFor.Options.Inventory.Label.UIStroke.Color = Color3.fromRGB(0, 70, 103);
                    CardFor.Options.Inventory.Label.UIStroke.Transparency = 0;
                else
                    CardFor.Options.Inventory.BackgroundColor3 = Color3.fromRGB(92, 92, 92);
                    CardFor.Options.Inventory.UIStroke.Color = Color3.fromRGB(65, 65, 65);
                    CardFor.Options.Inventory.Label.TextTransparency = 0.65;
                    CardFor.Options.Inventory.Label.UIStroke.Color = Color3.fromRGB(53, 53, 53);
                    CardFor.Options.Inventory.Label.UIStroke.Transparency = 0.75;
                end;
            end;
        end;

        u5 = true;
    end;
end;

function u6.Clear(p21) -- Line: 136
    -- upvalues: ScrollingFrame (copy), Players (copy)
    for _, child in ScrollingFrame:GetChildren() do
        if not (child:IsA("UIComponent") or Players:GetPlayerByUserId((tonumber(child.Name)))) then
            child:Destroy();
        end;
    end;
end;

return u6;