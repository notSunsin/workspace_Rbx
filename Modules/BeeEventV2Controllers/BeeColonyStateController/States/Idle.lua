-- Decompiled with Potassium's decompiler.

return function(p1) -- Line: 1
    return function(p2: string, p3: number, p4: table) -- Line: 2
        for _, v in p4 do
            v.Client.PredictedCFrame = nil;
            v.Client.LockFacing = false;
        end;
    end;
end;