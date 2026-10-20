-- Decompiled with Potassium's decompiler.

function _merge1(p1: function, p2: table, p3: table)
    if not p2.Left then
        p2.Left = p3;

        return p2;
    end;

    p2.Right = _merge(p1, p2.Right, p3);

    if p2.Left.Npl < p2.Right.Npl then
        local Left = p2.Left;
        p2.Left = p2.Right;
        p2.Right = Left;
    end;

    p2.Npl = p2.Right.Npl + 1;

    return p2;
end;

function _merge(p4: function, p5: table?, p6: table?)
    if not p5 then
        return p6;
    end;

    if not p6 then
        return p5;
    end;

    if p4(p5.Value, p6.Value) < 0 then
        return _merge1(p4, p5, p6);
    end;

    return _merge1(p4, p6, p5);
end;

local v7 = {};
local table_freeze_ret = table.freeze({
    __index = v7
});

function v7.Merge(p8, p9) -- Line: 131
    if p8.Root ~= p9.Root then
        p8.Root = _merge(p8.Comparator, p8.Root, p9.Root);
        p9.Root = nil;
    end;
end;

function v7.Insert(p10, p11) -- Line: 138
    p10.Root = _merge(p10.Comparator, {
        Npl = 0,
        Value = p11
    }, p10.Root);
end;

function v7.Min(p12) -- Line: 145
    assert(p12.Root);

    return p12.Root.Value;
end;

function v7.TryMin(p13) -- Line: 150
    if p13.Root then
        return true, p13.Root.Value;
    end;

    return false, nil;
end;

function v7.Pop(p14) -- Line: 157
    assert(p14.Root);
    local Value = p14.Root.Value;
    p14.Root = _merge(p14.Comparator, p14.Root.Left, p14.Root.Right);

    return Value;
end;

function v7.TryPop(p15) -- Line: 164
    if not p15.Root then
        return false, nil;
    end;

    local Value = p15.Root.Value;
    p15.Root = _merge(p15.Comparator, p15.Root.Left, p15.Root.Right);

    return true, Value;
end;

function v7.PopFast(p16) -- Line: 173
    p16.Root = _merge(p16.Comparator, p16.Root.Left, p16.Root.Right);
end;

function v7.Empty(p17) -- Line: 177
    return p17.Root == nil;
end;

function v7.Clear(p18) -- Line: 181
    p18.Root = nil;
end;

table.freeze(v7);

return table.freeze({
    Compare = function(p19, p20) -- Line: 190, Name: Compare
        return p19 < p20 and -1 or (p20 < p19 and 1 or 0);
    end,

    new = function(p21: function, p22: any) -- Line: 200, Name: new
        -- upvalues: table_freeze_ret (copy)
        local v23 = type(p21) == "function";
        assert(v23);

        return setmetatable({
            Comparator = p21
        }, table_freeze_ret);
    end
});