-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local BeeEventConfig = require(ReplicatedStorage.Data.BeeEvent.BeeEventConfig);
local GetFarm = require(ReplicatedStorage.Modules.GetFarm);
local BeeVFXPlayer = require(ReplicatedStorage.Modules.BeeEventV2Controllers.BeeColonyStateController.Util.BeeVFXPlayer);
local SpawnDuration = BeeEventConfig.Spawning.SpawnDuration;

local function GetHive(p1: userdata) -- Line: 11
    -- upvalues: GetFarm (copy)
    local v2 = GetFarm(p1);

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

local function GetBodyOffsetCFrame(p3) -- Line: 20
    local NestingBodyOffset = p3.Client.NestingBodyOffset;

    if NestingBodyOffset then
        return NestingBodyOffset;
    end;

    local Model = p3.Client.Model;
    local Hitbox = p3.Client.Hitbox;

    if not (Model and (Hitbox and Model.PrimaryPart)) then
        return CFrame.identity;
    end;

    local v4 = Model:GetBoundingBox().Position - Hitbox.Position;
    local v5 = Hitbox.CFrame:VectorToObjectSpace(v4);
    p3.Client.NestingBodyOffset = CFrame.new(-v5);

    return p3.Client.NestingBodyOffset;
end;

return function(p6) -- Line: 37
    -- upvalues: Players (copy), GetFarm (copy), BeeVFXPlayer (copy), GetBodyOffsetCFrame (copy), SpawnDuration (copy)
    return function(p7: string, p8: number, p9: table) -- Line: 38
        -- upvalues: Players (ref), GetFarm (ref), BeeVFXPlayer (ref), GetBodyOffsetCFrame (ref), SpawnDuration (ref)
        local string_split_ret = string.split(p7, "_");
        local v10;

        if string_split_ret[1] == "Player" and string_split_ret[2] then
            local PlayerByUserId = Players:GetPlayerByUserId((tonumber(string_split_ret[2])));

            if not PlayerByUserId then
                return;
            end;

            local v11 = GetFarm(PlayerByUserId);

            if v11 then
                v10 = v11:FindFirstChild("CurrentExpansion");

                if v10 then
                    v10 = v10:FindFirstChild("Custom");
                end;

                if v10 then
                    v10 = v10:FindFirstChild("Hive");
                end;
            else
                v10 = nil;
            end;
        else
            v10 = nil;
        end;

        for _, v in p9 do
            local Model = v.Client.Model;

            if Model and Model.Parent then
                local v12 = v.Server.BeeName or "";

                if v12 == "Wasp" or string.find(v12, "Wasp") then
                    if Model:GetAttribute("OriginalScale") == nil then
                        Model:SetAttribute("OriginalScale", Model:GetScale());
                    end;

                    Model:ScaleTo(Model:GetAttribute("OriginalScale"));
                    v.Client.IsSpawning = nil;
                    v.Client.SpawnElapsed = nil;
                    BeeVFXPlayer:PlayBeeVFX(v.Client.Model);
                else
                    local Slot = v.Server.Slot;
                    local v13 = nil;
                    local v14;

                    if v10 and Slot then
                        v14 = v10:FindFirstChild((tostring(Slot)));

                        if v14 then
                            if not v14:IsA("BasePart") then
                                v14 = v13;
                            end;
                        else
                            v14 = v13;
                        end;
                    else
                        v14 = v13;
                    end;

                    if Model:GetAttribute("OriginalScale") == nil then
                        Model:SetAttribute("OriginalScale", Model:GetScale());
                    end;

                    if v14 then
                        local v15 = v14.CFrame * CFrame.Angles(0, 3.141592653589793, 0) * GetBodyOffsetCFrame(v);
                        v.Client.LockFacing = true;
                        v.Client.FacingDirection = nil;
                        v.Client.RenderOffset = nil;
                        v.Client.SmoothedCFrame = v15;
                        v.Client.FromCFrame = v15;
                        v.Client.ToCFrame = v15;
                        v.Client.PredictedCFrame = v15;
                        v.Client.LerpAlpha = 1;
                    else
                        v.Client.PredictedCFrame = nil;
                    end;

                    if v.Client.SpawnElapsed == nil then
                        v.Client.SpawnElapsed = 0;
                        v.Client.IsSpawning = true;
                        Model:ScaleTo(0.0001);
                    end;

                    v.Client.SpawnElapsed = math.min(v.Client.SpawnElapsed + p8, SpawnDuration);
                    local v16 = v.Client.SpawnElapsed / SpawnDuration;
                    Model:ScaleTo(0.0001 + (Model:GetAttribute("OriginalScale") - 0.0001) * v16);

                    if SpawnDuration <= v.Client.SpawnElapsed then
                        Model:ScaleTo(Model:GetAttribute("OriginalScale"));
                        v.Client.IsSpawning = nil;
                        BeeVFXPlayer:PlayBeeVFX(v.Client.Model);
                    end;
                end;
            end;
        end;
    end;
end;