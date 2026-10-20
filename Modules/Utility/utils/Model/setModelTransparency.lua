-- Decompiled with Potassium's decompiler.

return function(p1: userdata, p2: number) -- Line: 1, Name: setModelTransparency
    for _, descendant in pairs(p1:GetDescendants()) do
        if descendant:IsA("BasePart") then
            descendant.Transparency = p2;
        end;
    end;
end;