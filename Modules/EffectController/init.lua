-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local script_Effects = script.Effects;
local script_Libraries = script.Libraries;
local EffectRequest = ReplicatedStorage.GameEvents.EffectRequest;
require(script.Types);
local Trove = require(ReplicatedStorage.Modules.Trove);
local u1 = {};
local v22 = {
    Init = function(u2, p3) -- Line: 25, Name: Init
        -- upvalues: script_Effects (copy), script_Libraries (copy), EffectRequest (copy)
        u2.Components = {};
        u2.Libraries = {};

        for _, descendant in script_Effects:GetDescendants() do
            if descendant.ClassName == "ModuleScript" then
                task.spawn(function() -- Line: 34
                    -- upvalues: descendant (copy), u2 (copy)
                    local success, result = pcall(require, descendant);

                    if success then
                        u2.Components[descendant.Name] = result;
                    end;
                end);
            end;
        end;

        for _, child in script_Libraries:GetChildren() do
            if child.ClassName == "ModuleScript" then
                task.spawn(function() -- Line: 48
                    -- upvalues: child (copy), u2 (copy)
                    local success, result = pcall(require, child);

                    if success then
                        u2.Libraries[child.Name] = result;
                    end;
                end);
            end;
        end;

        EffectRequest.OnClientEvent:Connect(function(p4) -- Line: 57
            -- upvalues: u2 (copy)
            u2:Play(p4);
        end);
    end,

    SplitName = function(p5, p6) -- Line: 62, Name: SplitName
        local v7 = p6:split("/");

        if v7 then
            return v7[1], v7[2];
        end;
    end,

    FetchComponent = function(p8, p9) -- Line: 72, Name: FetchComponent
        if p8.Components[p9] then
            return p8.Components[p9];
        end;

        warn((`Invalid Effect Name: {p9}, Component not Found.`));

        return nil;
    end,

    FetchCache = function(p10, p11, p12) -- Line: 82, Name: FetchCache
        -- upvalues: u1 (copy), Trove (copy)
        if not u1[p11] then
            u1[p11] = {};
        end;

        if not u1[p11][p12] then
            u1[p11][p12] = {
                Cache = {},
                Container = Trove.new()
            };
        end;

        return u1[p11][p12];
    end,

    Play = function(p13, p14) -- Line: 97, Name: Play
        if p14.caster then
            local v15, v16 = p13:SplitName(p14.name_State);
            local v17 = p13:FetchComponent(v15);
            local v18;

            if v17 then
                v18 = v17[v16];
            else
                v18 = v17;
            end;

            local v19;

            if v17 then
                v19 = p13:FetchCache(p14.caster, v17);
            else
                v19 = v17;
            end;

            if v17 and (v18 and v19) then
                task.spawn(v18, {
                    Caster = p14.caster,
                    Parameters = p14.parameters,
                    Libraries = p13.Libraries,
                    Default = p13.Libraries.Default,
                    Cache = v19.Cache,
                    Container = v19.Container
                });

                return true;
            end;

            warn((`Component Found: {v17}, Callback Found: {v18}, Cache Found: {v19}.`));

            return false;
        end;

        warn(`No caster found in data table {p14}.`, p14);
    end,

    Request = function(p20, p21) -- Line: 131, Name: Request
        -- upvalues: EffectRequest (copy)
        if not p21.caster then
            return;
        end;

        if p20:Play(p21) then
            EffectRequest:FireServer(p21);
        end;
    end
};
task.spawn(v22.Init, v22, Players.LocalPlayer);

return v22;