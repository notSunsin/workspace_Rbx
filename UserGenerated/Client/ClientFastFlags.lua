-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
game:GetService("Players");
assert(RunService:IsClient());
local Bindable = require(ReplicatedStorage.UserGenerated.Concurrency.Bindable);
local SharedFastFlags = require(ReplicatedStorage.UserGenerated.FastFlags.SharedFastFlags);
local Asserts = require(ReplicatedStorage.UserGenerated.Lang.Asserts);
local DeepEqualsPureUnsafe = require(ReplicatedStorage.UserGenerated.Collections.DeepEqualsPureUnsafe);
local DeepCopyPureUnsafe = require(ReplicatedStorage.UserGenerated.Collections.DeepCopyPureUnsafe);
local DeepFreezeUnsafe = require(ReplicatedStorage.UserGenerated.Collections.DeepFreezeUnsafe);
local ObjectPaths = require(ReplicatedStorage.UserGenerated.Strings.ObjectPaths);
local v1 = {};
local table_freeze_ret = table.freeze({
    __index = v1
});

function v1.Get(p2) -- Line: 45
    return p2.Value;
end;

function v1.GetAsync(p3) -- Line: 48
    if p3.ValueLoaded then
        return p3.Value;
    end;

    local coroutine_running_ret = coroutine.running();
    local v4 = p3.Loaded:Connect(function() -- Line: 53
        -- upvalues: coroutine_running_ret (copy)
        task.spawn(coroutine_running_ret);
    end);
    coroutine.yield();
    v4:Disconnect();

    return p3.Value;
end;

function v1.IsLoaded(p5) -- Line: 60
    return p5.ValueLoaded;
end;

table.freeze(v1);
local NullValue = SharedFastFlags.NullValue;
local UpdateRemote = SharedFastFlags.UpdateRemote;
local u6 = {};
local u7 = false;
local u8 = {};
local u9 = Bindable.new();

local function DecodeValue(p10) -- Line: 86
    -- upvalues: NullValue (copy)
    if p10 == NullValue then
        return nil;
    end;

    return p10;
end;

local function Create(p11: string, p12: function, p13: any) -- Line: 141
    -- upvalues: Asserts (copy), DeepCopyPureUnsafe (copy), DeepFreezeUnsafe (copy), u6 (copy), ObjectPaths (copy), u8 (ref), NullValue (copy), u7 (ref), Bindable (copy), table_freeze_ret (copy)
    Asserts.String(p11);
    Asserts.Function(p12);
    p12(p13);
    Asserts.Optional(Asserts.Storable)(p13);
    local v14 = DeepCopyPureUnsafe(p13);
    DeepFreezeUnsafe(v14);
    local v15 = not u6[p11];
    local v16 = `ConflictingKeys: {p11}, {p11}`;
    assert(v15, v16);

    for i, _ in pairs(u6) do
        if ObjectPaths.HasHierarchicalOverlap(p11, i) then
            error((`ConflictingKeys: {p11}, {i}`));
        end;
    end;

    local v17 = u8[p11];
    local v18;

    if v17 == nil then
        v17 = v14;
        v18 = false;
    else
        if v17 == NullValue then
            v17 = nil;
        end;

        v18 = u7;
    end;

    local v19 = {
        Replicated = true,
        Changed = Bindable.new(),
        Loaded = Bindable.new(),
        Key = p11,
        DefaultValue = v14,
        Assertion = p12,
        ValueLoaded = v18,
        Value = v17
    };
    local v20 = setmetatable(v19, table_freeze_ret);
    u6[p11] = v20;

    return v20;
end;

local v33 = {
    Loaded = u9,

    IsA = function(p21) -- Line: 64, Name: IsA
        -- upvalues: table_freeze_ret (copy)
        local v22;

        if type(p21) == "table" then
            v22 = getmetatable(p21) == table_freeze_ret;
        else
            v22 = false;
        end;

        return v22;
    end,

    Assert = function(p23) -- Line: 68, Name: Assert
        -- upvalues: table_freeze_ret (copy)
        local v24;

        if type(p23) == "table" then
            v24 = getmetatable(p23) == table_freeze_ret;
        else
            v24 = false;
        end;

        if not v24 then
            error("FastFlag", 2);
        end;

        return p23;
    end,

    Replicated = function(p25: string, p26: function, p27: any) -- Line: 193, Name: Replicated
        -- upvalues: Create (copy)
        return Create(p25, p26, p27);
    end,

    Private = function(p28: string, p29: function, p30: any) -- Line: 197, Name: Private
        error("ServerOnly");
    end,

    Get = function(p31: string) -- Line: 201, Name: Get
        -- upvalues: u6 (copy), Asserts (copy)
        local v32 = u6[p31];

        if v32 then
            return v32;
        end;

        Asserts.String(p31);
        error((`UnknownKey: '{p31}'`));
    end,

    IsLoaded = function() -- Line: 210, Name: IsLoaded
        -- upvalues: u7 (ref)
        return u7;
    end
};
UpdateRemote.OnClientEvent:Connect(function(p34: table, p35: boolean) -- Line: 90, Name: SetContent
    -- upvalues: u8 (ref), DeepFreezeUnsafe (copy), u6 (copy), NullValue (copy), DeepEqualsPureUnsafe (copy), u7 (ref), u9 (copy)
    local table_clone_ret = table.clone(u8);

    for i, v in pairs(p34) do
        table_clone_ret[i] = v;
    end;

    DeepFreezeUnsafe(table_clone_ret);
    u8 = table_clone_ret;
    local v36 = {};
    local v37 = {};

    for i, v in pairs(p34) do
        local v38 = u6[i];

        if v38 then
            local v39;

            if v == NullValue then
                v39 = nil;
            else
                v39 = v;
            end;

            local Value = v38.Value;

            if not DeepEqualsPureUnsafe(v39, Value) then
                v38.Value = v39;
                table.insert(v36, {
                    instance = v38,
                    value = v39,
                    prevValue = Value
                });
            end;

            if p35 and not v38.ValueLoaded then
                v38.ValueLoaded = true;
                table.insert(v37, v38);
            end;
        end;
    end;

    if p35 then
        p35 = not u7;
    end;

    if p35 then
        u7 = true;
    end;

    for _, v in ipairs(v37) do
        v.Loaded:Fire();
    end;

    if p35 then
        u9:Fire();
    end;

    for _, v in ipairs(v36) do
        v.instance.Changed:Fire(v.value, v.prevValue);
    end;
end);
table.freeze(v33);

return v33;