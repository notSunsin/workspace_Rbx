-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Logging = require(ReplicatedStorage.UserGenerated.Logging);
local Asserts = require(ReplicatedStorage.UserGenerated.Lang.Asserts);
local table_freeze_ret = table.freeze({
    __index = table.freeze({
        Disconnect = function(p1) -- Line: 51, Name: Disconnect
            p1.Connection:Disconnect();
            p1:OnDisconnected();
        end,

        OnDisconnected = function(p2) -- Line: 56, Name: OnDisconnected
            if p2.Vars.Disconnected then
                return;
            end;

            p2.Vars.Disconnected = true;

            for _, v in ipairs(p2.Callbacks) do
                task.spawn(v);
            end;

            table.clear(p2.Callbacks);
        end,

        Then = function(p3, p4) -- Line: 67, Name: Then
            -- upvalues: Asserts (copy)
            Asserts.Function(p4);

            if p3.Vars.Disconnected then
                task.spawn(p4);

                return;
            end;

            table.insert(p3.Callbacks, p4);
        end
    })
});

function new(u5: number, u6: function)
    -- upvalues: Asserts (copy), table_freeze_ret (copy), RunService (copy), Logging (copy)
    Asserts.FiniteNonNegative(u5);
    Asserts.Function(u6);
    local u7 = setmetatable({
        Connection = nil,
        Callbacks = {},
        Vars = {
            Disconnected = false
        }
    }, table_freeze_ret);
    local u8 = 0;
    local u9 = nil;
    u9 = RunService.RenderStepped:Connect(function(p10) -- Line: 94
        -- upvalues: u8 (ref), u5 (copy), u9 (ref), u6 (copy), Logging (ref), u7 (copy)
        local v11 = false;
        local v12 = u8;
        u8 = u8 + p10;

        if u5 <= u8 then
            u8 = u5;
            u9:Disconnect();
            v11 = true;
        end;

        local success, result = pcall(u6, u5 <= u8 and 1 or u8 / u5, u8, u8 - v12);

        if not success then
            Logging.Warn("RenderError", result);
        end;

        if not success or result ~= nil then
            u9:Disconnect();
            v11 = true;
        end;

        if v11 then
            u7:OnDisconnected();
        end;
    end);
    u7.Connection = u9;
    table.freeze(u7);

    return u7;
end;

return new;