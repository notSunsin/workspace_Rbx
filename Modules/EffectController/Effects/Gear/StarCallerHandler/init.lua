-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CollectionService = game:GetService("CollectionService");
local SoundPlayer = require(ReplicatedStorage.Modules.SoundPlayer);
local SoundData = require(ReplicatedStorage.Data.SoundData);
require(ReplicatedStorage.Modules.EffectController.Types);

return {
    Create = function(p1) -- Line: 13, Name: Create
        -- upvalues: ReplicatedStorage (copy), CollectionService (copy), SoundPlayer (copy), SoundData (copy)
        local ID = p1.Parameters.ID;
        local _ = p1.Parameters.Redirects;
        p1.Cache[ID] = {};
        local StarCallerCFrame = p1.Parameters.StarCallerCFrame;
        local v2 = ReplicatedStorage.ObjectModels:FindFirstChild(p1.Parameters.StarCallerType);

        if not v2 then
            return;
        end;

        local v3 = v2:Clone();

        if not v2 then
            return;
        end;

        CollectionService:AddTag(v3, "StarCaller");
        v3:SetAttribute("CALLER_ID", ID);

        for _, descendant in v3:GetDescendants() do
            if descendant:IsA("BasePart") then
                descendant.CanQuery = true;
                descendant.CanCollide = true;
            end;
        end;

        p1.Cache[ID].Caller = v3;
        local _, v4 = v3:GetBoundingBox();
        local v5 = v4.Y / 2 - 1;
        v3.PrimaryPart.CFrame = StarCallerCFrame * CFrame.new(0, v5, 0);
        v3.Parent = workspace.Visuals;
        local v6 = p1.Default:CreateEffect({
            Emit = true,
            DebrisTime = 2,
            Object = script.PlaceEffect,
            Position = StarCallerCFrame
        });
        SoundPlayer:PlaySound(SoundData.Tools.Generic.Place, {
            RollOffMaxDistance = 50,
            RollOffMinDistance = 10,
            Volume = 1,
            PlaybackSpeed = 1,
            RollOffMode = Enum.RollOffMode.InverseTapered
        }, nil, v6);
        p1.Libraries.BoatTween:Create(v3.PrimaryPart, {
            Time = 0.8,
            EasingStyle = "Smoother",
            EasingDirection = "In",
            StepType = "Heartbeat",
            Goal = {
                CFrame = StarCallerCFrame * CFrame.new(0, v5, 0)
            }
        }):Play();
        p1.Cache[ID].Caller = v3;
    end,

    Destroy = function(p7) -- Line: 80, Name: Destroy
        -- upvalues: CollectionService (copy), SoundPlayer (copy), SoundData (copy)
        local ID = p7.Parameters.ID;
        local u8 = p7.Cache[ID] and p7.Cache[ID].Caller;

        if not u8 then
            return;
        end;

        CollectionService:RemoveTag(u8, "StarCaller");
        p7.Libraries.BoatTween:Create(u8.PrimaryPart, {
            Time = 0.6,
            EasingStyle = "ExitExpressive",
            EasingDirection = "In",
            StepType = "Heartbeat",
            Goal = {
                CFrame = p7.Parameters.StarCallerCFrame * CFrame.new(0, 3, 0)
            }
        }):Play();
        SoundPlayer:PlaySound(SoundData.Tools.Generic.PlaceableStaffDestroy, {
            RollOffMaxDistance = 50,
            RollOffMinDistance = 10,
            Volume = 1,
            PlaybackSpeed = 1,
            RollOffMode = Enum.RollOffMode.InverseTapered
        }, nil, u8.PrimaryPart);
        task.delay(1.5, function() -- Line: 109
            -- upvalues: u8 (copy)
            u8:Destroy();
        end);
    end,

    Cancel = function(p9) -- Line: 115, Name: Cancel
        p9.Container:Clean();
        p9.Cache = {};
    end
};