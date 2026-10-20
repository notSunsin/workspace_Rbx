-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local EventRotationController = require(ReplicatedStorage.Modules.EventRotation.EventRotationController);

return {
    IsInFairyEvent = function(p1: table, p2: number?) -- Line: 10, Name: IsInFairyEvent
        -- upvalues: EventRotationController (copy)
        local LoadedEvent = EventRotationController:GetLoadedEvent();

        if not LoadedEvent then
            return false;
        end;

        if LoadedEvent.EventSet == "FairyEvent" then
            return not p2 and true or (EventRotationController:IsPastEventIDIndex(p2) and true or false);
        end;

        return false;
    end
};