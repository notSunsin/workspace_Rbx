-- Decompiled with Potassium's decompiler.

local RunService = game:GetService("RunService");
local Ping = script.Parent:WaitForChild("Ping");
local u1 = 0;
local u2 = 0;

local function SendPing() -- Line: 27
    -- upvalues: u2 (ref), Ping (copy)
    u2 = u2 + 1;
    Ping:FireServer(u2, workspace:GetServerTimeNow());
end;

RunService.Heartbeat:Connect(function(p3) -- Line: 31
    -- upvalues: u1 (ref), u2 (ref), Ping (copy)
    u1 = u1 + p3;

    if u1 >= 1 then
        u1 = u1 % 1;
        u2 = u2 + 1;
        Ping:FireServer(u2, workspace:GetServerTimeNow());
    end;
end);
task.spawn(SendPing);