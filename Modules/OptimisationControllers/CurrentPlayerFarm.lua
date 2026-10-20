-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local UserInputService = game:GetService("UserInputService");
local workspace_CurrentCamera = workspace.CurrentCamera;
local Signal = require(ReplicatedStorage.Modules.Signal);
local _, u1 = xpcall(function() -- Line: 9
    return CFrame.identity * nil;
end, function() -- Line: 11
    return debug.info(2, "f");
end);
local u2 = nil;
local u3 = {
    Changed = Signal.new()
};

function u3.Observe(p4: table, p5: function) -- Line: 19
    -- upvalues: u2 (ref), u3 (copy)
    p5(u2);

    return u3.Changed:Connect(p5);
end;

task.spawn(function() -- Line: 24
    -- upvalues: UserInputService (copy), u1 (copy), u2 (ref), u3 (copy), workspace_CurrentCamera (copy)
    UserInputService.InputBegan:Wait();
    task.wait(5);
    local v6 = {};

    for _, child in workspace.Farm:GetChildren() do
        v6[child] = child.Center_Point.CFrame:Inverse();
    end;

    local function fastIsPointInFarm(p7: vector, p8) -- Line: 36
        -- upvalues: u1 (ref)
        local v9 = u1(p8, p7);
        local vector_abs_ret = vector.abs(v9);
        local v10;

        if vector_abs_ret.X <= 75 then
            v10 = vector_abs_ret.Z <= 55;
        else
            v10 = false;
        end;

        return v10;
    end;

    local function setCurrentFarm(p11) -- Line: 41
        -- upvalues: u2 (ref), u3 (ref)
        if u2 == p11 then
            return;
        end;

        local v12 = u2;
        u2 = p11;
        u3.Changed:Fire(p11, v12);
    end;

    while true do
        local Position = workspace_CurrentCamera.Focus.Position;
        local v13 = false;

        for i, v in v6 do
            local v14 = u1(v, Position);
            local vector_abs_ret = vector.abs(v14);
            local v15;

            if vector_abs_ret.X <= 75 then
                v15 = vector_abs_ret.Z <= 55;
            else
                v15 = false;
            end;

            if v15 then
                v13 = i;
            end;

            task.wait();
        end;

        if u2 ~= v13 then
            local v16 = u2;
            u2 = v13;
            u3.Changed:Fire(v13, v16);
        end;

        task.wait(1);
    end;
end);

return u3;