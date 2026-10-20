-- Decompiled with Potassium's decompiler.

local CollectionService = game:GetService("CollectionService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local GetFarmAsync = require(ReplicatedStorage.Modules.GetFarmAsync);

local function GetHive(p1: userdata) -- Line: 10
    -- upvalues: GetFarmAsync (copy)
    local v2 = GetFarmAsync(p1);

    if not v2 then
        return nil;
    end;

    local CurrentExpansion = v2:FindFirstChild("CurrentExpansion");

    if CurrentExpansion then
        CurrentExpansion = CurrentExpansion:FindFirstChild("Custom");
    end;

    if CurrentExpansion then
        CurrentExpansion = CurrentExpansion:FindFirstChild("Hive");
    end;

    return CurrentExpansion;
end;

local function FindClosestUnclaimedBeeSlot(p3: vector, p4: table, p5: userdata?) -- Line: 36
    -- upvalues: CollectionService (copy)
    local v6 = 6;
    local v7 = nil;

    for _, v in CollectionService:GetTagged("BeeSlot") do
        if v:IsA("BasePart") and not p4[v] then
            local Magnitude = (v.Position - p3).Magnitude;

            if Magnitude < v6 and (p5 and v:IsDescendantOf(p5)) then
                v7 = v;
                v6 = Magnitude;
            end;
        end;
    end;

    return v7;
end;

local function GetCurrentCFrame(p8) -- Line: 50
    local v9 = p8.Client.PredictedCFrame or (p8.Client.SmoothedCFrame or p8.Server.CFrame);

    if v9 and v9.Position.Magnitude >= 0.01 then
        return v9;
    end;

    return p8.Server.CFrame;
end;

return function(p10) -- Line: 62
    -- upvalues: Players (copy), GetFarmAsync (copy), FindClosestUnclaimedBeeSlot (copy)
    return function(p11: string, p12: number, p13: table) -- Line: 63
        -- upvalues: Players (ref), GetFarmAsync (ref), FindClosestUnclaimedBeeSlot (ref)
        local string_split_ret = string.split(p11, "_");

        if string_split_ret[1] ~= "Player" or not string_split_ret[2] then
            return;
        end;

        local PlayerByUserId = Players:GetPlayerByUserId((tonumber(string_split_ret[2])));

        if not PlayerByUserId then
            warn("Owner of bee in Nesting state has left the game");

            return;
        end;

        local v14 = GetFarmAsync(PlayerByUserId);
        local v15;

        if v14 then
            v15 = v14:FindFirstChild("CurrentExpansion");

            if v15 then
                v15 = v15:FindFirstChild("Custom");
            end;

            if v15 then
                v15 = v15:FindFirstChild("Hive");
            end;
        else
            v15 = nil;
        end;

        local v16 = {};

        for _, v in p13 do
            v.Client.RenderOffset = nil;
            local v17 = v.Client.PredictedCFrame or (v.Client.SmoothedCFrame or v.Server.CFrame);

            if not v17 or v17.Position.Magnitude < 0.01 then
                v17 = v.Server.CFrame;
            end;

            local Slot = v.Server.Slot;

            if v.Client.CachedSlotIndex ~= Slot then
                v.Client.ResolvedSlot = nil;
                v.Client.CachedSlotIndex = Slot;
            end;

            if not v.Client.ResolvedSlot then
                if v15 then
                    if Slot then
                        Slot = v15:FindFirstChild((tostring(Slot)));
                    end;
                else
                    Slot = v15;
                end;

                if Slot and Slot:IsA("BasePart") then
                    v.Client.ResolvedSlot = Slot;
                else
                    v.Client.ResolvedSlot = FindClosestUnclaimedBeeSlot(v17.Position, v16);
                end;
            end;

            local ResolvedSlot = v.Client.ResolvedSlot;

            if ResolvedSlot and v16[ResolvedSlot] then
                ResolvedSlot = nil;
            end;

            if ResolvedSlot then
                v16[ResolvedSlot] = true;
                local v18 = ResolvedSlot.CFrame * CFrame.Angles(0, 3.141592653589793, 0) * CFrame.new(0, -0.5, 0);

                if not v.Server.DidDie then
                    v.Client.AppliedDeathNestSnap = nil;
                end;

                if v.Server.DidDie and not v.Client.AppliedDeathNestSnap then
                    v.Client.AppliedDeathNestSnap = true;
                    v.Client.PredictedCFrame = v18;
                    v.Client.SmoothedCFrame = v18;
                    v.Client.LockFacing = true;
                    local LookVector = v18.LookVector;
                    local Vector3_new_ret = Vector3.new(LookVector.X, 0, LookVector.Z);

                    if Vector3_new_ret.Magnitude > 0.001 then
                        v.Client.FacingDirection = Vector3_new_ret.Unit;
                    else
                        v.Client.FacingDirection = nil;
                    end;
                else
                    local Magnitude = (v18.Position - v17.Position).Magnitude;
                    local v19 = v.Server.Speed * p12;

                    if Magnitude <= v19 or Magnitude <= 0.08 then
                        v.Client.LockFacing = true;
                        v.Client.PredictedCFrame = v18;
                        v.Client.TargetFacingDirection = nil;
                        local LookVector = v18.LookVector;
                        local Vector3_new_ret = Vector3.new(LookVector.X, 0, LookVector.Z);

                        if Vector3_new_ret.Magnitude > 0.001 then
                            v.Client.FacingDirection = Vector3_new_ret.Unit;
                        else
                            v.Client.FacingDirection = nil;
                        end;
                    else
                        v.Client.LockFacing = false;
                        v.Client.FacingDirection = nil;
                        local Unit = (v18.Position - v17.Position).Unit;
                        local v20 = v17.Position + Unit * v19;
                        local Vector3_new_ret = Vector3.new(Unit.X, 0, Unit.Z);

                        if Vector3_new_ret.Magnitude > 0.001 then
                            local Unit2 = Vector3_new_ret.Unit;
                            v.Client.TargetFacingDirection = Unit2;
                            v.Client.PredictedCFrame = CFrame.lookAt(v20, v20 + Unit2);
                        else
                            v.Client.TargetFacingDirection = nil;
                            v.Client.PredictedCFrame = CFrame.lookAt(v20, v18.Position);
                        end;
                    end;
                end;
            else
                v.Client.LockFacing = false;
                v.Client.FacingDirection = nil;
                v.Client.TargetFacingDirection = nil;
                v.Client.PredictedCFrame = nil;
            end;
        end;
    end;
end;