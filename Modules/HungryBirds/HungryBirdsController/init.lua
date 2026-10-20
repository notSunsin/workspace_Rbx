-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local Players = game:GetService("Players");
require(ReplicatedStorage.Modules.GuiController);
require(ReplicatedStorage.Modules.Trove);
require(ReplicatedStorage.Modules.ItemImageFinder);
require(ReplicatedStorage.Modules.NumberUtil);
require(ReplicatedStorage.Modules.CommaFormatNumber);
local GiveServiceCommon = require(ReplicatedStorage.Modules.GiveServiceCommon);
require(ReplicatedStorage.Modules.UpdateService);
require(ReplicatedStorage.Modules.Signal);
local DataService = require(ReplicatedStorage.Modules.DataService);
local EventService = require(ReplicatedStorage.Modules.EventService);
require(ReplicatedStorage.Modules.QuestsController);
require(ReplicatedStorage.Modules.CreateTagHandler);
local Notification = require(ReplicatedStorage.Modules.Notification);
local InventoryServiceEnums = require(ReplicatedStorage.Data.EnumRegistry.InventoryServiceEnums);
require(ReplicatedStorage.Code.Spr);
require(ReplicatedStorage.Modules.MarketController);
local script_DecorativeBirds = require(script.DecorativeBirds);
local script_RewardPopup = require(script.RewardPopup);
require(ReplicatedStorage.Data.SharedCycleHandlerData);
local LocalPlayer = Players.LocalPlayer;
local _ = workspace.CurrentCamera;
local HungryBirdsController = EventService.new("HungryBirdsController", "Hungry Birds Event");
local FeedBirds = ReplicatedStorage.GameEvents.HungryBirds.FeedBirds;
local ProximityPrompt = Instance.new("ProximityPrompt");
ProximityPrompt.Name = "ForceHatchPrompt";
ProximityPrompt.Style = Enum.ProximityPromptStyle.Custom;
ProximityPrompt.HoldDuration = 0.5;
ProximityPrompt.MaxActivationDistance = 15;
ProximityPrompt.RequiresLineOfSight = false;
ProximityPrompt.KeyboardKeyCode = Enum.KeyCode.F;
ProximityPrompt.ActionText = "Feed";
ProximityPrompt.ObjectText = "FEED";
local u1 = nil;
local u2 = nil;
local u3 = nil;
local RaycastParams_new_ret = RaycastParams.new();
RaycastParams_new_ret.FilterDescendantsInstances = { game.Workspace.Interaction, game.Workspace.BasePlate };
RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Include;

function HungryBirdsController.OnStarted(u4) -- Line: 71
    -- upvalues: u1 (ref), u2 (ref), ProximityPrompt (copy), LocalPlayer (copy), DataService (copy), Notification (copy), InventoryServiceEnums (copy), u3 (ref), FeedBirds (copy), script_DecorativeBirds (copy), script_RewardPopup (copy), GiveServiceCommon (copy)
    u1 = game.Workspace.Interaction:WaitForChild("Bird_Nest");
    u2 = u1.PrimaryPart:WaitForChild("BillboardGui");
    ProximityPrompt.Parent = u1.PrimaryPart;

    local function GetRandomPositionAroundNest(p5: vector, p6: number, p7: number, p8: number) -- Line: 80
        local v9 = math.random() * 3.141592653589793 * 2;
        local v10 = p6 + math.random() * (p7 - p6);
        local v11 = math.cos(v9) * v10;
        local v12 = math.sin(v9) * v10;

        return CFrame.new(p5.X + v11, p5.Y + p8, p5.Z + v12);
    end;

    u4:Bind(ProximityPrompt.Triggered:Connect(function(p13) -- Line: 95
        -- upvalues: LocalPlayer (ref), DataService (ref), Notification (ref), InventoryServiceEnums (ref), u3 (ref), FeedBirds (ref)
        if p13 ~= LocalPlayer then
            return;
        end;

        local Data = DataService:GetData();

        if not (Data and Data.HungryBirdsEvent) then
            return;
        end;

        local Character = p13.Character;

        if not Character then
            return;
        end;

        local v14 = Character:FindFirstChildWhichIsA("Tool");

        if not v14 then
            return Notification:CreateNotification("No food equipped!");
        end;

        if not (v14:HasTag("FruitTool") or v14:HasTag("FoodTool")) then
            return Notification:CreateNotification("No food equipped!");
        end;

        if v14:GetAttribute(InventoryServiceEnums.Favorite) then
            return Notification:CreateNotification("You cannot feed pets Favorited fruit.");
        end;

        if v14:HasTag("Fed") then
            return;
        end;

        if (Data.HungryBirdsEvent.CooldownTime or 0) - game.Workspace:GetServerTimeNow() > 0 then
            return Notification:CreateNotification("You can only place down one food at a time!");
        end;

        if u3 then
            u3 = u3:Destroy();
        end;

        u3 = v14:Clone();
        FeedBirds:FireServer("Feed");
    end));
    u4:Bind(task.spawn(function() -- Line: 153
        -- upvalues: DataService (ref), ProximityPrompt (ref), Notification (ref)
        while true do
            local v15;

            repeat
                task.wait(1);
                v15 = DataService:GetData();
            until v15 and v15.HungryBirdsEvent;

            local v16 = (v15.HungryBirdsEvent.CooldownTime or 0) - game.Workspace:GetServerTimeNow();

            if (v16 <= 0 or v16 > 5) and (v16 <= 0 and not ProximityPrompt.Enabled) then
                Notification:CreateNotification("The birds are hungry!");
            end;
        end;
    end));
    local u17 = script_DecorativeBirds.new(u1.PrimaryPart.Position, {
        PetTypes = { "Cuckoo", "Gold Finch", "Brown Owl", "Black Bird", "Birb" }
    });
    u17:Start();
    u4:Bind(function() -- Line: 189
        -- upvalues: u17 (copy)
        if not u17 then
            return;
        end;

        u17:Stop();
    end);
    u4:Bind(FeedBirds.OnClientEvent:Connect(function(p18, u19, p20) -- Line: 195
        -- upvalues: u3 (ref), u1 (ref), GetRandomPositionAroundNest (copy), u4 (copy), u17 (copy), script_RewardPopup (ref), GiveServiceCommon (ref), Notification (ref)
        if not u3 then
            return;
        end;

        local v21 = u3:Clone();
        u3 = u3:Destroy();
        local Model = Instance.new("Model");

        for _, descendant in pairs(v21:GetDescendants()) do
            if descendant:IsA("BasePart") then
                descendant.Anchored = true;
                descendant.Parent = Model;

                if descendant.Name == "Handle" then
                    Model.PrimaryPart = descendant;
                end;
            end;
        end;

        v21:Destroy();
        local _, v22 = Model:GetBoundingBox();
        Model:ScaleTo(2 / v22.Y);
        Model.Parent = u1;
        local _, v23 = Model:GetBoundingBox();
        local u24 = GetRandomPositionAroundNest(u1.PrimaryPart.Position, 0, 0, v23.Y / 2);
        Model:PivotTo(u24);
        u4:Bind(task.delay(p20, function() -- Line: 254
            -- upvalues: u17 (ref), Model (copy), script_RewardPopup (ref), u24 (copy), GiveServiceCommon (ref), u19 (copy), Notification (ref)
            u17:AddFood(Model.PrimaryPart, function() -- Line: 255
                -- upvalues: script_RewardPopup (ref), u24 (ref), GiveServiceCommon (ref), u19 (ref), Notification (ref)
                script_RewardPopup.Create(u24.Position, GiveServiceCommon:GetImage(u19), {
                    PopHeight = 5,
                    HoverDuration = 2,
                    CurveHeight = 25,
                    FollowDuration = 1.35
                }, function() -- Line: 262
                    -- upvalues: Notification (ref), GiveServiceCommon (ref), u19 (ref)
                    Notification:CreateNotification((`The birds rewarded you with {GiveServiceCommon:Format(u19)}!`));
                end);
            end);
        end));
    end));
end;

function HungryBirdsController.OnEnded(p25) -- Line: 272
end;

return HungryBirdsController;