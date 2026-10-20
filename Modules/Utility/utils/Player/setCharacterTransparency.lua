-- Decompiled with Potassium's decompiler.

return function(p1: userdata, p2: number) -- Line: 3, Name: setCharacterTransparency
    for _, descendant in pairs(p1:GetDescendants()) do
        if descendant:IsA("BasePart") and descendant ~= p1:FindFirstChild("HumanoidRootPart") then
            descendant.Transparency = p2;
        end;
    end;
end;