-- Decompiled with Potassium's decompiler.

local RunService = game:GetService("RunService");
local u1 = newproxy();
local u2 = newproxy();
local table_freeze_ret = table.freeze({ "Destroy", "Disconnect", "destroy", "disconnect" });

local function GetObjectCleanupFunction(p3: any, p4: string?) -- Line: 126
    -- upvalues: u1 (copy), u2 (copy), table_freeze_ret (copy)
    local v5 = typeof(p3);

    if v5 == "function" then
        return u1;
    end;

    if v5 == "thread" then
        return u2;
    end;

    if p4 then
        return p4;
    end;

    if v5 == "Instance" then
        return "Destroy";
    end;

    if v5 == "RBXScriptConnection" then
        return "Disconnect";
    end;

    if v5 == "table" then
        for _, v in table_freeze_ret do
            if typeof(p3[v]) == "function" then
                return v;
            end;
        end;
    end;

    error(`failed to get cleanup function for object {v5}: {p3}`, 3);
end;

local function AssertPromiseLike(p6) -- Line: 154
    if typeof(p6) ~= "table" or (typeof(p6.getStatus) ~= "function" or (typeof(p6.finally) ~= "function" or typeof(p6.cancel) ~= "function")) then
        error("did not receive a promise as an argument", 3);
    end;
end;

local u7 = {};
u7.__index = u7;

function u7.new() -- Line: 181
    -- upvalues: u7 (copy)
    local v8 = setmetatable({}, u7);
    v8._objects = {};
    v8._cleaning = false;

    return v8;
end;

function u7.Add(p9: any, p10: any, p11: string?) -- Line: 240
    -- upvalues: GetObjectCleanupFunction (copy)
    if p9._cleaning then
        error("cannot call trove:Add() while cleaning", 2);
    end;

    local v12 = { p10, (GetObjectCleanupFunction(p10, p11)) };
    table.insert(p9._objects, v12);

    return p10;
end;

function u7.Clone(p13: any, p14: userdata) -- Line: 262
    if p13._cleaning then
        error("cannot call trove:Clone() while cleaning", 2);
    end;

    return p13:Add(p14:Clone());
end;

function u7.Construct(p15, p16, ...) -- Line: 305
    if p15._cleaning then
        error("Cannot call trove:Construct() while cleaning", 2);
    end;

    local v17 = nil;
    local v18 = type(p16);

    if v18 == "table" then
        v17 = p16.new(...);
    elseif v18 == "function" then
        v17 = p16(...);
    end;

    return p15:Add(v17);
end;

function u7.Connect(p19: any, p20: table, p21: function) -- Line: 338
    if p19._cleaning then
        error("Cannot call trove:Connect() while cleaning", 2);
    end;

    return p19:Add(p20:Connect(p21));
end;

function u7.BindToRenderStep(p22: any, u23: string, p24: number, p25: function) -- Line: 361
    -- upvalues: RunService (copy)
    if p22._cleaning then
        error("cannot call trove:BindToRenderStep() while cleaning", 2);
    end;

    RunService:BindToRenderStep(u23, p24, p25);
    p22:Add(function() -- Line: 368
        -- upvalues: RunService (ref), u23 (copy)
        RunService:UnbindFromRenderStep(u23);
    end);
end;

function u7.AddPromise(u26: any, u27: table) -- Line: 398
    if u26._cleaning then
        error("cannot call trove:AddPromise() while cleaning", 2);
    end;

    if typeof(u27) ~= "table" or (typeof(u27.getStatus) ~= "function" or (typeof(u27.finally) ~= "function" or typeof(u27.cancel) ~= "function")) then
        error("did not receive a promise as an argument", 3);
    end;

    if u27:getStatus() == "Started" then
        u27:finally(function() -- Line: 405
            -- upvalues: u26 (copy), u27 (copy)
            if u26._cleaning then
                return;
            end;

            u26:_findAndRemoveFromObjects(u27, false);
        end);
        u26:Add(u27, "cancel");
    end;

    return u27;
end;

function u7.Remove(p28, p29) -- Line: 430
    if p28._cleaning then
        error("cannot call trove:Remove() while cleaning", 2);
    end;

    return p28:_findAndRemoveFromObjects(p29, true);
end;

function u7.Extend(p30) -- Line: 459
    -- upvalues: u7 (copy)
    if p30._cleaning then
        error("cannot call trove:Extend() while cleaning", 2);
    end;

    return p30:Construct(u7);
end;

function u7.Pop(p31, p32) -- Line: 481
    if p31._cleaning then
        error("cannot call trove:Pop() while cleaning", 2);
    end;

    return p31:_findAndRemoveFromObjects(p32, false);
end;

function u7.Clean(p33) -- Line: 501
    if p33._cleaning then
        return;
    end;

    p33._cleaning = true;

    for _, v in p33._objects do
        p33:_cleanupObject(v[1], v[2]);
    end;

    table.clear(p33._objects);
    p33._cleaning = false;
end;

function u7.WrapClean(u34) -- Line: 543
    return function() -- Line: 544
        -- upvalues: u34 (copy)
        u34:Clean();
    end;
end;

function u7._findAndRemoveFromObjects(p35: any, p36: any, p37: boolean) -- Line: 549
    local _objects = p35._objects;

    for i, v in _objects do
        if v[1] == p36 then
            local v38 = #_objects;
            _objects[i] = _objects[v38];
            _objects[v38] = nil;

            if p37 then
                p35:_cleanupObject(v[1], v[2]);
            end;

            return true;
        end;
    end;

    return false;
end;

function u7._cleanupObject(p39: any, p40: any, p41: string?) -- Line: 569
    -- upvalues: u1 (copy), u2 (copy)
    if p41 == u1 then
        task.spawn(p40);

        return;
    end;

    if p41 == u2 then
        pcall(task.cancel, p40);

        return;
    end;

    p40[p41](p40);
end;

function u7.AttachToInstance(u42: any, p43: userdata) -- Line: 609
    if u42._cleaning then
        error("cannot call trove:AttachToInstance() while cleaning", 2);
    elseif not p43:IsDescendantOf(game) then
        error("instance is not a descendant of the game hierarchy", 2);
    end;

    return u42:Connect(p43.Destroying, function() -- Line: 616
        -- upvalues: u42 (copy)
        u42:Destroy();
    end);
end;

function u7.Destroy(p44) -- Line: 630
    p44:Clean();
end;

return {
    new = u7.new
};