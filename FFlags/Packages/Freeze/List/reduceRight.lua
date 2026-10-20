-- Decompiled with Potassium's decompiler.

local reduce = require(script.Parent.Parent.utils.reduce);

return function(p1: table, p2: function, p3: any) -- Line: 18, Name: reduceRight
    -- upvalues: reduce (copy)
    return reduce(p1, p2, p3, true);
end;