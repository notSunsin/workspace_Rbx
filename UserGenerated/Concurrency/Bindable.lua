-- Decompiled with Potassium's decompiler.

local function ErrorHandler(p1) -- Line: 96
    warn((`{tostring(p1)}\nStack Begin\n{debug.traceback(nil, 3)}Stack End`));
end;

local function WCall(p2: function, ...) -- Line: 100
    -- upvalues: ErrorHandler (copy)
    return xpcall(p2, ErrorHandler, ...);
end;

local function FindRight(p3: table, p4: any) -- Line: 108
    local v5 = #p3;
    local v6 = 1;
    local v7 = false;

    while v6 <= v5 do
        local v8 = v6 + (v5 - v6) // 2;
        local v9 = p3[v8].Pr - p4.Pr;

        if v9 > 0 then
            v5 = v8 - 1;
        elseif v9 < 0 then
            v6 = v8 + 1;
        else
            v6 = v8 + 1;
            v7 = true;
        end;
    end;

    return v7 and v6 and v6 or -v6;
end;

local function FindLeft(p10: table, p11: any) -- Line: 132
    local v12 = #p10;
    local v13 = 1;
    local v14 = false;

    while v13 <= v12 do
        local v15 = v13 + (v12 - v13) // 2;
        local v16 = p10[v15].Pr - p11.Pr;

        if v16 > 0 then
            v12 = v15 - 1;
        elseif v16 < 0 then
            v13 = v15 + 1;
        else
            v12 = v15 - 1;
            v14 = true;
        end;
    end;

    return v14 and v13 and v13 or -v13;
end;

local function InsertRight(p17: table, p18: any) -- Line: 155
    -- upvalues: FindRight (copy)
    local v19 = FindRight(p17, p18);
    local math_abs_ret = math.abs(v19);
    table.insert(p17, math_abs_ret, p18);

    return math_abs_ret;
end;

local function Remove(p20: table, p21: any) -- Line: 165
    -- upvalues: FindLeft (copy)
    local v22 = FindLeft(p20, p21);

    if v22 > 0 then
        for i = v22, #p20 do
            if p20[i] == p21 then
                table.remove(p20, i);

                return true;
            end;

            local _ = i;
        end;
    end;

    return false;
end;

local function Connection_Disconnect(p23) -- Line: 183
    -- upvalues: Remove (copy)
    local Ow = p23.Ow;

    if Ow ~= nil then
        p23.Ow = nil;

        if not Remove(Ow.Cs, p23) then
            warn("BindableConnectionDisconnect");
        end;

        for _, v in ipairs(p23.Wt) do
            task.spawn(v);
        end;

        table.clear(p23.Wt);
    end;
end;

local table_freeze_ret = table.freeze({
    IsConnected = function(p24) -- Line: 179, Name: Connection_IsConnected
        return p24.Ow ~= nil;
    end,

    Disconnect = Connection_Disconnect,

    GetPriority = function(p25) -- Line: 197, Name: Connection_GetPriority
        return p25.Pr;
    end
});
local table_freeze_ret2 = table.freeze({
    __index = table_freeze_ret
});

local function Connection_new(p26: any, p27: function, p28: number) -- Line: 208
    -- upvalues: table_freeze_ret2 (copy)
    return setmetatable({
        Ow = p26,
        Cb = p27,
        Pr = p28,
        Wt = {}
    }, table_freeze_ret2);
end;

local table_freeze_ret3 = table.freeze({
    Fire = function(p29, ...) -- Line: 250, Name: Bindable_Fire
        local Cs = p29.Cs;
        local v30 = 1;

        while v30 <= #Cs do
            local v31 = Cs[v30];
            task.spawn(v31.Cb, ...);

            if Cs[v30] == v31 then
                v30 = v30 + 1;
            end;
        end;
    end,

    FireAndWait = function(p32, ...) -- Line: 264, Name: Bindable_FireAndWait
        -- upvalues: WCall (copy)
        local Cs = p32.Cs;

        if #Cs == 0 then
            return;
        end;

        local u33 = 1;
        local coroutine_running_ret = coroutine.running();

        local function executor(p34: function, ...) -- Line: 271
            -- upvalues: WCall (ref), u33 (ref), coroutine_running_ret (copy)
            WCall(p34, ...);
            u33 = u33 - 1;

            if u33 == 0 then
                task.spawn(coroutine_running_ret);
            end;
        end;

        local v35 = 1;

        while v35 <= #Cs do
            local v36 = Cs[v35];
            u33 = u33 + 1;
            task.spawn(executor, v36.Cb, ...);

            if Cs[v35] == v36 then
                v35 = v35 + 1;
            end;
        end;

        u33 = u33 - 1;

        if u33 > 0 then
            coroutine.yield();
        end;
    end,

    FireSync = function(p37, ...) -- Line: 293, Name: Bindable_FireSync
        -- upvalues: WCall (copy)
        local Cs = p37.Cs;
        local v38 = 1;

        while v38 <= #Cs do
            local v39 = Cs[v38];
            WCall(v39.Cb, ...);

            if Cs[v38] == v39 then
                v38 = v38 + 1;
            end;
        end;
    end,

    Invoke = function(p40, ...) -- Line: 305, Name: Bindable_Invoke
        local Cs = p40.Cs;

        if #Cs >= 1 then
            return Cs[1].Cb(...);
        end;

        error("Invoke");
    end,

    Connect = function(p41: any, p42: function, p43: number?) -- Line: 234, Name: Bindable_Connect
        -- upvalues: table_freeze_ret2 (copy), FindRight (copy)
        local v44;

        if p43 == nil then
            v44 = true;
        elseif type(p43) == "number" then
            v44 = p43 == p43;
        else
            v44 = false;
        end;

        assert(v44);
        local v45 = p43 or (1 / 0);
        local v46 = setmetatable({
            Ow = p41,
            Cb = p42,
            Pr = v45,
            Wt = {}
        }, table_freeze_ret2);

        if v45 == (1 / 0) then
            table.insert(p41.Cs, v46);

            return v46;
        end;

        local Cs = p41.Cs;
        local v47 = FindRight(Cs, v46);
        local math_abs_ret = math.abs(v47);
        table.insert(Cs, math_abs_ret, v46);

        return v46;
    end,

    Wait = function(p48) -- Line: 316, Name: Bindable_Wait
        -- upvalues: Connection_Disconnect (copy), table_freeze_ret2 (copy)
        local coroutine_running_ret = coroutine.running();
        local u49 = true;
        local u50 = nil;

        local function v51(...) -- Line: 320
            -- upvalues: u50 (ref), coroutine_running_ret (copy), u49 (ref), Connection_Disconnect (ref)
            local table_find_ret = table.find(u50.Wt, coroutine_running_ret);

            if table_find_ret then
                table.remove(u50.Wt, table_find_ret);
            end;

            u49 = false;
            Connection_Disconnect(u50);
            task.spawn(coroutine_running_ret, ...);
        end;

        assert(true);
        local v52 = setmetatable({
            Pr = (1 / 0),
            Ow = p48,
            Cb = v51,
            Wt = {}
        }, table_freeze_ret2);
        table.insert(p48.Cs, v52);
        u50 = v52;
        table.insert(u50.Wt, coroutine_running_ret);
        local table_pack_ret = table.pack(coroutine.yield());

        if u49 then
            error("Disconnected");
        end;

        return table.unpack(table_pack_ret);
    end,

    Once = function(p53: any, u54: function, p55: number?) -- Line: 337, Name: Bindable_Once
        -- upvalues: Connection_Disconnect (copy), table_freeze_ret2 (copy), FindRight (copy)
        local u56 = nil;

        local function v57(...) -- Line: 343
            -- upvalues: Connection_Disconnect (ref), u56 (ref), u54 (copy)
            Connection_Disconnect(u56);

            return u54(...);
        end;

        local v58;

        if p55 == nil then
            v58 = true;
        elseif type(p55) == "number" then
            v58 = p55 == p55;
        else
            v58 = false;
        end;

        assert(v58);
        local v59 = p55 or (1 / 0);
        local v60 = setmetatable({
            Ow = p53,
            Cb = v57,
            Pr = v59,
            Wt = {}
        }, table_freeze_ret2);

        if v59 == (1 / 0) then
            table.insert(p53.Cs, v60);
        else
            local Cs = p53.Cs;
            local v61 = FindRight(Cs, v60);
            local math_abs_ret = math.abs(v61);
            table.insert(Cs, math_abs_ret, v60);
        end;

        u56 = v60;

        return u56;
    end,

    DisconnectAll = function(p62) -- Line: 350, Name: Bindable_DisconnectAll
        -- upvalues: Connection_Disconnect (copy)
        local Cs = p62.Cs;

        for i = #Cs, 1, -1 do
            Connection_Disconnect(Cs[i]);
            local _ = i;
        end;
    end,

    GetSize = function(p63) -- Line: 357, Name: Bindable_GetSize
        return #p63.Cs;
    end,

    IsEmpty = function(p64) -- Line: 361, Name: Bindable_IsEmpty
        return #p64.Cs == 0;
    end
});
local table_freeze_ret4 = table.freeze({
    __index = table_freeze_ret3
});

return table.freeze({
    new = function(p65: function?) -- Line: 379, Name: new
        -- upvalues: table_freeze_ret4 (copy)
        return table.freeze((setmetatable({
            Cs = {}
        }, table_freeze_ret4)));
    end,

    IsA = function(p66) -- Line: 386, Name: IsA
        -- upvalues: table_freeze_ret4 (copy)
        local v67;

        if type(p66) == "table" then
            v67 = getmetatable(p66) == table_freeze_ret4;
        else
            v67 = false;
        end;

        return v67;
    end,

    Assert = function(p68) -- Line: 390, Name: Assert
        -- upvalues: table_freeze_ret4 (copy)
        local v69;

        if type(p68) == "table" then
            v69 = getmetatable(p68) == table_freeze_ret4;
        else
            v69 = false;
        end;

        if not v69 then
            error("Bindable", 2);
        end;

        return p68;
    end,

    IsAConnection = function(p70) -- Line: 222, Name: Connection_IsA
        -- upvalues: table_freeze_ret2 (copy)
        local v71;

        if type(p70) == "table" then
            v71 = getmetatable(p70) == table_freeze_ret2;
        else
            v71 = false;
        end;

        return v71;
    end,

    AssertConnection = function(p72) -- Line: 226, Name: Connection_Assert
        -- upvalues: table_freeze_ret2 (copy)
        local v73;

        if type(p72) == "table" then
            v73 = getmetatable(p72) == table_freeze_ret2;
        else
            v73 = false;
        end;

        if not v73 then
            error("Connection", 2);
        end;

        return p72;
    end
});