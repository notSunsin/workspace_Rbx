-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CollectionService = game:GetService("CollectionService");
game:GetService("ReplicatedFirst");
game:GetService("Players");
local UpdateService = require(ReplicatedStorage.Modules.UpdateService);
local DataService = require(ReplicatedStorage.Modules.DataService);
local FastTween = require(ReplicatedStorage.Modules.FastTween);
require(ReplicatedStorage.Modules.Chalk);
local EventRotationController = require(ReplicatedStorage.Modules.EventRotation.EventRotationController);
local u1 = require(ReplicatedStorage.Modules.Trove).new();
local GameEvents = ReplicatedStorage:WaitForChild("GameEvents");
local _ = GameEvents.Notification;
local UpdateKitchenStormBar = GameEvents.Events.CookingEvent.UpdateKitchenStormBar;
local u11 = {
    Start = function(p2) -- Line: 22, Name: Start
        -- upvalues: CollectionService (copy), DataService (copy), FastTween (copy), u1 (copy), UpdateKitchenStormBar (copy), UpdateService (copy)
        local v3 = CollectionService:GetTagged("PigChefModel")[1];

        if not v3 then
            local v4 = 0;

            while v3 == nil or v4 <= 5 do
                v3 = CollectionService:GetTagged("PigChefModel")[1];
                v4 = v4 + task.wait(0.5);

                if v4 > 5 then
                    warn("KitchenStormManager | Could not find PigChefModel");
                    break;
                end;
            end;
        end;

        if v3 and not v3.Parent then
            return;
        end;

        local BillboardGui = v3.Parent:FindFirstChild("Cravings"):FindFirstChild("EventBar"):FindFirstChild("BillboardGui");
        local UpgradeBar = BillboardGui:FindFirstChild("UpgradeBar");
        local Fill = UpgradeBar:WaitForChild("Fill");
        local ProgressionLabel = UpgradeBar:WaitForChild("ProgressionLabel");
        local StormLabel = BillboardGui:WaitForChild("StormLabel");

        local function UpdateUI(p5: number?, p6: number?) -- Line: 45
            -- upvalues: DataService (ref), ProgressionLabel (copy), FastTween (ref), Fill (copy)
            local Data = DataService:GetData();

            if not Data then
                return;
            end;

            local v7 = p6 or 40;
            local v8 = p5 or Data.KitchenStormEventData.StormPoints;
            ProgressionLabel.Text = `{math.clamp(v8, 0, v7)}/{v7} Points`;
            local math_clamp_ret = math.clamp(v8 / v7, 0, 1);
            FastTween(Fill, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                Size = UDim2.fromScale(math_clamp_ret, 1)
            });
        end;

        UpdateUI();
        u1:Add(UpdateKitchenStormBar.OnClientEvent:Connect(function(p9: number, p10: number) -- Line: 63
            -- upvalues: UpdateUI (copy)
            UpdateUI(p9, p10);
        end));
        u1:Add(task.spawn(function() -- Line: 67
            -- upvalues: UpdateService (ref), BillboardGui (copy)
            while UpdateService:IsHiddenFromUpdate("KitchenStorm") ~= false do
                task.wait(1);
            end;

            BillboardGui.Enabled = true;
        end));
        u1:Add(workspace:GetAttributeChangedSignal("KitchenStormLevel"):Connect(function() -- Line: 77
            -- upvalues: StormLabel (copy)
            if not workspace:GetAttribute("KitchenStormLevel") then
                StormLabel.Visible = false;

                return;
            end;

            StormLabel.Visible = true;
            StormLabel.Text = `Storm Level: {workspace:GetAttribute("KitchenStormLevel")}`;
        end));
    end
};
local u12 = false;
EventRotationController.EventUpdated:Connect(function(p13: string, p14: string) -- Line: 88, Name: OnEventUpdated
    -- upvalues: u1 (copy), u12 (ref), u11 (copy)
    if p14 ~= "CookingEvent" then
        u1:Clean();
        u12 = false;

        return;
    end;

    if u12 then
        return;
    end;

    u12 = true;
    u1:Clean();
    task.spawn(u11.Start, u11);
end);

return u11;