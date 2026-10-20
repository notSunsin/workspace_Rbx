-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CollectionService = game:GetService("CollectionService");
local LocalPlayer = Players.LocalPlayer;
local BeeEventConfig = require(ReplicatedStorage.Data.BeeEvent.BeeEventConfig);
local SettingsService = require(ReplicatedStorage.Modules.Settings.SettingsService);
local Sounds = script.Parent.Parent:WaitForChild("Sounds");
local SpreadBase = BeeEventConfig.Swarm.SpreadBase;
local SpreadPerBee = BeeEventConfig.Swarm.SpreadPerBee;
local HeightMin = BeeEventConfig.Swarm.HeightMin;
local HeightMax = BeeEventConfig.Swarm.HeightMax;
local BobAmplitude = BeeEventConfig.Swarm.BobAmplitude;
local BobFrequency = BeeEventConfig.Swarm.BobFrequency;
local Random_new_ret = Random.new();
local u1 = { "RandomBuzz1", "RandomBuzz2", "RandomBuzz3", "RandomBuzz4", "RandomBuzz5", "RandomBuzz6" };

local function IsPointInsideBoundsPart(p2: userdata, p3: vector) -- Line: 40
    local v4 = p2.CFrame:PointToObjectSpace(p3);
    local v5 = p2.Size * 0.5;
    local v6;

    if math.abs(v4.X) <= v5.X then
        v6 = math.abs(v4.Z) <= v5.Z;
    else
        v6 = false;
    end;

    return v6;
end;

local function IsInBeeEventZone(p7: vector) -- Line: 46
    -- upvalues: CollectionService (copy)
    for _, v in CollectionService:GetTagged("BeeEventBounds") do
        if v:IsA("BasePart") and v:IsDescendantOf(workspace) then
            local v8 = v.CFrame:PointToObjectSpace(p7);
            local v9 = v.Size * 0.5;
            local v10;

            if math.abs(v8.X) <= v9.X then
                v10 = math.abs(v8.Z) <= v9.Z;
            else
                v10 = false;
            end;

            if v10 then
                return true;
            end;
        end;
    end;

    return false;
end;

local function GetBooleanSetting(u11: string, p12: boolean) -- Line: 57
    -- upvalues: LocalPlayer (copy), SettingsService (copy)
    local Attribute = LocalPlayer:GetAttribute(u11);

    if Attribute ~= nil then
        return Attribute == true;
    end;

    local success, result = pcall(function() -- Line: 63
        -- upvalues: SettingsService (ref), u11 (copy)
        return SettingsService:GetSetting(u11);
    end);

    if success and result ~= nil then
        return result == true;
    end;

    return p12;
end;

local function ShouldBeesFollowPlayer() -- Line: 74
    -- upvalues: LocalPlayer (copy), SettingsService (copy)
    local Attribute = LocalPlayer:GetAttribute("BeeColonyFollowPlayer");

    if Attribute ~= nil then
        return Attribute == true;
    end;

    local u13 = "BeeColonyFollowPlayer";
    local success, result = pcall(function() -- Line: 63
        -- upvalues: SettingsService (ref), u13 (copy)
        return SettingsService:GetSetting(u13);
    end);

    return (not success or result == nil) and true or result == true;
end;

local function PlayRandomBuzz(p14) -- Line: 78
    -- upvalues: Random_new_ret (copy), u1 (copy), Sounds (copy)
    local Client = p14.Client;
    local Hitbox = Client.Hitbox;

    if not Hitbox then
        return;
    end;

    local os_clock_ret = os.clock();

    if Client.LastRandomBuzzAt and os_clock_ret - Client.LastRandomBuzzAt < 3 then
        return;
    end;

    if Random_new_ret:NextNumber() > 0.1 then
        return;
    end;

    Client.LastRandomBuzzAt = os_clock_ret;
    local v15 = u1[Random_new_ret:NextInteger(1, #u1)];
    local v16 = Sounds:FindFirstChild(v15);

    if not (v16 and v16:IsA("Sound")) then
        return;
    end;

    local u17 = v16:Clone();
    u17.Name = v15;
    u17.Looped = false;
    u17.Parent = Hitbox;
    u17:Play();
    u17.Ended:Once(function() -- Line: 107
        -- upvalues: u17 (copy)
        u17:Destroy();
    end);
    task.delay(2, function() -- Line: 111
        -- upvalues: u17 (copy)
        if u17.Parent then
            u17:Destroy();
        end;
    end);
end;

local function GetCurrentCFrame(p18) -- Line: 118
    local v19 = p18.Client.PredictedCFrame or (p18.Client.SmoothedCFrame or p18.Server.CFrame);

    if v19 and v19.Position.Magnitude >= 0.01 then
        return v19;
    end;

    return p18.Server.CFrame;
end;

local function MoveEntryTowardCFrame(p20: any, p21, p22: number) -- Line: 130
    -- upvalues: PlayRandomBuzz (copy)
    local v23 = p20.Client.PredictedCFrame or (p20.Client.SmoothedCFrame or p20.Server.CFrame);

    if not v23 or v23.Position.Magnitude < 0.01 then
        v23 = p20.Server.CFrame;
    end;

    if not v23 or v23.Position.Magnitude < 0.01 then
        p20.Client.PredictedCFrame = p21;
        p20.Client.RandomBuzzWasMoving = false;

        return;
    end;

    local Magnitude = (p21.Position - v23.Position).Magnitude;
    local v24 = p20.Client.RandomBuzzWasMoving == true;
    local v25;

    if v24 then
        v25 = Magnitude > 0.05;
    else
        v25 = Magnitude > 0.2;
    end;

    if v25 and not v24 then
        PlayRandomBuzz(p20);
    end;

    p20.Client.RandomBuzzWasMoving = v25;

    if Magnitude < 0.01 then
        p20.Client.PredictedCFrame = p21;
        p20.Client.RandomBuzzWasMoving = false;

        return;
    end;

    local v26 = p20.Server.Speed * p22;

    if Magnitude <= v26 then
        p20.Client.PredictedCFrame = p21;

        return;
    end;

    local v27 = v23.Position:Lerp(p21.Position, v26 / Magnitude);
    local Position = p21.Position;

    if (Position - v27).Magnitude < 0.01 then
        Position = v27 + p21.LookVector;
    end;

    p20.Client.PredictedCFrame = CFrame.new(v27, Position);
end;

local function GetPlayerFollowAnchor(p28: userdata) -- Line: 179
    -- upvalues: IsInBeeEventZone (copy)
    local Position = p28.Position;

    if IsInBeeEventZone(Position) then
        local LookVector = p28.CFrame.LookVector;
        local Vector3_new_ret = Vector3.new(LookVector.X, 0, LookVector.Z);

        if Vector3_new_ret.Magnitude > 0.001 then
            Position = Position - Vector3_new_ret.Unit * 20;
        end;
    end;

    return Position;
end;

local function GetPlayerFollowTargetCFrame(p29: any, p30: vector, p31: number, p32: vector) -- Line: 195
    -- upvalues: HeightMin (copy), HeightMax (copy)
    local Identifier = p29.Server.Identifier;
    local v33 = p30 + Vector3.new((Identifier * 2.39996 % 1 - 0.5) * p31 * 2, HeightMin + Identifier * 1.61803 % 1 * (HeightMax - HeightMin), (Identifier * 3.14159 % 1 - 0.5) * p31 * 2);
    local Vector3_new_ret = Vector3.new(p32.X, v33.Y, p32.Z);

    return CFrame.new(v33, Vector3_new_ret);
end;

return function(p34) -- Line: 208
    -- upvalues: Players (copy), LocalPlayer (copy), SpreadBase (copy), SpreadPerBee (copy), SettingsService (copy), IsInBeeEventZone (copy), BobFrequency (copy), BobAmplitude (copy), GetPlayerFollowTargetCFrame (copy), MoveEntryTowardCFrame (copy)
    return function(p35: string, p36: number, p37: table) -- Line: 209
        -- upvalues: Players (ref), LocalPlayer (ref), SpreadBase (ref), SpreadPerBee (ref), SettingsService (ref), IsInBeeEventZone (ref), BobFrequency (ref), BobAmplitude (ref), GetPlayerFollowTargetCFrame (ref), MoveEntryTowardCFrame (ref)
        local string_split_ret = string.split(p35, "_");

        if string_split_ret[1] ~= "Player" or not string_split_ret[2] then
            return;
        end;

        local PlayerByUserId = Players:GetPlayerByUserId((tonumber(string_split_ret[2])));

        if not PlayerByUserId then
            return;
        end;

        local ServerTimeNow = workspace:GetServerTimeNow();
        local v38 = PlayerByUserId == LocalPlayer;
        local Character = PlayerByUserId.Character;

        if Character then
            Character = Character:FindFirstChild("HumanoidRootPart");
        end;

        local v39 = 0;

        for _ in p37 do
            v39 = v39 + 1;
        end;

        local v40 = SpreadBase + v39 * SpreadPerBee;
        local Attribute = LocalPlayer:GetAttribute("BeeColonyFollowPlayer");
        local v41;

        if Attribute == nil then
            local u42 = "BeeColonyFollowPlayer";
            local success, result = pcall(function() -- Line: 63
                -- upvalues: SettingsService (ref), u42 (copy)
                return SettingsService:GetSetting(u42);
            end);
            v41 = (not success or result == nil) and true or result == true;
        else
            v41 = Attribute == true;
        end;

        local v43;

        if v38 and (v41 and Character) then
            v43 = Character.Position;

            if IsInBeeEventZone(v43) then
                local LookVector = Character.CFrame.LookVector;
                local Vector3_new_ret = Vector3.new(LookVector.X, 0, LookVector.Z);

                if Vector3_new_ret.Magnitude > 0.001 then
                    v43 = v43 - Vector3_new_ret.Unit * 20;
                end;
            end;
        else
            v43 = nil;
        end;

        for _, v in p37 do
            v.Client.TargetFacingDirection = nil;
            v.Client.FacingDirection = nil;
            local v44 = math.sin(ServerTimeNow * BobFrequency + v.Server.Identifier * 2.39996 % 6.283185307179586) * BobAmplitude;
            v.Client.RenderOffset = CFrame.new(0, v44, 0);
            v.Client.LockFacing = false;

            if v38 and v43 then
                MoveEntryTowardCFrame(v, GetPlayerFollowTargetCFrame(v, v43, v40, PlayerByUserId.Character:GetPivot().Position), p36);
            else
                v.Client.PredictedCFrame = nil;
                v.Client.RandomBuzzWasMoving = false;
            end;
        end;
    end;
end;