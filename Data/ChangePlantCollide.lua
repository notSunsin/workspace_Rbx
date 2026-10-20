-- Decompiled with Potassium's decompiler.

local v1 = {};

local function MakePartsNonCollidable(p2: userdata) -- Line: 3
    for _, descendant in p2:GetDescendants() do
        if descendant:IsA("BasePart") then
            descendant.CanCollide = false;
            descendant.CanQuery = false;
            descendant.CanTouch = false;
        end;
    end;
end;

function v1.ChangeToolCollide(p3: userdata) -- Line: 13
    -- upvalues: MakePartsNonCollidable (copy)
    if not (p3 and p3:IsA("Tool")) then
        return false;
    end;

    MakePartsNonCollidable(p3);

    return true;
end;

function v1.QueueChangeToolCollide(u4: userdata) -- Line: 23
    -- upvalues: MakePartsNonCollidable (copy)
    if not (u4 and u4:IsA("Tool")) then
        return false;
    end;

    MakePartsNonCollidable(u4);
    task.defer(function() -- Line: 30
        -- upvalues: u4 (copy), MakePartsNonCollidable (ref)
        local os_clock_ret = os.clock();

        while u4:IsDescendantOf(game) and (not u4:HasTag("PlantGenerated") and os.clock() - os_clock_ret < 8) do
            task.wait();
        end;

        if not u4:IsDescendantOf(game) then
            return;
        end;

        task.wait(0.35);

        if not u4:IsDescendantOf(game) then
            return;
        end;

        MakePartsNonCollidable(u4);
    end);

    return true;
end;

return v1;