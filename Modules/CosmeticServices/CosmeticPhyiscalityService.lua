-- Decompiled with Potassium's decompiler.

local CosmeticPhysicalityService_Unreliable = game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("CosmeticPhysicalityService_Unreliable");

return {
    UpdateCFrame = function(p1: table, p2: string, p3) -- Line: 8, Name: UpdateCFrame
        -- upvalues: CosmeticPhysicalityService_Unreliable (copy)
        CosmeticPhysicalityService_Unreliable:FireServer("UpdateCFrame", p2, p3);
    end
};