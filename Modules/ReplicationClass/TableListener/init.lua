-- Decompiled with Potassium's decompiler.

game:GetService("ReplicatedStorage");
game:GetService("HttpService");
local _ = script.Parent;
local Signal = require(script:WaitForChild("Signal"));
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 11
    -- upvalues: u1 (copy)
    return setmetatable({
        Table = p2,
        PathRegistry = {}
    }, u1);
end;

function u1.Destroy(p3) -- Line: 20
    for _, v in p3.PathRegistry do
        v:Destroy();
    end;
end;

function u1.GetTable(p4) -- Line: 26
    return p4.Table;
end;

function u1.FindPathSignal(p5, p6) -- Line: 30
    local PathRegistry = p5.PathRegistry;

    if PathRegistry[p6] then
        return PathRegistry[p6];
    end;
end;

function u1.FreePathSignal(p7, p8) -- Line: 36
    p7.PathRegistry[p8] = nil;
end;

function u1.GetPathSignal(p9, p10) -- Line: 41
    -- upvalues: Signal (copy)
    local v11 = p9:FindPathSignal(p10);

    if v11 then
        return v11;
    end;

    local PathRegistry = p9.PathRegistry;
    local v12 = Signal.new();
    PathRegistry[`{p10}`] = v12;

    return v12;
end;

return u1;