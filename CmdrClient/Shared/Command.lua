-- Decompiled with Potassium's decompiler.

local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local Argument = require(script.Parent.Argument);
local u1 = RunService:IsServer();
local u2 = {};
u2.__index = u2;

function u2.new(p3) -- Line: 12
    -- upvalues: u2 (copy)
    local v4 = {
        Response = nil,
        Dispatcher = p3.Dispatcher,
        Cmdr = p3.Dispatcher.Cmdr,
        Name = p3.CommandObject.Name,
        RawText = p3.Text,
        Object = p3.CommandObject,
        Group = p3.CommandObject.Group,
        State = {},
        Aliases = p3.CommandObject.Aliases,
        Alias = p3.Alias,
        Description = p3.CommandObject.Description,
        Executor = p3.Executor,
        ArgumentDefinitions = p3.CommandObject.Args,
        RawArguments = p3.Arguments,
        Arguments = {},
        Data = p3.Data
    };
    setmetatable(v4, u2);

    return v4;
end;

function u2.Parse(p5, p6) -- Line: 40
    -- upvalues: Argument (copy)
    local v7 = false;

    for i, v in ipairs(p5.ArgumentDefinitions) do
        local v8;

        if type(v) == "function" then
            v8 = v(p5);

            if v8 == nil then
                break;
            end;
        else
            v8 = v;
        end;

        local v9;

        if v8.Default == nil then
            v9 = v8.Optional ~= true;
        else
            v9 = false;
        end;

        if v9 and v7 then
            error(("Command %q: Required arguments cannot occur after optional arguments."):format(p5.Name));
        else
            v7 = not v9 and true or v7;
        end;

        if p5.RawArguments[i] == nil and (v9 and p6 ~= true) then
            return false, ("Required argument #%d %s is missing."):format(i, v8.Name);
        end;

        if p5.RawArguments[i] or p6 then
            p5.Arguments[i] = Argument.new(p5, v8, p5.RawArguments[i] or "");
        end;
    end;

    return true;
end;

function u2.Validate(p10, p11) -- Line: 72
    p10._Validated = true;
    local v12 = "";
    local v13 = true;

    for i, v in pairs(p10.Arguments) do
        local v14, v15 = v:Validate(p11);

        if not v14 then
            v12 = ("%s; #%d %s: %s"):format(v12, i, v.Name, v15 or "error");
            v13 = false;
        end;
    end;

    return v13, v12:sub(3);
end;

function u2.GetLastArgument(p16) -- Line: 91
    for i = #p16.Arguments, 1, -1 do
        if p16.Arguments[i].RawValue then
            return p16.Arguments[i];
        end;

        local _ = i;
    end;
end;

function u2.GatherArgumentValues(p17) -- Line: 100
    local v18 = {};

    for i = 1, #p17.ArgumentDefinitions do
        local v19 = p17.Arguments[i];
        local v20;

        if v19 then
            v18[i] = v19:GetValue();
            v20 = i;
        elseif type(p17.ArgumentDefinitions[i]) == "table" then
            v18[i] = p17.ArgumentDefinitions[i].Default;
            v20 = i;
        else
            v20 = i;
        end;
    end;

    return v18, #p17.ArgumentDefinitions;
end;

function u2.Run(p21) -- Line: 117
    -- upvalues: u1 (copy)
    if p21._Validated == nil then
        error("Must validate a command before running.");
    end;

    local v22 = p21.Dispatcher:RunHooks("BeforeRun", p21);

    if v22 then
        return v22;
    end;

    if not (u1 or (not p21.Object.Data or p21.Data ~= nil)) then
        local v23, v24 = p21:GatherArgumentValues();
        p21.Data = p21.Object.Data(p21, unpack(v23, 1, v24));
    end;

    if not u1 and p21.Object.ClientRun then
        local v25, v26 = p21:GatherArgumentValues();
        p21.Response = p21.Object.ClientRun(p21, unpack(v25, 1, v26));
    end;

    if p21.Response == nil then
        if p21.Object.Run then
            local v27, v28 = p21:GatherArgumentValues();
            p21.Response = p21.Object.Run(p21, unpack(v27, 1, v28));
        elseif u1 then
            if p21.Object.ClientRun then
                warn(p21.Name, "command fell back to the server because ClientRun returned nil, but there is no server implementation! Either return a string from ClientRun, or create a server implementation for this command.");
            else
                warn(p21.Name, "command has no implementation!");
            end;

            p21.Response = "No implementation.";
        else
            p21.Response = p21.Dispatcher:Send(p21.RawText, p21.Data);
        end;
    end;

    return p21.Dispatcher:RunHooks("AfterRun", p21) or p21.Response;
end;

function u2.GetArgument(p29, p30) -- Line: 164
    return p29.Arguments[p30];
end;

function u2.GetData(p31) -- Line: 172
    -- upvalues: u1 (copy)
    if p31.Data then
        return p31.Data;
    end;

    if p31.Object.Data and not u1 then
        p31.Data = p31.Object.Data(p31);
    end;

    return p31.Data;
end;

function u2.SendEvent(p32, p33, p34, ...) -- Line: 185
    -- upvalues: u1 (copy), Players (copy)
    local v35 = typeof(p33) == "Instance";
    assert(v35, "Argument #1 must be a Player");
    local v36 = p33:IsA("Player");
    assert(v36, "Argument #1 must be a Player");
    local v37 = type(p34) == "string";
    assert(v37, "Argument #2 must be a string");

    if u1 then
        p32.Dispatcher.Cmdr.RemoteEvent:FireClient(p33, p34, ...);

        return;
    end;

    if p32.Dispatcher.Cmdr.Events[p34] then
        assert(p33 == Players.LocalPlayer, "Event messages can only be sent to the local player on the client.");
        p32.Dispatcher.Cmdr.Events[p34](...);
    end;
end;

function u2.BroadcastEvent(p38, ...) -- Line: 199
    -- upvalues: u1 (copy)
    if not u1 then
        error("Can\'t broadcast event messages from the client.", 2);
    end;

    p38.Dispatcher.Cmdr.RemoteEvent:FireAllClients(...);
end;

function u2.Reply(p39, ...) -- Line: 208
    return p39:SendEvent(p39.Executor, "AddLine", ...);
end;

function u2.GetStore(p40, ...) -- Line: 213
    return p40.Dispatcher.Cmdr.Registry:GetStore(...);
end;

function u2.HasImplementation(p41) -- Line: 218
    -- upvalues: RunService (copy)
    return (RunService:IsClient() and p41.Object.ClientRun or p41.Object.Run) and true or false;
end;

return u2;