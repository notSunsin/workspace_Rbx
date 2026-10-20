-- Decompiled with Potassium's decompiler.

return table.freeze({
    QueryObject = function(p1: any, p2: string, p3: any) -- Line: 29, Name: QueryObject
        for _, v in ipairs(string.split(p2, ".")) do
            if p1 == nil then
                return false;
            end;

            if p1 == p3 then
                return true;
            end;

            if type(p1) ~= "table" then
                return false;
            end;

            p1 = p1[v];
        end;

        if p1 == nil then
            return false;
        end;

        if p1 == p3 then
            return true;
        end;

        return true, p1;
    end,

    HasHierarchicalOverlap = function(p4: string, p5: string) -- Line: 57, Name: HasHierarchicalOverlap
        if p4 == p5 then
            return true;
        end;

        local string_split_ret = string.split(p4, ".");
        local string_split_ret2 = string.split(p5, ".");

        for i = 1, math.min(#string_split_ret, #string_split_ret2) do
            if string_split_ret[i] ~= string_split_ret2[i] then
                return false;
            end;

            local _ = i;
        end;

        return true;
    end
});