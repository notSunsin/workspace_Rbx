-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Observability = require(ReplicatedStorage.UserGenerated.Observability);
local Codec = require(ReplicatedStorage.UserGenerated.Observability.Codec);
local Op = Observability.Op;
local u34 = {
    Angular = 1,
    Linear = 2,
    Acceleration = 4,
    SameRotation = 8,

    at = function(p1, p2: vector, p3: vector, p4: vector, p5: number) -- Line: 28, Name: at
        local v6 = p4 * (p5 * 0.5 * p5);
        local Magnitude = p2.Magnitude;

        if Magnitude == 0 then
            return p1 + p3 * p5 + v6;
        end;

        local v7 = p2 / Magnitude;
        local v8 = p2:Cross(p3) / (Magnitude * Magnitude);
        local CFrame_fromAxisAngle_ret = CFrame.fromAxisAngle(v7, Magnitude * p5);
        local v9 = v8 + CFrame_fromAxisAngle_ret:VectorToWorldSpace(p1.Position - v8) + v7 * (v7:Dot(p3) * p5) + v6;

        return CFrame.new(v9) * CFrame_fromAxisAngle_ret * p1.Rotation;
    end,

    between = function(p10, p11, p12: number) -- Line: 46, Name: between
        local v13 = p11 * p10:Inverse();
        local v14, v15 = v13:ToAxisAngle();
        local Position = v13.Position;

        if v15 < 1e-6 or v14.Magnitude < 1e-6 then
            return Vector3.new(0, 0, 0), Position / p12;
        end;

        local Unit = v14.Unit;
        local v16 = Unit:Dot(Position);
        local v17 = Position - Unit * v16;
        local v18 = (v17 + Unit:Cross(v17) / math.tan(v15 / 2)) * 0.5;
        local v19 = Unit * (v15 / p12);

        return v19, Unit * (v16 / p12) - v19:Cross(v18);
    end,

    accelerating = function(p20: vector, p21: vector, p22: vector, p23: number, p24: number, p25: number) -- Line: 64, Name: accelerating
        local v26 = (p22 - p21) / (p25 - p24);
        local v27 = (v26 - (p21 - p20) / (p24 - p23)) / ((p25 - p23) / 2);

        return v26 + v27 * ((p25 - p24) / 2), v27;
    end,

    apart = function(p28, p29, p30: number, p31: number) -- Line: 72, Name: apart
        if p30 < (p28.Position - p29.Position).Magnitude then
            return true;
        end;

        local _, v32 = (p28.Rotation:Inverse() * p29.Rotation):ToAxisAngle();
        local v33 = math.abs(v32) % 6.283185307179586;

        return p31 < math.min(v33, 6.283185307179586 - v33);
    end
};

local function vector(p35: any, p36: vector) -- Line: 81
    p35:f32(p36.X);
    p35:f32(p36.Y);
    p35:f32(p36.Z);
end;

function u34.write(p37: any, p38: number, p39: number, p40, p41: vector, p42: vector, p43: vector, p44: boolean) -- Line: 89
    -- upvalues: u34 (copy), Op (copy), Codec (copy)
    local v45 = (p41 == Vector3.new(0, 0, 0) and 0 or u34.Angular) + (p42 == Vector3.new(0, 0, 0) and 0 or u34.Linear) + (p43 == Vector3.new(0, 0, 0) and 0 or u34.Acceleration) + (not p44 and 0 or u34.SameRotation);
    p37:u8(Op.CFrameMotion);
    Codec.varuint(p37, p38);
    Codec.varuint(p37, p39);
    p37:u8(v45);

    if p44 then
        Codec.position(p37, p40);
    else
        Codec.cframe(p37, p40);
    end;

    if bit32.btest(v45, u34.Angular) then
        p37:f32(p41.X);
        p37:f32(p41.Y);
        p37:f32(p41.Z);
    end;

    if bit32.btest(v45, u34.Linear) then
        p37:f32(p42.X);
        p37:f32(p42.Y);
        p37:f32(p42.Z);
    end;

    if bit32.btest(v45, u34.Acceleration) then
        p37:f32(p43.X);
        p37:f32(p43.Y);
        p37:f32(p43.Z);
    end;
end;

return u34;