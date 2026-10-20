-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Util = require(game.ReplicatedStorage.Code.Util);
local u1 = {};

for i, _ in require(ReplicatedStorage.Modules.TeamEventHelper).Events do
    table.insert(u1, i);
end;

local u6 = {
    Transform = function(p2: string) -- Line: 17, Name: Transform
        -- upvalues: Util (copy), u1 (copy)
        return Util.MakeFuzzyFinder(u1)(p2);
    end,

    Validate = function(p3) -- Line: 22, Name: Validate
        return #p3 > 0, "No team event by that name could be found.";
    end,

    Autocomplete = function(p4) -- Line: 26, Name: Autocomplete
        -- upvalues: Util (copy)
        return Util.GetNames(p4);
    end,

    Parse = function(p5) -- Line: 30, Name: Parse
        return p5[1];
    end
};

return function(p7) -- Line: 35
    -- upvalues: u6 (copy), Util (copy)
    p7:RegisterType(script.Name, u6);
    p7:RegisterType(script.Name .. "s", Util.MakeListableType(u6));
end;