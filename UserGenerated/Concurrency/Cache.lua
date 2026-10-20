-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Bindable = require(ReplicatedStorage.UserGenerated.Concurrency.Bindable);
local DeepFreeze = require(game.ReplicatedStorage.UserGenerated.Collections.DeepFreeze);
local Lock = require(game.ReplicatedStorage.UserGenerated.Concurrency.Lock);
local Asserts = require(game.ReplicatedStorage.UserGenerated.Lang.Asserts);

local function ValueAge(p1: table, p2: number) -- Line: 38
    local RetrievedAt = p1.RetrievedAt;

    if RetrievedAt then
        return p2 - RetrievedAt;
    end;

    return nil;
end;

local function AttemptAge(p3: table, p4: number) -- Line: 43
    local AttemptedAt = p3.AttemptedAt;

    return not AttemptedAt and (1 / 0) or p4 - AttemptedAt;
end;

local v17 = {
    RemoveUsedAt = function(p5: table, p6: table) -- Line: 83, Name: RemoveUsedAt
    end,

    InsertUsedAt = function(p7: table, p8: table) -- Line: 87, Name: InsertUsedAt
    end,

    SetUsedAt = function(p9: table, p10: table, p11: number) -- Line: 91, Name: SetUsedAt
        p9:RemoveUsedAt(p10);
        p10.UsedAt = p11;
        p9:InsertUsedAt(p10);
    end,

    Get = function(p12, p13) -- Line: 100, Name: Get
        local v14 = p12.AssertKey(p13);
        local v15 = p12.Cache[v14];

        if not v15 then
            return nil;
        end;

        local os_clock_ret = os.clock();
        local RetrievedAt = v15.RetrievedAt;
        local v16;

        if RetrievedAt then
            v16 = os_clock_ret - RetrievedAt;
        else
            v16 = nil;
        end;

        if not (v16 and (p12.MaxAge > v16 or p12.ReturnStale)) then
            return nil;
        end;

        p12:SetUsedAt(v15, os_clock_ret);

        return v15.Value;
    end
};

function AsyncCallback(p18: any, p19: table, p20: any, p21: number)
    -- upvalues: DeepFreeze (copy)
    local RetrievedAt = p19.RetrievedAt;
    local v22;

    if RetrievedAt then
        v22 = p21 - RetrievedAt;
    else
        v22 = nil;
    end;

    if v22 and v22 < p18.MaxAge then
        return p19.Value;
    end;

    local AttemptedAt = p19.AttemptedAt;

    if (not AttemptedAt and (1 / 0) or p21 - AttemptedAt) < p18.FailureRetryDelay then
        if p18.ReturnStale then
            return p19.Value;
        end;

        return nil;
    end;

    p19.AttemptedAt = p21;
    local success, result = pcall(p18.Callback, p20);
    local os_clock_ret = os.clock();
    p19.AttemptedAt = os_clock_ret;
    p18:SetUsedAt(p19, os_clock_ret);

    if not success then
        if p18.ReturnStale then
            return p19.Value;
        end;

        return nil;
    end;

    if p18.Freeze then
        result = DeepFreeze(result);
    end;

    p19.Value = result;
    p19.RetrievedAt = os_clock_ret;
    p18.Updated:Fire(p20);

    return result;
end;

function v17.GetAsync(p23, p24) -- Line: 142
    -- upvalues: Lock (copy)
    local os_clock_ret = os.clock();
    local v25 = p23.AssertKey(p24);
    local v26 = p23.Cache[v25];

    if v26 then
        p23:SetUsedAt(v26, os_clock_ret);
    else
        v26 = {
            Lock = Lock.new(),
            UsedAt = os_clock_ret
        };
        p23.Cache[v25] = v26;
        p23:InsertUsedAt(v26);
    end;

    return v26.Lock:Call(AsyncCallback, p23, v26, p24, os_clock_ret);
end;

function v17.Delete(p27, p28) -- Line: 160
    local v29 = p27.AssertKey(p28);

    if p27.Cache[v29] then
        p27.Cache[v29] = nil;
        p27.Deleted:Fire(p28);
    end;
end;

local table_freeze_ret = table.freeze({
    __index = table.freeze(v17)
});
local u30 = Asserts.Table({
    Callback = Asserts.Function,
    AssertKey = Asserts.Function,
    MaxAge = Asserts.Optional(Asserts.NonNegative),
    FailureRetryDelay = Asserts.Optional(Asserts.NonNegative),
    ReturnStale = Asserts.Optional(Asserts.Boolean),
    Freeze = Asserts.Optional(Asserts.Boolean)
});

return table.freeze({
    new = function(p31: table) -- Line: 196, Name: new
        -- upvalues: u30 (copy), Bindable (copy), table_freeze_ret (copy)
        u30(p31);
        local v32 = {
            Updated = Bindable.new(),
            Deleted = Bindable.new(),
            Callback = p31.Callback,
            AssertKey = p31.AssertKey,
            MaxAge = p31.MaxAge or (1 / 0),
            FailureRetryDelay = p31.FailureRetryDelay or 300,
            ReturnStale = p31.ReturnStale == nil and true or p31.ReturnStale,
            Freeze = p31.Freeze == nil and true or p31.Freeze,
            Cache = {}
        };
        local v33 = setmetatable(v32, table_freeze_ret);
        table.freeze(v33);

        return v33;
    end
});