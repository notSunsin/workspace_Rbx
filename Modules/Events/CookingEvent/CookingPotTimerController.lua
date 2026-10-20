-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local _ = Players.LocalPlayer;
local CollectionService = game:GetService("CollectionService");
game:GetService("RunService");
game:GetService("TweenService");
local DataService = require(ReplicatedStorage.Modules.DataService);
require(ReplicatedStorage.Modules.TimeHelper);
require(ReplicatedStorage.Modules.UpdateService);
local NumberUtil = require(ReplicatedStorage.Modules.NumberUtil);
local CookingPotClientUtils = require(ReplicatedStorage.Modules.Events.CookingEvent.CookingPotClientUtils);
local IsDev = require(ReplicatedStorage.Modules.IsDev);
local EventRotationController = require(ReplicatedStorage.Modules.EventRotation.EventRotationController);
local u1 = require(ReplicatedStorage.Modules.Trove).new();
local LocalPlayer = Players.LocalPlayer;
local u12 = {
    Start = function(p2) -- Line: 25, Name: Start
        -- upvalues: CollectionService (copy), IsDev (copy), CookingPotClientUtils (copy), LocalPlayer (copy), NumberUtil (copy), DataService (copy)
        local v3 = CollectionService:GetTagged("CookingEventModel")[1];

        if not v3 then
            local v4 = 0;

            while v3 == nil or v4 <= 5 do
                v3 = CollectionService:GetTagged("CookingEventModel")[1];
                v4 = v4 + task.wait(0.5);

                if v4 > 5 then
                    warn("CookingPotSharedVisuals | Could not find CookingEventModel");
                    break;
                end;
            end;
        end;

        if v3 and not v3.Parent then
            return;
        end;

        if not v3:WaitForChild("CookingPotPart") then
            return;
        end;

        local TimeLabel = v3:FindFirstChild("IngredientsBoard"):FindFirstChild("CookTimeDisplay").Face.SurfaceGui.TimeDisplayFrame.TimeLabel;
        local TextColor3 = TimeLabel.TextColor3;
        local u5 = false;

        local function StudioWarn(p6) -- Line: 51
            -- upvalues: IsDev (ref)
            if IsDev() then
                warn(p6);
            end;
        end;

        local function UpdateTimer() -- Line: 57
            -- upvalues: CookingPotClientUtils (ref), LocalPlayer (ref), u5 (ref), TimeLabel (copy), NumberUtil (ref), TextColor3 (copy)
            local CookingPotData = CookingPotClientUtils:GetCookingPotData(LocalPlayer, "OLD_KITCHEN_COOKING_EVENT");

            if not CookingPotData then
                u5 = false;

                return;
            end;

            local v7 = CookingPotData.CookingEndTime or nil;

            if CookingPotData.FinishedFoodRawData ~= nil and v7 == nil then
                TimeLabel.Text = "🍳Ready";

                return;
            end;

            if v7 == nil then
                u5 = false;

                return;
            end;

            local v8 = workspace:GetAttribute("KitchenStormLevel") or 0;
            local v9 = v7 - workspace:GetServerTimeNow();
            local math_max_ret = math.max(0, v9);
            local math_round_ret = math.round(math_max_ret);
            local v10 = NumberUtil.toMS(math_round_ret);
            TimeLabel.Text = `{v8 > 0 and "⚡" or "⌛"}{v10}`;
            local v11;

            if v8 > 0 and not (math_round_ret <= 0) then
                v11 = Color3.fromRGB(0, 85, 0);
            else
                v11 = TextColor3;
            end;

            TimeLabel.TextColor3 = v11;
        end;

        local function StartTimer() -- Line: 89
            -- upvalues: u5 (ref), UpdateTimer (copy)
            task.spawn(function() -- Line: 90
                -- upvalues: u5 (ref), UpdateTimer (ref)
                if u5 then
                    return;
                end;

                u5 = true;

                while u5 do
                    UpdateTimer();
                    task.wait(0.2);
                end;
            end);
        end;

        DataService:GetPathSignal("CookingPot/CookingEndTime"):Connect(StartTimer);
        task.spawn(function() -- Line: 90
            -- upvalues: u5 (ref), UpdateTimer (copy)
            if u5 then
                return;
            end;

            u5 = true;

            while u5 do
                UpdateTimer();
                task.wait(0.2);
            end;
        end);
    end
};
local u13 = false;
EventRotationController.EventUpdated:Connect(function(p14: string, p15: string) -- Line: 179, Name: OnEventUpdated
    -- upvalues: u1 (copy), u13 (ref), u12 (copy)
    if p15 ~= "CookingEvent" then
        u1:Clean();
        u13 = false;

        return;
    end;

    if u13 then
        return;
    end;

    u13 = true;
    u1:Clean();
    task.spawn(u12.Start, u12);
end);

return u12;