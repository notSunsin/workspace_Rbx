-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local DeepEquals = require(ReplicatedStorage.UserGenerated.Collections.DeepEquals);
local Bindable = require(ReplicatedStorage.UserGenerated.Concurrency.Bindable);
local table_freeze_ret = table.freeze({
    Get = function(p1) -- Line: 45, Name: Get
        return p1.Value;
    end,

    Set = function(p2, p3) -- Line: 60, Name: Set
        -- upvalues: DeepEquals (copy)
        if p2.Assertion then
            p3 = p2.Assertion(p3);
        end;

        local Value = p2.Value;
        p2.Value = p3;

        if not DeepEquals(p3, Value) then
            p2.Changed:Fire(p3, Value);
        end;

        return Value;
    end
});
local table_freeze_ret2 = table.freeze({
    __index = table_freeze_ret
});

return table.freeze({
    new = function(p4: function, p5: any) -- Line: 79, Name: new
        -- upvalues: Bindable (copy), table_freeze_ret2 (copy)
        local v6 = type(p4) == "function";
        assert(v6);
        local v7 = p4(p5);
        local v8 = {
            Changed = Bindable.new(),
            Assertion = p4,
            Value = v7
        };
        v8.Readonly = v8;

        return setmetatable(v8, table_freeze_ret2);
    end,

    Unasserted = function(p9) -- Line: 92, Name: Unasserted
        -- upvalues: Bindable (copy), table_freeze_ret2 (copy)
        local v10 = {
            Changed = Bindable.new(),
            Value = p9
        };
        v10.Readonly = v10;

        return setmetatable(v10, table_freeze_ret2);
    end
});