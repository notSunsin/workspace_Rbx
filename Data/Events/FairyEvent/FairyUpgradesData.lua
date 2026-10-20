-- Decompiled with Potassium's decompiler.

local ServerScriptService = game:GetService("ServerScriptService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local NumberUtil = require(ReplicatedStorage.Modules.NumberUtil);
local u5 = {
    ["Fairy Spawn Amount"] = {
        Default = 3,
        Upgrades = { {
                Price = 2500,
                Value = 4
            }, {
                Price = 5000,
                Value = 5
            }, {
                Price = 9000,
                Value = 6
            }, {
                Price = 15000,
                Value = 7
            }, {
                Price = 24000,
                Value = 8
            }, {
                Price = 36000,
                Value = 9
            }, {
                Price = 52000,
                Value = 10
            }, {
                Price = 74000,
                Value = 11
            }, {
                Price = 98000,
                Value = 12
            } },

        Display = function(p1) -- Line: 49, Name: Display
            return tostring(p1);
        end
    },
    ["Glimmer Multiplier"] = {
        Default = 1,
        Upgrades = { {
                Price = 500,
                Value = 1.1
            }, {
                Price = 1000,
                Value = 1.2
            }, {
                Price = 3000,
                Value = 1.3
            }, {
                Price = 6000,
                Value = 1.4
            }, {
                Price = 9000,
                Value = 1.5
            }, {
                Price = 15000,
                Value = 1.6
            }, {
                Price = 30000,
                Value = 1.7
            }, {
                Price = 60000,
                Value = 1.8
            }, {
                Price = 80000,
                Value = 1.9
            }, {
                Price = 120000,
                Value = 2
            } },

        Display = function(p2) -- Line: 98, Name: Display
            return `{p2}x`;
        end
    },
    ["Fairy Event Duration"] = {
        Default = 600,
        Upgrades = { {
                Price = 2500,
                Value = 660
            }, {
                Price = 5000,
                Value = 720
            }, {
                Price = 8500,
                Value = 780
            }, {
                Price = 14000,
                Value = 840
            }, {
                Price = 21000,
                Value = 900
            }, {
                Price = 31000,
                Value = 960
            }, {
                Price = 44000,
                Value = 1020
            }, {
                Price = 61000,
                Value = 1080
            }, {
                Price = 80000,
                Value = 1140
            }, {
                Price = 136200,
                Value = 1200
            } },

        Display = function(p3) -- Line: 147, Name: Display
            -- upvalues: NumberUtil (copy)
            return NumberUtil.compactFormat(p3, true);
        end
    },
    ["Loose Fairy Spawn Amount"] = {
        Title = "Roaming Fairy Spawn Amount",
        Default = 3,
        Upgrades = { {
                Price = 2500,
                Value = 4
            }, {
                Price = 5000,
                Value = 5
            }, {
                Price = 9000,
                Value = 6
            }, {
                Price = 15000,
                Value = 7
            } },

        Display = function(p4) -- Line: 173, Name: Display
            return tostring(p4);
        end
    }
};
local Default = u5["Loose Fairy Spawn Amount"].Default;
local Upgrades = u5["Loose Fairy Spawn Amount"].Upgrades;

local function RemoveFairyEventPart2Data() -- Line: 194
    -- upvalues: u5 (copy), Default (copy), Upgrades (copy)
    u5["Loose Fairy Spawn Amount"].Default = Default;
    u5["Loose Fairy Spawn Amount"].Upgrades = Upgrades;
end;

local function AddFairyEventPart2Data() -- Line: 199
    -- upvalues: u5 (copy)
    u5["Loose Fairy Spawn Amount"].Default = 5;
    u5["Loose Fairy Spawn Amount"].Upgrades = { {
            Price = 2500,
            Value = 6
        }, {
            Price = 5000,
            Value = 7
        }, {
            Price = 9000,
            Value = 8
        }, {
            Price = 15000,
            Value = 9
        }, {
            Price = 25000,
            Value = 10
        }, {
            Price = 55000,
            Value = 11
        }, {
            Price = 120000,
            Value = 12
        }, {
            Price = 200000,
            Value = 13
        }, {
            Price = 300000,
            Value = 14
        }, {
            Price = 450000,
            Value = 15
        } };
end;

if RunService:IsServer() then
    require(ServerScriptService.Modules.EventRotation.EventRotationServerBinder):Bind({
        EventSet = "FairyEvent",
        MinPartIndex = 2,
        Script = script,

        OnStart = function() -- Line: 253, Name: OnStart
            -- upvalues: AddFairyEventPart2Data (copy)
            task.spawn(AddFairyEventPart2Data);
        end,

        OnStop = function() -- Line: 254, Name: OnStop
            -- upvalues: u5 (copy), Default (copy), Upgrades (copy)
            u5["Loose Fairy Spawn Amount"].Default = Default;
            u5["Loose Fairy Spawn Amount"].Upgrades = Upgrades;
        end
    });

    return u5;
end;

if RunService:IsClient() then
    require(ReplicatedStorage.Modules.EventRotation.EventRotationClientBinder):Bind({
        EventSet = "FairyEvent",
        MinPartIndex = 2,
        Script = script,

        OnStart = function() -- Line: 262, Name: OnStart
            -- upvalues: AddFairyEventPart2Data (copy)
            task.spawn(AddFairyEventPart2Data);
        end,

        OnStop = function() -- Line: 263, Name: OnStop
            -- upvalues: u5 (copy), Default (copy), Upgrades (copy)
            u5["Loose Fairy Spawn Amount"].Default = Default;
            u5["Loose Fairy Spawn Amount"].Upgrades = Upgrades;
        end
    });
end;

return u5;