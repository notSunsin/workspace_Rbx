-- Decompiled with Potassium's decompiler.

return function(p1: userdata, p2: boolean) -- Line: 1, Name: validatePlayer
    if p2 then
        if not p1 then
            return nil;
        end;

        local v3 = p1.Character or p1.CharacterAdded:Wait();

        return v3, v3:WaitForChild("HumanoidRootPart"), v3:WaitForChild("Humanoid");
    end;

    if not p1 then
        return nil;
    end;

    local Character = p1.Character;

    if not Character then
        return nil;
    end;

    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return nil;
    end;

    local Humanoid = Character:FindFirstChild("Humanoid");

    if not Humanoid then
        return nil;
    end;

    if Humanoid.Health <= 0 then
        return nil;
    end;

    return Character, HumanoidRootPart, Humanoid;
end;