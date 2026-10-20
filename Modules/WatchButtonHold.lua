-- Decompiled with Potassium's decompiler.

local UserInputService = game:GetService("UserInputService");
local RunService = game:GetService("RunService");
local u1 = nil;
local u2 = 0;

local function updateHolding() -- Line: 19
    -- upvalues: u1 (ref), u2 (ref)
    if not u1 then
        return;
    end;

    local os_clock_ret = os.clock();

    if os_clock_ret < u1.t or os_clock_ret - u2 < u1.interval then
        return;
    end;

    u2 = os_clock_ret;
    u1.callback(os_clock_ret - u1.t);
end;

local function clearHolding() -- Line: 33
    -- upvalues: u1 (ref), u2 (ref)
    if u1 then
        if u1.conn then
            u1.conn:Disconnect();
            u1.conn = nil;
        end;

        local os_clock_ret = os.clock();

        if u1.t <= os_clock_ret then
            task.spawn(u1.callback, os_clock_ret - u1.t, true);
        end;

        u2 = 0;
        u1 = nil;
    end;
end;

UserInputService.InputEnded:Connect(function(p3: userdata, p4: boolean) -- Line: 50
    -- upvalues: clearHolding (copy)
    if p3.UserInputType == Enum.UserInputType.MouseButton1 or (p3.UserInputType == Enum.UserInputType.Touch or p3.KeyCode == Enum.KeyCode.ButtonA) then
        clearHolding();
    end;
end);

return function(u5: userdata, u6: function, u7: table?) -- Line: 57
    -- upvalues: clearHolding (copy), u1 (ref), RunService (copy), updateHolding (copy)
    local u8 = u5.MouseButton1Down:Connect(function() -- Line: 58
        -- upvalues: clearHolding (ref), u1 (ref), u5 (copy), u7 (copy), u6 (copy), RunService (ref), updateHolding (ref)
        clearHolding();
        u1 = {
            button = u5,
            t = os.clock() + (u7 and u7.minimumHoldTime or 0),
            interval = u7 and u7.interval or 0,
            callback = u6,
            conn = RunService.PostSimulation:Connect(updateHolding)
        };
    end);
    local u9 = u5.MouseButton1Up:Connect(function() -- Line: 70
        -- upvalues: u1 (ref), u5 (copy), clearHolding (ref)
        if u1 and u1.button == u5 then
            clearHolding();
        end;
    end);
    local u10 = u5.Destroying:Once(function() -- Line: 76
        -- upvalues: u1 (ref), u5 (copy), clearHolding (ref)
        if u1 and u1.button == u5 then
            clearHolding();
        end;
    end);

    return function() -- Line: 82
        -- upvalues: u10 (copy), u8 (copy), u9 (copy)
        u10:Disconnect();
        u8:Disconnect();
        u9:Disconnect();
    end;
end;