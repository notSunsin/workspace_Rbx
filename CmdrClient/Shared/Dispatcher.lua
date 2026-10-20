-- Decompiled with Potassium's decompiler.

local RunService = game:GetService("RunService");
local TeleportService = game:GetService("TeleportService");
local Players = game:GetService("Players");
local Util = require(script.Parent.Util);
local Command = require(script.Parent.Command);
local u1 = false;
local u44 = {
    Cmdr = nil,
    Registry = nil,

    Evaluate = function(p2, p3, p4, p5, p6) -- Line: 21, Name: Evaluate
        -- upvalues: RunService (copy), Players (copy), Util (copy), Command (copy)
        if RunService:IsClient() == true and p4 ~= Players.LocalPlayer then
            error("Can\'t evaluate a command that isn\'t sent by the local player.");
        end;

        local v7 = Util.SplitString(p3);
        local table_remove_ret = table.remove(v7, 1);
        local Command2 = p2.Registry:GetCommand(table_remove_ret);

        if not Command2 then
            return false, ("%q is not a valid command name. Use the help command to see all available commands."):format((tostring(table_remove_ret)));
        end;

        local v8 = Util.MashExcessArguments(v7, #Command2.Args);
        local v9 = Command.new({
            Dispatcher = p2,
            Text = p3,
            CommandObject = Command2,
            Alias = table_remove_ret,
            Executor = p4,
            Arguments = v8,
            Data = p6
        });
        local v10, v11 = v9:Parse(p5);

        if v10 then
            return v9;
        end;

        return false, v11;
    end,

    EvaluateAndRun = function(p12, p13, p14, p15) -- Line: 58, Name: EvaluateAndRun
        -- upvalues: Players (copy), RunService (copy)
        local v16 = p14 or Players.LocalPlayer;
        local v17 = p15 or {};

        if RunService:IsClient() and v17.IsHuman then
            p12:PushHistory(p13);
        end;

        local u18, v19 = p12:Evaluate(p13, v16, nil, v17.Data);

        if not u18 then
            return v19;
        end;

        local v23, v24 = xpcall(function() -- Line: 72
            -- upvalues: u18 (copy)
            local v20, v21 = u18:Validate(true);

            return v20 and (u18:Run() or "Command executed.") or v21;
        end, function(p22) -- Line: 80
            return debug.traceback((tostring(p22)));
        end);

        if not v23 then
            warn(("Error occurred while evaluating command string %q\n%s"):format(p13, (tostring(v24))));
        end;

        return v23 and v24 and v24 or "An error occurred while running this command. Check the console for more information.";
    end,

    Send = function(p25, p26, p27) -- Line: 92, Name: Send
        -- upvalues: RunService (copy)
        if RunService:IsClient() == false then
            error("Dispatcher:Send can only be called from the client.");
        end;

        return p25.Cmdr.RemoteFunction:InvokeServer(p26, {
            Data = p27
        });
    end,

    Run = function(p28, ...) -- Line: 104, Name: Run
        -- upvalues: Players (copy)
        if not Players.LocalPlayer then
            error("Dispatcher:Run can only be called from the client.");
        end;

        local v29 = { ... };
        local v30 = v29[1];

        for i = 2, #v29 do
            v30 = v30 .. " " .. tostring(v29[i]);
            local _ = i;
        end;

        local v31, v32 = p28:Evaluate(v30, Players.LocalPlayer);

        if not v31 then
            error(v32);
        end;

        local v33, v34 = v31:Validate(true);

        if not v33 then
            error(v34);
        end;

        return v31:Run();
    end,

    RunHooks = function(p35, p36, p37, ...) -- Line: 132, Name: RunHooks
        -- upvalues: RunService (copy), u1 (ref)
        if not p35.Registry.Hooks[p36] then
            error(("Invalid hook name: %q"):format(p36), 2);
        end;

        if p36 == "BeforeRun" and (#p35.Registry.Hooks[p36] == 0 and (p37.Group ~= "DefaultUtil" and (p37.Group ~= "UserAlias" and p37:HasImplementation()))) then
            if not RunService:IsStudio() then
                return "Command blocked for security as no BeforeRun hook is configured.";
            end;

            if u1 == false then
                p37:Reply((RunService:IsServer() and "<Server>" or "<Client>") .. " Commands will not run in-game if no BeforeRun hook is configured. Learn more: https://eryn.io/Cmdr/guide/Hooks.html", Color3.fromRGB(255, 228, 26));
                u1 = true;
            end;
        end;

        for _, v in ipairs(p35.Registry.Hooks[p36]) do
            local v38 = v.callback(p37, ...);

            if v38 ~= nil then
                return tostring(v38);
            end;
        end;
    end,

    PushHistory = function(p39, p40) -- Line: 164, Name: PushHistory
        -- upvalues: RunService (copy), Util (copy), TeleportService (copy)
        local v41 = RunService:IsClient();
        assert(v41, "PushHistory may only be used from the client.");
        local History = p39:GetHistory();

        if Util.TrimString(p40) == "" or p40 == History[#History] then
            return;
        end;

        History[#History + 1] = p40;
        TeleportService:SetTeleportSetting("CmdrCommandHistory", History);
    end,

    GetHistory = function(p42) -- Line: 179, Name: GetHistory
        -- upvalues: RunService (copy), TeleportService (copy)
        local v43 = RunService:IsClient();
        assert(v43, "GetHistory may only be used from the client.");

        return TeleportService:GetTeleportSetting("CmdrCommandHistory") or {};
    end
};

return function(p45) -- Line: 185
    -- upvalues: u44 (copy)
    u44.Cmdr = p45;
    u44.Registry = p45.Registry;

    return u44;
end;