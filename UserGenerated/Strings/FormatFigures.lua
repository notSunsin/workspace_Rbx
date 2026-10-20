-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RoundFigures = require(ReplicatedStorage.UserGenerated.Math.RoundFigures);
local Commas = require(ReplicatedStorage.UserGenerated.Strings.Commas);

return function(p1: number, p2: number?, p3: number?, p4: function?) -- Line: 44, Name: FormatFigures
    -- upvalues: Commas (copy), RoundFigures (copy)
    return Commas(RoundFigures(p1, p2, p3, p4));
end;