-- Decompiled with Potassium's decompiler.

local ProximityPromptService = game:GetService("ProximityPromptService");
local CollectionService = game:GetService("CollectionService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local UserInputService = game:GetService("UserInputService");
local RunService = game:GetService("RunService");
game:GetService("GuiService");
local Players = game:GetService("Players");
local Trove = require(ReplicatedStorage.Modules.Trove);
require(ReplicatedStorage.Modules.Notification);
local GetFarm = require(ReplicatedStorage.Modules.GetFarm);
local InventoryService = require(ReplicatedStorage.Modules.InventoryService);
local Observers = require(ReplicatedStorage.Modules.Observers);
require(ReplicatedStorage.Modules.UseDynamicPrices);
require(ReplicatedStorage.Modules.MarketController);
local GetPlayerFromFarm = require(ReplicatedStorage.Modules.GetPlayerFromFarm);
local CountDictionary = require(ReplicatedStorage.Modules.CountDictionary);
local DevProductIds = require(ReplicatedStorage.Data.DevProductIds);
local Notification = require(ReplicatedStorage.Modules.Notification);
local ConfirmationPromptController = require(ReplicatedStorage.Modules.ConfirmationPromptController);
local MarketController = require(ReplicatedStorage.Modules.MarketController);
local InfGrowPlantData = require(ReplicatedStorage.Data.InfGrowPlantData);
local u1 = RunService:IsStudio() and false;
local LocalPlayer = Players.LocalPlayer;
local PlayerGui = LocalPlayer.PlayerGui;
local HoldToCollect = PlayerGui:WaitForChild("HoldToCollect");
local _ = LocalPlayer.Backpack;
local u2 = {};
local u3 = Trove.new();
local u9 = {
    _lastCollected = 0,
    _holding = false,

    _updateButtonState = function(p4) -- Line: 61, Name: _updateButtonState
        -- upvalues: HoldToCollect (copy), u2 (copy)
        HoldToCollect.Collect.Visible = next(u2) ~= nil;
    end,

    Collect = function(p5) -- Line: 67, Name: Collect
        -- upvalues: u3 (copy), u2 (copy), ReplicatedStorage (copy), InventoryService (copy), CountDictionary (copy), LocalPlayer (copy)
        local os_clock_ret = os.clock();
        u3:Clean();
        local _ = os_clock_ret - p5._lastCollected;
        p5._lastCollected = os_clock_ret;
        local v6 = {};

        for i, _ in u2 do
            i:SetAttribute("Collected", true);
            task.delay(1, function() -- Line: 89
                -- upvalues: i (copy)
                i:SetAttribute("Collected", nil);
            end);
            local v7 = i.Parent and i.Parent.Parent;

            if v7 then
                table.insert(v6, v7);
            end;
        end;

        if #v6 > 0 then
            p5._lastCollected = os_clock_ret;
            ReplicatedStorage.GameEvents.Crops.Collect:FireServer(v6);

            if CountDictionary((InventoryService:Find("Holdable"))) >= 200 + (LocalPlayer:GetAttribute("BonusBackpackSize") or 0) then
                return;
            end;

            local v8;

            if v6[1].Variant.Value == "Normal" then
                v8 = game.SoundService.Collect.Name;
            else
                v8 = v6[1].Variant.Value;
            end;

            game.ReplicatedStorage.GameEvents.PickupEvent:Fire(v8);
        end;
    end
};
local Queue = require(game.ReplicatedStorage.Code.Queue);
local PickupParticle = workspace.Terrain:WaitForChild("PickupParticle");

function u9.Start(u10) -- Line: 124
    -- upvalues: UserInputService (copy), u1 (copy), HoldToCollect (copy), ProximityPromptService (copy), u2 (copy), PlayerGui (copy), LocalPlayer (copy), GetFarm (copy), Queue (copy), InventoryService (copy), PickupParticle (copy), InfGrowPlantData (copy), Observers (copy), GetPlayerFromFarm (copy), Notification (copy), CountDictionary (copy), DevProductIds (copy), CollectionService (copy), MarketController (copy), ConfirmationPromptController (copy)
    UserInputService.LastInputTypeChanged:Connect(function() -- Line: 126, Name: updateHoldToCollect
        -- upvalues: UserInputService (ref), u1 (ref), HoldToCollect (ref)
        local v11 = UserInputService.TouchEnabled and UserInputService:GetLastInputType() == Enum.UserInputType.Touch;
        HoldToCollect.Enabled = v11 or u1;
    end);
    local v12 = UserInputService.TouchEnabled and UserInputService:GetLastInputType() == Enum.UserInputType.Touch;
    HoldToCollect.Enabled = v12 or u1;
    task.delay(3, function() -- Line: 137
        -- upvalues: UserInputService (ref), u1 (ref), HoldToCollect (ref)
        local v13 = UserInputService.TouchEnabled and UserInputService:GetLastInputType() == Enum.UserInputType.Touch;
        HoldToCollect.Enabled = v13 or u1;
    end);
    local u14 = nil;
    local u15 = 0;
    local u16 = nil;
    ProximityPromptService.PromptShown:Connect(function(p17) -- Line: 147
        -- upvalues: u2 (ref), u10 (copy), u16 (ref)
        if p17:HasTag("CollectPrompt") then
            u2[p17] = true;
            u10:_updateButtonState();
        end;

        u16 = p17;
    end);
    ProximityPromptService.PromptHidden:Connect(function(p18) -- Line: 156
        -- upvalues: u2 (ref), u10 (copy), u16 (ref)
        if p18:HasTag("CollectPrompt") then
            u2[p18] = nil;
            u10:_updateButtonState();
        end;

        if u16 == p18 then
            u16 = nil;
        end;
    end);

    local function RunHoldLoop(p19) -- Line: 167
        -- upvalues: u10 (copy), u15 (ref), PlayerGui (ref), LocalPlayer (ref), GetFarm (ref), Queue (ref), u16 (ref), ProximityPromptService (ref), u2 (ref), InventoryService (ref), PickupParticle (ref)
        if u10._holding then
            return;
        end;

        u10._holding = true;
        u15 = 0;
        PlayerGui.PickupTally.TextLabel.val:SetAttribute("LastUpdate", os.time() - 5);
        PlayerGui.PickupTally.TextLabel.val:SetAttribute("ActualValue", 0);
        LocalPlayer.PlayerScripts.CollectionQOL.Enabled = false;
        local v20 = GetFarm(LocalPlayer);
        local u21 = Queue.new();

        if u16 then
            u21:enqueue(u16);
        end;

        ProximityPromptService.PromptShown:Connect(function(p22) -- Line: 195
            -- upvalues: u21 (copy)
            if not table.find(u21._queue, p22) then
                u21:enqueue(p22);
            end;
        end);

        while true do
            while true do
                if not u10._holding then
                    LocalPlayer.PlayerScripts.CollectionQOL.Enabled = true;

                    return;
                end;

                if u21:isEmpty() then
                    break;
                end;

                local u23 = u21:dequeue();
                os.time();

                if u23 then
                    if u23:IsDescendantOf(v20) and (u23:HasTag("CollectPrompt") and (u23:GetAttribute("Collected") ~= true and (u23:IsDescendantOf(v20) and (u23:IsDescendantOf(workspace) and u23.Enabled)))) then
                        u23.Enabled = false;
                        task.delay(1, function() -- Line: 238
                            -- upvalues: u23 (copy)
                            if u23 and u23:IsDescendantOf(workspace) then
                                u23.Enabled = true;
                            end;
                        end);
                        u2[u23] = true;
                        u10:_updateButtonState();
                        u10:Collect();

                        if (u23.Parent and u23.Parent.Parent):FindFirstChild("Variant") then
                            if InventoryService.IsMaxInventory(LocalPlayer) == false then
                                PickupParticle.WorldPosition = u23.Parent.Position;
                                PickupParticle.ParticleEmitter:Emit(Random.new():NextInteger(1, 3));
                                PickupParticle.Gradient:Emit(1);
                            end;

                            task.wait(0.125);
                        end;
                    end;
                else
                    task.wait(0.125);
                end;
            end;

            task.wait(0.125);
        end;
    end;

    ProximityPromptService.PromptTriggered:Connect(function(p24) -- Line: 351
        -- upvalues: UserInputService (ref), RunHoldLoop (copy)
        if not p24:HasTag("CollectPrompt") then
            return;
        end;

        if not (UserInputService:IsKeyDown(Enum.KeyCode.E) or UserInputService:IsGamepadButtonDown(Enum.UserInputType.Gamepad1, Enum.KeyCode.ButtonX)) then
            return;
        end;

        local u25 = false;
        local u26 = nil;
        u26 = UserInputService.InputEnded:Connect(function(p27) -- Line: 366
            -- upvalues: u26 (ref), u25 (ref)
            if p27.KeyCode == Enum.KeyCode.E or p27.KeyCode == Enum.KeyCode.ButtonX then
                u26:Disconnect();
                u25 = true;
            end;
        end);
        task.wait(1);

        if not u25 then
            u26:Disconnect();
            RunHoldLoop(false);
        end;
    end);
    UserInputService.InputBegan:Connect(function(p28: userdata, p29: boolean) -- Line: 381
        -- upvalues: u14 (ref), UserInputService (ref), RunHoldLoop (copy)
        if not (p29 or p28.KeyCode ~= Enum.KeyCode.E and p28.KeyCode ~= Enum.KeyCode.ButtonX) then
            u14 = p28;
            local u30 = false;
            local u31 = nil;
            u31 = UserInputService.InputEnded:Connect(function(p32) -- Line: 389
                -- upvalues: u31 (ref), u30 (ref)
                if p32.KeyCode == Enum.KeyCode.E or p32.KeyCode == Enum.KeyCode.ButtonX then
                    u31:Disconnect();
                    u30 = true;
                end;
            end);
            task.wait(1);

            if not u30 and (game:GetService("UserInputService"):IsGamepadButtonDown(Enum.UserInputType.Gamepad1, Enum.KeyCode.ButtonX) or game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.E)) then
                u31:Disconnect();
                RunHoldLoop(false);
            end;
        end;
    end);
    u10:_updateButtonState();
    HoldToCollect.Collect.MouseButton1Down:Connect(function() -- Line: 415
        -- upvalues: u10 (copy), HoldToCollect (ref), RunHoldLoop (copy)
        u10:Collect();
        local u33 = false;
        local u34 = nil;
        u34 = HoldToCollect.Collect.MouseButton1Up:Connect(function() -- Line: 420
            -- upvalues: u33 (ref), u34 (ref)
            u33 = true;

            if u34 then
                u34:Disconnect();
            end;
        end);
        task.delay(0.1, function() -- Line: 427
            -- upvalues: u34 (ref), u33 (ref), RunHoldLoop (ref)
            if u34 then
                u34:Disconnect();
            end;

            if u33 then
                return;
            end;

            RunHoldLoop(true);
        end);
    end);
    UserInputService.InputEnded:Connect(function(p35: userdata, p36: boolean) -- Line: 440
        -- upvalues: u10 (copy)
        if p35.KeyCode == Enum.KeyCode.E or p35.KeyCode == Enum.KeyCode.ButtonX then
            u10._holding = false;
        end;

        if p35.UserInputType == Enum.UserInputType.Touch or p35.UserInputType == Enum.UserInputType.MouseButton1 then
            u10._holding = false;
        end;
    end);
    UserInputService.WindowFocusReleased:Connect(function() -- Line: 453
        -- upvalues: u10 (copy)
        u10._holding = false;
    end);
    PlayerGui:WaitForChild("PickupTally").Enabled = true;

    local function HarvestableCropValidation(p37: userdata, p38: userdata, p39: userdata) -- Line: 467
        -- upvalues: InfGrowPlantData (ref)
        local _ = p38.Name;
        local v40 = p38:FindFirstAncestor("Farm");

        if not p38:IsDescendantOf(p39) and v40 then
            local _ = v40:GetAttribute("CommunityGarden") == true;
        end;

        if not p38:IsDescendantOf(workspace) or p38.Parent == nil then
            return false;
        end;

        local Attribute = p38:GetAttribute("MaxAge");

        if not Attribute then
            return false;
        end;

        local Age = p38:FindFirstChild("Grow"):FindFirstChild("Age");

        if not Age then
            return false;
        end;

        local v41 = InfGrowPlantData.InfGrowPlants[p38.Name];

        if v41 and os.time() < v41.CollectionDate then
            return false;
        end;

        if Age.Value < Attribute and not v41 then
            return false;
        end;

        if p38:GetAttribute("Collected") then
            return false;
        end;

        if p38:FindFirstChild("Item_Seed") then
            return p38:FindFirstChild("Variant") and true or false;
        end;

        return false;
    end;

    Observers.observeTag("CollectAllSign", function(p42: userdata) -- Line: 513
        -- upvalues: GetPlayerFromFarm (ref), Notification (ref), InventoryService (ref), CountDictionary (ref), DevProductIds (ref), CollectionService (ref), HarvestableCropValidation (copy), LocalPlayer (ref), MarketController (ref), ConfirmationPromptController (ref)
        local PrimaryPart = p42.PrimaryPart;

        if not PrimaryPart then
            return nil;
        end;

        local v43 = PrimaryPart:FindFirstChildOfClass("ProximityPrompt");

        if not v43 then
            return nil;
        end;

        local Parent = p42.Parent;

        if not Parent then
            return nil;
        end;

        v43.Triggered:Connect(function(p44: userdata) -- Line: 532
            -- upvalues: GetPlayerFromFarm (ref), Parent (copy), Notification (ref), InventoryService (ref), CountDictionary (ref), DevProductIds (ref), CollectionService (ref), HarvestableCropValidation (ref), LocalPlayer (ref), MarketController (ref), ConfirmationPromptController (ref)
            if GetPlayerFromFarm(Parent) ~= p44 then
                Notification:CreateNotification("Not your farm!");

                return;
            end;

            if p44:GetAttribute("RunningCollectAll") then
                Notification:CreateNotification("You\'re already collecting, please wait.");

                return;
            end;

            local v45 = CountDictionary((InventoryService:Find("Holdable")));
            local v46 = p44:GetAttribute("BonusBackpackSize") or 0;

            if 200 + v46 <= v45 then
                Notification:CreateNotification("Max backpack space! Go sell!");

                return;
            end;

            local v47 = 200 + v46 - v45;
            local Owner = Parent:FindFirstChild("Owner", true);

            if not (Owner and Owner.Value) then
                return;
            end;

            local Target_Item = p44:FindFirstChild("Target_Item");

            if not Target_Item then
                return;
            end;

            Target_Item.Value = Owner;
            local PurchaseID = DevProductIds.CollectAll.PurchaseID;
            local v48 = 0;

            for _, v in CollectionService:GetTagged("Harvestable") do
                if v:IsDescendantOf(Parent) and (not v:GetAttribute("Favorited") and HarvestableCropValidation(LocalPlayer, v, Parent)) then
                    v48 = v48 + 1;
                end;
            end;

            if v47 <= v48 then
                v48 = v47;
            end;

            if v48 == 0 then
                Notification:CreateNotification("No harvestable plants found!");

                return;
            end;

            local ProductInfo, v49 = MarketController:GetProductInfo(DevProductIds.CollectAll.PurchaseID, Enum.InfoType.Product);

            if not ProductInfo then
                warn("No product info for CollectAll");

                return;
            end;

            local PriceInRobux = v49.PriceInRobux;
            ConfirmationPromptController:Open({
                Title = "Harvest All",
                Footer = "This action cannot be undone. <font color=\'#ff0000\'>Please do not leave while it\'s collecting!</font>",
                ConfirmText = "Buy",
                RejectText = "Cancel",
                Header = `You are about to harvest as much as you can from your farm. <font color='#55ff00'>({v48} plants)</font>`,
                Middle = `Are you sure you want to do this for {PriceInRobux}R$?`
            }, {
                ConfirmCallback = function() -- Line: 608, Name: ConfirmCallback
                    -- upvalues: MarketController (ref), PurchaseID (copy)
                    MarketController:PromptPurchase(PurchaseID, Enum.InfoType.Product);
                end
            });
        end);

        return nil;
    end, { workspace });
end;

task.spawn(function() -- Line: 618
    -- upvalues: u9 (copy)
    while true do
        task.wait(2);
        u9:_updateButtonState();
    end;
end);
task.spawn(u9.Start, u9);

return u9;