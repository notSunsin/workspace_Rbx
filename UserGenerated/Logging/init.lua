-- Decompiled with Potassium's decompiler.

local RunService = game:GetService("RunService");
local Keys = require(game.ReplicatedStorage.UserGenerated.Lang.Keys);
local Asserts = require(game.ReplicatedStorage.UserGenerated.Lang.Asserts);
local Stringify = require(game.ReplicatedStorage.UserGenerated.Strings.Stringify);
local u1 = {
    Pretty = true,
    IndentChar = " ",
    IndentSize = 2
};

local function GetPrefix(p2: number?) -- Line: 39
    local debug_info_ret, v3, v4 = debug.info((p2 or 0) + 2, "sln");
    local v5 = `{debug_info_ret}:{v3}`;

    if v4 then
        v5 = v5 .. ` {v4}`;
    end;

    return `[{v5}]`;
end;

local function Format(p6) -- Line: 49
    -- upvalues: Stringify (copy), u1 (copy)
    if type(p6) == "string" then
        return p6;
    end;

    if typeof(p6) == "Instance" then
        return `{p6.ClassName}[{p6:GetFullName()}]`;
    end;

    return Stringify.Serialize(p6, u1);
end;

local function FormatArgs(...) -- Line: 59
    -- upvalues: Stringify (copy), u1 (copy)
    local table_pack_ret = table.pack(...);

    for i = 1, table_pack_ret.n do
        local v7 = table_pack_ret[i];

        if type(v7) ~= "string" then
            if typeof(v7) == "Instance" then
                v7 = `{v7.ClassName}[{v7:GetFullName()}]`;
            else
                v7 = Stringify.Serialize(v7, u1);
            end;
        end;

        table_pack_ret[i] = v7;
        local _ = i;
    end;

    return table.unpack(table_pack_ret);
end;

local v8, v9;

if RunService:IsStudio() then
    v8 = print;
    v9 = warn;
else
    v8 = function(...) -- Line: 67
        -- upvalues: FormatArgs (copy)
        local task_spawn = task.spawn;

        local function v11(p10, ...) -- Line: 68
            -- upvalues: FormatArgs (ref)
            print(p10, FormatArgs(...));
        end;

        local debug_info_ret, v12, v13 = debug.info(2, "sln");
        local v14 = `{debug_info_ret}:{v12}`;

        if v13 then
            v14 = v14 .. ` {v13}`;
        end;

        task_spawn(v11, `[{v14}]`, ...);
    end;

    v9 = function(...) -- Line: 72
        -- upvalues: FormatArgs (copy)
        local task_spawn = task.spawn;

        local function v16(p15, ...) -- Line: 73
            -- upvalues: FormatArgs (ref)
            warn(p15, FormatArgs(...));
        end;

        local debug_info_ret, v17, v18 = debug.info(2, "sln");
        local v19 = `{debug_info_ret}:{v17}`;

        if v18 then
            v19 = v19 .. ` {v18}`;
        end;

        task_spawn(v16, `[{v19}]`, ...);
    end;
end;

local function u20() -- Line: 85
end;

local u21 = {
    Trace = 1,
    Debug = 2,
    Info = 3,
    Warn = 4,
    Error = 5,
    Critical = 6,
    Off = 7
};
table.freeze(u21);
local u22 = {
    Trace = v8,
    Debug = v8,
    Info = v8,
    Warn = v9,
    Error = v9,
    Critical = v9,
    Off = u20
};
table.freeze(u22);
local v23 = Asserts.Set(Keys(u21));
local table_clone_ret = table.clone(u22);
local u24 = "Info";

local function SetLevel(p25: string, p26: boolean?) -- Line: 113
    -- upvalues: u21 (copy), u24 (ref), table_clone_ret (copy), u22 (copy), u20 (copy)
    assert(u21[p25]);
    local v27 = p26 == nil and true or type(p26) == "boolean";
    assert(v27);

    if u24 == p25 and not p26 then
        return;
    end;

    u24 = p25;
    local v28 = assert(u21[p25]);

    for i, v in pairs(u21) do
        if v28 <= v then
            table_clone_ret[i] = u22[i];
        else
            table_clone_ret[i] = u20;
        end;
    end;
end;

SetLevel(u24, true);
local v29 = {
    Levels = u21,
    AssertLevel = v23
};
setmetatable(v29, {
    __index = table_clone_ret
});

function v29.GetLevel() -- Line: 138
    -- upvalues: u24 (ref)
    return u24;
end;

function v29.SetLevel(p30: string) -- Line: 142
    -- upvalues: SetLevel (copy)
    SetLevel(p30);
end;

function v29.Sink(p31: string) -- Line: 146
    -- upvalues: table_clone_ret (copy)
    return assert(table_clone_ret[p31]);
end;

return table.freeze(v29);