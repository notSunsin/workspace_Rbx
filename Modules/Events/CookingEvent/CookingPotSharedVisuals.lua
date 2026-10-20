-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local CollectionService = game:GetService("CollectionService");
local DataService = require(ReplicatedStorage.Modules.DataService);
local EventRotationController = require(ReplicatedStorage.Modules.EventRotation.EventRotationController);
local u1 = require(ReplicatedStorage.Modules.Trove).new();
local u14 = {
    Start = function(p2) -- Line: 15, Name: Start
        -- upvalues: CollectionService (copy), DataService (copy), RunService (copy)
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

        local SpinPlayerCollider = v3:FindFirstChild("VisualParts"):FindFirstChild("SpinPlayerCollider");
        local u5 = 1;
        local u6 = {};
        local u7 = {
            ["Left Leg"] = true,
            ["Right Leg"] = true
        };
        local u8 = {};
        SpinPlayerCollider.Touched:Connect(function(p9) -- Line: 44
            -- upvalues: u7 (copy), u6 (copy), u8 (copy), DataService (ref), RunService (ref), u5 (ref)
            local u10 = p9:FindFirstAncestorOfClass("Model");

            if not u10 then
                return;
            end;

            if not u10:FindFirstChildWhichIsA("Humanoid") then
                return;
            end;

            if not u7[p9.Name] then
                return;
            end;

            if p9:IsA("Tool") then
                return;
            end;

            local PlayerFromCharacter = game.Players:GetPlayerFromCharacter(u10);

            if not PlayerFromCharacter or u6[PlayerFromCharacter] then
                return;
            end;

            if u8[PlayerFromCharacter] ~= nil then
                return;
            end;

            local Data = DataService:GetData();

            if not Data then
                warn("CookingPotSharedVisuals | No Player Data");

                return;
            end;

            local IsCooking = Data.CookingPot.IsCooking;

            if next(Data.CookingPot.SubmittedIngredients) == nil and not IsCooking then
                return;
            end;

            u6[PlayerFromCharacter] = true;
            local HumanoidRootPart = u10:FindFirstChild("HumanoidRootPart");

            if HumanoidRootPart then
                u8[PlayerFromCharacter] = RunService.Heartbeat:Connect(function(p11) -- Line: 71
                    -- upvalues: u6 (ref), PlayerFromCharacter (copy), HumanoidRootPart (copy), u8 (ref), u10 (copy), u5 (ref)
                    if u6[PlayerFromCharacter] and HumanoidRootPart.Parent then
                        u10:PivotTo(u10:GetPivot() * CFrame.Angles(0, math.rad(90 * p11 * u5), 0));

                        return;
                    end;

                    if u8[PlayerFromCharacter] == nil then
                        return;
                    end;

                    u8[PlayerFromCharacter]:Disconnect();
                    u8[PlayerFromCharacter] = nil;
                end);
            end;
        end);
        SpinPlayerCollider.TouchEnded:Connect(function(p12) -- Line: 87
            -- upvalues: u6 (copy)
            local v13 = p12:FindFirstAncestorOfClass("Model");

            if not v13 then
                return;
            end;

            local PlayerFromCharacter = game.Players:GetPlayerFromCharacter(v13);

            if PlayerFromCharacter then
                u6[PlayerFromCharacter] = nil;
            end;
        end);
        workspace:GetAttributeChangedSignal("KitchenStormLevel"):Connect(function() -- Line: 97
            -- upvalues: u5 (ref)
            if workspace:GetAttribute("KitchenStormLevel") then
                u5 = 1 + 0.5 * workspace:GetAttribute("KitchenStormLevel");

                return;
            end;

            u5 = 1;
        end);

        if workspace:GetAttribute("KitchenStormLevel") then
            task.defer(function() -- Line: 107
                -- upvalues: u5 (ref)
                u5 = 1 + 0.5 * workspace:GetAttribute("KitchenStormLevel");
            end);
        else
            u5 = 1;
        end;
    end
};
local u15 = false;
EventRotationController.EventUpdated:Connect(function(p16: string, p17: string) -- Line: 116, Name: OnEventUpdated
    -- upvalues: u1 (copy), u15 (ref), u14 (copy)
    if p17 ~= "CookingEvent" then
        u1:Clean();
        u15 = false;

        return;
    end;

    if u15 then
        return;
    end;

    u15 = true;
    u1:Clean();
    task.spawn(u14.Start, u14);
end);

return u14;