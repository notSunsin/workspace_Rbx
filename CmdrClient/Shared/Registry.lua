-- Decompiled with Potassium's decompiler.

local RunService = game:GetService("RunService");
local Util = require(script.Parent.Util);
local u14 = {
    Cmdr = nil,
    TypeMethods = Util.MakeDictionary({ "Transform", "Validate", "Autocomplete", "Parse", "DisplayName", "Listable", "ValidateOnce", "Prefixes", "Default", "ArgumentOperatorAliases" }),
    CommandMethods = Util.MakeDictionary({ "Name", "Aliases", "AutoExec", "Description", "Args", "Run", "ClientRun", "Data", "Group" }),
    CommandArgProps = Util.MakeDictionary({ "Name", "Type", "Description", "Optional", "Default" }),
    Types = {},
    TypeAliases = {},
    Commands = {},
    CommandsArray = {},
    Hooks = {
        BeforeRun = {},
        AfterRun = {}
    },
    Stores = setmetatable({}, {
        __index = function(p1, p2) -- Line: 20, Name: __index
            p1[p2] = {};

            return p1[p2];
        end
    }),
    AutoExecBuffer = {},

    RegisterType = function(p3, p4, p5) -- Line: 30, Name: RegisterType
        if not p4 or typeof(p4) ~= "string" then
            error("Invalid type name provided: nil");
        end;

        if not p4:find("^[%d%l]%w*$") then
            error(("Invalid type name provided: \"%s\", type names must be alphanumeric and start with a lower-case letter or a digit."):format(p4));
        end;

        for i in pairs(p5) do
            if p3.TypeMethods[i] == nil then
                error("Unknown key/method in type \"" .. p4 .. "\": " .. i);
            end;
        end;

        if p3.Types[p4] ~= nil then
            error(("Type \"%s\" has already been registered."):format(p4));
        end;

        p5.Name = p4;
        p5.DisplayName = p5.DisplayName or p4;
        p3.Types[p4] = p5;

        if p5.Prefixes then
            p3:RegisterTypePrefix(p4, p5.Prefixes);
        end;
    end,

    RegisterTypePrefix = function(p6, p7, p8) -- Line: 59, Name: RegisterTypePrefix
        if not p6.TypeAliases[p7] then
            p6.TypeAliases[p7] = p7;
        end;

        p6.TypeAliases[p7] = ("%s %s"):format(p6.TypeAliases[p7], p8);
    end,

    RegisterTypeAlias = function(p9, p10, p11) -- Line: 67, Name: RegisterTypeAlias
        assert(p9.TypeAliases[p10] == nil, ("Type alias %s already exists!"):format(p11));
        p9.TypeAliases[p10] = p11;
    end,

    RegisterTypesIn = function(u12, p13) -- Line: 73, Name: RegisterTypesIn
        for _, child in pairs(p13:GetChildren()) do
            if child:IsA("ModuleScript") then
                child.Parent = u12.Cmdr.ReplicatedRoot.Types;
                local success, result = pcall(function() -- Line: 79
                    -- upvalues: child (copy), u12 (copy)
                    require(child)(u12);
                end);

                if not success then
                    warn("Error registering type from " .. child.Name .. ":\n" .. result);
                end;
            else
                u12:RegisterTypesIn(child);
            end;
        end;
    end
};
u14.RegisterHooksIn = u14.RegisterTypesIn;

function u14.RegisterCommandObject(p15, p16, p17) -- Line: 102
    -- upvalues: RunService (copy)
    for i in pairs(p16) do
        if p15.CommandMethods[i] == nil then
            error("Unknown key/method in command " .. (p16.Name or "unknown command") .. ": " .. i);
        end;
    end;

    if p16.Args then
        for i, v in pairs(p16.Args) do
            if type(v) == "table" then
                local v18 = i;

                for i2 in pairs(v) do
                    if p15.CommandArgProps[i2] == nil then
                        error(("Unknown property in command \"%s\" argument #%d: %s"):format(p16.Name or "unknown", v18, i2));
                    end;
                end;
            end;
        end;
    end;

    if p16.AutoExec and RunService:IsClient() then
        table.insert(p15.AutoExecBuffer, p16.AutoExec);
        p15:FlushAutoExecBufferDeferred();
    end;

    local v19 = p15.Commands[p16.Name:lower()];

    if v19 and v19.Aliases then
        for _, v in pairs(v19.Aliases) do
            p15.Commands[v:lower()] = nil;
        end;
    elseif not v19 then
        table.insert(p15.CommandsArray, p16);
    end;

    p15.Commands[p16.Name:lower()] = p16;

    if p16.Aliases then
        for _, v in pairs(p16.Aliases) do
            p15.Commands[v:lower()] = p16;
        end;
    end;
end;

function u14.RegisterCommand(p20, u21, u22, p23) -- Line: 147
    -- upvalues: RunService (copy)
    local success, result = pcall(function() -- Line: 150
        -- upvalues: u21 (copy)
        return require(u21);
    end);

    if not success then
        task.delay(5, function() -- Line: 155
            -- upvalues: u21 (copy)
            warn((`Error while requiring command script "{u21.Name}" (ModuleScript expected, got {typeof(u21)})`));
        end);

        return result;
    end;

    local v24 = typeof(result) == "table";
    local v25 = `Invalid return value from command script "{u21.Name}" (CommandDefinition expected, got {typeof(result)})`;
    assert(v24, v25);

    if u22 then
        local v26 = RunService:IsServer();
        assert(v26, "The commandServerScript parameter is not valid for client usage.");
        local success2, result2 = pcall(function() -- Line: 171
            -- upvalues: u22 (copy)
            return require(u22);
        end);

        if not success2 then
            task.delay(5, function() -- Line: 176
                -- upvalues: u21 (copy), result2 (copy)
                warn((`Error while requiring command script "{u21.Name}" (CommandServerDefinition expected, got {result2})`));
            end);
        end;

        if success2 then
            result.Run = result2;
        else
            function result.Run() -- Line: 185
                return "This Command is broken, please fix server implementation";
            end;
        end;
    end;

    if p23 and not p23(result) then
        return;
    end;

    p20:RegisterCommandObject(result);
    u21.Parent = p20.Cmdr.ReplicatedRoot.Commands;
end;

function u14.RegisterCommandsIn(p27: table, p28: userdata, p29: any) -- Line: 201
    local v30 = {};
    local v31 = {};

    for _, descendant in p28:GetDescendants() do
        if not descendant:IsA("Folder") then
            if descendant:IsA("ModuleScript") then
                if descendant.Name:find("Server") then
                    v30[descendant] = true;
                else
                    local v32 = p28:FindFirstChild(descendant.Name .. "Server", true);

                    if v32 then
                        v31[v32] = true;
                    end;

                    local task_delay_ret = task.delay(5, function() -- Line: 221
                        -- upvalues: descendant (copy)
                        warn(("Command script \'%s\' is taking longer than %d seconds to load."):format(descendant.Name, 5));
                    end);
                    p27:RegisterCommand(descendant, v32, p29);
                    task.cancel(task_delay_ret);
                end;
            else
                p27:RegisterCommandsIn(descendant, p29);
            end;
        end;
    end;

    for i in v30 do
        if not v31[i] then
            warn("Command script " .. i.Name .. " was skipped because it has \'Server\' in its name, and has no equivalent shared script.");
        end;
    end;
end;

function u14.RegisterDefaultCommands(p33, u34) -- Line: 244
    -- upvalues: RunService (copy), Util (copy)
    local v35 = RunService:IsServer();
    assert(v35, "RegisterDefaultCommands cannot be called from the client.");
    local v36 = type(u34) == "table";

    if v36 then
        u34 = Util.MakeDictionary(u34);
    end;

    p33:RegisterCommandsIn(p33.Cmdr.DefaultCommandsFolder, v36 and function(p37) -- Line: 253
        -- upvalues: u34 (ref)
        return u34[p37.Group] or false;
    end or u34);
end;

function u14.GetCommand(p38, p39) -- Line: 259
    return p38.Commands[(p39 or ""):lower()];
end;

function u14.GetCommands(p40) -- Line: 265
    return p40.CommandsArray;
end;

function u14.GetCommandNames(p41) -- Line: 270
    local v42 = {};

    for _, v in pairs(p41.CommandsArray) do
        table.insert(v42, v.Name);
    end;

    return v42;
end;

u14.GetCommandsAsStrings = u14.GetCommandNames;

function u14.GetTypeNames(p43) -- Line: 283
    local v44 = {};

    for i in pairs(p43.Types) do
        table.insert(v44, i);
    end;

    return v44;
end;

function u14.GetType(p45, p46) -- Line: 295
    return p45.Types[p46];
end;

function u14.GetTypeName(p47, p48) -- Line: 300
    return p47.TypeAliases[p48] or p48;
end;

function u14.RegisterHook(p49, p50, p51, p52) -- Line: 305
    if not p49.Hooks[p50] then
        error(("Invalid hook name: %q"):format(p50), 2);
    end;

    table.insert(p49.Hooks[p50], {
        callback = p51,
        priority = p52 or 0
    });
    table.sort(p49.Hooks[p50], function(p53, p54) -- Line: 311
        return p53.priority < p54.priority;
    end);
end;

u14.AddHook = u14.RegisterHook;

function u14.GetStore(p55, p56) -- Line: 319
    return p55.Stores[p56];
end;

function u14.FlushAutoExecBufferDeferred(u57) -- Line: 324
    -- upvalues: RunService (copy)
    if u57.AutoExecFlushConnection then
        return;
    end;

    u57.AutoExecFlushConnection = RunService.Heartbeat:Connect(function() -- Line: 329
        -- upvalues: u57 (copy)
        u57.AutoExecFlushConnection:Disconnect();
        u57.AutoExecFlushConnection = nil;
        u57:FlushAutoExecBuffer();
    end);
end;

function u14.FlushAutoExecBuffer(p58) -- Line: 337
    for _, v in ipairs(p58.AutoExecBuffer) do
        for _, v2 in ipairs(v) do
            p58.Cmdr.Dispatcher:EvaluateAndRun(v2);
        end;
    end;

    p58.AutoExecBuffer = {};
end;

return function(p59) -- Line: 347
    -- upvalues: u14 (copy)
    u14.Cmdr = p59;

    return u14;
end;