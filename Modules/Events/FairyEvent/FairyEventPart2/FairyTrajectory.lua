-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local Bezier_2 = require(ReplicatedStorage.Code.Bezier_2);

return {
    GetFairyPosition = function(p1: table, p2, p3, p4: number, p5: any) -- Line: 9, Name: GetFairyPosition
        -- upvalues: Bezier_2 (copy), TweenService (copy)
        local Position = p2.Position;
        local Position2 = p3.Position;
        local v6 = Position2 - (Position2 - Position).Unit * 2;
        local v7 = Position:Lerp(v6, 0.05) + p2.LookVector * 25;
        local v8 = Position:Lerp(v6, 0.5) + Vector3.new(0, 18, 0);
        local v9 = Position:Lerp(v6, 0.75) + Vector3.new(0, 8, 0);
        local v10 = Bezier_2.new(Position, v7, v8, v9, v6);
        local Value = TweenService:GetValue(p4, Enum.EasingStyle.Sine, p5 or Enum.EasingDirection.Out);

        return v10:CalculatePositionAt((math.max(0.001, Value)));
    end,

    GetReverseFairyPosition = function(p11: table, p12, p13, p14: number, p15: any) -- Line: 34, Name: GetReverseFairyPosition
        -- upvalues: Bezier_2 (copy), TweenService (copy)
        local Position = p12.Position;
        local Position2 = p13.Position;
        local v16 = Position2 - (Position2 - Position).Unit * 2;
        local v17 = Position:Lerp(v16, 0.05) + p12.LookVector * 25;
        local v18 = Position:Lerp(v16, 0.5) + Vector3.new(0, 18, 0);
        local v19 = Position:Lerp(v16, 0.75) + Vector3.new(0, 8, 0);

        return Bezier_2.new(v16, v19, v18, v17, Position):CalculatePositionAt((TweenService:GetValue(p14, Enum.EasingStyle.Sine, p15 or Enum.EasingDirection.InOut)));
    end
};