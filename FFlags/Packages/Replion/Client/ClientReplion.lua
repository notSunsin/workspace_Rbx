-- Decompiled with Potassium's decompiler.

local Freeze = require(script.Parent.Parent.Parent.Freeze);
local Utils = require(script.Parent.Parent.Internal.Utils);
local Signal = require(script.Parent.Parent.Parent.Signal);
require(script.Parent.Parent.Internal.Types);
local Signals = require(script.Parent.Parent.Internal.Signals);
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 99
    -- upvalues: Signal (copy), Signals (copy), u1 (copy)
    local v3 = {
        Data = p2[3],
        Tags = p2[5],
        ReplicateTo = p2[4],
        _channel = p2[2],
        _beforeDestroy = Signal.new(),
        _signals = Signals.new()
    };

    return setmetatable(v3, u1);
end;

function u1.__tostring(p4) -- Line: 114
    return `Replion<{p4._channel}>`;
end;

function u1.BeforeDestroy(p5, p6) -- Line: 125
    return p5._beforeDestroy:Connect(p6);
end;

function u1.OnDataChange(p7, p8) -- Line: 136
    return p7._signals:Connect("onDataChange", "__root", p8);
end;

function u1.OnChange(p9, p10, p11) -- Line: 154
    return p9._signals:Connect("onChange", p10, p11);
end;

function u1.OnDescendantChange(p12, p13, p14) -- Line: 177
    return p12._signals:Connect("onDescendantChange", p13, p14);
end;

function u1.OnArrayInsert(p15, p16, p17) -- Line: 189
    return p15._signals:Connect("onArrayInsert", p16, p17);
end;

function u1.OnArrayRemove(p18, p19, p20) -- Line: 201
    return p18._signals:Connect("onArrayRemove", p19, p20);
end;

function u1._set(p21, p22, p23) -- Line: 205
    -- upvalues: Utils (copy), Freeze (copy)
    local PathTable = Utils.getPathTable(p22);

    if Freeze.Dictionary.getIn(p21.Data, PathTable) == p23 then
        return p23;
    end;

    local v24 = Freeze.Dictionary.setIn(p21.Data, PathTable, p23);
    local Data = p21.Data;
    p21.Data = v24;
    p21._signals:FireEvent("onDataChange", "__root", v24, PathTable);
    p21._signals:FireChange(p22, v24, Data);

    return p23;
end;

function u1._update(p25, p26, p27, u28) -- Line: 224
    -- upvalues: Freeze (copy), Utils (copy)
    local v31 = Freeze.Dictionary.map(p27 or p26, function(p29, p30) -- Line: 225
        -- upvalues: Utils (ref), Freeze (ref), u28 (copy)
        if p29 == Utils.SerializedNone then
            p29 = Freeze.None;
        end;

        if u28 then
            return p29, tonumber(p30);
        end;

        return p29, p30;
    end);
    local Data = p25.Data;

    if p27 == nil then
        local v32 = Freeze.Dictionary.merge(p25.Data, v31);
        p25.Data = v32;
        p25._signals:FireEvent("onDataChange", "__root", v32, {});

        for i, v in v31 do
            p25._signals:FireEvent("onChange", i, Utils.getValue(v), Data[i]);
        end;

        return;
    end;

    local PathTable = Utils.getPathTable(p26);
    local v33 = Freeze.Dictionary.mergeIn(p25.Data, PathTable, v31);
    p25.Data = v33;
    p25._signals:FireEvent("onDataChange", "__root", v33, PathTable);

    for i, v in v31 do
        local v34 = Freeze.List.push(PathTable, i);
        local In = Freeze.Dictionary.getIn(Data, v34);
        p25._signals:FireEvent("onChange", v34, Utils.getValue(v), In);
    end;

    p25._signals:FireChange(p26, v33, Data);
end;

function u1._increase(p35, p36, p37) -- Line: 260
    return p35:_set(p36, p35:GetExpect(p36) + p37);
end;

function u1._decrease(p38, p39, p40) -- Line: 266
    return p38:_increase(p39, -p40);
end;

function u1._insert(p41, p42, p43, p44) -- Line: 270
    -- upvalues: Utils (copy), Freeze (copy)
    local PathTable = Utils.getPathTable(p42);
    local In = Freeze.Dictionary.getIn(p41.Data, PathTable);
    local v45 = `"{Utils.getPathString(p42)}" is not a valid path!`;
    local v46 = assert(In, v45);
    local v47 = p44 or #v46 + 1;
    local v48 = Freeze.List.insert(v46, v47, p43);
    local Data = p41.Data;
    local v49 = Freeze.Dictionary.setIn(p41.Data, PathTable, v48);
    p41.Data = v49;
    p41._signals:FireEvent("onDataChange", "__root", v49, PathTable);
    p41._signals:FireEvent("onArrayInsert", PathTable, v47, p43);
    p41._signals:FireChange(PathTable, v49, Data);
end;

function u1._remove(p50, p51, p52) -- Line: 289
    -- upvalues: Utils (copy), Freeze (copy)
    local PathTable = Utils.getPathTable(p51);
    local In = Freeze.Dictionary.getIn(p50.Data, PathTable);
    local v53 = `"{Utils.getPathString(p51)}" is not a valid path!`;
    local v54 = assert(In, v53);
    local v55 = p52 or #v54;
    local v56 = v54[v55];
    local v57 = Freeze.List.remove(v54, v55);
    local Data = p50.Data;
    local v58 = Freeze.Dictionary.setIn(p50.Data, PathTable, v57);
    p50.Data = v58;
    p50._signals:FireEvent("onDataChange", "__root", v58, PathTable);
    p50._signals:FireEvent("onArrayRemove", p51, v55, v56);
    p50._signals:FireChange(p51, v58, Data);

    return v56;
end;

function u1._clear(p59, p60) -- Line: 311
    -- upvalues: Utils (copy), Freeze (copy)
    local PathTable = Utils.getPathTable(p60);
    local Data = p59.Data;
    local v61 = Freeze.Dictionary.setIn(p59.Data, PathTable, {});
    p59.Data = v61;
    p59._signals:FireEvent("onDataChange", "__root", v61, PathTable);
    p59._signals:FireChange(p60, v61, Data);
end;

function u1.Find(p62, p63, p64) -- Line: 336
    local v65 = p62:Get(p63);

    if not v65 then
        return;
    end;

    local table_find_ret = table.find(v65, p64);

    if table_find_ret then
        return table_find_ret, p64;
    end;
end;

function u1.Get(p66, p67) -- Line: 360
    -- upvalues: Freeze (copy), Utils (copy)
    return Freeze.Dictionary.getIn(p66.Data, Utils.getPathTable(p67));
end;

function u1.GetExpect(p68, p69, p70) -- Line: 378
    -- upvalues: Utils (copy)
    assert(p69, "Path is required!");
    local v71 = p70 or `"{Utils.getPathString(p69)}" is not a valid path!`;
    local v72 = p68:Get(p69);

    if v72 == nil then
        error(v71);
    end;

    return v72;
end;

function u1.Destroy(p73) -- Line: 391
    if p73.Destroyed then
        return;
    end;

    p73._beforeDestroy:Fire();
    p73._beforeDestroy:DisconnectAll();
    p73._signals:Destroy();
    p73.Destroyed = true;
end;

return u1;