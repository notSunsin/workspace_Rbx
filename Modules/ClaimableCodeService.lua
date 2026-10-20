-- Decompiled with Potassium's decompiler.

local ClaimableCodeService = game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("ClaimableCodeService");

return {
    ClaimCode = function(p1: table, p2: string) -- Line: 8, Name: ClaimCode
        -- upvalues: ClaimableCodeService (copy)
        return ClaimableCodeService:FireServer("ClaimCode", p2);
    end
};