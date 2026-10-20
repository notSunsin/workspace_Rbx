-- Decompiled with Potassium's decompiler.

local Signal = require(script.Parent.Parent.Parent.Signal);
require(script.Parent.Types);
local Utils = require(script.Parent.Utils);

local function getIn(p1: any, p2: table) -- Line: 13
    for _, v in p2 do
        if not p1 then
            return nil;
        end;

        p1 = p1[v];
    end;

    return p1;
end;

local u3 = {};
u3.__index = u3;

function u3.new() -- Line: 45
    -- upvalues: u3 (copy)
    return setmetatable({
        _containers = {}
    }, u3);
end;

function u3._getContainer(p4, p5, p6) -- Line: 51
    assert(p4._containers, "You\'re trying to use a Replion that has been destroyed!");

    if p6 and not p4._containers[p5] then
        p4._containers[p5] = {};
    end;

    return p4._containers[p5];
end;

function u3.Connect(p7, p8, p9, p10) -- Line: 61
    -- upvalues: Utils (copy)
    if _G.__DEV__ and not _G.__IGNORE_INSTANCES_WARNING__ then
        local v11 = false;

        for _, v in Utils.getPathTable(p9) do
            if typeof(v) == "Instance" then
                v11 = true;
                break;
            end;
        end;

        if v11 then
            local debug_info_ret, v12 = debug.info(3, "sl");
            task.spawn(error, `[Memory Leak Warning] Instance used as a Connection index at {debug_info_ret}:{v12}. ` .. "Using Instances will cause memory leaks as Replion cannot automatically dispose of such connections. Consider using a string or number as your index to prevent this issue.");
        end;
    end;

    local v13 = p7:Get(p8, p9);

    return assert(v13, "Signal does not exist!"):Connect(p10);
end;

function u3.Get(p14, p15, p16, p17) -- Line: 92
    -- upvalues: Utils (copy), Signal (copy)
    local v18 = p17 == nil and true or p17;
    local v19 = p14:_getContainer(p15, v18);

    if v19 then
        for _, v in Utils.getPathTable(p16) do
            if not v19[v] then
                if not v18 then
                    return nil;
                end;

                v19[v] = {};
            end;

            v19 = v19[v];

            if not v19 then
                return nil;
            end;
        end;

        if v18 and not v19.__signal then
            v19.__signal = Signal.new();
        end;

        return v19.__signal;
    end;
end;

function u3.FireEvent(p20, p21, p22, ...) -- Line: 124
    local v23 = p20:Get(p21, p22, false);

    if v23 then
        v23:Fire(...);
    end;
end;

function u3.FireChange(p24, p25, p26, p27) -- Line: 131
    -- upvalues: Utils (copy)
    if not (p24._containers and next(p24._containers)) then
        return;
    end;

    local PathTable = Utils.getPathTable(p25);
    local v28 = #PathTable;
    local v29 = p24._containers.onDescendantChange ~= nil;

    for i = v28, 1, -1 do
        if i < v28 then
            PathTable[i + 1] = nil;
        end;

        local onChange = p24._containers.onChange;
        local v30 = i;

        for _, v in PathTable do
            if not onChange then
                onChange = nil;
                break;
            end;

            onChange = onChange[v];
        end;

        local v31;

        if onChange then
            v31 = onChange.__signal;
        else
            v31 = nil;
        end;

        local v32;

        if v29 and v30 > 1 then
            local v33 = PathTable[v30];
            PathTable[v30] = nil;
            local onDescendantChange = p24._containers.onDescendantChange;

            for _, v in PathTable do
                if not onDescendantChange then
                    onDescendantChange = nil;
                    break;
                end;

                onDescendantChange = onDescendantChange[v];
            end;

            if onDescendantChange then
                v32 = onDescendantChange.__signal;
            else
                v32 = nil;
            end;

            PathTable[v30] = v33;
        else
            v32 = nil;
        end;

        if v31 or v32 then
            local v34 = p26;

            for _, v in PathTable do
                if not p26 then
                    p26 = nil;
                    break;
                end;

                p26 = p26[v];
            end;

            local v35 = p27;

            for _, v in PathTable do
                if not p27 then
                    p27 = nil;
                    break;
                end;

                p27 = p27[v];
            end;

            if v31 then
                v31:Fire(p26, p27);
            end;

            if v32 then
                v32:Fire(table.clone(PathTable), p26, p27);
                p27 = v35;
                p26 = v34;
            else
                p27 = v35;
                p26 = v34;
            end;
        end;
    end;
end;

function u3.Destroy(p36) -- Line: 188
    assert(p36._containers, "This Replion has already been destroyed!");

    local function destroySignals(p37: table) -- Line: 191
        -- upvalues: destroySignals (copy)
        if p37.__signal then
            p37.__signal:Destroy();
            p37.__signal = nil;
        end;

        for _, v in p37 do
            destroySignals(v);
        end;
    end;

    for _, v in p36._containers do
        if v.__signal then
            v.__signal:Destroy();
            v.__signal = nil;
        end;

        for _, v2 in v do
            destroySignals(v2);
        end;
    end;

    p36._containers = nil;
end;

return u3;