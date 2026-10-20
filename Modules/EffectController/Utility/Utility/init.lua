-- Decompiled with Potassium's decompiler.

local u1 = {};
local RaycastParams_new_ret = RaycastParams.new();
RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Include;
RaycastParams_new_ret.FilterDescendantsInstances = { workspace };
u1.RayParams = RaycastParams_new_ret;

function u1.AddItem(p2: table, u3: userdata, p4: number) -- Line: 9
    task.delay(p4, function() -- Line: 10
        -- upvalues: u3 (copy)
        if u3.Parent ~= nil then
            u3:Destroy();
        end;
    end);
end;

function u1.PlaySound(p5: table, p6: userdata, p7: userdata) -- Line: 17
    -- upvalues: u1 (copy)
    local v8 = p6:Clone();
    v8.Parent = p7;
    v8:Play();
    u1:AddItem(v8, v8.TimeLength);

    return v8;
end;

function u1.WeldInPlace(p9, p10, p11) -- Line: 27
    if p10 ~= p11 then
        local CFrame_new_ret = CFrame.new(p10.Position);
        local ManualWeld = Instance.new("ManualWeld");
        ManualWeld.Part0 = p10;
        ManualWeld.Part1 = p11;
        ManualWeld.C0 = p10.CFrame:inverse() * CFrame_new_ret;
        ManualWeld.C1 = p11.CFrame:inverse() * CFrame_new_ret;
        ManualWeld.Parent = p10;
        ManualWeld.Name = "Weld";

        return ManualWeld;
    end;
end;

function u1.CreateLockPart(p12: table, p13: userdata, p14, p15: number?, p16: string?) -- Line: 40
    p13:PivotTo(p14);
    local v17;

    if p16 then
        v17 = workspace.World.ClientEffects:FindFirstChild(p16);
    else
        v17 = p16;
    end;

    if not v17 then
        v17 = script.LOCK:Clone();
        v17.Name = p16 or "LOCK";
        v17.Parent = workspace.World.Visuals;
        v17.Transparency = 1;
    end;

    v17:PivotTo(p14);

    if p15 then
        task.delay(p15, v17.Destroy, v17);
    end;

    v17.Weld.part1 = p13;

    return v17;
end;

function u1.Round(p18: table, p19: number, p20: number, p21: number) -- Line: 67
    local v22 = p21 ^ p20;

    return math.floor(p19 * v22 + 0.5) / v22;
end;

function u1.HasProperty(p23: table, u24: userdata, u25: string) -- Line: 72
    local success, _ = pcall(function() -- Line: 73
        -- upvalues: u24 (copy), u25 (copy)
        local _ = u24[u25];
    end);

    return success;
end;

return u1;