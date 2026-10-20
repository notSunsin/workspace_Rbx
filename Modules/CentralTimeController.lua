-- Decompiled with Potassium's decompiler.

local u1 = {
    OverwriteTime = nil
};
local RunService = game:GetService("RunService");

function u1.SetTime(p2: table, p3: number) -- Line: 8
    -- upvalues: u1 (copy)
    u1.OverwriteTime = p3;
end;

function u1.GetTime(p4) -- Line: 12
    -- upvalues: u1 (copy), RunService (copy)
    local OverwriteTime = u1.OverwriteTime;

    if not OverwriteTime then
        if RunService:IsServer() then
            return DateTime.now().UnixTimestamp;
        end;

        OverwriteTime = workspace:GetServerTimeNow();
    end;

    return OverwriteTime;
end;

return u1;