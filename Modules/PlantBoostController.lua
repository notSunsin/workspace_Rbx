-- Decompiled with Potassium's decompiler.

local GameEvents = game:GetService("ReplicatedStorage"):WaitForChild("GameEvents");

return {
    Boost = function(p1: table, p2: userdata) -- Line: 8, Name: Boost
        -- upvalues: GameEvents (copy)
        GameEvents.PlantBoostServiceEvents.Boost:FireServer(p2);
    end
};