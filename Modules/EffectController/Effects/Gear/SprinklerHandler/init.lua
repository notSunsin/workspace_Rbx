-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local GetFarm = require(ReplicatedStorage.Modules.GetFarm);
require(ReplicatedStorage.Modules.EffectController.Types);
local SprinklerData = require(ReplicatedStorage.Data.SprinklerData);
local SoundPlayer = require(ReplicatedStorage.Modules.SoundPlayer);
local SoundData = require(ReplicatedStorage.Data.SoundData);
local SprinklerOffsets = SprinklerData.SprinklerOffsets;
local v1 = {};

local function SafeDestroy(p2: userdata?) -- Line: 19
    if p2 and p2.Parent then
        p2:Destroy();
    end;
end;

function v1.Create(u3) -- Line: 25
    -- upvalues: Players (copy), GetFarm (copy), SprinklerOffsets (copy), SoundPlayer (copy), SoundData (copy)
    local ID = u3.Parameters.ID;

    if not ID then
        return;
    end;

    local v4 = u3.Cache[ID];

    if typeof(v4) == "table" then
        local SprinklerEffect = v4.SprinklerEffect;

        if SprinklerEffect and SprinklerEffect.Parent then
            SprinklerEffect:Destroy();
        end;

        local Sprinkler = v4.Sprinkler;

        if Sprinkler and Sprinkler.Parent then
            Sprinkler:Destroy();
        end;
    end;

    u3.Cache[ID] = {
        Destroyed = false
    };
    local v5 = u3.Cache[ID];
    local SprinklerType = u3.Parameters.SprinklerType;
    local SprinklerCFrame = u3.Parameters.SprinklerCFrame;

    if not (SprinklerType and SprinklerCFrame) then
        u3.Cache[ID] = nil;

        return;
    end;

    local OWNER = u3.Parameters.OWNER;

    if not OWNER then
        u3.Cache[ID] = nil;

        return;
    end;

    local v6 = Players:FindFirstChild(OWNER);

    if not v6 then
        u3.Cache[ID] = nil;

        return;
    end;

    local v7 = GetFarm(v6);

    if not v7 then
        u3.Cache[ID] = nil;

        return;
    end;

    local Important = v7:FindFirstChild("Important");

    if Important then
        Important = Important:FindFirstChild("Objects_Physical");
    end;

    if not Important then
        u3.Cache[ID] = nil;

        return;
    end;

    local v8 = SprinklerOffsets[SprinklerType];

    if not v8 then
        u3.Cache[ID] = nil;

        return;
    end;

    local Part = Instance.new("Part");
    Part.Name = "SprinklerAnchor";
    Part.Size = Vector3.new(0.5, 0.5, 0.5);
    Part.CFrame = SprinklerCFrame * CFrame.new(0, 1, 0);
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanTouch = false;
    Part.CanQuery = false;
    Part.Transparency = 1;
    Part.Massless = true;
    Part.Parent = workspace.Visuals;
    v5.Sprinkler = Part;
    local OBJECT_UUID = u3.Parameters.OBJECT_UUID;

    for _, child in Important:GetChildren() do
        if child:GetAttribute("OBJECT_UUID") == OBJECT_UUID then
            v5.DestroyingConnection = child.Destroying:Connect(function() -- Line: 104
                -- upvalues: u3 (copy), ID (copy)
                local v9 = u3.Cache[ID];

                if typeof(v9) ~= "table" then
                    return;
                end;

                v9.Destroyed = true;
                local SprinklerEffect = v9.SprinklerEffect;

                if SprinklerEffect and SprinklerEffect.Parent then
                    SprinklerEffect:Destroy();
                end;

                local Sprinkler = v9.Sprinkler;

                if Sprinkler and Sprinkler.Parent then
                    Sprinkler:Destroy();
                end;

                local DestroyingConnection = v9.DestroyingConnection;

                if DestroyingConnection then
                    DestroyingConnection:Disconnect();
                end;

                u3.Cache[ID] = nil;
            end);
            break;
        end;
    end;

    local v10 = u3.Default:CreateEffect({
        Emit = true,
        DebrisTime = 2,
        Object = script.PlaceEffect,
        Position = SprinklerCFrame * CFrame.Angles(0, 3.141592653589793, 3.141592653589793)
    });
    SoundPlayer:PlaySound(SoundData.Gears.SprinklerHandler.PlaceSFX, {
        RollOffMaxDistance = 50,
        RollOffMinDistance = 10,
        Volume = 0.5,
        PlaybackSpeed = 1,
        RollOffMode = Enum.RollOffMode.InverseTapered
    }, nil, v10);
    u3.Libraries.BoatTween:Create(Part, {
        Time = 0.8,
        EasingStyle = "Smoother",
        EasingDirection = "In",
        StepType = "Heartbeat",
        Goal = {
            CFrame = SprinklerCFrame * v8
        }
    }):Play();
    task.delay(0.2, function() -- Line: 152
        -- upvalues: u3 (copy), ID (copy), Part (copy), SprinklerType (copy), SprinklerCFrame (copy), SoundPlayer (ref), SoundData (ref)
        local v11 = u3.Cache[ID];

        if typeof(v11) ~= "table" then
            return;
        end;

        if v11.Destroyed == true then
            local v12 = Part;

            if v12 and v12.Parent then
                v12:Destroy();
            end;

            u3.Cache[ID] = nil;

            return;
        end;

        if not Part.Parent then
            u3.Cache[ID] = nil;

            return;
        end;

        local v13 = script:FindFirstChild(string.format("%s VFX", SprinklerType));

        if not v13 then
            warn((`Missing sprinkler VFX for {SprinklerType}`));

            return;
        end;

        local v14 = u3.Default:CreateEffect({
            Object = v13,
            Parent = Part,
            Position = SprinklerCFrame
        });
        SoundPlayer:PlaySound(SoundData.Gears.SprinklerHandler.SprinklerLoop, {
            RollOffMaxDistance = 50,
            RollOffMinDistance = 10,
            Volume = 0.5,
            PlaybackSpeed = 1,
            Looped = true,
            RollOffMode = Enum.RollOffMode.InverseTapered
        }, nil, v14);
        v11.SprinklerEffect = v14;
    end);
end;

function v1.Destroy(u15) -- Line: 196
    local ID = u15.Parameters.ID;

    if not ID then
        return;
    end;

    local u16 = u15.Cache[ID];

    if not u16 or typeof(u16) ~= "table" then
        return;
    end;

    u16.Destroyed = true;
    local Sprinkler = u16.Sprinkler;
    local SprinklerEffect = u16.SprinklerEffect;

    if SprinklerEffect then
        u15.Default:UpdateStatus(SprinklerEffect, false, {});
    end;

    local DestroyingConnection = u16.DestroyingConnection;

    if DestroyingConnection then
        DestroyingConnection:Disconnect();
    end;

    if Sprinkler and Sprinkler.Parent then
        u15.Libraries.BoatTween:Create(Sprinkler, {
            Time = 0.6,
            EasingStyle = "ExitExpressive",
            EasingDirection = "In",
            StepType = "Heartbeat",
            Goal = {
                CFrame = (u15.Parameters.SprinklerCFrame or Sprinkler.CFrame) * CFrame.new(0, 3, 0)
            }
        }):Play();
        task.delay(0.6, function() -- Line: 234
            -- upvalues: SprinklerEffect (copy), Sprinkler (copy), u15 (copy), ID (copy), u16 (copy)
            local v17 = SprinklerEffect;

            if v17 and v17.Parent then
                v17:Destroy();
            end;

            local v18 = Sprinkler;

            if v18 and v18.Parent then
                v18:Destroy();
            end;

            if u15.Cache[ID] == u16 then
                u15.Cache[ID] = nil;
            end;
        end);

        return;
    end;

    if SprinklerEffect and SprinklerEffect.Parent then
        SprinklerEffect:Destroy();
    end;

    u15.Cache[ID] = nil;
end;

function v1.Cancel(p19) -- Line: 248
    for _, v in p19.Cache do
        if typeof(v) == "table" then
            local DestroyingConnection = v.DestroyingConnection;

            if DestroyingConnection then
                DestroyingConnection:Disconnect();
            end;

            local SprinklerEffect = v.SprinklerEffect;

            if SprinklerEffect and SprinklerEffect.Parent then
                SprinklerEffect:Destroy();
            end;

            local Sprinkler = v.Sprinkler;

            if Sprinkler and Sprinkler.Parent then
                Sprinkler:Destroy();
            end;
        end;
    end;

    p19.Container:Clean();
    p19.Cache = {};
end;

return v1;