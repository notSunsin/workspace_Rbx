-- Decompiled with Potassium's decompiler.

local BindableEvent = Instance.new("BindableEvent");
local u1 = false;
BindableEvent.Event:Connect(function() -- Line: 7
    -- upvalues: u1 (ref)
    u1 = true;
end);
BindableEvent:Fire();
BindableEvent:Destroy();
local script_Deferred = require(script.Deferred);
local script_Immediate = require(script.Immediate);
local v2 = (u1 == false and true or false) and script_Deferred and script_Deferred or script_Immediate;
v2.Deferred = script_Deferred;
v2.Immediate = script_Immediate;

return v2;