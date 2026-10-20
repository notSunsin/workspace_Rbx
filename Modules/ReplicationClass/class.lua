-- Decompiled with Potassium's decompiler.

local u1 = { "Set", "Get", "Private", "ReadOnly", "WriteOnly", "Constructor", "GlobalGetFunction", "GlobalSetFunction" };

local function DeepCopy(p2: userdata) -- Line: 5
    -- upvalues: DeepCopy (copy)
    local v3 = {};

    for i, v in p2 do
        local v4;

        if type(v) == "table" then
            v4 = DeepCopy(v) or v;
        else
            v4 = v;
        end;

        v3[i] = v4;
    end;

    return v3;
end;

return function(u5) -- Line: 13, Name: class
    -- upvalues: DeepCopy (copy), u1 (copy)
    local u6 = {};
    u6.__index = u6;
    u6.__customclass = true;
    local u7 = DeepCopy(u5.Set or {});
    local u8 = DeepCopy(u5.Get or {});
    local u9 = DeepCopy(u5.ReadOnly or {});
    local u10 = DeepCopy(u5.WriteOnly or {});
    local u11 = DeepCopy(u5.Private or {});
    local GlobalGetFunction = u5.GlobalGetFunction;
    local GlobalSetFunction = u5.GlobalSetFunction;
    local Constructor = u5.Constructor;
    table.freeze(u7);
    table.freeze(u8);
    table.freeze(u9);
    table.freeze(u10);
    table.freeze(u11);
    table.freeze(u5);

    function u6.new(...) -- Line: 35
        -- upvalues: u5 (ref), DeepCopy (ref), u1 (ref), u11 (copy), u10 (copy), u8 (copy), GlobalGetFunction (copy), u6 (copy), u9 (copy), u7 (copy), GlobalSetFunction (copy), Constructor (copy)
        local u12 = {};
        local u13 = {};
        u5 = DeepCopy(u5);

        for i, v in u5 do
            if not table.find(u1, i) then
                u12[i] = v;
            end;
        end;

        local v21 = setmetatable({
            RealData = u12
        }, {
            __index = function(p14, p15) -- Line: 50, Name: __index
                -- upvalues: u11 (ref), u13 (copy), u10 (ref), u8 (ref), GlobalGetFunction (ref), u6 (ref), u12 (copy)
                local debug_info_ret = debug.info(2, "f");

                if not u13[debug_info_ret] and u11[p15] then
                    return error((`Cannot access private function {debug_info_ret} from {debug.info(2, "f")}`));
                end;

                if u10[p15] then
                    return error((`Cannot read from write only property {p15}`));
                end;

                local v16 = u8[p15];

                if GlobalGetFunction then
                    GlobalGetFunction(p14, p15);
                end;

                return rawget(u6, p15) or v16 and v16(p14) or rawget(u12, p15);
            end,

            __newindex = function(p17, p18, p19) -- Line: 73, Name: __newindex
                -- upvalues: u11 (ref), u13 (copy), u9 (ref), u7 (ref), u12 (copy), GlobalSetFunction (ref)
                local debug_info_ret = debug.info(2, "f");

                if not u13[debug_info_ret] and u11[p18] then
                    return error((`Cannot access private function {debug_info_ret} from {debug.info(2, "f")}`));
                end;

                if u9[p18] then
                    return error((`Cannot write to read only property {p18}`));
                end;

                local v20 = u7[p18];

                if v20 then
                    v20(p17, p18, p19);
                else
                    rawset(u12, p18, p19);
                end;

                if GlobalSetFunction then
                    GlobalSetFunction(p17, p18, p19);
                end;
            end
        });

        for _, v in u6 do
            if type(v) == "function" then
                u13[v] = true;
            end;
        end;

        u13[debug.info(1, "f")] = true;

        if Constructor then
            Constructor(v21, ...);
        end;

        return v21;
    end;

    return u6;
end;