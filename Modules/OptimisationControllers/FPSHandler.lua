-- Decompiled with Potassium's decompiler.

local v1 = {};
local RunService = game:GetService("RunService");
local u2 = 0;
local u3 = 0;
local u4 = nil;

local function Cleanup() -- Line: 11
    -- upvalues: u4 (ref)
    if u4 then
        u4:Disconnect();
        u4 = nil;
    end;
end;

function v1.EnableFPSTracker(p5) -- Line: 18
    -- upvalues: u4 (ref), RunService (copy), u2 (ref), u3 (ref)
    if u4 then
        u4:Disconnect();
        u4 = nil;
    end;

    u4 = RunService.RenderStepped:Connect(function(p6) -- Line: 21
        -- upvalues: u2 (ref), u3 (ref)
        if u2 > 1 then
            u2 = 0;
            u3 = 0;
        end;

        u2 = u2 + p6;
        u3 = u3 + 1;
    end);
end;

function v1.DisableFPSTracker(p7) -- Line: 32
    -- upvalues: u4 (ref)
    if u4 then
        u4:Disconnect();
        u4 = nil;
    end;
end;

function v1.GetCurrentFPS(p8) -- Line: 36
    -- upvalues: u3 (ref), u2 (ref)
    if u3 == 0 or u2 == 0 then
        u2 = u2 + task.wait();
        u3 = u3 + 1;
    end;

    return u3 / u2;
end;

return v1;