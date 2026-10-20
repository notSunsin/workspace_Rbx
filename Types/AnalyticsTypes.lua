-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Asserts = require(ReplicatedStorage.UserGenerated.Lang.Asserts);

return {
    Validate_SessionStartPayload = Asserts.TableCoerce({
        Platform = Asserts.Optional(Asserts.Enum(Enum.DeviceForm)),
        OS = Asserts.Default(Asserts.Enum(Enum.Platform), Enum.Platform.None),
        InputMethod = Asserts.Optional(Asserts.Enum(Enum.PreferredInput)),
        ViewWidth = Asserts.Optional(Asserts.Range(0, 10000)),
        ViewHeight = Asserts.Optional(Asserts.Range(0, 10000)),
        LoadSeconds = Asserts.Optional(Asserts.Range(0, 600))
    }),

    SessionStartPayload = function(p1: table, p2: table) -- Line: 32, Name: SessionStartPayload
        return p2;
    end
};