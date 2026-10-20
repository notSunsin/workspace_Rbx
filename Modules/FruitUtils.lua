-- Decompiled with Potassium's decompiler.

local u3 = {
    GetFruitAge = function(p1: table, p2: userdata) -- Line: 4, Name: GetFruitAge
        if not p2:HasTag("Harvestable") then
            return nil;
        end;

        local Grow = p2:FindFirstChild("Grow");

        if not Grow then
            return nil;
        end;

        local Age = Grow:FindFirstChild("Age");

        if Age then
            return Age.Value;
        end;

        return nil;
    end
};

function u3.IsFruitGrown(p4: table, p5: userdata) -- Line: 16
    -- upvalues: u3 (copy)
    if not p5:HasTag("Harvestable") then
        return nil;
    end;

    local FruitAge = u3:GetFruitAge(p5);

    if not FruitAge then
        return nil;
    end;

    local Attribute = p5:GetAttribute("MaxAge");

    if Attribute then
        return Attribute <= FruitAge;
    end;

    return nil;
end;

return u3;